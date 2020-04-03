function armorcal(player_index)
	global.max_equipment_movement_speed_bonus[player_index] = 0
    is = game.get_player(player_index).get_inventory(defines.inventory.character_armor)[1]
	if is then
		if is.valid_for_read then
			for i,eq in pairs(is.grid.equipment) do
				global.max_equipment_movement_speed_bonus[player_index] = (global.max_equipment_movement_speed_bonus[player_index] or 0) + eq.movement_bonus
			end
		end
    end
	if global.max_equipment_movement_speed_bonus[player_index] == 0 then
		game.get_player(player_index).gui.top["ade-open-gui-button"].visible = false
		game.get_player(player_index).gui.left["ade-main-frame"].visible = false
	else game.get_player(player_index).gui.top["ade-open-gui-button"].visible = true end
	--game.get_player(player_index).print(global.max_equipment_movement_speed_bonus[player_index])
end

function movement_bonus_update(player_index)
	player = game.get_player(player_index)
	if global.max_equipment_movement_speed_bonus[player_index] == 0 then 
		player.character_running_speed_modifier = 0
	else
		player.character_running_speed_modifier = ((1/(global.max_equipment_movement_speed_bonus[player_index]+1))-1)*(100-global.sliderval[player_index])/100
	end
	----player.print(global.max_equipment_movement_speed_bonus[player_index])
	----player.print(global.sliderval[player_index])
	--player.print(player.character_running_speed_modifier, {r=0, b=0, g=240})
	--player.print(player.character_running_speed, {r=255, b=0, g=0})
end

script.on_event(defines.events.on_player_joined_game, function(event)
	global.max_equipment_movement_speed_bonus = global.max_equipment_movement_speed_bonus or {}
	global.sliderval = global.sliderval or {}
	--global.slider = global.slider or {}
	
	player = game.get_player(event.player_index)
	local lGui = player.gui.left
    local tGui = player.gui.top
	
	if tGui["ade-open-gui-button"] then
        tGui["ade-open-gui-button"].destroy()
    end
	if lGui["ade-main-frame"] then
        lGui["ade-main-frame"].destroy()
    end
	--cGui.visible = false

    tGui.add{
	    name = "ade-open-gui-button",
        type = "sprite-button",
        tooltip = "Exoskeletion config",
        sprite = "ade-open-gui-button-sprite",
        style = "ade_small_buttons"
    }
	
	local frame = lGui.add{
		name="ade-main-frame",
		type="frame",
		caption="Adjust exoskeletion multipier",
		direction="vertical"
	}
	frame.visible = false
	
	local slider = frame.add{
		name="ade-slider",
		type="slider"
	}
	slider.set_slider_minimum_maximum(0, 100)
	slider.set_slider_value_step(5)
	slider.set_slider_discrete_slider(true)
	slider.set_slider_discrete_values(true)
	global.sliderval[event.player_index] = global.sliderval[event.player_index] or 100
	slider.slider_value = global.sliderval[event.player_index]
	slider.tooltip = slider.slider_value.."%"
	--for i,s in pairs(slider.children_names) do player.print(s) end
	armorcal(event.player_index)
	movement_bonus_update(event.player_index)
end)

script.on_event(defines.events.on_player_placed_equipment, function(event)
    armorcal(event.player_index)
	movement_bonus_update(event.player_index)
end)

script.on_event(defines.events.on_player_removed_equipment, function(event)
	armorcal(event.player_index)
	movement_bonus_update(event.player_index)
end)

script.on_event(defines.events.on_player_armor_inventory_changed, function(event)
    armorcal(event.player_index)
	movement_bonus_update(event.player_index)
	--player = game.get_player(event.player_index)
	--player.print(global.sliderval[event.player_index], {r=0, b=200, g=0})
	--player.print(event.element.name)
	--TODO
end)

script.on_event(defines.events.on_gui_value_changed, function(event)
	if event.element.name == "ade-slider" then
		armorcal(event.player_index)
		--player = game.get_player(event.player_index)
		--player.print(event.element.slider_value, {r=0, b=200, g=0})
		event.element.tooltip = event.element.slider_value.."%"
		global.sliderval[event.player_index] = event.element.slider_value
		movement_bonus_update(event.player_index)
		--player.print(event.element.name)
	end
end)

script.on_event(defines.events.on_gui_click, function(event)
	if event.element.name == "ade-open-gui-button" then
		--player = game.get_player(event.player_index)
		--player.print(event.element.parent.gui.center.name)
		event.element.gui.left["ade-main-frame"].visible = not event.element.gui.left["ade-main-frame"].visible
		--player.print(event.element.gui.left["ade-main-frame"].visible, {r=255, g=10, b=10})
	end
end)

script.on_event(defines.events.on_player_died, function(event)
    player = game.get_player(event.player_index)
    if player.name == "famfo" then
        player.print("Git gud fucking noob! xD", {r=50, g=113, b=12})
    end
end)