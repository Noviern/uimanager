ADDON:ImportAPI(API.X2Option)

local UIC_UIMANAGER = 16777215
local uiManagerWindow
local uiBoundKeys = {
  "ui_bound_actionBar_renewal1",
  "ui_bound_actionBar_renewal2",
  "ui_bound_actionBar_renewal3",
  "ui_bound_actionBar_renewal4",
  "ui_bound_actionBar_renewal5",
  "ui_bound_actionBar_renewal6",
  "ui_bound_actionBar_renewal7",
  "ui_bound_actionBar_renewal8",
  "ui_bound_actionBar_renewal9",
  "ui_bound_actionBar_renewal10",
  "ui_bound_actionBar_renewal11",
  "ui_bound_battlefield_actionbar",
  "ui_bound_chatWindow[0]",
  "ui_bound_chatWindow[1]",
  "ui_bound_chatWindow[2]",
  "ui_bound_chatWindow[3]",
  "ui_bound_chatWindow[4]",
  "ui_bound_chatWindow[5]",
  "ui_bound_chatWindow[6]",
  "ui_bound_chatWindow[7]",
  "ui_bound_combatResource",
  "ui_bound_combatResourceFrame",
  "ui_bound_craftFrame",
  "ui_bound_craftOrderBoard",
  "ui_bound_invite_jury_popup",
  "ui_bound_megaphone_frame",
  "ui_bound_mobilization_order_popup",
  "ui_bound_modeSkillActionBar",
  "ui_bound_partyFrame1",
  "ui_bound_partyFrame2",
  "ui_bound_partyFrame3",
  "ui_bound_partyFrame4",
  "ui_bound_petBar1",
  "ui_bound_petBar2",
  "ui_bound_petFrame1",
  "ui_bound_petFrame2",
  "ui_bound_petInfoWindow",
  "ui_bound_playerFrame",
  "ui_bound_questList",
  "ui_bound_questNotifier",
  "ui_bound_raidFrame",
  "ui_bound_raidFrame2",
  "ui_bound_sagaBook",
  "ui_bound_shortcutSkillActionBar",
  "ui_bound_targetFrame",
  "ui_bound_targettotarget",
  "ui_bound_watchtarget",
}
---@TODO: filePath could fail if the user installed ArcheRage on another drive. Need to find a way to get the ArcheRage Documents folder.
local filePath = "C:/ArcheRage/Documents/Addon/" .. ADDON:GetName() .. "/ui_bounds.lua"

