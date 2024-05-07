/// @description Insert description here
// You can write your code in this editor

var col;
var col_list = ds_list_create();
var qtt = instance_place_list(x, y, obj_entity, col_list, 0);

//Cheking all the objects in the list and appending if not on the list
for (var i = 0; i < qtt; i++){
	//Cheking the current object
	var current = col_list[| i];
	
	if(object_get_parent(current.object_index) != object_get_parent(father.object_index)){
		
		//Cheking if the current is in the list
		var pos = ds_list_find_index(apply_damage, current);
		if(pos == -1){
			//Appending the current in the list
			ds_list_add(apply_damage, current);
		}
	}
}

//Applying the damage
var size = ds_list_size(apply_damage);
for(var i = 0; i < size; i++){
	col = apply_damage[| i].id;
	if(col.current_life > 0){
		col.state = "hit";
		image_index = 0;
		col.current_life -= damage;
	}
}

//Destroying the damage and the lists
ds_list_destroy(apply_damage);
ds_list_destroy(col_list);
instance_destroy();

/*if(col){
	
	if(col.id != father){
		
		var obj_father = object_get_parent(col.object_index);
		
		if(obj_father != object_get_parent(father.object_index)){
			if(col.current_life > 0){
				col.state = "hit";
				image_index = 0;
				col.current_life -= damage;
				instance_destroy();
			}
		}
	}
}*/