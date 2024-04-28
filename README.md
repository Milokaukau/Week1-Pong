# Week 1 Pong :baseball:

This is a recreation of the pong game made solely for learning purpose. 

## Controls

The player can control the right paddle using the up arrow key <kbd>&uarr;</kbd> and the down arrow key <kbd>&darr;</kbd>.

The left paddle will be controlled by AI.
## Game Screenshot

![Game Screenshot](https://github.com/Milokaukau/Week1-Pong/blob/main/pong_game_screenshot.png?raw=true)


## Assets Used

The assets were gotten from [this tutorial](https://docs.godotengine.org/en/2.1/learning/step_by_step/simple_2d_game.html). Whoever made them, thank you!
## Lessons Learned

#### Before diving into coding:
- Configure the project settings (add game logo, whatever necessary).
- Determine nodes needed and their type (RigidBody2D, Area2D...).

#### Coding:

- You can use `clamp()` to set a value limit.

- For `RigidBody2D`, you were to only set the initial velocity! Other movements are handled by physics.

- `add_child(ball, true)`: The `true` here is to force set a readable name for the node on instantiation.

- When getting direction, remember to `normalized()`.

- Apparently you can get bounced direction (for `RigidBody2D`) like this:

        ball_dir = ball_dir.bounce(collision.get_normal())
    given that

        collision = move_and_collide(velocity*delta)

- You can get sprite size like this:

        target.get_sprite().texture.get_size()
    
    given that

        func get_sprite():
            return $Sprite2D
 
- Picking a random number:

       Option 1: [n1,n2].pick_random()
       Option 2: randf_range(n1,n2)

#### Publishing to itch.io:

1. For the game to size well on web, make sure the window `Stretch` mode is **NOT** disabled. (Check in project settings)

1.  Change to `Compatibility` (to me, optional, cuz `Mobile` still works)

1. Get an export template manager
    
    Go to Editor -> Manage Export Template -> Select: official GitHub releases mirror -> Download and Install

1. Export the project

    Go to Project -> Export -> Add -> Select: HTML -> Export Project - Make sure filename: index.html

1. Compress the exported project into a `.zip` file and you're ready to upload.


## Badges

![Static Badge](https://img.shields.io/badge/Game%20Engine-Godot%204.0-blue)

![Static Badge](https://img.shields.io/badge/beginner%20project%20-%20green)

## Author

- [@Milokaukau](https://www.github.com/Milokaukau)

