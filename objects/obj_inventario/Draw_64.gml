/// @description Insira a descrição aqui
var _guil = display_get_gui_width();
var _guia = display_get_gui_height();

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

if inventario == true {
    var _invx = _guil / 2 - inventario_l / 2;
    var _invy = _guia / 2 - inventario_a / 2;
    
    // Desenha o fundo do inventário
    draw_sprite_ext(spr_inventario, 0, _invx, _invy, escala, escala, 0, c_white, 1);  
    
    var ix = 0;
    var iy = 0;
	
    for (var i = 0; i < total_solts; i++) {
	   var _slotsx = _invx + comeco_x + ((tamanho_slots + buffer) * ix);
        var _slotsy = _invy + comeco_y + ((tamanho_slots + buffer) * iy);
        
        // Verifica se o mouse está sobre este slot
        if point_in_rectangle(_mx, _my, _slotsx, _slotsy, _slotsx + tamanho_slots, _slotsy + tamanho_slots) {
            draw_sprite_ext(spr_inventario_seletor, 0, _slotsx, _slotsy, escala, escala, 0, c_white, 1);
            
			if keyboard_check_pressed(ord("Q"))  && grid_items[# Infos.Item, i] != -1 {
				var _inst = instance_create_layer(obj_personagem.x, obj_personagem.y, "Instances", obj_item);
				_inst.sprite_index = grid_items[# Infos.Sprite, i];
				_inst.image_index = grid_items[# Infos.Item, i];
				_inst.quantidade = grid_items[# Infos.Quantidade, i];
				
				//Esvaziando o slot
				grid_items[# Infos.Item, i] = -1;
				grid_items[# Infos.Quantidade, i] = -1;
				grid_items[# Infos.Sprite, i] = -1;
			}
			
            if mouse_check_button_pressed(mb_left) {
                if item_selecionado == -1 {
                    // Se nenhum item estiver selecionado
                    item_selecionado = grid_items[# Infos.Item, i];
                    pos_selecionado = i;
                } else {
                    // Se um item já estiver selecionado
                    // 1 - Se o item selecionado for o mesmo e estiver em um slot diferente
                    if item_selecionado == grid_items[# Infos.Item, i] && pos_selecionado != i && grid_items[# Infos.Sprite, i] == grid_items[# Infos.Sprite, pos_selecionado]  {
                        grid_items[# Infos.Quantidade, i] += grid_items[# Infos.Quantidade, pos_selecionado];
                        
                        grid_items[# Infos.Item, pos_selecionado] = -1;
                        grid_items[# Infos.Quantidade, pos_selecionado] = -1;
                        item_selecionado = -1;
                        pos_selecionado = -1;
                    } 
                    // 2 - Caso o slot selecionado esteja vazio
                    else if grid_items[# Infos.Item, i] == -1 {
                        grid_items[# Infos.Item, i] = grid_items[# Infos.Item, pos_selecionado];
                        grid_items[# Infos.Quantidade, i] = grid_items[# Infos.Quantidade, pos_selecionado];
                        grid_items[# Infos.Sprite, i] = grid_items[# Infos.Sprite, pos_selecionado];
						
                        grid_items[# Infos.Item, pos_selecionado] = -1;
                        grid_items[# Infos.Quantidade, pos_selecionado] = -1;
                        grid_items[# Infos.Sprite, pos_selecionado] = -1;
                        item_selecionado = -1;
                        pos_selecionado = -1;
                    }
                    // 3 - Caso o slot selecionado já tenha um item e iremos trocar as posições
                    else if grid_items[# Infos.Item, pos_selecionado] != grid_items[# Infos.Item, i] || grid_items[# Infos.Sprite, pos_selecionado] != grid_items[# Infos.Sprite, i] {
                        var _item = grid_items[# Infos.Item, i];
                        var _quantidade = grid_items[# Infos.Quantidade, i];
						var _spr = grid_items[# Infos.Sprite, i];
                        
                        grid_items[# Infos.Item, i] = grid_items[# Infos.Item, pos_selecionado];
                        grid_items[# Infos.Quantidade, i] = grid_items[# Infos.Quantidade, pos_selecionado];
                        grid_items[# Infos.Sprite, i] = grid_items[# Infos.Sprite, pos_selecionado];
                        
                        grid_items[# Infos.Item, pos_selecionado] = _item;
                        grid_items[# Infos.Quantidade, pos_selecionado] = _quantidade;
                        grid_items[# Infos.Sprite, pos_selecionado] = _spr;
                        
                        item_selecionado = -1;
                        pos_selecionado = -1;
                    }
                }
            }
        } 
               
		var _sprite = grid_items[# Infos.Sprite, i];
		
        // Desenha o item se o slot não estiver vazio
        if grid_items[# Infos.Item, i] != -1 {
            // Desenha o sprite do item
            draw_sprite_ext(_sprite, grid_items[# Infos.Item, i], _slotsx, _slotsy, escala, escala, 0, c_white, 1);
            
            // Desenha a quantidade do item
            draw_set_font(fnt_text);
            draw_set_halign(fa_center);
            draw_text_colour_outline(_slotsx + tamanho_slots, _slotsy + tamanho_slots, string(grid_items[# Infos.Quantidade, i]), 4, c_black, 16, 100, 100);
        }
        
        ix++;
        if (ix >= slots_h) {
            ix = 0;
            iy++;
        }
    }
    
    // 4 - Largar o item selecionado
    if mouse_check_button_pressed(mb_right) {
        item_selecionado = -1;
        pos_selecionado = -1;
    } 
    
    // Desenha o item selecionado seguindo o mouse
    if item_selecionado != -1 {
        draw_sprite_ext(grid_items[# Infos.Sprite, pos_selecionado], item_selecionado, _mx, _my, escala, escala, 0, c_white, 1);
    }
}
