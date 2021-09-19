# Auto-Braking Script

## Function Description
braker(target, vtar, pretarget)
### Parameters
- target: stopping point distance
- vtar: passing speed
- pretarget: Preprocess Distance
- facing: train incoming direction, valid vaules: "west", "east", "north", "south"


## How to Use the Script
First of all, one would need to set up a system like the following picture. Note that the upper computer and the detector at the staring point is not neceesary, and the script should be running at the computer on the other side with a controller and a detector attached.
![system_setup](https://github.com/FallenerFurtherstr/Automate-Train-Control-Library/blob/main/braker/System_Setup.png)

Normally, the buffer distance, aka preprocessing distance, depends on what the incoming trians should be expected. If it's a light-weight, low top speed consist, then a 10 ~ 20 blocks should be fine. Otherwise it would be 40 to 50 blocks. The purpose of the buffer distance is to make sure that the script yields a result before the train reaches the starting point, so keep that in mind when testing out the distance.

This script can be a standalone program and run independently. Or one can seperatly call braker() function, but note that it would only perform one brake per call.

## Notice

- Make sure the braking track is flat and without slope because it isn't calucalating the slope loss. Whether the track can be curved remains untested but I think it can handle the curve.

- NO HAND CAR PASSING! And no manaul operation involved when working! (if you want to avoid troubles)

- For multi-loco consist, one should turn on all the locos to make sure there's enough tractive effort going on.

- For steam locos, it's important to hook up a tender behind and make sure that the chamber is always full of water. Although it cannot solve the problem of huge water loss, at least it's for safe driving. Thus, less accuracy is to be expected when involving steam locos.

- All the test is not involving gauges of rail other than a standard one, thus the result might vary. Please do inform me via Issue dashboard at the repo!


## Changelog

### Ver 1.2

- System can detect the direction of consist and ignore the request that is not of the system's concern.

- Fix the traction and friction calculation.

### Ver 1.1

- Add support to multi-loco consist, though in a hacky way, see the comment. This is subject to change.

### Ver 1.0

- Initial commit, only works with single loco
