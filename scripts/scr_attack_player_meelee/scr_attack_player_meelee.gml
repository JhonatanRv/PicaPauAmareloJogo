///@arg player
///@arg distance
///@argo xscale

var col = argument0;
var distance = argument1;
var xscale = argument2;

function scr_attack_player_meelee(col, dist, xscale){
	var player = collision_line(x, y - sprite_height/2, x + (distance * xscale), y - sprite_height/2, col, 0, 1)

	if (player){
		state = "attack";
	}
}