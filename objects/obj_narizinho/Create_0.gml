/// @description Insert description here
// You can write your code in this editor

randomize();

//Creating the camera
cam = instance_create_layer(x, y, layer, obj_cam);
cam.target = id;

// Inherit the parent event
event_inherited();

max_life = 5;
current_life = max_life;



max_velh = 4.5;
max_velv = 8.5;

dash_vel = 6;
can_dash = true

show_state = true;

combo = 0;
combo_multi = 1;
damage = noone;
new_attack = true;
