local modname = "[NoVocationRequirements]"
log.info(modname .. " Start")

local config_file = "NoVocationRequirements.json"
local config = json.load_file(config_file) or {
    enable_no_vocation = true
}

local initialized = false
local original_item_data = {}

local function UpdateItems()
    local itemManager = sdk.get_managed_singleton("app.ItemManager")
    if not itemManager then return false end

    local itemDict = itemManager._ItemDataDict
    if not itemDict then return false end

    local count = itemDict:get_field("_count")
    if not count or count == 0 then return false end

    local entries = itemDict:get_field("_entries")
    if not entries then return false end

    local capacity = entries:get_Count()

    for i = 0, capacity - 1 do
        local entry = entries:get_element(i)
        if entry then
            local item = entry:get_field("value")

            if item then
                local itemId = item:get_field("_Id")

                if original_item_data[itemId] == nil then
                    original_item_data[itemId] = {
                        job = item._Job
                    }
                end

                if item._Job ~= nil then
                    item._Job = original_item_data[itemId].job
                end

                if config.enable_no_vocation then
                    if item._Job ~= nil then
                        if item:call("get_IsWeaponData") == false then
                            item._Job = 65535
                        end
                    end
                end
            end
        end
    end

    return true
end

re.on_frame(function()
    if initialized then return end
    
    local success = UpdateItems()
    if success then
        log.info(modname .. " Items cached and updated.")
        initialized = true
    end
end)

re.on_draw_ui(function()
    if imgui.tree_node(modname) then
        local changed = false
        local voc_changed, new_voc = imgui.checkbox("Enable No Vocation Requirements (Armor Only)", config.enable_no_vocation)

        if voc_changed then
            config.enable_no_vocation = new_voc
            changed = true
        end

        if changed then
            json.dump_file(config_file, config)
            UpdateItems()
        end

        imgui.tree_pop()
    end
end)