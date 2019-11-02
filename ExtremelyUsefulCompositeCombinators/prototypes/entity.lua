local function generate_arithmetic_combinator(combinator)
  combinator.sprites =
    make_4way_animation_from_spritesheet({ layers =
      {
        {
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/arithmetic-combinator.png",
          width = 74,
          height = 64,
          frame_count = 1,
          shift = util.by_pixel(1, 8),
          hr_version =
          {
            scale = 0.5,
            filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-arithmetic-combinator.png",
            width = 144,
            height = 124,
            frame_count = 1,
            shift = util.by_pixel(0.5, 7.5)
          }
        },
        {
          filename = "__base__/graphics/entity/combinator/arithmetic-combinator-shadow.png",
          width = 76,
          height = 78,
          frame_count = 1,
          shift = util.by_pixel(14, 24),
          draw_as_shadow = true,
          hr_version =
          {
            scale = 0.5,
            filename = "__base__/graphics/entity/combinator/hr-arithmetic-combinator-shadow.png",
            width = 148,
            height = 156,
            frame_count = 1,
            shift = util.by_pixel(13.5, 24.5),
            draw_as_shadow = true
          }
        }
      }
    })
  combinator.activity_led_sprites =
  {
    north =
    {
      filename = "__base__/graphics/entity/combinator/activity-leds/arithmetic-combinator-LED-N.png",
      width = 8,
      height = 8,
      frame_count = 1,
      shift = util.by_pixel(8, -12),
      hr_version =
      {
        scale = 0.5,
        filename = "__base__/graphics/entity/combinator/activity-leds/hr-arithmetic-combinator-LED-N.png",
        width = 16,
        height = 14,
        frame_count = 1,
        shift = util.by_pixel(8.5, -12.5)
      }
    },
    east =
    {
      filename = "__base__/graphics/entity/combinator/activity-leds/arithmetic-combinator-LED-E.png",
      width = 8,
      height = 8,
      frame_count = 1,
      shift = util.by_pixel(17, -1),
      hr_version =
      {
        scale = 0.5,
        filename = "__base__/graphics/entity/combinator/activity-leds/hr-arithmetic-combinator-LED-E.png",
        width = 14,
        height = 14,
        frame_count = 1,
        shift = util.by_pixel(16.5, -1)
      }
    },
    south =
    {
      filename = "__base__/graphics/entity/combinator/activity-leds/arithmetic-combinator-LED-S.png",
      width = 8,
      height = 8,
      frame_count = 1,
      shift = util.by_pixel(-8, 7),
      hr_version =
      {
        scale = 0.5,
        filename = "__base__/graphics/entity/combinator/activity-leds/hr-arithmetic-combinator-LED-S.png",
        width = 16,
        height = 16,
        frame_count = 1,
        shift = util.by_pixel(-8, 7.5)
      }
    },
    west =
    {
      filename = "__base__/graphics/entity/combinator/activity-leds/arithmetic-combinator-LED-W.png",
      width = 8,
      height = 8,
      frame_count = 1,
      shift = util.by_pixel(-16, -12),
      hr_version =
      {
        scale = 0.5,
        filename = "__base__/graphics/entity/combinator/activity-leds/hr-arithmetic-combinator-LED-W.png",
        width = 14,
        height = 14,
        frame_count = 1,
        shift = util.by_pixel(-16, -12.5)
      }
    }
  }
  combinator.plus_symbol_sprites =
  {
    north =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 15,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 30,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    east =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 15,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 30,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      },
    south =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 15,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 30,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    west =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 15,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 30,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      }
  }
  combinator.minus_symbol_sprites =
  {
    north =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 30,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 60,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    east =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 30,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 60,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      },
    south =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 30,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 60,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    west =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 30,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 60,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      }
  }
  combinator.multiply_symbol_sprites =
  {
    north =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 45,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 90,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    east =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 45,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 90,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      },
    south =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 45,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 90,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    west =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 45,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 90,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      }
  }
  combinator.divide_symbol_sprites =
  {
    north =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 60,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 120,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    east =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 60,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 120,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      },
    south =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 60,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 120,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    west =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 60,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 120,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      }
  }
  combinator.modulo_symbol_sprites =
  {
    north =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 75,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 150,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    east =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 75,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 150,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      },
    south =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 75,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 150,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    west =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 75,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 150,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      }
  }
  combinator.power_symbol_sprites =
  {
    north =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    east =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      },
    south =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    west =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      }
  }
  combinator.left_shift_symbol_sprites =
  {
    north =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 15,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 30,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    east =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 15,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 30,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      },
    south =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 15,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 30,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    west =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 15,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 30,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      }
  }
  combinator.right_shift_symbol_sprites =
  {
    north =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 30,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 60,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    east =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 30,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 60,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      },
    south =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 30,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 60,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    west =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 30,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 60,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      }
  }
  combinator.and_symbol_sprites =
  {
    north =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 45,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 90,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    east =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 45,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 90,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      },
    south =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 45,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 90,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    west =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 45,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 90,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      }
  }
  combinator.or_symbol_sprites =
  {
    north =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 60,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 120,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    east =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 60,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 120,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      },
    south =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 60,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 120,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    west =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 60,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 120,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      }
  }
  combinator.xor_symbol_sprites =
  {
    north =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 75,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 150,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    east =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 75,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 150,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      },
    south =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 75,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 150,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    west =
      {
        filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/delay-combinator-displays.png",
        x = 75,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-delay-combinator-displays.png",
          x = 150,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      }
  }
  combinator.input_connection_points =
  {
    {
      shadow =
      {
        red = util.by_pixel(5, 26),
        green = util.by_pixel(24.5, 26)
      },
      wire =
      {
        red = util.by_pixel(-8.5, 14),
        green = util.by_pixel(10, 14)
      }
    },
    {
      shadow =
      {
        red = util.by_pixel(-10, -3.5),
        green = util.by_pixel(-10, 9.5)
      },
      wire =
      {
        red = util.by_pixel(-25.5, -15),
        green = util.by_pixel(-25.5, -1.5)
      }
    },
    {
      shadow =
      {
        red = util.by_pixel(24.5, -11.5),
        green = util.by_pixel(5.5, -9.5)
      },
      wire =
      {
        red = util.by_pixel(9.5, -21.5),
        green = util.by_pixel(-9, -21.5)
      }
    },
    {
      shadow =
      {
        red = util.by_pixel(44, 12),
        green = util.by_pixel(44, -1.5)
      },
      wire =
      {
        red = util.by_pixel(26, -1),
        green = util.by_pixel(26, -14.5)
      }
    }
  }
  combinator.output_connection_points =
  {
    {
      shadow =
      {
        red = util.by_pixel(4, -12.5),
        green = util.by_pixel(23.5, -12)
      },
      wire =
      {
        red = util.by_pixel(-9, -22),
        green = util.by_pixel(10, -22)
      }
    },
    {
      shadow =
      {
        red = util.by_pixel(38.5, -1.5),
        green = util.by_pixel(38, 12)
      },
      wire =
      {
        red = util.by_pixel(23, -13),
        green = util.by_pixel(23, 1)
      }
    },
    {
      shadow =
      {
        red = util.by_pixel(24, 26.5),
        green = util.by_pixel(4, 27)
      },
      wire =
      {
        red = util.by_pixel(10, 15.5),
        green = util.by_pixel(-9, 15.5)
      }
    },
    {
      shadow =
      {
        red = util.by_pixel(-7, 12.5),
        green = util.by_pixel(-7.5, -1.5)
      },
      wire =
      {
        red = util.by_pixel(-22.5, 1),
        green = util.by_pixel(-22.5, -12)
      }
    }
  }
  return combinator
