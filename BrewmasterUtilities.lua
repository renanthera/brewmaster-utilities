-- finds the first instance of anchor_id in CDM, and then anchors a Frame
-- which contains the current number of Gift of the Ox orbs to position

-- requirements:
--  - Expel Harm must exist on an action bar

local anchor_id = 205523 -- spell id for text anchor. defaults to blackout kick (205523)
local position = 'TOP' -- see link for possible values: https://warcraft.wiki.gg/wiki/API_ScriptRegionResizing_SetPoint
local text_scale = 1
local update_frequency = 0.05 -- sensible default, 20 times a second. cannot be handled based on events.

local CDM_FRAMES = {"EssentialCooldownViewer", "UtilityCooldownViewer"}

function find_frame(name)
   local children = {_G[name]:GetChildren()}
   for i, child in ipairs(children) do
      local cdid = child.cooldownID
      local sid = nil
      if cdid then
         sid = C_CooldownViewer.GetCooldownViewerCooldownInfo(cdid).spellID
      end
      if sid == anchor_id then
         return child
      end
   end
end

local addon = CreateFrame("Frame")
addon:RegisterEvent("PLAYER_ENTERING_WORLD")
addon:SetScript("OnEvent", function (is_startup, ...)
	if not is_startup then
		return
	end 
	
	local frame
	for i, name in ipairs(CDM_FRAMES) do
	   print(name)
	   frame = find_frame(name)
	   if frame then
		  break
	   end
	end

	local holder = CreateFrame("Frame", nil, frame)
	holder:SetAllPoints()
	local fs = holder:CreateFontString(nil, "OVERLAY", "GameTooltipText")
	fs:SetPoint(position)
	fs:SetTextScale(text_scale)

	function cb(...)
		local ab = C_ActionBar.FindSpellActionButtons(322101)
		if #ab then
			local value = C_ActionBar.GetActionDisplayCount(ab[1])
			fs:SetText(value)
		end
	end
	
	function wrapped_cb(...)
		local spell_id = select(5, ...)
		if spell_id == 124503 or spell_id == 124506 then
			cb()
		end
	end

	C_Timer.NewTicker(update_frequency, cb)
	holder:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")
	holder:SetScript("OnEvent", wrapped_cb)
end)



