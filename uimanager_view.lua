ADDON:ImportObject(OBJECT.Button)
ADDON:ImportObject(OBJECT.Combobox)
ADDON:ImportObject(OBJECT.EmptyWidget)
ADDON:ImportObject(OBJECT.ImageDrawable)
ADDON:ImportObject(OBJECT.Listbox)
ADDON:ImportObject(OBJECT.NinePartDrawable)
ADDON:ImportObject(OBJECT.Slider)
ADDON:ImportObject(OBJECT.TextStyle)
ADDON:ImportObject(OBJECT.Window)
ADDON:ImportObject(OBJECT.X2Editbox)
ADDON:ImportObject(OBJECT.Textbox)

WINDOW             = {
  UIBOUND_NAME      = "ui_bound_uimanager",
  WIDTH             = 350,
  HEIGHT            = 200,
  TITLE_HEIGHT      = 45,
  MARGIN            = 20,
  ITEM_DIMENSION    = 30,
  VISIBLE_ROW_COUNT = 15
}

local defaultColor = UIParent:GetFontColor("default")
local blueColor    = UIParent:GetFontColor("blue")
local grayColor    = UIParent:GetFontColor("gray")
local inset        = { 8, 5, 20, 5 }

---Sets up the view of the ui manager window.
---@return Window
function SetViewOfUIManagerWindow()
  -- Create the main window.
  local window = UIParent:CreateWidget("window", "manager", "UIParent")
  window:SetWidth(WINDOW.WIDTH)
  window:AddAnchor("CENTER", 0, 0)

  -- Add background to the main window.
  local background = window:CreateDrawable(TEXTURE_PATH.DEFAULT, "main_bg", "background")
  background:AddAnchor("TOPLEFT", window, -5, -5)
  background:AddAnchor("BOTTOMRIGHT", window, 5, 5)

  -- Add title decoration to the main window.
  local decoration = window:CreateDrawable(TEXTURE_PATH.DEFAULT, "main_bg_deco", "background")
  decoration:AddAnchor("TOPLEFT", window, 0, -5)
  decoration:AddAnchor("TOPRIGHT", window, 0, -5)

  -- Create title bar.
  local titleBar = window:CreateChildWidget("window", "titleBar", 0, true)
  titleBar.titleStyle:SetAlign(ALIGN_CENTER)
  titleBar.titleStyle:SetSnap(true)
  titleBar.titleStyle:SetFont(FONT_PATH.SUB, FONT_SIZE.XLARGE)
  titleBar.titleStyle:SetColorByKey("title")
  titleBar:AddAnchor("TOPLEFT", window, 0, 0)
  titleBar:AddAnchor("TOPRIGHT", window, 0, 0)
  titleBar:SetTitleText(locale.addon.title)
  titleBar:EnableDrag(true)
  titleBar:SetHeight(WINDOW.TITLE_HEIGHT)

  -- Add close button to title bar.
  local closeButton = titleBar:CreateChildWidget("button", "closeButton", 0, true)
  closeButton:AddAnchor("TOPRIGHT", titleBar, 3, -3)
  closeButton:SetStyle("btn_close_default")

  -- Create content frame.
  local contentFrame = window:CreateChildWidget("emptywidget", "contentFrame", 0, true)
  contentFrame:AddAnchor("TOPLEFT", titleBar, "BOTTOMLEFT", WINDOW.MARGIN, 0)
  contentFrame:AddAnchor("TOPRIGHT", titleBar, "BOTTOMRIGHT", -WINDOW.MARGIN, 0)

  -- Create save frame.
  local saveFrame = contentFrame:CreateChildWidget("emptywidget", "saveFrame", 0, true)
  saveFrame:AddAnchor("TOPLEFT", 0, 0)
  saveFrame:AddAnchor("TOPRIGHT", 0, 0)

  -- Create save editbox for save frame.
  local saveEditbox = saveFrame:CreateChildWidget("x2editbox", "saveEditbox", 0, true)
  saveEditbox.guideTextStyle:SetAlign(ALIGN_LEFT)
  saveEditbox.guideTextStyle:SetColorByKey("guide_text_in_editbox")
  saveEditbox:SetGuideTextInset({ inset[1], inset[2], inset[3], inset[4] })
  saveEditbox:SetGuideText(locale.addon.guide)
  saveEditbox.style:SetColorByKey("default")
  saveEditbox.style:SetAlign(ALIGN_LEFT)
  saveEditbox:SetInset(inset[1], inset[2], inset[3], inset[4])
  saveEditbox:UseSelectAllWhenFocused(true)
  saveEditbox:SetCursorColorByColorKey("editbox_cursor_default")

  local saveEditboxBackground = saveEditbox:CreateDrawable(TEXTURE_PATH.DEFAULT, "editbox_df", "background")
  saveEditboxBackground:AddAnchor("TOPLEFT", saveEditbox, 0, 0)
  saveEditboxBackground:AddAnchor("BOTTOMRIGHT", saveEditbox, 0, 0)

  -- Create save button for save frame.
  local saveButton = saveFrame:CreateChildWidget("button", "saveButton", 0, true)
  saveButton:SetStyle("text_default")
  saveButton:SetText(locale.addon.save)

  saveFrame:SetHeight(saveButton:GetHeight())

  -- Create load frame.
  local loadFrame = contentFrame:CreateChildWidget("emptywidget", "loadFrame", 0, true)
  loadFrame:AddAnchor("TOPLEFT", saveFrame, "BOTTOMLEFT", 0, WINDOW.MARGIN)
  loadFrame:AddAnchor("TOPRIGHT", saveFrame, "BOTTOMRIGHT", 0, WINDOW.MARGIN)

  -- Create load combobox for load frame.
  local loadCombobox = loadFrame:CreateChildWidget("combobox", "loadCombobox", 0, true)

  local loadComboboxBackground = loadCombobox:CreateDrawable(TEXTURE_PATH.DEFAULT, "editbox_df", "background")
  loadComboboxBackground:AddAnchor("TOPLEFT", loadCombobox, 0, 0)
  loadComboboxBackground:AddAnchor("BOTTOMRIGHT", loadCombobox, 0, 0)

  local selectorBtn = loadCombobox.selectorBtn
  local selector    = loadCombobox.selector
  local toggle      = loadCombobox.toggle
  local dropdown    = loadCombobox.dropdown
  local upButton    = dropdown.upBtn
  local downButton  = dropdown.downBtn
  local vslider     = dropdown.vslider
  local thumb       = dropdown.vslider.thumb

  selectorBtn.style:SetAlign(ALIGN_LEFT)
  selectorBtn.style:SetEllipsis(true)
  selectorBtn:SetTextColor(defaultColor[1], defaultColor[2], defaultColor[3], defaultColor[4])
  selectorBtn:SetHighlightTextColor(defaultColor[1], defaultColor[2], defaultColor[3], defaultColor[4])
  selectorBtn:SetPushedTextColor(defaultColor[1], defaultColor[2], defaultColor[3], defaultColor[4])
  selectorBtn:SetDisabledTextColor(defaultColor[1], defaultColor[2], defaultColor[3], defaultColor[4])
  selectorBtn:SetInset(inset[1], inset[2], inset[3], inset[4])

  selector.guideTextStyle:SetAlign(ALIGN_LEFT)
  selector.guideTextStyle:SetColorByKey("guide_text_in_editbox")
  selector:SetGuideTextInset({ inset[1], inset[2], inset[3], inset[4] })
  selector:SetGuideText("Save a UI")

  toggle:AddAnchor("RIGHT", selectorBtn, -2, 2)
  toggle:SetStyle("grid_folder_down_arrow")

  dropdown.itemStyle:SetAlign(ALIGN_LEFT)
  dropdown:SetInset(inset[1], inset[2], inset[3], inset[4])
  dropdown:SetOveredItemColor(0, 0.5, 1, 0.2)
  dropdown:SetSelectedItemColor(0, 0.3, 0.5, 0.3)
  dropdown:SetDefaultItemTextColor(defaultColor[1], defaultColor[2], defaultColor[3], defaultColor[4])
  dropdown:SetOveredItemTextColor(blueColor[1], blueColor[2], blueColor[3], blueColor[4])
  dropdown:SetSelectedItemTextColor(blueColor[1], blueColor[2], blueColor[3], blueColor[4])
  dropdown:SetDisableItemTextColor(grayColor[1], grayColor[2], grayColor[3], grayColor[4])

  local dropdownBackground = dropdown:CreateDrawable(TEXTURE_PATH.DEFAULT, "editbox_df", "background")
  dropdownBackground:AddAnchor("TOPLEFT", dropdown, 0, 0)
  dropdownBackground:AddAnchor("BOTTOMRIGHT", dropdown, 0, 0)

  local buttonOffsetX = -4
  local buttonOffsetY = 8

  upButton:AddAnchor("TOPRIGHT", dropdown, buttonOffsetX, buttonOffsetY)
  upButton:SetExtent(20, 12)

  local upButtonNormalBackground = assert(upButton:CreateImageDrawable(TEXTURE_PATH.SCROLL, "background"))
  upButtonNormalBackground:SetTextureInfo("scroll_button_up", "normal")
  upButtonNormalBackground:AddAnchor("TOPLEFT", upButton, 0, 0)
  upButtonNormalBackground:AddAnchor("BOTTOMRIGHT", upButton, 0, 0)
  upButton:SetNormalBackground(upButtonNormalBackground)

  local upButtonHighlightBackground = assert(upButton:CreateImageDrawable(TEXTURE_PATH.SCROLL, "background"))
  upButtonHighlightBackground:SetTextureInfo("scroll_button_up", "over")
  upButtonHighlightBackground:AddAnchor("TOPLEFT", upButton, 0, 0)
  upButtonHighlightBackground:AddAnchor("BOTTOMRIGHT", upButton, 0, 0)
  upButton:SetHighlightBackground(upButtonHighlightBackground)

  local upButtonPushedBackground = assert(upButton:CreateImageDrawable(TEXTURE_PATH.SCROLL, "background"))
  upButtonPushedBackground:SetTextureInfo("scroll_button_up", "click")
  upButtonPushedBackground:AddAnchor("TOPLEFT", upButton, 0, 0)
  upButtonPushedBackground:AddAnchor("BOTTOMRIGHT", upButton, 0, 0)
  upButton:SetPushedBackground(upButtonPushedBackground)

  local upButtonDisabledBackground = assert(upButton:CreateImageDrawable(TEXTURE_PATH.SCROLL, "background"))
  upButtonDisabledBackground:SetTextureInfo("scroll_button_up", "disable")
  upButtonDisabledBackground:AddAnchor("TOPLEFT", upButton, 0, 0)
  upButtonDisabledBackground:AddAnchor("BOTTOMRIGHT", upButton, 0, 0)
  upButton:SetDisabledBackground(upButtonDisabledBackground)

  downButton:AddAnchor("BOTTOMRIGHT", dropdown, buttonOffsetX, -buttonOffsetY)
  downButton:SetExtent(20, 12)

  local downButtonNormalBackground = assert(downButton:CreateImageDrawable(TEXTURE_PATH.SCROLL, "background"))
  downButtonNormalBackground:SetTextureInfo("scroll_button_down", "normal")
  downButtonNormalBackground:AddAnchor("TOPLEFT", downButton, 0, 0)
  downButtonNormalBackground:AddAnchor("BOTTOMRIGHT", downButton, 0, 0)
  downButton:SetNormalBackground(downButtonNormalBackground)

  local downButtonHighlightBackground = assert(downButton:CreateImageDrawable(TEXTURE_PATH.SCROLL, "background"))
  downButtonHighlightBackground:SetTextureInfo("scroll_button_down", "over")
  downButtonHighlightBackground:AddAnchor("TOPLEFT", downButton, 0, 0)
  downButtonHighlightBackground:AddAnchor("BOTTOMRIGHT", downButton, 0, 0)
  downButton:SetHighlightBackground(downButtonHighlightBackground)

  local downButtonPushedBackground = assert(downButton:CreateImageDrawable(TEXTURE_PATH.SCROLL, "background"))
  downButtonPushedBackground:SetTextureInfo("scroll_button_down", "click")
  downButtonPushedBackground:AddAnchor("TOPLEFT", downButton, 0, 0)
  downButtonPushedBackground:AddAnchor("BOTTOMRIGHT", downButton, 0, 0)
  downButton:SetPushedBackground(downButtonPushedBackground)

  local downButtonDisabledBackground = assert(downButton:CreateImageDrawable(TEXTURE_PATH.SCROLL, "background"))
  downButtonDisabledBackground:SetTextureInfo("scroll_button_down", "disable")
  downButtonDisabledBackground:AddAnchor("TOPLEFT", downButton, 0, 0)
  downButtonDisabledBackground:AddAnchor("BOTTOMRIGHT", downButton, 0, 0)
  downButton:SetDisabledBackground(downButtonDisabledBackground)

  vslider:AddAnchor("TOPLEFT", upButton, "BOTTOMLEFT", 0, 0)
  vslider:AddAnchor("BOTTOMRIGHT", downButton, "TOPRIGHT", 0, 0)

  local scrollBackground = dropdown:CreateDrawable(TEXTURE_PATH.SCROLL, "scroll_frame_bg", "background")
  scrollBackground:SetTextureColor("default")
  scrollBackground:AddAnchor("TOPLEFT", vslider, 3, -9)
  scrollBackground:AddAnchor("BOTTOMRIGHT", vslider, -3, 9)
  dropdown.scrollBackground = scrollBackground

  thumb:SetWidth(20)

  local thumbNormalBackground = thumb:CreateDrawable(TEXTURE_PATH.SCROLL, "thumb_df", "background")
  thumbNormalBackground:AddAnchor("TOPLEFT", thumb, 0, 0)
  thumbNormalBackground:AddAnchor("BOTTOMRIGHT", thumb, 0, 0)
  thumb:SetNormalBackground(thumbNormalBackground)

  local thumbHighlightBackground = thumb:CreateDrawable(TEXTURE_PATH.SCROLL, "thumb_ov", "background")
  thumbHighlightBackground:AddAnchor("TOPLEFT", thumb, 0, 0)
  thumbHighlightBackground:AddAnchor("BOTTOMRIGHT", thumb, 0, 0)
  thumb:SetHighlightBackground(thumbHighlightBackground)

  local thumbPushedBackground = thumb:CreateDrawable(TEXTURE_PATH.SCROLL, "thumb_on", "background")
  thumbPushedBackground:AddAnchor("TOPLEFT", thumb, 0, 0)
  thumbPushedBackground:AddAnchor("BOTTOMRIGHT", thumb, 0, 0)
  thumb:SetPushedBackground(thumbPushedBackground)

  -- Create delete button for load frame.
  local loadDeleteButton = loadFrame:CreateChildWidget("button", "loadDeleteButton", 0, true)
  loadDeleteButton:SetStyle("wastebasket_shape_small")

  -- Create load button for load frame.
  local loadButton = loadFrame:CreateChildWidget("button", "loadButton", 0, true)
  loadButton:SetStyle("text_default")
  loadButton:SetText(locale.addon.load)

  loadFrame:SetHeight(loadButton:GetHeight())
  loadDeleteButton:SetExtent(loadButton:GetHeight(), loadButton:GetHeight())

  -- Create helper textbox.
  local helperTextbox = window:CreateChildWidget("textbox", "helperTextbox", 0, true)
  helperTextbox.style:SetAlign(ALIGN_LEFT)
  helperTextbox.style:SetColorByKey("gray")
  helperTextbox:AddAnchor("TOPLEFT", loadFrame, "BOTTOMLEFT", 0, WINDOW.MARGIN)
  helperTextbox:AddAnchor("TOPRIGHT", loadFrame, "BOTTOMRIGHT", 0, WINDOW.MARGIN)
  helperTextbox:SetAutoResize(true)

  helperTextbox:SetText(locale.addon.helper)

  -- Anchor elements in save frame.
  saveEditbox:AddAnchor("TOPLEFT", 0, 0)
  saveEditbox:AddAnchor("BOTTOMRIGHT", saveButton, "BOTTOMLEFT", 0, 0)
  saveButton:AddAnchor("TOPRIGHT", 0, 0)

  -- Anchor elements in load frame.
  loadCombobox:AddAnchor("TOPLEFT", 0, 0)
  loadCombobox:AddAnchor("BOTTOMRIGHT", loadDeleteButton, "BOTTOMLEFT", 0, 0)
  loadDeleteButton:AddAnchor("RIGHT", loadButton, "LEFT", 0, 0)
  loadButton:AddAnchor("TOPRIGHT", 0, 0)

  -- Set dropdown extent. selectorBtn is anchored to loadCombobox so we can only
  -- set the extent when the loadCombobox extent is known.
  dropdown:SetExtent(selectorBtn:GetWidth(), 10 * dropdown:GetHeight() + inset[2] + inset[4])

  local _, helperTextboxOffsetY = helperTextbox:GetOffset()
  local _, contentFrameOffsetY  = contentFrame:GetOffset()
  local _, windowOffsetY        = window:GetOffset()

  contentFrame:SetHeight(helperTextboxOffsetY - contentFrameOffsetY + helperTextbox:GetHeight())
  window:SetHeight(contentFrameOffsetY - windowOffsetY + contentFrame:GetHeight() + WINDOW.MARGIN)

  return window
end
