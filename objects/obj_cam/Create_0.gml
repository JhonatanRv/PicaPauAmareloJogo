/// @description Camera variables
// You can write your code in this editor
target = noone;

background_map = ds_map_create();
background_map[? layer_get_id("B_ceu")] = 0.9;
background_map[? layer_get_id("B_6")] = 0.6;
background_map[? layer_get_id("B_5")] = 0.5;
background_map[? layer_get_id("B_4")] = 0.4;
background_map[? layer_get_id("B_3")] = 0.3;
background_map[? layer_get_id("B_2")] = 0.2;
background_map[? layer_get_id("B_1")] = 0.1;
background_map[? layer_get_id("foreground")] = -0.5;