
local debug = false -- bibok

local genericComponentActivityLedSprites = 
  {
     filename = "__CompositeCombinatorsCore__/graphics/activity-leds/component-LED.png",
     width = 8,
     height = 8,
     frame_count = 1,
     shift = util.by_pixel(0, 0),
     hr_version =
     {
       scale = 0.5,
       filename = "__CompositeCombinatorsCore__/graphics/activity-leds/hr-component-LED.png",
       width = 16,
       height = 16,
       frame_count = 1,
       shift = util.by_pixel(0, 0),
     }
  }
  
local constantComponentWireConnectionOffset = 
  {
    red = {0.0,0.0},
    green = {0.0,0.0}
  }
  
function generate_decider_component(combinator)
  local spriteSide = 
  {
    filename = "__base__/graphics/entity/combinator/combinator-displays.png",
    x = 0,
    y = 0,
    width = 1,
    height = 1,
    shift = util.by_pixel(0, 0),
    hr_version =
    {
      scale = 1,
      filename = "__base__/graphics/entity/combinator/hr-combinator-displays.png",
      x = 0,
      y = 0,
      width = 1,
      height = 1,
      shift = util.by_pixel(0, 0)
    }
  }
    
  local sprite = 
  {
    north = spriteSide,
    east = spriteSide,
    south = spriteSide,
    west = spriteSide
  }

  combinator.sprites =
    make_4way_animation_from_spritesheet({ layers =
      {
        {
          filename = not debug and "__CompositeCombinatorsCore__/graphics/components/not-debug-component.png" or "__CompositeCombinatorsCore__/graphics/components/decider-component.png",
          width = 2,
          height = 2,
          frame_count = 1,
          shift = util.by_pixel(0, 0),
          hr_version =
          {
            scale = 1,
            filename = not debug and "__CompositeCombinatorsCore__/graphics/components/not-debug-component.png" or "__CompositeCombinatorsCore__/graphics/components/decider-component.png",
            width = 2,
            height = 2,
            frame_count = 1,
            shift = util.by_pixel(0, 0)
          }
        }
      }
    })
  
  combinator.activity_led_sprites =
  {
    north = genericComponentActivityLedSprites,
    east = genericComponentActivityLedSprites,
    south = genericComponentActivityLedSprites,
    west = genericComponentActivityLedSprites
  }
  
  combinator.greater_symbol_sprites = sprite
  combinator.less_symbol_sprites = sprite
  combinator.equal_symbol_sprites = sprite
  combinator.not_equal_symbol_sprites = sprite
  combinator.less_or_equal_symbol_sprites = sprite
  combinator.greater_or_equal_symbol_sprites = sprite
 
  
 combinator.input_connection_points =
  {
    {
      shadow = constantComponentWireConnectionOffset,
      wire = constantComponentWireConnectionOffset
    },
    {
      shadow = constantComponentWireConnectionOffset,
      wire = constantComponentWireConnectionOffset
    },
    {
      shadow = constantComponentWireConnectionOffset,
      wire = constantComponentWireConnectionOffset
    },
    {
      shadow = constantComponentWireConnectionOffset,
      wire = constantComponentWireConnectionOffset
    }
  }
  combinator.output_connection_points =
  {
    {
      shadow = constantComponentWireConnectionOffset,
      wire = constantComponentWireConnectionOffset
    },
    {
      shadow = constantComponentWireConnectionOffset,
      wire = constantComponentWireConnectionOffset
    },
    {
      shadow = constantComponentWireConnectionOffset,
      wire = constantComponentWireConnectionOffset
    },
    {
      shadow = constantComponentWireConnectionOffset,
      wire = constantComponentWireConnectionOffset
    }
  }
  if not debug then
    combinator.draw_circuit_wires = false
    combinator.draw_copper_wires = false
  end
  return combinator
