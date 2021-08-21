local component = require("component")
local event = require("event")
local computer = require("computer")
local controler = component.ir_augment_control
local detector = component.ir_augment_detector

speedRatio = 20 * 3.6

--- Recursive Method of finding traveling braking distance
--- cal.co: coefficient, v: speed, n: tick, s: distance
local function callback(cal, v, n, s)
  vnext = v - cal.co / (v * speedRatio + 100) - 2.20462 * 0.0015 * 4.44822 / speedRatio
  if vnext > 0 then
    s = callback(cal, vnext, n + 1, s + vnext)
  else
    print(n, s)
  end
  return s
end

--- Calculate Preprocess Segment
--- v: Incoming Speed, s: Preprocess Distance
local function preprocess(v, s)
  while s > 0 do
    v = v - 2.20462 * 0.0015 * 4.44822 / speedRatio
    s = s - v
  end
  return v
end


--- Main
time = computer.uptime()
simulated = 0
while true do
  _, _, aug, _ = event.pull("ir_train_overhead")
  info = detector.info() --- this may be useless
  consist = detector.consist()
  if computer.uptime() - time > 0.1 then
    time = computer.uptime()
    if simulated == 0 and info and aug == "DETECTOR" then
      x = 0.5
      print("Incoming Speed:",consist.speed_km)
      cal = {}
      --- cal.co = info.traction / info.weight / speedRatio * x * x * 100  --- original method 
      --- make cal a table for better compatibility
      cal.co = consist.total_traction_N / consist.weight_kg/ speedRatio * x * x * 100
      print("Weight:",consist.weight_kg)
      pretarget = 50
      v0 = preprocess(consist.speed_km / speedRatio, pretarget)
      print("Starting Speed:",v0*speedRatio)

      --- Find Proper Brake Vaule
      delta = 0
      target = 100
      leftbound = 0
      rightbound = 1
      while true do
        print("Trying:", x)
        delta = target - callback(cal, v0, 0, 0)
        if delta < 0.05 and delta > -0.05 then
          break
        end
        if delta > 0 then
          --- if not catch up, apply less brake
          cal.co = cal.co / x / x
          rightbound = x
          x = (leftbound + rightbound) / 2
          cal.co = cal.co * x * x
        elseif delta < 0 then
          --- if overshoot, apply more brake
          cal.co = cal.co / x / x
          leftbound = x
          x = (leftbound + rightbound) / 2
          cal.co = cal.co * x * x
          delta = delta * -1
        end
      end
      print("Result:", x)
      simulated = 1
    elseif simulated == 1 and aug == "LOCO_CONTROL" then 
      print("Braking")
      controler.setBrake(x)
      simulated = 0
    end
  end
end