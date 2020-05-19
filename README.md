# AreaManager Official Addons

These are a collection of official addons for areamanager

## Installation

Simply download any addon you would like from the addon directory, and place it into your installation at the following path:

addons/areamanager/lua/areamanager/addons/

## Addon creators

Read the addons/README.txt for addon creators, as this includes advice on how to format your addons properly

* Your addon should be named am_your_addon_name.lua
* You should refer to the official AreaManager API for help (https://www.gmodstore.com/help/addon/6659/developers-5)
* Your addons will only ever be loaded in the server realm. If your addon requires functionality beyond the server realm, please consider creating a new seperate gmod addon, or submitting a ticket
* Your addons should use the AreaManager hooking function, found in init.lua and named AreaManager:RegisterHook
* Your addons should use the AreaManager timer function, found in init.lua and named AreaManager:RegisterTimer
* Your addons should be refresh sensitive, i.e. they shouldn't break or fail on refresh
* Your addons should use local variables whenever possible, and only use global variables when directly hooking into other addons or AreaManager itself
* Your addons should use AreaManager:Log(text, type) for logging, where type can be 'log', 'issue' or 'error'

Your addons MUST include a comment at the top with the following template:
```
--[[
	@name
	@description
	@dependencies
	@author
]]
```
View official addons for help on this template
