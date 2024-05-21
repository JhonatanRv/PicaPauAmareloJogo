/// @description Insert description here
// You can write your code in this editor

randomize();

// Inherit the parent event
event_inherited();

max_life = 5;
current_life = max_life;

max_velh = 4.5;
max_velv = 8.5;

can_switch = false;
		alarm[1] = 3 * game_get_speed(gamespeed_fps);
		
dash_vel = 1;
can_dash = true

show_state = true;

combo = 0;
combo_multi = 1;
damage = noone;
new_attack = true; //Narizinho variable
can_attack = true; //Pedrinho variable

//Sprites
sprite_walking = spr_base_narizinho;
sprite_idle = spr_base_narizinho;
sprite_jump = spr_base_narizinho;
sprite_falling = spr_base_narizinho;
sprite_dash = spr_base_narizinho;
sprite_damage = spr_base_narizinho;
sprite_dead = spr_base_narizinho;
sprite_attack1 = spr_base_narizinho;
sprite_attack2 = spr_base_narizinho;
sprite_attack3 = spr_base_narizinho;