end



local function generate_constant_combinator(combinator)
  combinator.sprites =
    make_4way_animation_from_spritesheet({ layers =
      {
        {
          filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/constant-combinator.png",
          width = 58,
          height = 52,
          frame_count = 1,
          shift = util.by_pixel(0, 5),
          hr_version =
          {
            scale = 0.5,
            filename = "__ExtremelyUsefulCompositeCombinators__/graphics/entity/hr-constant-combinator.png",
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



data:extend(
{

generate_constant_combinator
  {
    type = "constant-combinator",
    name = "euc-distinct-constant-combinator",
    icon = "__ExtremelyUsefulCompositeCombinators__/graphics/icons/constant-combinator.png",
    icon_size = 32,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "euc-distinct-constant-combinator"},
    max_health = 120,
    corpse = "constant-combinator-remnants",

    collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},

    item_slot_count = 0,

    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },

    activity_led_light =
    {
      intensity = 0,
      size = 1,
      color = {r = 1.0, g = 1.0, b = 1.0}
    },

    activity_led_light_offsets =
    {
      {0.296875, -0.40625},
      {0.25, -0.03125},
      {-0.296875, -0.078125},
      {-0.21875, -0.46875}
    },

    circuit_wire_max_distance = 11
  },
  
  generate_arithmetic_combinator
  {
    type = "arithmetic-combinator",
    name = "euc-simple-delay-combinator",
    icon = "__ExtremelyUsefulCompositeCombinators__/graphics/icons/arithmetic-combinator.png",
    icon_size = 32,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "euc-simple-delay-combinator"},
    max_health = 150,
    corpse = "arithmetic-combinator-remnants",
    collision_box = {{-0.35, -0.65}, {0.35, 0.65}},
    selection_box = {{-0.5, -1}, {0.5, 1}},

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
        volume = 0.45
      },
      max_sounds_per_type = 2,
      match_speed_to_activity = true
    },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },

    activity_led_light =
    {
      intensity = 0,
      size = 1,
      color = {r = 1.0, g = 1.0, b = 1.0}
    },

    activity_led_light_offsets =
    {
      {0.234375, -0.484375},
      {0.5, 0},
      {-0.265625, 0.140625},
      {-0.453125, -0.359375}
    },

    screen_light =
    {
      intensity = 0.3,
      size = 0.6,
      color = {r = 1.0, g = 1.0, b = 1.0}
    },

    screen_light_offsets =
    {
      {0.015625, -0.234375},
      {0.015625, -0.296875},
      {0.015625, -0.234375},
      {0.015625, -0.296875}
    },

    input_connection_bounding_box = {{-0.5, 0}, {0.5, 1}},
    output_connection_bounding_box = {{-0.5, -1}, {0.5, 0}},

    circuit_wire_max_distance = 11
  },
  
}
)