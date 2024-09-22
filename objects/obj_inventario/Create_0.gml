/// @description Insert description here
inventario = false;
escala = 3;

comeco_x = 15 * escala;
comeco_y = 24 * escala;

slots_h = 8;
slots_v = 3;
total_solts = slots_h * slots_v;
tamanho_slots = 16 * escala;
buffer = 1 * escala;

inventario_l = sprite_get_width(spr_inventario) * escala;
inventario_a = sprite_get_height(spr_inventario) * escala;

item_selecionado = -1;
pos_selecionado = -1;

enum Info_Armas {
	Espada, 
	Arco,
	Cajado,
	Altura
}

enum Items_inimigos {
	Slime_parte,
	Orc_capacete,
	Orc_dente,
	Altura
}

enum Infos {
	Item,
	Quantidade,
	Sprite,
	Altura
}

grid_items = ds_grid_create(Infos.Altura, total_solts);
ds_grid_set_region(grid_items, 0, 0, Infos.Altura - 1, total_solts - 1, -1);

ds_grid_add_item(Info_Armas.Arco, 1, spr_items_armas);
ds_grid_add_item(Info_Armas.Espada, 2, spr_items_armas);
ds_grid_add_item(Info_Armas.Cajado, 4, spr_items_armas);

ds_grid_add_item(Items_inimigos.Slime_parte, 12, spr_items_inimigos);
ds_grid_add_item(Items_inimigos.Orc_capacete, 24, spr_items_inimigos);
ds_grid_add_item(Items_inimigos.Orc_dente, 48, spr_items_inimigos);