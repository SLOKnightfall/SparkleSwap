--  ///////////////////////////////////////////////////////////////////////////////////////////
--
--  SparkleSwap 
--  Author: SLOKnightfall

--  ///////////////////////////////////////////////////////////////////////////////////////////

local addonName, addon = ...

local f = CreateFrame("Frame")

-- Register to monitor events
f:RegisterEvent("PLAYER_ENTERING_WORLD")

-- Handle the events as they happen
f:SetScript("OnEvent", function(self, event, ...)
	if (event == "PLAYER_ENTERING_WORLD") then
		addon:Swap()
	end
end)


function addon:Swap()
	local value = GetCVar("graphicsOutlineMode")
	if value == "3" then 
		SetCVar("graphicsOutlineMode", 0)
	else
		SetCVar("graphicsOutlineMode", 3)
	end

	C_Timer.After(3, function() addon:Swap() end)
end