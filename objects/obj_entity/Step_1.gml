/// @description Correcting the direction
// You can write your code in this editor

//Making the entities look to the right direction
if (velh != 0) xscale = sign(velh);
image_xscale = xscale;

//Showing the state with mouse click
if(position_meeting(mouse_x, mouse_y, id) && mouse_check_button_released(mb_left)){
	show_state = !show_state;
}

image_speed = (img_spd / 30);