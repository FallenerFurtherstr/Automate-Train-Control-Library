# Auto-Braking Script

## Function Description
braker(target, vtar, pretarget)
### Parameters
- target: stopping point distance
- vtar: passing speed
- pretarget: Preprocess Distance


## How to Use the Script
First of all, one would need to set up a system like the following picture. Note that the upper computer and the detector at the staring point is not neceesary, and the script should be running at the computer on the other side with a controller and a detector attached.
![system_setup](https://github.com/FallenerFurtherstr/Automate-Train-Control-Library/blob/main/braker/System_Setup.png)

Normally, one should choose a preprocessing distance at a range of 20~50 blocks behind the controller, because a distance too large would discourge train from braking at the right spot and introduce wheel-slip bounces, and the one too small would make the train go ahead the controller before the script can give a answer.

This script can be a standalone program and can run independly. Or one can seperatly call braker() function, but note that it would only perform one brake per call.

## Notice

- Make sure the braking track is flat and without slope because it isn't calucalating the slope loss. Whether the track can be curved remains untested but I think it can handle the curve.

- NO HAND CAR PASSING!

- For multi-loco consist, one should turn on all the locos to make sure there's enough tractive effort going on.

- For steam locos, it's important to hook up a tender behind and make sure that the chamber is always full of water. Although it cannot solve the problem of huge water loss, at least it's for safe driving. Thus, less accuracy is to be expected when involving steam locos.

- All the test is not involving other gauges of rail, thus the result might vary. Please do inform us via Issue dashboard at the repo!

- Although the script is powerful, one should still remain conservative and perform experiments with it because of its imperfection.

## Changelog

### Ver 1.1

- Add support to multi-loco consist, though in a hacky way, see the comment. This is subject to change.

### Ver 1.0

- Initial commit, only works with single loco
