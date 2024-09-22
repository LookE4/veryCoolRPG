/// @description Insert description here
draw_sprite(spr_personagem_sombra, 0, x, y + 4);

draw_self();

if alarm[3] > 0 {
	if image_alpha >= 1 {
		dano_alpha = -0.05;
		draw_yscale = .90;
		draw_xscale = .90;
	} else if image_alpha <= 0 {
		dano_alpha = 0.05;
		draw_yscale = 1;
		draw_xscale = 1;
	}
	
	image_yscale = draw_yscale;
	image_xscale = draw_xscale;
	image_alpha += dano_alpha;
} else {
	image_yscale = 1;
	image_xscale = 1;
	image_alpha = 1;
}