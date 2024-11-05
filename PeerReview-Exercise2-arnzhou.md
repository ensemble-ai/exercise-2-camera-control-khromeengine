# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* Arnold Zhou
* *email:* arnzhou@ucdavis.edu

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect #### 
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


___

## Solution Assessment ##

### Stage 1 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Camera correctly locks onto target position, even when hyper speed is active.

___
### Stage 2 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Autoscroll works correctly for the most part, but export variables seem to not
work correctly. `top_left` and `bottom_right` don't correctly control the corner
locations. For example, changing `top_left` from `(0, 0)` to `(-3, 0)`  while
keeping `bottom_right` at `(5, 5)` shrinks the box rather than expanding it.

___
### Stage 3 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The leash distance seems to shorten when hyper speed is activated (tested with
default export values). Everything else works as expected.

___
### Stage 4 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Everything works as expected, both at regular and hyper speed. Export variables
work correctly, but `lead_speed` is not included as an export.

___
### Stage 5 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Pushbox and speedup zone work correctly, but it's not super clear what the
exported variables are supposed to represent (similar to Stage 3). The default
export values for `pushbox_top_left` and `pushbox_bottom_right` in the inspector
are both `(12, 7)`, which doesn't make sense.
___
# Code Style #


### Description ###
Check the scripts to see if the student code adheres to the dotnet style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.


#### Style Guide Infractions ####

* [Code comments](https://github.com/ensemble-ai/exercise-2-camera-control-khromeengine/blob/cf7771b6b5e055a58a1a135c8bd47b7aade850cf/Obscura/scripts/camera_controllers/position_lerp.gd#L30) -
Comments could be added to some of the more technical code sections to improve readability (for example, the linked section for calculating lerp velocity).

#### Style Guide Exemplars ####

* [Variable typing](https://github.com/ensemble-ai/exercise-2-camera-control-khromeengine/blob/cf7771b6b5e055a58a1a135c8bd47b7aade850cf/Obscura/scripts/camera_controllers/push_box.gd#L5) -
Variables are typed at declaration, improving readability.
* [Private variable prefixing](https://github.com/ensemble-ai/exercise-2-camera-control-khromeengine/blob/cf7771b6b5e055a58a1a135c8bd47b7aade850cf/Obscura/scripts/camera_controllers/leading_lerp_alt.gd#L10) -
Private variables are prefixed with `_`, improving readability.
___

# Best Practices #

### Description ###

If the student has followed best practices (Unity coding conventions from the StyleGuides document) then feel free to point at these code segments as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####

* [Default export values](https://github.com/ensemble-ai/exercise-2-camera-control-khromeengine/blob/cf7771b6b5e055a58a1a135c8bd47b7aade850cf/Obscura/scripts/camera_controllers/autoscroller.gd#L4) -
Some of the default export values don't work. For example, using the default `Autoscroller` export values results in a stationary camera with pushbox of 0 area.

#### Best Practices Exemplars ####

* [Built-in function usage](https://github.com/ensemble-ai/exercise-2-camera-control-khromeengine/blob/cf7771b6b5e055a58a1a135c8bd47b7aade850cf/Obscura/scripts/camera_controllers/position_lerp.gd#L43) -
Good usage of existing library functions to avoid redundancy and improve readability.
* [`@on_ready` usage](https://github.com/ensemble-ai/exercise-2-camera-control-khromeengine/blob/cf7771b6b5e055a58a1a135c8bd47b7aade850cf/Obscura/scripts/camera_controllers/speedup_push_box.gd#L11) -
Good usage of `@on_ready` to update target and camera parameters.
