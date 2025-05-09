/// @description Damage core code
// You can write your code in this editor

//Defines the scale of the sprite

//col = colision
var col = instance_place(x, y, obj_entity);

//making the shot fly to the right direction
x += shot_vel * dir;



//If the shot is touching the block
if(place_meeting(x, y, obj_block)){
	instance_destroy();
	
}

//If the shot is touching something and the parent
if(col){
	
	if(col.id != father){
		
		var obj_father = object_get_parent(col.object_index); //Variable to identfie the parent entitie
		
		if(obj_father != object_get_parent(father.object_index)){
			if(col.current_life > 0){
				col.state = "hit";
				image_index = 0;
				col.current_life -= damage;
				instance_destroy();
			}
		}
	}
}