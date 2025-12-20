ADDON:ImportObject(OBJECT.Window)
ADDON:ImportObject(OBJECT.NinePartDrawable)
ADDON:ImportObject(OBJECT.ImageDrawable)
ADDON:ImportObject(OBJECT.TextStyle)
ADDON:ImportObject(OBJECT.Button)
ADDON:ImportObject(OBJECT.EmptyWidget)
ADDON:ImportObject(OBJECT.ListCtrl)
ADDON:ImportObject(OBJECT.Textbox)
ADDON:ImportObject(OBJECT.Slider)
ADDON:ImportObject(OBJECT.Editbox)
ADDON:ImportObject(OBJECT.X2Editbox)
ADDON:ImportObject(OBJECT.Combobox)
ADDON:ImportObject(OBJECT.Listbox)

WINDOW = {
  UIBOUND_NAME      = "ui_bound_uimanager",
  WIDTH             = 350,
  HEIGHT            = 200,
  TITLE_HEIGHT      = 45,
  MARGIN            = 20,
  ITEM_DIMENSION    = 30,
  VISIBLE_ROW_COUNT = 15
}

---Sets up the view of the ui manager window.
---@return Window
function SetViewOfUIManagerWindow()
  -- Create a window.
  local window = UIParent:CreateWidget("window", "manager", "UIParent")
  window:SetExtent(WINDOW.WIDTH, WINDOW.HEIGHT)
  window:AddAnchor("CENTER", 0, 0)

  -- Create a background.
  local background = window:CreateDrawable(TEXTURE_PATH.DEFAULT, "main_bg", "background")
  background:AddAnchor("TOPLEFT", window, -5, -5)
  background:AddAnchor("BOTTOMRIGHT", window, 5, 5)

  -- Create a title decoration.
  local decoration = window:CreateDrawable(TEXTURE_PATH.DEFAULT, "main_bg_deco", "background")
  decoration:AddAnchor("TOPLEFT", window, 0, -5)
  decoration:AddAnchor("TOPRIGHT", window, 0, -5)

  -- Create a title bar.
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

  -- Create a close button for the title bar.
  local closeButton = titleBar:CreateChildWidget("button", "closeButton", 0, true)
  closeButton:AddAnchor("TOPRIGHT", titleBar, 3, -3)
  closeButton:SetStyle("btn_close_default")

  -- Create a content frame.
  local contentFrame = window:CreateChildWidget("emptywidget", "contentFrame", 0, true)
  contentFrame:AddAnchor("TOPLEFT", titleBar, "BOTTOMLEFT", WINDOW.MARGIN, 0)
  contentFrame:AddAnchor("TOPRIGHT", titleBar, "BOTTOMRIGHT", -WINDOW.MARGIN, 0)

  -- Create a save frame.
  local saveFrame = contentFrame:CreateChildWidget("emptywidget", "saveFrame", 0, true)
  saveFrame:AddAnchor("TOPLEFT", 0, 0)
  saveFrame:AddAnchor("TOPRIGHT", 0, 0)

  -- Create a save editbox.
  local saveEditbox = saveFrame:CreateChildWidget("x2editbox", "saveEditbox", 0, true)
  saveEditbox:SetInset(8, 0, 8, 0)
  saveEditbox:UseSelectAllWhenFocused(true)
  saveEditbox.style:SetColorByKey("default")
  saveEditbox.style:SetAlign(ALIGN_LEFT)
  saveEditbox:SetGuideText(locale.addon.guideText)
  saveEditbox.guideTextStyle:SetAlign(ALIGN_LEFT)
  saveEditbox.guideTextStyle:SetColorByKey("guide_text_in_editbox")
  saveEditbox:SetGuideTextInset({ 8, 0, 8, 0 })

  local saveEditboxBackground = saveEditbox:CreateDrawable(TEXTURE_PATH.DEFAULT, "editbox_df", "background")
  saveEditboxBackground:AddAnchor("TOPLEFT", saveEditbox, 0, 0)
  saveEditboxBackground:AddAnchor("BOTTOMRIGHT", saveEditbox, 0, 0)

  -- Create a save button.
  local saveButton = saveFrame:CreateChildWidget("button", "saveButton", 0, true)
  saveButton:SetStyle("text_default")
  saveButton:SetText(locale.addon.save)

  saveFrame:SetHeight(saveButton:GetHeight())

  -- Create a load frame.
  local loadFrame = contentFrame:CreateChildWidget("emptywidget", "loadFrame", 0, true)
  loadFrame:AddAnchor("TOPLEFT", saveFrame, "BOTTOMLEFT", 0, WINDOW.MARGIN)
  loadFrame:AddAnchor("TOPRIGHT", saveFrame, "BOTTOMRIGHT", 0, WINDOW.MARGIN)

  -- Create a load combobox.
  local loadCombobox = loadFrame:CreateChildWidget("combobox", "loadCombobox", 0, true)
  local selectorBtn = loadCombobox.selectorBtn
  local selector = loadCombobox.selector
  local toggle = loadCombobox.toggle
  local dropdown = loadCombobox.dropdown
  local upButton = dropdown.upBtn
  local downButton = dropdown.downBtn
  local vslider = dropdown.vslider
  local thumb = dropdown.vslider.thumb

  local color = UIParent:GetFontColor("default")
  selectorBtn:SetTextColor(color[1], color[2], color[3], color[4])
  selectorBtn:SetHighlightTextColor(color[1], color[2], color[3], color[4])
  selectorBtn:SetPushedTextColor(color[1], color[2], color[3], color[4])
  selectorBtn:SetDisabledTextColor(color[1], color[2], color[3], color[4])
  selectorBtn:SetInset(8, 0, 8, 0)
  selectorBtn.style:SetAlign(ALIGN_LEFT)
  
  selector.guideTextStyle:SetAlign(ALIGN_LEFT)
  selector.guideTextStyle:SetColorByKey("guide_text_in_editbox")
  selector:SetGuideTextInset({ 8, 0, 8, 0 })
  selector:SetGuideText("Save a UI")

  dropdown.itemStyle:SetAlign(ALIGN_LEFT)

  local loadComboboxBackground = loadCombobox:CreateDrawable(TEXTURE_PATH.DEFAULT, "editbox_df", "background")
  loadComboboxBackground:AddAnchor("TOPLEFT", loadCombobox, 0, 0)
  loadComboboxBackground:AddAnchor("BOTTOMRIGHT", loadCombobox, 0, 0)

  toggle:AddAnchor("RIGHT", selectorBtn, -2, 2)
  toggle:SetStyle("grid_folder_down_arrow")

  local dropdownBackground = dropdown:CreateDrawable(TEXTURE_PATH.DEFAULT, "editbox_df", "background")
  dropdownBackground:AddAnchor("TOPLEFT", dropdown, 0, 0)
  dropdownBackground:AddAnchor("BOTTOMRIGHT", dropdown, 0, 0)

  local offsetX = -4
  local offSetY = 8
  upButton:AddAnchor("TOPRIGHT", dropdown, offsetX, offSetY)
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

  downButton:AddAnchor("BOTTOMRIGHT", dropdown, offsetX, -offSetY)
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

  thumb:EnableDrag(true)
  thumb:SetExtent(20, 40)

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

  vslider:SetMinThumbLength(50)

  local scrollBackground = dropdown:CreateDrawable(TEXTURE_PATH.SCROLL, "scroll_frame_bg", "background")
  scrollBackground:SetTextureColor("default")
  scrollBackground:AddAnchor("TOPLEFT", vslider, 2, -9)
  scrollBackground:AddAnchor("BOTTOMRIGHT", vslider, -3, 9)
  dropdown.scrollBackground = scrollBackground

  -- Create a delete button.
  local loadDeleteButton = loadFrame:CreateChildWidget("button", "loadDeleteButton", 0, true)
  loadDeleteButton:SetStyle("wastebasket_shape_small")
  loadDeleteButton:SetExtent(34, 34)

  -- Create a load button.
  local loadButton = loadFrame:CreateChildWidget("button", "loadButton", 0, true)
  loadButton:SetStyle("text_default")
  loadButton:SetText(locale.addon.load)

  loadFrame:SetHeight(loadButton:GetHeight())

  saveEditbox:AddAnchor("TOPLEFT", 0, 0)
  saveEditbox:AddAnchor("RIGHT", saveButton, "LEFT", 0, 0)
  saveEditbox:AddAnchor("BOTTOM", saveButton, "BOTTOM", 0, 0)
  saveButton:AddAnchor("TOPRIGHT", 0, 0)
  loadCombobox:AddAnchor("TOPLEFT", 0, 0)
  loadCombobox:AddAnchor("RIGHT", loadDeleteButton, "LEFT", 0, 0)
  loadDeleteButton:AddAnchor("RIGHT", loadButton, "LEFT", 0, 0)
  loadCombobox:AddAnchor("BOTTOM", loadButton, "BOTTOM", 0, 0)
  loadButton:AddAnchor("TOPRIGHT", 0, 0)

  dropdown:SetInset(5, 5, 20, 5)
  local left, top, right, bottom = dropdown:GetInset()
  dropdown:SetExtent(selectorBtn:GetWidth(), 10 * dropdown:GetHeight() + top + bottom)


  dropdown:SetOveredItemColor(0, 0.5, 1, 0.2)
  dropdown:SetSelectedItemColor(0, 0.3, 0.5, 0.3)

  local color = UIParent:GetFontColor("default")
  dropdown:SetDefaultItemTextColor(color[1], color[2], color[3], color[4])
  color = UIParent:GetFontColor("blue")
  dropdown:SetOveredItemTextColor(color[1], color[2], color[3], color[4])
  dropdown:SetSelectedItemTextColor(color[1], color[2], color[3], color[4])
  color = UIParent:GetFontColor("gray")
  dropdown:SetDisableItemTextColor(color[1], color[2], color[3], color[4])

  contentFrame:SetHeight(select(2, loadFrame:GetOffset()) - select(2, contentFrame:GetOffset()) + loadFrame:GetHeight())
  window:SetHeight(select(2, contentFrame:GetOffset()) - select(2, window:GetOffset()) + contentFrame:GetHeight() + WINDOW.MARGIN)

  return window
end
