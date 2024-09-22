/// @description Insert description here
var _escala = 3;
var _gui_a = display_get_gui_height();
var _spr_a = sprite_get_height(spr_hud_vida) * _escala;
var _hud_a = _gui_a - _spr_a;

if instance_exists(obj_personagem)  {
	var _vida = obj_personagem.vida;
	var _maxvida = obj_personagem.max_vida[obj_personagem.level];
	
	var _st = obj_personagem.st;
	var _maxst = obj_personagem.max_st[obj_personagem.level];
	
	var _xpa = sprite_get_height(spr_hud_exp);
	var _xp = obj_personagem.xp;
	var _maxxp = obj_personagem.max_xp[obj_personagem.level];
		
	//barra de vida
	draw_sprite_ext(spr_hud_barra_vida, 0, 0, _hud_a, (_vida/_maxvida) * _escala, _escala, 0, c_white, 1);

	//barra de estamina
	draw_sprite_ext(spr_hud_barra_estamina, 0, 0, _hud_a + (8 * _escala), (_st/_maxst) * _escala, _escala, 0, c_white, 1);
	
	//HUD
	draw_sprite_ext(spr_hud_vida, 0, 0, _hud_a, _escala, _escala, 0, c_white, 1);
	
	//EXP
	draw_sprite_ext(spr_hud_exp, 0, 0, _gui_a - _xpa - 15, _escala, _escala, 0, c_white, 1);
	draw_sprite_ext(spr_hud_exp_barra, 0, 9, _gui_a - _xpa - 6, (_xp/_maxxp) * _escala, _escala, 0, c_white, 1);
	
	//LEVEL
	draw_text(20, 20, string(obj_personagem.level) + " / " + "5")
	
	//BARRA DO BOSS
	var _gl = display_get_gui_width();
	
	if instance_exists(par_boss) {
		var _sprw = sprite_get_width(spr_boss_hud) * _escala;
		
		draw_sprite_ext(spr_boss_hud, 0, _gl / 2 - _sprw / 2, 100, _escala, _escala, 0, c_white, 1);
		draw_sprite_ext(spr_boss_vida, 0, _gl / 2 - _sprw / 2 + 6, 100, obj_boss.vida / obj_boss.vida_max * _escala, _escala, 0, c_white, 1);
	}
}