---Creates the UI manager window.
---@return Window
local function CreateUIManagerWindow()
  local window           = SetViewOfUIManagerWindow()
  local titleBar         = window.titleBar ---@type Window
  local closeButton      = titleBar.closeButton ---@type Button
  local contentFrame     = window.contentFrame ---@type EmptyWidget
  local saveEditbox      = contentFrame.saveFrame.saveEditbox ---@type X2EditBox
  local saveButton       = contentFrame.saveFrame.saveButton ---@type Button
  local loadCombobox     = contentFrame.loadFrame.loadCombobox ---@type Combobox
  local selectorBtn      = loadCombobox.selectorBtn ---@type Button
  local toggle           = loadCombobox.toggle ---@type Button
  local dropdown         = loadCombobox.dropdown ---@type ComboboxDropDown
  local upButton         = dropdown.upBtn ---@type Button
  local downButton       = dropdown.downBtn ---@type Button
  local vslider          = dropdown.vslider ---@type Vslider
  local thumb            = dropdown.vslider.thumb ---@type Button
  local scrollBackground = dropdown.scrollBackground ---@type DrawableDDS
  local loadDeleteButton = contentFrame.loadFrame.loadDeleteButton ---@type Button
  local loadButton       = contentFrame.loadFrame.loadButton ---@type Button

  window:SetSounds("bag")
  window:SetCloseOnEscape(true)
  window:EnableHidingIsRemove(true)
  window:SetAlphaAnimation(0, 1, .1, .1)
  window:SetStartAnimation(true, true)
  window:SetUILayer("system")

  titleBar:SetHandler("OnDragStart", function ()
    window:StartMoving()
  end)

  titleBar:SetHandler("OnDragStop", function ()
    window:StopMovingOrSizing()
    CorrectWidgetScreenPos(window)
  end)

  closeButton:SetHandler("OnClick", function ()
    window:Show(false)
  end)

  saveEditbox:SetHandler("OnTextChanged", function (self)
    saveButton:Enable(#saveEditbox:GetText() ~= 0)
  end)

  saveEditbox:SetHandler("OnEnterPressed", function (self)
    if #saveEditbox:GetText() ~= 0 then
      saveButton:SaveUI()
    end
  end)

  function dropdown:UpdateList()
    local savedUIBounds, error = table.load(filePath)

    if not error then
      loadCombobox.selectorBtn:SetText("")
      dropdown:ClearItem()

      local list = {}
      for key in pairs(savedUIBounds) do
        list[#list + 1] = key
      end

      local enableLoadCombobox = #list > 0

      if enableLoadCombobox then
        table.sort(list, function (a, b) return a:lower() < b:lower() end)

        for key, value in pairs(list) do
          dropdown:AppendItemByTable({
            text = value,
            value = key
          })
        end

        dropdown:Select(0)

        local max = dropdown:GetMaxTop()

        vslider:SetMinMaxValues(0, max)

        local enableVSlider = max > 0

        upButton:Enable(enableVSlider)
        thumb:Enable(enableVSlider)
        downButton:Enable(enableVSlider)

        if enableVSlider then
          scrollBackground:SetTextureColor("default")
          vslider:Up(max)
        else
          scrollBackground:SetTextureColor("disable")
        end
      end

      selectorBtn:Enable(enableLoadCombobox)
      toggle:Enable(enableLoadCombobox)
      loadButton:Enable(enableLoadCombobox)
      loadDeleteButton:Enable(enableLoadCombobox)
    end
  end

  dropdown:UpdateList()

  saveButton:Enable(false)

  function saveButton:SaveUI()
    if #saveEditbox:GetText() ~= 0 then
      local savedUIBounds, error = table.load(filePath)

      if not error then
        local uiBoundCollection = {}
        local key = saveEditbox:GetText()

        saveEditbox:SetText("")

        for _, key in pairs(uiBoundKeys) do
          local uiBound = UIParent:GetUIBound(key)

          uiBoundCollection[key] = uiBound
        end

        savedUIBounds[key] = uiBoundCollection
        local success = table.save(filePath, savedUIBounds)

        if success then
          dropdown:UpdateList()
        end
      end
    end
  end

  saveButton:SetHandler("OnClick", saveButton.SaveUI)

  loadDeleteButton:SetHandler("OnClick", function ()
    local savedUIBounds, error = table.load(filePath)

    if not error then
      local key = loadCombobox.selectorBtn:GetText()
      savedUIBounds[key] = nil

      local success = table.save(filePath, savedUIBounds)

      if success then
        dropdown:UpdateList()
      end
    end
  end)

  local step = 1

  vslider:SetHandler("OnSliderChanged", function (self, value)
    dropdown:SetTop(value)
  end)

  upButton:SetHandler("OnClick", function ()
    vslider:Up(step)
  end)

  downButton:SetHandler("OnClick", function ()
    vslider:Down(step)
  end)

  dropdown:SetHandler("OnWheelUp", function ()
    vslider:Up(step)
  end)

  dropdown:SetHandler("OnWheelDown", function ()
    vslider:Down(step)
  end)

  loadButton:SetHandler("OnClick", function ()
    window:Show(false)

    local savedUIBounds, error = table.load(filePath)

    if not error then
      local vsync  = X2Option:GetConsoleVariable("r_VSync")
      local uiName = loadCombobox.selectorBtn:GetText()

      for key, uiBound in pairs(savedUIBounds[uiName]) do
        UIParent:SetUIBound(key, uiBound)
      end

      if vsync == "1" then
        X2Option:SetConsoleVariable("r_VSync", "0")
      elseif vsync == "0" then
        X2Option:SetConsoleVariable("r_VSync", "1")
      end
    end
  end)

  return window
end

---Toggles the UI manager window.
---@param show boolean|nil
local function ToggleManagerWindow(show)
  -- If the window should be shown.
  if show == nil then
    show = uiManagerWindow == nil or not uiManagerWindow:IsVisible()
  end

  -- If the window should be shown and doesn't exist, create it.
  if show == true and uiManagerWindow == nil then
    uiManagerWindow = CreateUIManagerWindow()

    uiManagerWindow:SetDeletedHandler(function ()
      uiManagerWindow = nil
    end)
  end

  -- If the window exists, Show or Hide it.
  if uiManagerWindow then
    uiManagerWindow:Show(show)
  end
end

ADDON:RegisterContentTriggerFunc(UIC_UIMANAGER, ToggleManagerWindow)
ADDON:AddEscMenuButton(5, UIC_UIMANAGER, "optimizer", locale.addon.name)
