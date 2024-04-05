/// @description Enemie core code		
// You can write your code in this editor

var _ground = place_meeting(x, y + 1, obj_block);

if(!_ground){
	velv += GRAVITY * mass;
	
}

switch(state){

	#region Stopped
	case "stopped":
	{
		velh = 0;
		state_timer++;
		
		if(sprite_index != spr_idle_ghost){

			image_index = 0;
		}
		
		sprite_index = spr_idle_ghost;
		
		//Switch to patrol mode
		if(irandom(state_timer) > 300 ){
			state = choose("walk", "stopped", "walk");
			state_timer = 0;
		}
		
		break;
	}
	#endregion
	
	#region Walking
	case "walk":
	{	
		state_timer++;
		
		if(sprite_index != spr_walk_ghost){
			image_index = 0
			velh = choose(1,-1);
		
		}
		sprite_index = spr_walk_ghost;
		
		//Condition to switch states
		if(irandom(state_timer) > 300){
			state = choose("stopped", "stopped", "walk");
			state_timer = 0;
			
		}
	
	
		break;
	}
	
	
	#endregion
	
	#region Hit
	case "hit":
	{
		velh = 0;
		if(sprite_index != spr_hurt_ghost){

			image_index = 0;
			//current_life--;
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
	#endregion
	
	#region Dead
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
	#endregion

}

