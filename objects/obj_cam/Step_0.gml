/// @description Camera core code
// You can write your code in this editor

if(target = noone) exit;

//Following the player
x = lerp(x, target.x, .1);
y = lerp(y, target.y, .1);