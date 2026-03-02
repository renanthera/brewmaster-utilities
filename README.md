# Brewmaster Utilities

## Gift of the Ox orb Counter

- Shows Gift of the Ox orb count above a specified CDM action, by default Blackout Kick.
- Requires Expel Harm to be on an action bar.
- Anchored spell, position and scale may be adjusted.

```
BrewmasterUtilities.lua:1-4
local anchor_id = 205523 -- spell id for text anchor. defaults to blackout kick (205523)
local position = 'TOP' -- see link for possible values: https://warcraft.wiki.gg/wiki/API_ScriptRegionResizing_SetPoint
local text_scale = 1
local update_frequency = 0.05 -- sensible default, 20 times a second. cannot be handled based on events.
```

## Black Ox Statue Totem Cancel Assistant

- Create a macro containing all of the following lines, or separate macros for each line.
- All lines in one macro can result in canceling Invoke Niuzao ox as well as any other active totems.
```
/click BUTotemCancelFrame1
/click BUTotemCancelFrame2
/click BUTotemCancelFrame3
/click BUTotemCancelFrame4
```

## Contributions Welcome
Report bugs, request features or make contributions at
https://github.com/renanthera/brewmaster-utilities