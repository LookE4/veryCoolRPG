// Function for collision handling
function colisao() {
	// Horizontal collision handling
	if place_meeting(x + hveloc, y, obj_parede) { // If there is a wall horizontally
		while !place_meeting(x + sign(hveloc), y, obj_parede) { // Move until no collision
			x += sign(hveloc); // Move one pixel at a time
		}
		hveloc = 0; // Stop horizontal movement
	}
	x += hveloc; // Update x position

	// Vertical collision handling
	if place_meeting(x, y + vveloc, obj_parede) { // If there is a wall vertically
		while !place_meeting(x, y + sign(vveloc), obj_parede) { // Move until no collision
			y += sign(vveloc); // Move one pixel at a time
		}
		vveloc = 0; // Stop vertical movement
	}
	y += vveloc; // Update y position
}

// Function for slime AI to check if it should chase the player
function scr_slime_checar_personagem() {
	if distance_to_object(obj_personagem) <= dist_aggro { // If player is within aggro distance
		estado = scr_slime_preseguindo; // Change state to chasing
	}
}

// Function for slime AI to choose its next state
function scr_slime_escolher_estado() {
	scr_slime_checar_personagem(); // Check if player is nearby
	prox_estado = choose(scr_slime_andando, scr_slime_parado); // Choose randomly between walking and standing

	if prox_estado == scr_slime_andando {
		estado = scr_slime_andando; // Change state to walking
		dest_x = irandom_range(0, room_width); // Random destination x-coordinate
		dest_y = irandom_range(0, room_height); // Random destination y-coordinate

	} else if prox_estado == scr_slime_parado {
		estado = scr_slime_parado; // Change state to standing still
	}
}

// Function for slime AI to walk towards a destination
function scr_slime_andando() {
	scr_slime_checar_personagem(); // Check if player is nearby
	image_speed = 1; // Set animation speed to normal

	if distance_to_point(dest_x, dest_y) > veloc { // If not at destination
		var _dir = point_direction(x, y, dest_x, dest_y); // Calculate direction
		hveloc = lengthdir_x(veloc, _dir); // Calculate horizontal velocity
		vveloc = lengthdir_y(veloc, _dir); // Calculate vertical velocity
	} else {
		x = dest_x; // Arrived at destination, set x coordinate
		y = dest_y; // Arrived at destination, set y coordinate
	}

	colisao(); // Handle collision
}

// Function for slime AI to stand still
function scr_slime_parado() {
	scr_slime_checar_personagem(); // Check if player is nearby
	image_speed = 0.5; // Set animation speed to half
}

// Function for slime AI to chase the player
function scr_slime_preseguindo() {
	image_speed = 1.5; // Set animation speed to faster

	dest_x = obj_personagem.x; // Set destination to player's x-coordinate
	dest_y = obj_personagem.y; // Set destination to player's y-coordinate

	var _dir = point_direction(x, y, dest_x, dest_y); // Calculate direction
	hveloc = lengthdir_x(veloc_perseg, _dir); // Calculate horizontal velocity
	vveloc = lengthdir_y(veloc_perseg, _dir); // Calculate vertical velocity

	colisao(); // Handle collision

	if distance_to_object(obj_personagem) >= dist_desaggro { // If player is far away
		estado = scr_slime_escolher_estado; // Change state to randomly choose next state
		alarm[0] = irandom_range(120, 240); // Set a random delay before choosing next state
	}
}

// Function for slime AI to handle being hit
function scr_slime_hit() {
	alarm[2] = 100;
	empurrar_veloc = lerp(empurrar_veloc, 0, 0.05); // Decrease pushback speed

	hveloc = lengthdir_x(empurrar_veloc, empurrar_dir); // Calculate horizontal velocity
	vveloc = lengthdir_y(empurrar_veloc, empurrar_dir); // Calculate vertical velocity

	colisao(); // Handle collision
}
