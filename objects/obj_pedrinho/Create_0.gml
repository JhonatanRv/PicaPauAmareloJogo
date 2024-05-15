/// @description Modified Pedrinho Variables
// You can write your code in this editor

//Creating the camera
cam = instance_create_layer(x, y, layer, obj_cam);
cam.target = id;

// Inherit the parent event
event_inherited();

max_velh = 4.5;
dash_vel = 6.5;

//Sprites
sprite_walking = spr_run_pedrinho;
sprite_idle = spr_idle_pedrinho;
sprite_jump = spr_jump_pedrinho;
sprite_falling = spr_fall_pedrinho;
sprite_dash = spr_dash_pedrinho;
sprite_damage = spr_damage_pedrinho;
sprite_dead = spr_dead_pedrinho;
sprite_attack1 = spr_attack_pedrinho;