end


  
local function generate_arithmetic_component(combinator)
  local spriteSide = 
  {
    filename = "__base__/graphics/entity/combinator/combinator-displays.png",
    x = 0,
    y = 0,
    width = 1,
    height = 1,
    shift = util.by_pixel(0, 0),
    hr_version =
    {
      scale = 1,
      filename = "__base__/graphics/entity/combinator/hr-combinator-displays.png",
      x = 0,
      y = 0,
      width = 1,
      height = 1,
      shift = util.by_pixel(0, 0)
    }
  }
    
  local sprite = 
  {
    north = spriteSide,
    east = spriteSide,
    south = spriteSide,
    west = spriteSide
  }
  
  combinator.sprites =
    make_4way_animation_from_spritesheet({ layers =
      {
        {
          filename = not debug and "__CompositeCombinatorsCore__/graphics/components/not-debug-component.png" or "__CompositeCombinatorsCore__/graphics/components/arithmetic-component.png",
          width = 2,
          height = 2,
          frame_count = 1,
          shift = util.by_pixel(0, 0),
          hr_version =
          {
            scale = 1,
            filename = not debug and "__CompositeCombinatorsCore__/graphics/components/not-debug-component.png" or "__CompositeCombinatorsCore__/graphics/components/arithmetic-component.png",
            width = 2,
            height = 2,
            frame_count = 1,
            shift = util.by_pixel(0, 0)
          }
        }
      }
    })
  
  combinator.activity_led_sprites =
  {
    north = genericComponentActivityLedSprites,
    east = genericComponentActivityLedSprites,
    south = genericComponentActivityLedSprites,
    west = genericComponentActivityLedSprites
  }
  
  combinator.plus_symbol_sprites = sprite
  combinator.minus_symbol_sprites = sprite
  combinator.multiply_symbol_sprites = sprite
  combinator.divide_symbol_sprites = sprite
  combinator.modulo_symbol_sprites = sprite
  combinator.power_symbol_sprites = sprite
  combinator.left_shift_symbol_sprites = sprite
  combinator.right_shift_symbol_sprites = sprite
  combinator.and_symbol_sprites = sprite
  combinator.or_symbol_sprites = sprite
  combinator.xor_symbol_sprites = sprite
  
  combinator.input_connection_points =
  {
    {
      shadow = constantComponentWireConnectionOffset,
      wire = constantComponentWireConnectionOffset
    },
    {
      shadow = constantComponentWireConnectionOffset,
      wire = constantComponentWireConnectionOffset
    },
    {
      shadow = constantComponentWireConnectionOffset,
      wire = constantComponentWireConnectionOffset
    },
    {
      shadow = constantComponentWireConnectionOffset,
      wire = constantComponentWireConnectionOffset
    }
  }
  combinator.output_connection_points =
  {
    {
      shadow = constantComponentWireConnectionOffset,
      wire = constantComponentWireConnectionOffset
    },
    {
      shadow = constantComponentWireConnectionOffset,
      wire = constantComponentWireConnectionOffset
    },
    {
      shadow = constantComponentWireConnectionOffset,
      wire = constantComponentWireConnectionOffset
    },
    {
      shadow = constantComponentWireConnectionOffset,
      wire = constantComponentWireConnectionOffset
    }
  }
  if not debug then
    combinator.draw_circuit_wires = false
    combinator.draw_copper_wires = false
  end
  return combinator
end


function generate_component_constant_combinator(combinator, isConstructionData)
  if isConstructionData then
    combinator.sprites =
    make_4way_animation_from_spritesheet({ layers =
      {
        {
          filename = not debug and "__CompositeCombinatorsCore__/graphics/components/not-debug-component.png" or "__CompositeCombinatorsCore__/graphics/components/construction-data.png",
          width = 2,
          height = 2,
          frame_count = 1,
          shift = util.by_pixel(0, 0),
          hr_version =
          {
            scale = 1,
            filename = not debug and "__CompositeCombinatorsCore__/graphics/components/not-debug-component.png" or "__CompositeCombinatorsCore__/graphics/components/construction-data.png",
            width = 2,
            height = 2,
            frame_count = 1,
            shift = util.by_pixel(0, 0),
          },
        }
      },
    })
  else
    combinator.sprites =
    make_4way_animation_from_spritesheet({ layers =
      {
        {
          filename = not debug and "__CompositeCombinatorsCore__/graphics/components/not-debug-component.png" or "__CompositeCombinatorsCore__/graphics/components/constant-component.png",
          width = 2,
          height = 2,
          frame_count = 1,
          shift = util.by_pixel(0, 0),
          hr_version =
          {
            scale = 1,
            filename = not debug and "__CompositeCombinatorsCore__/graphics/components/not-debug-component.png" or "__CompositeCombinatorsCore__/graphics/components/constant-component.png",
            width = 2,
            height = 2,
            frame_count = 1,
            shift = util.by_pixel(0, 0),
          },
        }
      },
    })
  end

  
  combinator.activity_led_sprites =
  {
    north = genericComponentActivityLedSprites,
    east = genericComponentActivityLedSprites,
    south = genericComponentActivityLedSprites,
    west = genericComponentActivityLedSprites
  }

  combinator.activity_led_light_offsets =
  {
    {0, 0},
    {0, 0},
    {0, 0},
    {0, 0}
  }

  combinator.circuit_wire_max_distance = 20

  combinator.circuit_wire_connection_points =
  {
    {
      shadow = constantComponentWireConnectionOffset,
      wire = constantComponentWireConnectionOffset
    },
    {
      shadow = constantComponentWireConnectionOffset,
      wire = constantComponentWireConnectionOffset
    },
    {
      shadow = constantComponentWireConnectionOffset,
      wire = constantComponentWireConnectionOffset
    },
    {
      shadow = constantComponentWireConnectionOffset,
      wire = constantComponentWireConnectionOffset
    }
  }
  
  if not debug then
    combinator.draw_circuit_wires = false
    combinator.draw_copper_wires = false
  end
  
  return combinator
