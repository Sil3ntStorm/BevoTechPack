// Mekanism
val mekLithiumDust = <Mekanism:OtherDust:4>;


// Modify Steel Infuser recipe (requires 3 diamonds or a third of a compressed diamond)
mods.mekanism.Infuser.removeRecipe(<Mekanism:OtherDust:1>);
mods.mekanism.Infuser.addRecipe("DIAMOND", 30, <Mekanism:EnrichedIron>, <IC2:itemIngot:3>);

// Harder disassembler recipe
recipes.remove(<Mekanism:AtomicDisassembler:100>);
recipes.addShaped(<Mekanism:AtomicDisassembler:100>, [[<ore:alloyUltimate>, <ore:battery>, <ore:alloyUltimate>], [<ore:itemEnrichedAlloy>, <ore:alloyUltimate>, <ore:itemEnrichedAlloy>], [<ore:alloyUltimate>, <ore:ingotRefinedObsidian>, <ore:alloyUltimate>]]);


// Remove Mekanism Lithium Dust from OreDict to prevent Lexikon, Unifier, Oredictionificator etc. from swapping world found ones to Mekanism.
// Seems buggy in Minetweaker, other mods (including NEI) still consider the removed item part of the oreDict Entry.
// See https://github.com/stanhebben/MineTweaker3/issues/272
val odDustLithium = <ore:dustLithium>;
odDustLithium.remove(mekLithiumDust);

// Only allow Mekanism Lithium Dust in Oxidizer Lithium Recipe
mods.mekanism.chemical.Oxidizer.removeRecipe(<gas:lithium>);
// Don't add this back due to MineTweaker OreDict Removal Bug, uncomment if https://github.com/stanhebben/MineTweaker3/issues/272 is fixed.
// If added allows for any OreDict Swapping Item/Block to be used to swap other Lithium to the Mekanism version and then be turned into Lithium.
//mods.mekanism.chemical.Oxidizer.addRecipe(mekLithiumDust, <gas:lithium> * 100); 

// Remove Salt to Brine Recipe from Oxidizer, should be done in SEP/SET.
mods.mekanism.chemical.Oxidizer.removeRecipe(<gas:brine>, <ore:dustSalt>);

// Remove Ore Block to Lithium Gas from Dissolution Chamber (NuclearCraft Lithium Ore found in world -> Dissolution Chamber -> Neutron Activator -> Tritium) 
// Can't 5x NuclearCraft Lithium anymore, but 4x is still possible and shouldn't pose a problem.
mods.mekanism.chemical.Dissolution.removeRecipe(<gas:lithium>);

// Fix Energy Tablets not having NBT Tag when crafted
recipes.remove(<Mekanism:EnergyTablet:100>);
recipes.addShaped(<Mekanism:EnergyTablet:100>.withTag({electricity: 0}), [[<minecraft:redstone>, <minecraft:gold_ingot>, <minecraft:redstone>], [<ore:itemEnrichedAlloy>, <minecraft:gold_ingot>, <ore:itemEnrichedAlloy>], [<minecraft:redstone>, <minecraft:gold_ingot>, <minecraft:redstone>]]);

// Only allow Mekanism Lithium Dust for Induction Cells
recipes.remove(<Mekanism:BasicBlock2:3>.onlyWithTag({tier:0}));
recipes.addShaped(<Mekanism:BasicBlock2:3>.withTag({tier:0}), [[mekLithiumDust, <Mekanism:EnergyTablet:*>.marked("tab1"), mekLithiumDust], [<Mekanism:EnergyTablet:*>.marked("tab2"), <Mekanism:EnergyCube:*>.onlyWithTag({tier:"Basic"}).marked("cube"), <Mekanism:EnergyTablet:*>.marked("tab3")], [mekLithiumDust, <Mekanism:EnergyTablet:*>.marked("tab4"), mekLithiumDust]], function(output, inputs, crafting) {
	return <Mekanism:BasicBlock2:3>.withTag({tier:0, energyStored: inputs.tab1.tag.electricity + inputs.tab2.tag.electricity + inputs.tab3.tag.electricity + inputs.tab4.tag.electricity + inputs.cube.tag.electricity});
});

// Only allow Mekanism Lithium Dust for Induction Providers
recipes.remove(<Mekanism:BasicBlock2:4>.onlyWithTag({tier:0}));
recipes.addShaped(<Mekanism:BasicBlock2:4>.withTag({tier:0}), [[mekLithiumDust, <ore:circuitBasic>, mekLithiumDust], [<ore:circuitBasic>, <Mekanism:EnergyCube:*>.onlyWithTag({tier:"Basic"}), <ore:circuitBasic>], [mekLithiumDust, <ore:circuitBasic>, mekLithiumDust]]);
