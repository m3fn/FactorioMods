if settings.startup['composite-combinators-dev-mode'].value then

data:extend(
{
  {
    type = "item-with-tags",
    name = "composite-combinator-io-marker",
    icon = "__CompositeCombinatorsCore__/graphics/icons/io-marker.png",
    icon_size = 32,
    flags = {  },
    subgroup = "circuit-network",
    place_result="composite-combinator-io-marker",
    order = "c[combinators]-d[composite-combinator-io-marker]",
    stack_size= 50,
  }
}
)

end

data:extend(
{
  { -- TODO: is this needed?
    type = "item",
    name = "composite-combinator-construction-data",
    icon = "__base__/graphics/icons/constant-combinator.png",
    icon_size = 32,
    flags = {  },
    subgroup = "circuit-network",
    place_result="composite-combinator-construction-data",
    order = "c[combinators]-c[composite-combinator-construction-data]",
    stack_size= 50,
  },
  {
    type = "item-with-tags",
    name = "composite-combinator-constant-component",
    icon = "__CompositeCombinatorsCore__/graphics/blank.png",
    icon_size = 32,
    flags = {  },
    subgroup = "circuit-network",
    place_result="composite-combinator-constant-component",
    order = "c[combinators]-d[composite-combinator-constant-component]",
    stack_size= 50,
  },
  {
    type = "item-with-tags",
    name = "composite-combinator-arithmetic-component",
    icon = "__CompositeCombinatorsCore__/graphics/blank.png",
    icon_size = 32,
    flags = {  },
    subgroup = "circuit-network",
    place_result="composite-combinator-arithmetic-component",
    order = "c[combinators]-d[dre-logic-cells-arithmetic-component]",
    stack_size= 50,
  },
  {
    type = "item-with-tags",
    name = "composite-combinator-decider-component",
    icon = "__CompositeCombinatorsCore__/graphics/blank.png",
    icon_size = 32,
    flags = {  },
    subgroup = "circuit-network",
    place_result="composite-combinator-decider-component",
    order = "c[combinators]-d[composite-combinator-decider-component]",
    stack_size= 50,
  }
}
)