/// @description Knockback system


dir = point_direction(x, y, other.x, other.y);
knockingback = true;
alarm[0] = game_get_speed(gamespeed_fps) * other.knockback;
