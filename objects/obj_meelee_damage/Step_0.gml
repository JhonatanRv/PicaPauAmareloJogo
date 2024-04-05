/// @description Insert description here
// You can write your code in this editor
var col = instance_place(x, y, obj_entity);

if(col){
	
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
}