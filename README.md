# No Vocation Requirements (Dragon's Dogma 2)

REFramework script that lets every vocation equip any armor. Weapons keep their
normal vocation restrictions, and item weights are left untouched.

This is a trimmed copy of `NoVocationRequirements0Weight.lua` with the
"0 Weight" feature removed. The vocation logic is unchanged.

## Install

1. Make sure [REFramework](https://github.com/praydog/REFramework/releases) (`DD2.zip`) is
   installed (`dinput8.dll` in the game folder).
2. Remove the original mod so it doesn't keep setting weights to 0:
   delete `reframework/autorun/NoVocationRequirements0Weight.lua` from the game
   folder (or uninstall it in your mod manager). Its leftover config,
   `reframework/data/NoVocationRequirements0Weight.json`, can be deleted too.
3. Copy `reframework/autorun/NoVocationRequirements.lua` from this repo into
   `<Dragon's Dogma 2 folder>/reframework/autorun/`.
4. Restart the game. Weights already zeroed by the old script only go back to
   normal after a restart; "Reset scripts" is not enough.

## Toggle

Open the REFramework menu (Insert key by default), go to
**Script Generated UI > [NoVocationRequirements]** and use the checkbox. The
choice is saved to `reframework/data/NoVocationRequirements.json`.
