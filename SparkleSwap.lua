--  ///////////////////////////////////////////////////////////////////////////////////////////
--
--  SparkleSwap 
--  Author: SLOKnightfall

--  ///////////////////////////////////////////////////////////////////////////////////////////

local addonName, addon = ...
addon = LibStub("AceAddon-3.0"):GetAddon(addonName)
local AceGUI = LibStub("AceGUI-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)


--ACE3 Option Handlers
local optionHandler = {}
function optionHandler:Setter(info, value)
	addon.Profile[info[#info]] = value
end


function optionHandler:Getter(info)
	return addon.Profile[info[#info]]
end


local options = {
	name = "SparkleSwap",
	handler = optionHandler,
	get = "Getter",
	set = "Setter",
	type = 'group',
	childGroups = "tab",
	inline = true,
	args = {
		settings={
			name = L["Options"],
			type = "group",
			inline = false,
			order = 0,
			args = {
				Options_Header = {
					order = 1,
					name = L["General Options"],
					type = "header",
					width = "full",
				},
			
				AutoStart = {
					order = 2,
					name = L["Start on Entering World"],
					type = "toggle",
					width = "full",
				},
				SwapDelay = {
					order = 2,
					name = L["Swap Delay"],
					type = "range",
					width = "full",
					min = 1,
					max = 10,
					step = 1,
				},
				EndState = {
					order = 4,
					name = L["Outline Mode when disabled"],
					type = "select",
					width = "full",
					values = {[0] = L["Sparkles"],[ 3] = L["Outline"]},
				},
				
			},
		},
	},
}

local defaults = {
	profile = {
				['*'] = true,
				SwapDelay = 3,
				EndState = 3,
			},
}


---Ace based addon initilization
function addon:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("SparkleSwapDB", defaults, true)

	addon.Profile = self.db.profile
	LibStub("AceConfigRegistry-3.0"):ValidateOptionsTable(options, addonName)
	LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, options)
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("SparkleSwap", "SparkleSwap")
end


function addon:OnEnable()
	if addon.Profile.AutoStart then 
		addon:Swap()
	end
end


local run = true
function addon:Swap()
	if not run then SetCVar("graphicsOutlineMode", self.db.EndState) return end
	local value = GetCVar("graphicsOutlineMode")
	if value == "2" then 
		SetCVar("graphicsOutlineMode", 0)
	else
		SetCVar("graphicsOutlineMode", 2)
	end

	C_Timer.After(addon.Profile.SwapDelay, function() addon:Swap() end)
end


-- Use AceConsole-3.0 to register a Chat Command
addon:RegisterChatCommand(addonName, "ChatCommand")


function addon:ChatCommand(input)
	if input == "start" then
		run = true
		addon:Swap()
	elseif input == "stop" then 
		run = false
	end
end