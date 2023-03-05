-- SFO adapt things for his chaos invasion. Some can be found in settings, others here
-- Need to be loaded after sf

if _G.sfo then
    GAM_LOG("Startup: SFO is active!");
    CI_SPECIAL_CHARACTERS.ARCHAON.effect_bundle = "wh_chaos_archaon_ai";
    CI_SPECIAL_CHARACTERS.KHOLEK.effect_bundle = "wh_chaos_kholek_ai";
    CI_SPECIAL_CHARACTERS.SIGVALD.effect_bundle = "wh_chaos_sigvald_ai";
    CI_SPECIAL_CHARACTERS.SARTHORAEL.effect_bundle = "wh_chaos_sarthorael_ai";
    CI_ARMY_TYPES.CHAOS.effect_bundle = "wh_chaos_hordes_ai";
    CI_ARMY_TYPES.CHAOS.buildings = {"wh_main_horde_chaos_settlement_5", "wh_main_horde_chaos_warriors_4", "wh_main_horde_chaos_weapons_2", "wh_main_horde_chaos_magic_2", "wh_main_horde_chaos_trolls_1", "wh_main_horde_chaos_dragon_ogres_2", "wh_main_horde_chaos_giants_1", "wh_main_horde_chaos_knights_2", "wh_main_horde_chaos_forge_2"};
    CI_ARMY_TYPES.BEASTMEN.effect_bundle = "wh_chaos_hordes_ai";
    CI_ARMY_TYPES.BEASTMEN.buildings = {"wh_dlc03_horde_beastmen_herd_5", "wh_dlc03_horde_beastmen_gors_3", "wh_dlc03_horde_beastmen_weapons_2", "wh_dlc03_horde_beastmen_creatures_3", "wh2_dlc17_horde_beastmen_army_buffs_terror_3", "wh_dlc03_horde_beastmen_ruination_2", "wh_dlc03_horde_beastmen_centigors_2", "wh2_dlc17_horde_beastmen_army_buffs_arcane_3", "wh_dlc03_horde_beastmen_minotaurs_2"};
    CI_ARMY_TYPES.NORSCA.effect_bundle = "wh_chaos_hordes_ai";
else
    GAM_LOG("Startup: SFO not active!");
end