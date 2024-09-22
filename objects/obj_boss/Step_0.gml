/// @description Insert description here
script_execute(estado);

if vida <= 0 {
	obj_personagem.xp += drop_xp;
	instance_destroy();
}