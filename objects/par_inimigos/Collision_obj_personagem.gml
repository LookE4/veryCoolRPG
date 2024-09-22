/// @description Insert description here
if other.tomar_dano == true {
	var _dir = point_direction(x, y, other.x, other.y);

	with(other) {
		empurrar_dir = _dir;
		estado = scr_personaegm_hit;
		alarm[2] = 10;
		alarm[3] = 180;
		tomar_dano = false;
		vida -= 1;
	}
	var _inst = instance_create_layer(x, y, "Instances", obj_dano);
	_inst.alvo = other;
	_inst.dano = 1;
}

