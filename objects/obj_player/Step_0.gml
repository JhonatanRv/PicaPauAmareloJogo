/// @description Player core code
// You can write your code in this editor

// Initializing variables
var _right, _left, _jump, _attack, _dash, _reset;
var _ground = place_meeting(x, y + 1, obj_block);


gamepad_set_axis_deadzone(0, 0.6); //Defines the deadZone of the gamepad axis 
_right = keyboard_check(ord("D")) || (gamepad_axis_value(0, gp_axislh) > 0);
_left = keyboard_check(ord("A")) || (gamepad_axis_value(0, gp_axislh) < 0);
_jump = keyboard_check_pressed(ord("K")) || gamepad_button_check_pressed(0, gp_face1);
_attack = keyboard_check_pressed(ord("J")) || gamepad_button_check_pressed(0, gp_face3);
_dash = keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_face2);

// Movementation code
velh = (_right - _left) * max_velh;

// Aplying gravity
if(!_ground && velv < max_velv * 2){
	velv += GRAVITY * mass;
	
}

//Starting the state machine
switch(state){

	#region Stopped
	case "stopped":
	{
		sprite_index = spr_idle_pedrinho;
		
		//Switch state condition
		//Ansuring that character doesn't move if both buttons are pressed
		if (_right && _left ){
			state = "stopped";
			velh = 0;
		}//Jumping
		else if(_jump || velv != 0){
			state = "jumping";
			velv = (-max_velv * _jump);
			image_index = 0;
		}//Attacking
		else if(_attack){
			state = "attacking";
			velh = 0;
			image_index = 0;
		}//Moving
		else if (_right || _left){
			state = "moving"
		}//Dashing
		else if (_dash && can_dash = true){
			can_dash = false;
			alarm[0] = 0.8 * game_get_speed(gamespeed_fps);
			state = "dash";
			sprite_index = 0;
		
		}
		
		break;
	}
	
	#endregion
	
	#region Moving
	case "moving":
	{
		//Moving state behavior
		sprite_index = spr_run_pedrinho;
		
		//Switch state condition
		//Stopped
		if(abs(velh) < .1){
			state = "stopped";
			velh = 0;
		}//Jumping
		else if(_jump || velv != 0){
			state = "jumping";
			velv = (-max_velv * _jump);
			image_index = 0;
		}//Attacking
		else if(_attack){
			state = "attacking";
			velh = 0;
			image_index = 0;
		}//Dashing
		else if (_dash && can_dash = true){
			can_dash = false;
			alarm[0] = 0.8 * game_get_speed(gamespeed_fps);
			state = "dash";
			image_index = 0;
		}
		
		break;
	}
	
	#endregion

	#region Jumping
	case "jumping":
	{
		//Falling
		if(velv > 0){
			sprite_index = spr_fall_pedrinho;
		}
		else{ //Jumping
			sprite_index = spr_jump_pedrinho;
			image_index = 0;
			//Ensuring the animation does not repeat
			if(image_index >= image_number - 1){
				image_index = image_number - 1;
			}
		}
		
		//Switch state condition
		//Stopped
		if(_ground){
			state = "stopped";
		}
		
		break;
	}
	#endregion
	
	#region Attack
	case "attacking":
	{
		velh = 0;
		
		sprite_index = spr_attack_pedrinho;
		
			//Creating the damage object
			if(image_index >= 1 && new_attack = true){
				damage = instance_create_layer(x + sprite_width /2, (y - sprite_height/2 - 8), layer, obj_pedrinho_damage);
				damage.damage = attack;
				damage.father = id;
				damage.dir = image_xscale;
				new_attack = false;
				alarm[0] = 0.8 * game_get_speed(gamespeed_fps);
			}
			//Switch to stopped
			if(image_index > image_number - 1){
				new_attack = true;
				state = "stopped";
			}
			
			//Switch to dash 
			if (_dash && can_dash = true){
				can_dash = false;
				alarm[0] = 0.8 * game_get_speed(gamespeed_fps);
				state = "dash"
				image_index = 0
			}
			//Switch to jump if the player fall for some reason
			if(velv != 0){
				state = "jumping";
				image_index = 0;		
			}
		
		break;
	}
	#endregion
	
	#region Dash
	case "dash":
	{
		
		if(sprite_index != spr_dash_pedrinho){
			sprite_index = spr_dash_pedrinho;
			image_index = 0;
		}
			
		velh = image_xscale * dash_vel;
		
		//Swtich state condition
		if(image_index >= image_number - 1){
			state = "stopped";
		
		}
	
		break;
	}
	
	#endregion
	
	#region Hit
	case "hit":{
		
		if(sprite_index != spr_hit_pedrinho){
			sprite_index = spr_hit_pedrinho;
			image_index = 0;
		}
		
		//Cheking if the player died
		if(current_life > 0){
			if(image_index >= image_number - 1){
				state = "stopped";
			}
		}
		else{
			if(image_index >= image_number - 1){
				state = "dead"
			
			}
		
		
		}
		
		//Stunning the player
		velh = 0;
		
		
	
		break;
	}
	
	#endregion
	
	#region Dead
	case "dead":
	{
		velh = 0;
		if(sprite_index != spr_dead_pedrinho){
			image_index = 0;
			sprite_index = spr_dead_pedrinho
		}
		
		//Stopping the dead animation at the final sprite
		/*if(image_index > image_number - 1){
			image_speed = 0;
		
		}*/
	
	
		break;
	}
	
	#endregion
	
	//Default state
	default:{
		state = "stopped";
	
	}
}

//Resetting the room
_reset = keyboard_check_pressed(vk_enter);
if(_reset){
	room_restart();
}