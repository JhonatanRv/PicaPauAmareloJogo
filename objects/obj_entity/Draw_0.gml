/// @description Draw the entitie state
// You can write your code in this editor

draw_self();

if(show_state){
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	draw_text(x, y - (sprite_height + 10), state);
	draw_set_halign(-1);
	draw_set_valign(-1);
	
	draw_text(x, y - (sprite_height + 30), current_life);
}