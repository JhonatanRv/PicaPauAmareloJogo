/// @description Player core code
// You can write your code in this editor

// Initializing variables
var _right, _left, _jump, _attack;
var _ground = place_meeting(x, y + 1, obj_block);



gamepad_set_axis_deadzone(0, 0.6); //Defines the deadZone of the gamepad axis 
_right = keyboard_check(ord("D")) || (gamepad_axis_value(0, gp_axislh) > 0);
_left = keyboard_check(ord("A")) || (gamepad_axis_value(0, gp_axislh) < 0);
_jump = keyboard_check_pressed(ord("K")) || gamepad_button_check_pressed(0, gp_face1);
_attack = keyboard_check_pressed(ord("J")) || gamepad_button_check_pressed(0, gp_face3);


// Movementation code
velh = (_right - _left) * max_velh;


// Aplying gravity
if(!_ground && velv < max_velv * 2){
	velv += GRAVITY * mass;
	
}


//Starting the state machine
switch(state){


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
		}
		
		
		break;
	}
	
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
		}
		
		
		break;
	}

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
	
	case "attacking":
	{
		velh = 0;
		
		sprite_index = spr_attack_pedrinho;
		
			//Creating the damage object
			if(image_index >= 0 && damage == noone && new_attack){
				damage = instance_create_layer(x + sprite_width/2, (y - sprite_width + 4/2), layer, obj_damage);
				damage.damage = attack;
				damage.father = id;
				new_attack = false;
			}
		
		
		
		if(image_index > image_number - 1){
			state = "stopped";
			new_attack = true;
			
			//Destroying the damage instance
			if(damage){
				 instance_destroy(damage, false);
				damage = noone;
			}
		}
		
		break;
	}

}