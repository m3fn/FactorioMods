data:extend(  
{
 {
    type = "recipe",
    name = "euc-distinct-constant-combinator",
    enabled = true,
    ingredients =
    {
      {"constant-combinator", 2},
      {"electronic-circuit", 2}
    },
    result = "euc-distinct-constant-combinator"
  },
  {
    type = "recipe",
    name = "euc-simple-delay-combinator",
    enabled = true,
    ingredients =
    {
      {"arithmetic-combinator", 8},
      {"electronic-circuit", 12}
    },
    result = "euc-simple-delay-combinator"
  },
  {
    type = "recipe",
    name = "euc-inclusive-filter-combinator",
    enabled = true,
    ingredients =
    {
      {"decider-combinator", 8},
      {"electronic-circuit", 12}
    },
    result = "euc-inclusive-filter-combinator"
  },
}
)