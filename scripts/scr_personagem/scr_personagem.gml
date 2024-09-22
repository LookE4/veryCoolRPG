function scr_personagem_andando(){
	//Movimentação
	gamepad_set_axis_deadzone(global.controle, 0.25);
	direita = keyboard_check(ord("D")) || gamepad_axis_value(global.controle, gp_axislh) > 0.25;
	cima = keyboard_check(ord("W")) || gamepad_axis_value(global.controle, gp_axislv) < -0.25;
	esquerda = keyboard_check(ord("A")) || gamepad_axis_value(global.controle, gp_axislh) < -0.25;
	baixo = keyboard_check(ord("S")) || gamepad_axis_value(global.controle, gp_axislv) > 0.25;

	hveloc = (direita - esquerda); // Calculating horizontal velocity
	vveloc = (baixo - cima); // Calculating vertical velocity

	veloc_dir = point_direction(x, y, x + hveloc, y + vveloc); // Calculating direction of movement

	if hveloc != 0 || vveloc != 0 { 
		veloc = 2; // Setting movement speed
	} else {
		veloc = 0; // If not moving, speed is 0
	}
	
	hveloc = lengthdir_x(veloc, veloc_dir); // Calculating horizontal velocity component
	vveloc = lengthdir_y(veloc, veloc_dir); // Calculating vertical velocity component

	colisao(); // Checking for collision with obstacles

	// Changing sprites based on the mouse direction
	if gamepad_is_connected(global.controle) {
		if gamepad_axis_value(global.controle, gp_axislh) != 0 || gamepad_axis_value(global.controle, gp_axislv) {
			dir = floor((point_direction(x, y, x + gamepad_axis_value(global.controle, gp_axislh), y + gamepad_axis_value(global.controle, gp_axislh)) + 45) / 90);
		}
	} else {
		dir = floor((point_direction(x, y, mouse_x, mouse_y) + 45) / 90);
	}

	if hveloc == 0 && vveloc == 0 {
		switch (dir) {
			default:
				sprite_index = spr_personagem_parado_direita;
			break;
			case 1:
				sprite_index = spr_personagem_parado_cima;
			break;	
			case 2:	
				sprite_index = spr_personagem_parado_esquerda;	
			break;	
			case 3:
				sprite_index = spr_personagem_parado_baixo;	
			break;
		}
	} else {
		switch (dir) {
			default:
				sprite_index = spr_personagem_correndo_direita;
			break;
			case 1:
				sprite_index = spr_personagem_correndo_cima;
			break;	
			case 2:	
				sprite_index = spr_personagem_correndo_esquerda;	
			break;	
			case 3:
				sprite_index = spr_personagem_correndo_baixo;	
			break;
		}
	}
	#region dash
	if st >= 10 { // Checking if enough stamina for dash
		if mouse_check_button(mb_right) || gamepad_button_check_pressed(global.controle, gp_face2) { // Checking if right mouse button is pressed
			st -= 10; // Decreasing stamina
			alarm[1] = 180; // Setting alarm for dash cooldown
			alarm[0] = 8; // Setting alarm for dash duration
			if gamepad_is_connected(global.controle) {
				if gamepad_axis_value(global.controle, gp_axislh) != 0 || gamepad_axis_value(global.controle, gp_axislv) {
					dash_dir = point_direction(x, y, x + gamepad_axis_value(global.controle, gp_axislh), y + gamepad_axis_value(global.controle, gp_axislh));
				}
			} else {
				dash_dir = point_direction(x, y, mouse_x, mouse_y);
			}
			estado = scr_personagem_dash; // Changing state to dash
		}
	}
	#endregion
	
	#region ataque espada
	if mouse_check_button_pressed(mb_left) || gamepad_button_check_pressed(global.controle, gp_face1) { // Checking if left mouse button is pressed
		if arma == Armas.Espada {
			image_index = 0; // Resetting attack animation frame
			switch (dir) {
				default:
					sprite_index = spr_personagem_atacando_direita;
				break;
				case 1:
					sprite_index = spr_personagem_atacando_cima;
				break;	
				case 2:	
					sprite_index = spr_personagem_atacando_esquerda;
				break;	
				case 3:
					sprite_index = spr_personagem_atacando_baixo;
				break;
			}
		
			estado = scr_personagem_atacando; // Changing state to attacking
		} else if arma == Armas.Arco {
			image_index = 0;
			
			estado = scr_personagem_arco;
		}
	}
	#endregion
}

function scr_personagem_dash() {
	tomar_dano = false
	hveloc = lengthdir_x(dash_veloc, dash_dir); // Calculating horizontal velocity component for dash
	vveloc = lengthdir_y(dash_veloc, dash_dir); // Calculating vertical velocity component for dash
	
	colisao(); // Checking for collision with obstacles
	
	var _inst = instance_create_layer(x, y, "Instances", obj_dash); // Creating dash object
	_inst.sprite_index = sprite_index; // Setting dash object sprite
}

function scr_personagem_atacando() {
	if image_index >= 1 { // Checking if attack animation has progressed enough
		if atacar = false { // Checking if attack has not been executed yet
			switch (dir) {
				default:
					instance_create_layer(x + 10, y, "Instances", obj_hitbox); // Creating hitbox to the right
				break;
				case 1:
					instance_create_layer(x, y - 10,"Instances", obj_hitbox); // Creating hitbox upwards
				break;	
				case 2:	
					instance_create_layer(x - 10, y, "Instances", obj_hitbox); // Creating hitbox to the left
				break;	
				case 3:
					instance_create_layer(x, y + 10, "Instances", obj_hitbox); // Creating hitbox downwards
				break;
			}
			atacar = true; // Setting attack executed flag
		}
	}
	
	if fim_da_animacao() { // Checking if attack animation is finished
		estado = scr_personagem_andando; // Changing state to walking
		atacar = false; // Resetting attack executed flag
	}
}
	
function scr_personaegm_hit() {
	if alarm[2] > 0 {
		var _veloc = 3
		hveloc = lengthdir_x(_veloc, empurrar_dir); // Calculate horizontal velocity
		vveloc = lengthdir_y(_veloc, empurrar_dir); // Calculate vertical velocity

		colisao(); // Handle collision
	} else {
		estado = scr_personagem_andando;
	}
}
	
function scr_personagem_arco() {
	dir = floor((point_direction(x, y, mouse_x, mouse_y) + 45) / 90);
	
	switch (dir) {
		default:
			sprite_index = spr_personagem_arco_direita;
		break;
		case 1:
			sprite_index = spr_personagem_arco_cima;
		break;	
		case 2:	
			sprite_index = spr_personagem_arco_esquerda;	
		break;	
		case 3:
			sprite_index = spr_personagem_arco_baixo;	
		break;
	}
	
	if fim_da_animacao() {
		image_index = 4;
	}
	
	if mouse_check_button_released(mb_left) {
		if image_index >= 4 {
			var _dir = point_direction(x, y, mouse_x, mouse_y);
			var _xx = lengthdir_x(5, _dir);
			var _yy = lengthdir_y(5, _dir);
			
			var _flecha = instance_create_layer(x + _xx, y + _yy, "Instances", obj_flecha);
			_flecha.direction = _dir;
			_flecha.image_angle = _dir;
			_flecha.speed = 12;
			
			empurrar_dir = point_direction(mouse_x, mouse_y, x, y,);
			alarm[2] = 5;
			estado = scr_personaegm_hit;
		} else {
			estado = scr_personagem_andando;	
		}
	}
}