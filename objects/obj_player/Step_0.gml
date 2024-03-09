/// @description Player core code
// You can write your code in this editor

// Initializing variables
var right, left, jump, attack;
var ground = place_meeting(x, y +1, obj_block);



gamepad_set_axis_deadzone(0, 0.6); //Defines the deadZone of the gamepad axis 
right = keyboard_check(ord("D")) || (gamepad_axis_value(0, gp_axislh) > 0);
left = keyboard_check(ord("A")) || (gamepad_axis_value(0, gp_axislh) < 0);
jump = keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_face1);


// Movementation code
velh = (right - left) < max_velh;


// Aplying gravity
if(!ground && velv < max_velv * 2){
	velv += GRAVITY * mass;
	
}
else{ // Making the jump if the player is on the ground
	if (jump){
		velv = -max_velv;
	}

}