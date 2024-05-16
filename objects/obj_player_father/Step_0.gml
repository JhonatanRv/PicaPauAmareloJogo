/// @description Insert description here
// You can write your code in this editor

// Initializing variables
var _right, _left, _jump, _attack, _dash, _reset, _switch;
var _ground = place_meeting(x, y + 1, obj_block);
var _player = object_index;

gamepad_set_axis_deadzone(0, 0.6); //Defines the deadZone of the gamepad axis 
_right = keyboard_check(ord("D")) || (gamepad_axis_value(0, gp_axislh) > 0);
_left = keyboard_check(ord("A")) || (gamepad_axis_value(0, gp_axislh) < 0);
_jump = keyboard_check_pressed(ord("K")) || gamepad_button_check_pressed(0, gp_face1);
_attack = keyboard_check_pressed(ord("J")) || gamepad_button_check_pressed(0, gp_face3);
_dash = keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_face2);
_switch = keyboard_check_pressed(ord("L")) || gamepad_button_check_pressed(0, gp_face4);

// Movementation code
velh = (_right - _left) * max_velh;

// Aplying gravity
if(!_ground && velv < max_velv * 2){
	velv += GRAVITY * mass;
}

//Verifying who the player is
if(_player == obj_narizinho){
    _player = obj_narizinho;
}
else if (_player == obj_pedrinho){
    _player = obj_pedrinho;
}

//Starting the state machine
switch(state){

	#region Stopped
	case "stopped":
	{
		sprite_index = sprite_idle;
		max_velh = 4.5;
		
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
			image_index = 0;
		}//switching
		else if (_switch) {
			state = "switch";
			image_index = 0;
		}
		
		break;
	}
	
	#endregion
	
	#region Moving
	case "moving":
	{
		//Moving state behavior
		sprite_index = sprite_walking;
		
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
		}//switching
		else if (_switch) {
			state = "switch";
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
			sprite_index = sprite_falling;
		}
		else{ //Jumping
			sprite_index = sprite_jump;
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
		//Narizinho attack
		if(_player = obj_narizinho){
			max_velh = 1;
			if(combo == 0){
				sprite_index = sprite_attack1;
			
				//creating the damage
				if(image_index >= 2 && damage == noone && image_index < 4 && new_attack){
					damage = instance_create_layer(x + sprite_width /2, (y - sprite_height/2 - 8), layer, obj_meelee_damage_father);
					damage.damage = attack * combo_multi;
					damage.father = id;
					new_attack = false;
				}
			
				//destroying the damage
				if(damage != noone && image_index >= 4){
					instance_destroy(damage);
					damage = noone;
				}
		
			}
			else if(combo == 1){
				sprite_index = sprite_attack2;
			
				//creating the damage
				if(image_index >= 2 && damage == noone && image_index < 4 && new_attack){
					damage = instance_create_layer(x + sprite_width /2, (y - sprite_height/2 - 8), layer, obj_meelee_damage_father);
					damage.damage = attack * combo_multi;
					damage.father = id;
					new_attack = false;
				}
			
				//destroying the damage
				if(damage != noone && image_index >= 4){
					instance_destroy(damage);
					damage = noone;
				}
			}
			else if(combo == 2){
				sprite_index = sprite_attack3;
			
				//creating the damage
				if(image_index >= 3 && damage == noone && image_index < 7 && new_attack){
					damage = instance_create_layer(x + 10, (y - sprite_height/2 - 8), layer, obj_meelee_damage_large);
					damage.damage = attack * combo_multi;
					damage.father = id;
					new_attack = false;
				}
			
				//destroying the damage
				if(damage != noone && image_index >= 7){
					instance_destroy(damage);
					damage = noone;
				}
			}
		
		
			if(_attack && combo < 2 && image_index >= image_number - 2){
				combo++;
				combo_multi += .7;
				image_index = 0;
				new_attack = true;
				if(damage){
					instance_destroy(damage, false);
					damage = noone;
				}
			}
		
			if(image_index > image_number - 1){
				state = "stopped";
				velh = 0;
				combo = 0;
				combo_multi = 1;
				new_attack = true;
				max_velh = 4.5;
				if(damage){
					instance_destroy(damage, false);
					damage = noone;
				}
			}
			break;
		}
		//Pedrinho Attack
		else if(_player == obj_pedrinho){
			velh = 0;

	        sprite_index = sprite_attack1;

	            //Creating the damage object
	            if(image_index >= 1 && can_attack = true){
	                damage = instance_create_layer(x + sprite_width /2, (y - sprite_height/2 - 8), layer, obj_pedrinho_damage);
	                damage.damage = attack;
	                damage.father = id;
	                damage.dir = image_xscale;
	                can_attack = false;
	                alarm[0] = 0.8 * game_get_speed(gamespeed_fps);
	            }
	            //Switch to stopped
	            if(image_index > image_number - 1){
	                can_attack = true;
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
		
		break;
	}
	#endregion
	
	#region Dash
	case "dash":
	{
		
		if(sprite_index != sprite_dash){
			sprite_index = sprite_dash;
			image_index = 0;
		}
			
		if(velh == 0){
			velh = image_xscale * dash_vel;
		}
		else{
			velh = (_right - _left) * dash_vel;
			}
		
		//Swtich state condition
		if(image_index >= image_number - 1){
			state = "stopped";
		
		}
	
		break;
	}
	
	#endregion
	
	#region Hit
	case "hit":{
		
		if(sprite_index != sprite_damage){
			sprite_index = sprite_damage;
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
		if(sprite_index != sprite_dead){
			image_index = 0;
			sprite_index = sprite_dead;
		}
		
		//Stopping the dead animation at the final sprite
		/*if(image_index > image_number - 1){
			image_speed = 0;
		
		}*/
	
	
		break;
	}
	
	#endregion
	
	#region Switch
	case "switch": 
	{
		instance_destroy(cam);
		
		if(_player = obj_narizinho){
			instance_create_layer(x, y, layer, obj_pedrinho);
			_player = obj_pedrinho;
			instance_destroy(obj_narizinho);
			state = "stopped";
		}
		else if(_player = obj_pedrinho){
			instance_create_layer(x, y, layer, obj_narizinho);
			_player = obj_narizinho;
			instance_destroy(obj_pedrinho);
			state = "stopped";
		}
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