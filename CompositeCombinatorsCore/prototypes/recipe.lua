data:extend(
{
  {
    type = "recipe",
    name = "composite-combinator-construction-data",
    enabled = false,
    ingredients =
    {
      {"constant-combinator", 2},
    },
    result = "composite-combinator-construction-data"
  },
}
)

if settings.startup['composite-combinators-dev-mode'].value then

data:extend(
{
  {
    type = "recipe",
    name = "composite-combinator-io-marker",
    enabled = true,
    ingredients =
    {
      {"constant-combinator", 1},
    },
    result = "composite-combinator-io-marker"
  },
}
)

end