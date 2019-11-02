data:extend(
{
    -- The Comment to describe what is happening here: 
	------------ ---> signals <--- ------------
	------------ yes ------------
	{
		type = "virtual-signal",
		name = "signal-composite-combinators-core-technical",
		icon = "__CompositeCombinatorsCore__/graphics/signal-reset.png",
		icon_size = 32,
		subgroup = "other",
		order = "e[readwrite]-[technical-not-supposed-to-be-here]",
		flags = {"hidden"},
	},
	{
		type = "virtual-signal",
		name = "signal-composite-combinators-base-technical",
		icon = "__CompositeCombinatorsCore__/graphics/signal-reset.png",
		icon_size = 32,
		subgroup = "other",
		order = "e[readwrite]-[technical-not-supposed-to-be-here]",
		flags = {"hidden"},
	}
}
)