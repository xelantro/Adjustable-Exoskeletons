data:extend{
   {
      type="sprite",
      name="ade-open-gui-button-sprite",
      filename = "__adjustable_exoskeletons__/exoskeleton-equipment.png",
      priority = "extra-high",
      width = 32,
      height = 32,
   },
}

data.raw["gui-style"].default.ade_buttons = {
   type="button_style",
   --parent="button_style",
   maximal_height = 65,
   minimal_height = 65,
   maximal_width = 65,
   minimal_width = 65,
   top_padding = 0,
   bottom_padding = 0,
   right_padding = 0,
   left_padding = 0,
   left_click_sound = {
      {
         filename = "__core__/sound/gui-click.ogg",
         volume = 1
      }
   },
   right_click_sound = {
      {
         filename = "__core__/sound/gui-click.ogg",
         volume = 1
      }
   }
}

data.raw["gui-style"].default.ade_small_buttons = {
   type="button_style",
   --parent="button_style",
   maximal_height = 36,
   minimal_height = 36,
   maximal_width = 36,
   minimal_width = 36,
   top_padding = 0,
   bottom_padding = 0,
   right_padding = 0,
   left_padding = 0,
   top_margin = 4,
   left_click_sound = {
      {
         filename = "__core__/sound/gui-click.ogg",
         volume = 1
      }
   },
   right_click_sound = {
      {
         filename = "__core__/sound/gui-click.ogg",
         volume = 1
      }
   }
}
