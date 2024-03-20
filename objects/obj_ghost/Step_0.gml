/// @description Enemie core code		
// You can write your code in this editor

var _ground = place_meeting(x, y + 1, obj_block);

if(!_ground){
	velv += GRAVITY * mass;
	
}

switch(state){

	case "stopped":
	{
		if(sprite_index != spr_idle_ghost){

			image_index = 0;
		}
		
		sprite_index = spr_idle_ghost;
		
		//swtich state condition
		if(keyboard_check(ord("L"))){
			state = "hit";
			
		}
		
		break;
	}

	case "hit":
	{
		
		if(sprite_index != spr_hurt_ghost){

			image_index = 0;
			current_life--;
		}
		
		sprite_index = spr_hurt_ghost;
		
		//swtich state condition
		if(current_life > 0){
				if(image_index > image_number - 1){
					state = "stopped";
				}
			}
			else{
				if(image_index >= 3){
					state = "dead";
				}
			}
	
		break;
	}
	
	case "dead":
	{
		if(sprite_index != spr_dead_ghost){

			image_index = 0;
		}
		
		sprite_index = spr_dead_ghost;
		
		//Killing the enemy
		if(image_index > image_number - 1){
			image_speed = 0;
			image_alpha -= .01;
			
			if(image_alpha <= 0) instance_destroy();
		
		} 
	
		break;
	}


}

