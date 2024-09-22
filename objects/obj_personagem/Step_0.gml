/// @description Insert description here
script_execute(estado);

depth =- y;

if alarm[1] <= 0 {
	st += 1;
}

st = clamp(st, 0, max_st[level]);

if xp >= max_st[level] {
	if level < 4 {
		xp = xp - max_xp[level];
	
		level++;
	
		vida = max_vida[level];
		st = max_st[level];
	}
}

if keyboard_check_pressed(vk_f2) {
	arma += 1;
}

if keyboard_check_pressed(vk_f1) {
	arma -= 1;
}

if arma >= Armas.Altura {
	arma = 0;
} else if arma < 0 {
	arma = Armas.Altura - 1;
}

if instance_exists(obj_item) && obj_inventario.inventario == false {
	var _inst = instance_nearest(x, y, obj_item);
	if distance_to_point(_inst.x, _inst.y) <= 20 {
		if keyboard_check_pressed(ord("Q")) {
			ds_grid_add_item(_inst.image_index, _inst.quantidade, _inst.sprite_index);
			
			instance_destroy(_inst);
		}
	}
}
