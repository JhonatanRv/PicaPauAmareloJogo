/// @description Camera core code
// You can write your code in this editor

if(target = noone) exit;

//Following the player
x = lerp(x, target.x, .1);
y = lerp(y, target.y, .1);

var _cx = camera_get_view_x(view_camera[0]);
var _xspd = 3 * (keyboard_check(vk_right) - keyboard_check(vk_left));
_cx += _xspd
camera_set_view_pos(view_camera[0], _cx, 0);

var _b = ds_map_find_first(background_map);
repeat(ds_map_size(background_map))
    {
    layer_x(_b, background_map[? _b] * _cx);
    _b = ds_map_find_next(background_map, _b);
    }