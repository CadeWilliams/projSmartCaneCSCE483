# Weekly Report and Meeting Agenda


| Report # | Project Name | Date | Prepared By |
| --- | --- | --- | --- |
| 7 | Smart Cane | 4/15/2020 | Baltazar Guerra L. |


## Agenda for the meeting
1. Given that now using YOLO V3 is out of the question (due to it's slow processing with the Pi), we have to decide if using
alternatives like TensorFlow could work for our project or if we should just scrap the use of cameras.
2. Update on scope for the project (communication between Pi and smartphone, extent of in-door navigation, etc) given the fallbacks.
3. Get feedback from instructors to influence our course of actions from now until the final video deadline.
4. Talk about the requirements for the final demo video (how to showcase different systems working together, some examples of how it would work).

## Overall accomplishments since last meeting
1. Finished testing and analysis on ultrasonic sensors and vibrating motors in Arduino. Now passed on to be used on Raspberry Pi.
2. Started developing the breadcrumb system to be used for indoor navigation.
3. Found that using YOLO V3 would not be ideal for our project. Kept looking for alternatives. 
A promising one which we will test is TensorFlow.
4. Overall testing to see the feasability of the gyroscope/accelerometer usage in the in-door navigation.

## Tasks completed by each team member since last meeting

| Task description | Assigned to | Completed? |
| --- | --- | --- |
| Finished testing the ultrasonic sensors and vibrating motors working together. Passed them to Arthur to incorporate to the Pi. |  Baltazar Guerra L.  | Yes |
| Started development of breadcrumb system for in-door navigation. | Matthew Giuffrida | Yes |
| Finished functionality of the iOS App for Outdoor Navigation. Worked on communication between Pi and iPhone.| Shawn Popal | Yes |
| Tested YOLO V3 and found that it would be too slow for our use. Kept looking for alternatives. | Jonathan Williams | Yes |
| Received components from Baltazar. Started testing the gyroscope/accelerometer. | Arthur Helmen | Yes |


## Plans for next period
1. Finish working on sub-systems and bring as many together as possible.
2. Get stable connection between Pi and iPhone.
3. Do more testings with multiple components working together for calibration and the demo.
4. Make and finish the demo video.

## Task assignment per team member (to be completed before the next meeting)
| Task Description | Assigned to |
| --- | --- |
|Assist on making code to test TensorFlow. Edit final video.| Baltazar Guerra L |
|Keep working on the breadcrumb system and tracking for indoor navigation.| Matthew Giuffrida |
|Update the app so the user can make a gesture in the phone to drop a breadcrumb. Continue testing and calibrating communication between Pi and iPhone.| Shawn Popal |
|Test TensorFlow on the camera to determine if its use is still feasable.| Jonathan Williams |
|Bring components together with the Pi. Test breadcrumb program with the Gyroscope/Accelerometer.| Arthur Helmen |

## Project management status
1. As of now, 4 of us are in College Station and Shawn Popal is in Dallas. Since he is mostly working on the software side of the project, that aspect doesn't hold us back. 
2. We are going to have some problems when it comes to testing the communication between the Pi and the App since Shawn is away and can make the collaboration a bit difficult (since for this we have to interact with hardware and debug accordingly).
3. Now it is official that we will use Google Maps rather than Aggie Maps.
4. Again, the speed of progress for our project has been brought down due to the current situation. Debugging, testing, and adapting will take a lot longer since we can't all be together as a group.
5. Since the subsystems for the outdoor navigation are pretty much done, we started working on the breadcrumb and tracking system
for the indoor navigation.
## Minutes from previous meeting
