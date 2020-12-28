local addonName, addon = ...
addon = LibStub("AceAddon-3.0"):NewAddon(addon, addonName, "AceEvent-3.0", "AceConsole-3.0", "AceHook-3.0")
local L = _G.LibStub("AceLocale-3.0"):NewLocale(addonName, "enUS", true, true)

L["Options"] = true
L["General Options"] = true
L["Swap Delay"] = true
L["Outline Mode when disabled"]= true
L["Sparkles"] = true
L["Outline"] = true