# SOTA UI Sample

![suis](https://github.com/user-attachments/assets/c7f2c296-987f-4b13-b42a-1954ed923482)

#### 1. Stopwatch.
- resets time, gained XP, gold and COTO when clicked
- gray is the time in the zone, it is updated automatically
#### 2. Adventurer XP
- shows the total amount if you have not received experience
- also show level without buffs and progress to the next level
#### 3. Producer XP
- same as adventurer xp
#### 4. Toggle visibility of Stats, Buffs and Notify windows.
#### 5. Filter Stats by name (lua patterns available)
#### 6. Check stat or buff so that it is visible in the Notify window
- unlike buffs, stats will not be updated unless checked (there are just a lot of them)
#### 7. Filter Buffs by description (lua patterns available)
#### 8. Notify (will change)
- show gold and coto gained during the timer period
- show checked stats and buffs

## HOWTO
- If you don't like the sample you can make your own user interface.
- Comment last line `-- use_sample()`
- And add your stuff
```lua
on_update.task(function()
    local button = Button()
    button.set_size(200, 50)
    button.set_position(200, 200)
    
    button.set_text_value("Button")
    button.set_font_size(24)
    button.set_normal_color(ui_color.Black)
    button.set_hovered_color(ui_color.DimGray)
    button.set_pressed_color(ui_color.Oxblood)

    button.on_pressed.action(function (pressed)
        print(pressed and "Button pressed" or "Button released")
    end)
end)
```

## TODO
- Containers min_size
    > For large lists (like Stats), detected minimum size has a big impact on performance!

## Contact
- Discord: **hryden**
- IGN: **Denys**
