data:extend(  
{
 {
    type = "recipe",
    name = "euc-distinct-constant-combinator",
    enabled = true,
    ingredients =
    {
      {"constant-combinator", 2},
      {"electronic-circuit", 1}
    },
    result = "euc-distinct-constant-combinator"
  },
  {
    type = "recipe",
    name = "euc-simple-delay-combinator",
    enabled = true,
    ingredients =
    {
      {"arithmetic-combinator", 2},
      {"decider-combinator", 2},
      {"electronic-circuit", 1}
    },
    result = "euc-simple-delay-combinator"
  }
}
)