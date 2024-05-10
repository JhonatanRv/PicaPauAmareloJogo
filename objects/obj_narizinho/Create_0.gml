/// @description Narizinho Modified variables

cam = instance_create_layer(x, y, layer, obj_cam);
cam.target = id;

// Inherit the parent event
event_inherited();

max_velh = 4.5;

dash_vel = 6

//Sprites
sprite_walking = spr_run_narizinho;
sprite_idle = spr_idle_narizinho;
sprite_jump = spr_jump_narizinho;
sprite_falling = spr_fall_narizinho;
sprite_dash = spr_base_narizinho;
sprite_damage = spr_base_narizinho;
sprite_dead = spr_base_narizinho;
sprite_attack1 = spr_attack_narizinho1;
sprite_attack2 = spr_attack_narizinho2;
sprite_attack3 = spr_attack_narizinho3;