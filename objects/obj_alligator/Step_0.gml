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
		
		if(sprite_index != spr_idle_alligator){

			image_index = 0;
		}
		
		sprite_index = spr_idle_alligator;
		
		//Switch to patrol mode
		if(irandom(state_timer) > 300 ){
			state = choose("walk", "stopped", "walk");
			state_timer = 0;
		}
		//Switch to attack state
		scr_attack_player_meelee(obj_player, distance, xscale);
		
		break;
	}
	#endregion
	
	#region Walking
	case "walk":
	{	
		state_timer++;
		
		if(sprite_index != spr_walk_alligator){
			image_index = 0
			velh = choose(1,-1);
		
		}
		sprite_index = spr_walk_alligator;
		
		//Condition to switch states
		if(irandom(state_timer) > 300){
			state = choose("stopped", "stopped", "walk");
			state_timer = 0;
		}
		
		//Switch to attack state
		scr_attack_player_meelee(obj_player, distance, xscale);
	
		break;
	}
	#endregion
	
	#region Attack
	case "attack":
	{
		velh = 0;
		if(sprite_index != spr_attack_alligator){
			image_index = 0;
			new_attack = true;
			damage = noone;
		}
		
		sprite_index = spr_attack_alligator;
		
		if(image_index > image_number - 1){
			state = "stopped";
		}
	
		//creating the damage
		if(image_index >= 2 && damage == noone && image_index < 4 && new_attack){
			damage = instance_create_layer(x + sprite_width /2, (y - sprite_height/2 - 8), layer, obj_meelee_damage);
			damage.damage = attack;
			damage.father = id;
			new_attack = false;
		}
		//destroying the damage
		if(damage != noone && image_index >= 4){
			instance_destroy(damage);
			damage = noone;
		}
	
		break;
	}
	#endregion
	
	#region Hit
	case "hit":
	{
		velh = 0;
		if(sprite_index != spr_hit_alligator){

			image_index = 0;
			//current_life--;
		}
		
		sprite_index = spr_hit_alligator;
		
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
		velh = 0;
		if(sprite_index != spr_dead_alligator){

			image_index = 0;
		}
		
		sprite_index = spr_dead_alligator;
		
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