end

function generate_constant_combinator(combinator)
  combinator.sprites =
    make_4way_animation_from_spritesheet({ layers =
      {
        {
          filename = "__CompositeCombinatorsCore__/graphics/entity/io-marker.png",
          width = 58,
          height = 52,
          frame_count = 1,
          shift = util.by_pixel(0, 5),
          hr_version =
          {
            scale = 0.5,
            filename = "__CompositeCombinatorsCore__/graphics/entity/hr-io-marker.png",
            width = 114,
            height = 102,
            frame_count = 1,
            shift = util.by_pixel(0, 5)
          }
        },
        {
          filename = "__base__/graphics/entity/combinator/constant-combinator-shadow.png",
          width = 50,
          height = 34,
          frame_count = 1,
          shift = util.by_pixel(9, 6),
          draw_as_shadow = true,
          hr_version =
          {
            scale = 0.5,
            filename = "__base__/graphics/entity/combinator/hr-constant-combinator-shadow.png",
            width = 98,
            height = 66,
            frame_count = 1,
            shift = util.by_pixel(8.5, 5.5),
            draw_as_shadow = true
          }
        }
      }
    })
  combinator.activity_led_sprites =
  {
    north =
    {
      filename = "__base__/graphics/entity/combinator/activity-leds/constant-combinator-LED-N.png",
      width = 8,
      height = 6,
      frame_count = 1,
      shift = util.by_pixel(9, -12),
      hr_version =
      {
        scale = 0.5,
        filename = "__base__/graphics/entity/combinator/activity-leds/hr-constant-combinator-LED-N.png",
        width = 14,
        height = 12,
        frame_count = 1,
        shift = util.by_pixel(9, -11.5)
      }
    },
    east =
    {
      filename = "__base__/graphics/entity/combinator/activity-leds/constant-combinator-LED-E.png",
      width = 8,
      height = 8,
      frame_count = 1,
      shift = util.by_pixel(8, 0),
      hr_version =
      {
        scale = 0.5,
        filename = "__base__/graphics/entity/combinator/activity-leds/hr-constant-combinator-LED-E.png",
        width = 14,
        height = 14,
        frame_count = 1,
        shift = util.by_pixel(7.5, -0.5)
      }
    },
    south =
    {
      filename = "__base__/graphics/entity/combinator/activity-leds/constant-combinator-LED-S.png",
      width = 8,
      height = 8,
      frame_count = 1,
      shift = util.by_pixel(-9, 2),
      hr_version =
      {
        scale = 0.5,
        filename = "__base__/graphics/entity/combinator/activity-leds/hr-constant-combinator-LED-S.png",
        width = 14,
        height = 16,
        frame_count = 1,
        shift = util.by_pixel(-9, 2.5)
      }
    },
    west =
    {
      filename = "__base__/graphics/entity/combinator/activity-leds/constant-combinator-LED-W.png",
      width = 8,
      height = 8,
      frame_count = 1,
      shift = util.by_pixel(-7, -15),
      hr_version =
      {
        scale = 0.5,
        filename = "__base__/graphics/entity/combinator/activity-leds/hr-constant-combinator-LED-W.png",
        width = 14,
        height = 16,
        frame_count = 1,
        shift = util.by_pixel(-7, -15)
      }
    }
  }
  combinator.circuit_wire_connection_points =
  {
    {
      shadow =
      {
        red = util.by_pixel(7, -6),
        green = util.by_pixel(23, -6)
      },
      wire =
      {
        red = util.by_pixel(-8.5, -17.5),
        green = util.by_pixel(7, -17.5)
      }
    },
    {
      shadow =
      {
        red = util.by_pixel(32, -5),
        green = util.by_pixel(32, 8)
      },
      wire =
      {
        red = util.by_pixel(16, -16.5),
        green = util.by_pixel(16, -3.5)
      }
    },
    {
      shadow =
      {
        red = util.by_pixel(25, 20),
        green = util.by_pixel(9, 20)
      },
      wire =
      {
        red = util.by_pixel(9, 7.5),
        green = util.by_pixel(-6.5, 7.5)
      }
    },
    {
      shadow =
      {
        red = util.by_pixel(1, 11),
        green = util.by_pixel(1, -2)
      },
      wire =
      {
        red = util.by_pixel(-15, -0.5),
        green = util.by_pixel(-15, -13.5)
      }
    }
  }
  return combinator
