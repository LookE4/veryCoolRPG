/// @description Insert description here
script_execute(estado);

depth =- y;

if vida <= 0 {
	//código se for um slime grande, quando morto cria dois menores
    if slime_grande == true {
        repeat(2) {
			var _dist = irandom_range(25, 50);
			instance_create_layer(x + _dist, y, "Instances", obj_slime);
        }
    }
	
	obj_personagem.xp += drop_xp;
	instance_destroy();
}