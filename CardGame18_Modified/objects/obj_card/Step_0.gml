/// @description 在此处插入描述 
// 你可以在此编辑器中写入代码 

if(facedown){
	sprite_index = spr_card_back;
}else {
	if(card_type == CARD_TYPE_ROCK){
		sprite_index = spr_card_rocks;
	}else if(card_type == CARD_TYPE_PAPER){
		sprite_index = spr_card_paper;
	}else if(card_type == CARD_TYPE_SCISSOR){
		sprite_index = spr_card_scissor;
	}else if(card_type == CARD_TYPE_SPOCK){
		sprite_index = spr_card_spock;
	}else if(card_type == CARD_TYPE_LIZARD){
		sprite_index = spr_card_lizard;
	}
}

x = lerp(x, target_x, 0.1);
y = lerp(y, target_y, 0.1);