end

if settings.startup['composite-combinators-dev-mode'].value then

data:extend(
{
  ------------------------------------------------------------------------------------------------
  -- Input/Output marker
  ------------------------------------------------------------------------------------------------

  generate_constant_combinator
  {
    type = "constant-combinator",
    name = "composite-combinator-io-marker",
    icon = "__CompositeCombinatorsCore__/graphics/icons/io-marker.png",
    icon_size = 32,
    flags = { "placeable-neutral", "player-creation" },
    minable = { mining_time = 0.1, result = "composite-combinator-io-marker" },
    max_health = 120,
    corpse = "constant-combinator-remnants",

    collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},

    item_slot_count = 1,

    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },

    activity_led_light =
    {
      intensity = 1,
      size = 3,
      color = { r = 0, g = 0.5, b = 1 }
    },

    activity_led_light_offsets =
    {
      {0.296875, -0.40625},
      {0.25, -0.03125},
      {-0.296875, -0.078125},
      {-0.21875, -0.46875}
    },

    circuit_wire_max_distance = 9
  }
}
)

end

data:extend(
{
  ------------------------------------------------------------------------------------------------
  -- Composite Combinator construction memory storage
  ------------------------------------------------------------------------------------------------

  generate_component_constant_combinator(
  {
    type = "constant-combinator",
    name = "composite-combinator-construction-data",
    icon = "__CompositeCombinatorsCore__/graphics/icons/construction-data.png",
    icon_size = 32,
    flags = { "placeable-neutral", "player-creation", "placeable-off-grid", "not-flammable", "not-selectable-in-game", "not-rotatable", "not-repairable", "not-on-map", "hide-alt-info", "not-upgradable" },
    max_health = 120,
    corpse = "small-remnants",

    collision_box = {{0.0, -0.0}, {0.0, 0.0}},
    selection_box = {{0.0, 0.0}, {0, 0}},

    item_slot_count = 8192,

    selectable_in_game = false,

    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },

    collision_mask = { "doodad-layer" } -- IDK
  }, true),

  ------------------------------------------------------------------------------------------------
  -- Composite Combinator components (constant, decider, arithmetic)
  ------------------------------------------------------------------------------------------------

  generate_component_constant_combinator(
  {
    type = "constant-combinator",
    name = "composite-combinator-constant-component",
    icon = "__base__/graphics/icons/constant-combinator.png",
    icon_size = 32,
    flags = { "placeable-neutral", "placeable-off-grid", "not-blueprintable", "not-flammable", "not-selectable-in-game", "not-rotatable", "not-repairable", "not-on-map", "hidden", "hide-alt-info", "not-upgradable" },
    minable = {hardness = 0.2, mining_time = 0.5, result = "composite-combinator-constant-component"},
    max_health = 120,
    corpse = "small-remnants",

    collision_box = {{0.0, -0.0}, {0.0, 0.0}},
    selection_box = {{0.0, 0.0}, {0.0, 0.0}},

    item_slot_count = 64,
  
    selectable_in_game = debug,

    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
  }, false),

  generate_arithmetic_component
  {
    type = "arithmetic-combinator",
    name = "composite-combinator-arithmetic-component",
    icon = "__base__/graphics/icons/arithmetic-combinator.png",
    icon_size = 32,
    flags = { "placeable-neutral", "placeable-off-grid", "not-blueprintable", "not-flammable", "not-selectable-in-game", "not-rotatable", "not-repairable", "not-on-map", "hidden", "hide-alt-info", "not-upgradable" },
    minable = {hardness = 0.2, mining_time = 0.5, result = "arithmetic-combinator"},
    max_health = 150,
    corpse = "small-remnants",
    collision_box = {{0.0, -0.0}, {0.0, 0.0}},
    selection_box = debug and {{-1, -1}, {2, 2}} or {{0.0, 0.0}, {0.0, 0.0}},

    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input"
    },
    active_energy_usage = "1KW",

    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/combinator.ogg",
        volume = 0.35,
      },
      max_sounds_per_type = 2,
      match_speed_to_activity = true,
    },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },

    activity_led_light = { intensity = 0, size = 0, color = { r = 1, g = 1, b = 1 } },
    activity_led_light_offsets = { {0, 0}, {0, 0}, {0, 0}, {0, 0} },
    screen_light = { intensity = 0, size = 0, color = { r = 1, g = 1, b = 1 } },
    screen_light_offsets = { {0, 0}, {0, 0}, {0, 0}, {0, 0} },

    input_connection_bounding_box = {{-0.0, 0}, {0.0, 0}},
    output_connection_bounding_box = {{-0.0, -0}, {0.0, 0}},
  
    selectable_in_game = debug,

    circuit_wire_max_distance = 9
  },

  generate_decider_component
  {
    type = "decider-combinator",
    name = "composite-combinator-decider-component",
    icon = "__base__/graphics/icons/decider-combinator.png",
    icon_size = 32,
    flags = { "placeable-neutral", "placeable-off-grid", "not-blueprintable", "not-flammable", "not-selectable-in-game", "not-rotatable", "not-repairable", "not-on-map", "hidden", "hide-alt-info", "not-upgradable" },
    minable = {hardness = 0.2, mining_time = 0.5, result = "composite-combinator-decider-component" },
    max_health = 150,
    corpse = "small-remnants",
    collision_box = {{0.0, -0.0}, {0.0, 0.0}},
    selection_box = debug and {{-1, -1}, {2, 2}}  or {{0.0, 0.0}, {0.0, 0.0}},

    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input"
    },
    active_energy_usage = "1KW",

    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/combinator.ogg",
        volume = 0.35,
      },
      max_sounds_per_type = 2,
      match_speed_to_activity = true,
    },

    activity_led_light = { intensity = 0, size = 0, color = { r = 1, g = 1, b = 1 } },
    activity_led_light_offsets = { {0, 0}, {0, 0}, {0, 0}, {0, 0} },
    screen_light = { intensity = 0, size = 0, color = { r = 1, g = 1, b = 1 } },
    screen_light_offsets = { {0, 0}, {0, 0}, {0, 0}, {0, 0} },


    input_connection_bounding_box = {{-0.0, 0}, {0, 0}},
    output_connection_bounding_box = {{-0.0, -0}, {0, 0}},
  
    selectable_in_game = debug,

    input_connection_points =
    {
      {
        shadow = constantComponentWireConnectionOffset,
        wire = constantComponentWireConnectionOffset
      },
      {
        shadow = constantComponentWireConnectionOffset,
        wire = constantComponentWireConnectionOffset
      },
      {
        shadow = constantComponentWireConnectionOffset,
        wire = constantComponentWireConnectionOffset
      },
      {
        shadow = constantComponentWireConnectionOffset,
        wire = constantComponentWireConnectionOffset
      }
    },

    output_connection_points =
    {
      {
        shadow = constantComponentWireConnectionOffset,
        wire = constantComponentWireConnectionOffset
      },
      {
        shadow = constantComponentWireConnectionOffset,
        wire = constantComponentWireConnectionOffset
      },
      {
        shadow = constantComponentWireConnectionOffset,
        wire = constantComponentWireConnectionOffset
      },
      {
        shadow = constantComponentWireConnectionOffset,
        wire = constantComponentWireConnectionOffset
      }
    },
    circuit_wire_max_distance = 9
  },
}
)