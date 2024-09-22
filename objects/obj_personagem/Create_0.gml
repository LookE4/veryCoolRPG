/// @description Insert description here
enum Armas {
	Espada,
	Arco,
	//Adicionar aqui mais armas para altura funcionar certo
	Altura
}

//movimentação
direita = -1;
cima = -1;
esquerda = -1;
baixo = -1;

hveloc = 0;
vveloc = 0;

veloc = 2;
veloc_dir = -1;

dir = 0;

//dash
dash_dir = -1;
dash_veloc = 6;

//estado
estado = scr_personagem_andando;

inimigos_atingidos = ds_list_create();

//combate
level = 0;
xp = 0;
max_xp = [100, 120, 150, 200, 285];

max_st = [100, 115, 130, 145, 160, 200];
st = max_st[level];


max_vida = [20, 30, 42, 60, 80];
vida = max_vida[level];

tomar_dano = true;
empurrar_dir = 0;

dano = [1, 2, 4, 8, 10];
atacar = false;
dano_alpha = -1;

draw_xscale = 1;
draw_yscale = 1;

arma = 0;