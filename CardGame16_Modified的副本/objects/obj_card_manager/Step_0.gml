/// @description 在此处插入描述 
// 你可以在此编辑器中写入代码 

//卡牌初始位置
card_x = 100;
card_y = room_height/2;

//定义初始
if (game_state == STATE_DEAL_CARDSTACK) {
	 player_card_i = 0;
	 n = 0;
	 ds_list_clear(discard_pile);
	 ds_list_shuffle(cards);
	
	for(i = 0;i < num_cards; i++) {
		
		cards[|i].target_x = card_x;
		cards[|i].target_y = card_y - i*2;
		cards[|i].facedown = true;
		cards[|i].depth = -i;
		cards[|i].card_holder = ch_ai;
		
	}
	 
	
	//判定当前游戏阶段，若应进入下一个state，开始倒计时，倒计时结束进入下一个state
	if (!waiting_for_alarm) {
		game_state = -4;
		alarm[0] = 2 * room_speed;
		show_debug_message("state deal cardstack ends");
		//waiting_for_alarm = true;
	}
		
	 //game_state = STATE_DEAL_CARDS_AI;
}

if (game_state == STATE_DEAL_CARDS_AI) {
	
	num_ai_card = 3;
	num_player_card = 3;
	ai_x = 300;
	ai_y = 300;
	//show_debug_message("ai deal a cards");


	if(timer < 70){
		timer ++;
	}

	if(ds_list_size(ai_cards) < 3 and timer == 20){
		
		show_debug_message("you deal a card");
		cards[|num_cards - 1].target_x = ai_x + ai_card_i * 100;
		cards[|num_cards - 1].target_y = ai_y;
		cards[|num_cards - 1].facedown = true;
		cards[|num_cards - 1].card_holder = ch_ai;
		audio_play_sound(snd_deal_cards,1,false);
		effect_create_below(ef_flare,cards[|num_cards - 1].target_x, cards[|num_cards - 1].target_y, 1, c_yellow);
		
		ds_list_add(ai_cards,cards[|num_cards - 1]);		
		ds_list_delete(cards, num_cards - 1);
		show_debug_message("1 you deal a card");
		timer = 0;
		num_cards -=1;
		ai_card_i +=1;
	}
	
	
	waiting_for_alarm = true;
	
	if (waiting_for_alarm and ds_list_size(ai_cards) ==3) {
		game_state = -4;
		alarm[1] = 1 * room_speed;
		show_debug_message("state deal cards AI ends");
		//waiting_for_alarm = false;
	} 
	//game_state = STATE_DEAL_CARDS_PLAYER;
}

if(game_state == STATE_DEAL_CARDS_PLAYER) {
	ai_card_i = 0;
	player_x = 300;
	player_y = 650;
	
	
	if(timer < 70){
		timer ++;
		
	}

	if(ds_list_size(player_cards) < 3 and timer == 20){
		
		cards[|num_cards - 1].target_x = player_x + player_card_i * 100;
		cards[|num_cards - 1].target_y = player_y;
		cards[|num_cards - 1].facedown = false;
		cards[|num_cards - 1].card_holder = ch_player;
		audio_play_sound(snd_deal_cards,1,false);
		effect_create_below(ef_flare,cards[|num_cards - 1].target_x, cards[|num_cards - 1].target_y, 1, c_aqua);
		
		ds_list_add(player_cards,cards[|num_cards - 1]);		
		ds_list_delete(cards, num_cards - 1);

		timer = 0;
		num_cards -=1;
		player_card_i +=1;
		
	}
	
	if(ds_list_size(player_cards) == 3){
		game_state = STATE_CARD_SELECTION;
		show_debug_message("state deal cards player ends");
	}
	
} 

if (game_state == STATE_CARD_SELECTION) {
	 player_card_i = 0;
	
	player_deal_card_inst = instance_position(mouse_x,mouse_y,obj_card)
	
	if (player_deal_card_inst!=noone) {
		if (player_deal_card_inst.card_holder == ch_player) {
			player_deal_card_inst.target_y = 630;
				
			if (mouse_check_button_pressed(mb_left)) {
				if(player_deal_card_inst == CARD_TYPE_SCISSOR){///////
					show_debug_message("kacha kacha");
				}else{
					audio_play_sound(snd_deal_cards,1,false);
				}
					
					
				player_deal_card_inst.card_holder = ch_deal;
				player_deal_card_inst.target_x = 400;
				player_deal_card_inst.target_y = 530;
				effect_create_below(ef_ring,player_deal_card_inst.target_x, player_deal_card_inst.target_y, 1, c_aqua);
				

					
				if (!waiting_for_alarm) {
					game_state = -4;
					alarm[2] = 2 * room_speed;
					show_debug_message("state deal card selection ends");
					//waiting_for_alarm = true;
				} 
			}
		}
	}
	
	else {
		for (i=0;i<num_player_card;i++) {
			if (player_cards[|i].card_holder==ch_player) {
				player_cards[|i].target_y=650;
			}
		}
	}		
}

if (game_state = STATE_CARD_SELECTION_AI) {
	
	ai_index = random_range(0,2);
	ai_cards[|ai_index].card_holder = ch_deal;
	ai_cards[|ai_index].target_x = 400;
	ai_cards[|ai_index].target_y = 415;
	audio_play_sound(snd_deal_cards,1,false);
	effect_create_below(ef_ring,ai_cards[|ai_index].target_x,ai_cards[|ai_index].target_y, 1, c_yellow);

	waiting_for_alarm = true;
	
	if (waiting_for_alarm) {
		game_state = -4;
		alarm[3] = 2 * room_speed;
		show_debug_message("card selection AI ends");
		//waiting_for_alarm = true;
	}
}

if (game_state = STATE_CARD_SELECTION_AI_FACEUP) {
	
	ai_cards[|ai_index].facedown = false;
	
	if (ai_cards[|ai_index].card_type == CARD_TYPE_ROCK) {AI_card_selected = 0;}
	
	if (ai_cards[|ai_index].card_type == CARD_TYPE_PAPER) {AI_card_selected = 1;}
	
	if (ai_cards[|ai_index].card_type == CARD_TYPE_SCISSOR) {AI_card_selected = 2;}
	
	if (ai_cards[|ai_index].card_type == CARD_TYPE_SPOCK) {AI_card_selected = 3;}
	
	if (ai_cards[|ai_index].card_type == CARD_TYPE_LIZARD) {AI_card_selected = 4;}
	
	
	waiting_for_alarm = true;
	
	if (waiting_for_alarm) {
		game_state = -4;
		alarm[5] = 1 * room_speed;
		show_debug_message("card selection AI faceup ends");
	}
	
}

if (game_state = STATE_CARD_COMP) {
	discard_card_i = 6;	
	i = 0;
	j = 0;
	k = 0;
	//Reset();
	
	if (player_deal_card_inst.card_type == CARD_TYPE_ROCK) {
		if (AI_card_selected == 2) {
			//player +score
			global.player_score = global.player_score + 1;
			audio_play_sound(snd_win,1,false);
			effect_create_below(ef_ring,400, 530, 1, c_aqua);
			show_debug_message("scissor");
		}
		
		else if (AI_card_selected == 4) {
			//ai +score
			global.player_score = global.player_score + 1;
			audio_play_sound(snd_win,1,false);
			show_debug_message("lizard");
		}
		
		else if (AI_card_selected == 1) {
			//ai +score
			global.ai_score  = global.ai_score + 1;
			audio_play_sound(snd_lose,1,false);
			show_debug_message("paper");
		}
		
		else if (AI_card_selected == 3) {
			//ai +score
			global.ai_score  = global.ai_score + 1;
			audio_play_sound(snd_lose,1,false);
			show_debug_message("spock");
		}
		
		
		
		else {
			show_debug_message("rock");
		}
	}
	
	else if (player_deal_card_inst.card_type==CARD_TYPE_PAPER) {
		
		if (AI_card_selected == 0) {
			//player +score
			global.player_score = global.player_score + 1;
			audio_play_sound(snd_win,1,false);
			show_debug_message("rock");
		}
		
		if (AI_card_selected == 3) {
			//player +score
			global.player_score = global.player_score + 1;
			audio_play_sound(snd_win,1,false);
			show_debug_message("spock");
		}
		
		else if (AI_card_selected == 2) {
			//ai +score
			global.ai_score  = global.ai_score + 1;
			audio_play_sound(snd_lose,1,false);
			show_debug_message("scissor");
		}
		
		else if (AI_card_selected == 4) {
			//ai +score
			global.ai_score  = global.ai_score + 1;
			audio_play_sound(snd_lose,1,false);
			show_debug_message("lizard");
		}
		
		else {
			show_debug_message("paper");
		}
	}
	
	else if (player_deal_card_inst.card_type==CARD_TYPE_SCISSOR) {
		
		if (AI_card_selected == 1) {
			//player +score
			global.player_score = global.player_score + 1;
			audio_play_sound(snd_win,1,false);
			show_debug_message("paper");
		}
		
		if (AI_card_selected == 4) {
			//player +score
			global.player_score = global.player_score + 1;
			audio_play_sound(snd_win,1,false);
			show_debug_message("lizard");
		}
		
		else if (AI_card_selected == 0) {
			//ai +score
			global.ai_score  = global.ai_score + 1 ;
			audio_play_sound(snd_lose,1,false);
			show_debug_message("rock");
		}
		
		else if (AI_card_selected == 3) {
			//ai +score
			global.ai_score  = global.ai_score + 1 ;
			audio_play_sound(snd_lose,1,false);
			show_debug_message("spock");
		}
		
		else {
			show_debug_message("scissor");
		}
	}
	
	else if (player_deal_card_inst.card_type==CARD_TYPE_LIZARD) {
		
		if (AI_card_selected == 3) {
			//player +score
			global.player_score = global.player_score + 1;
			audio_play_sound(snd_win,1,false);
			show_debug_message("spock");
		}
		
		if (AI_card_selected == 1) {
			//player +score
			global.player_score = global.player_score + 1;
			audio_play_sound(snd_win,1,false);
			show_debug_message("paper");
		}
		
		else if (AI_card_selected == 2) {
			//ai +score
			global.ai_score  = global.ai_score + 1 ;
			audio_play_sound(snd_lose,1,false);
			show_debug_message("scissor");
		}
		
		else if (AI_card_selected == 0) {
			//ai +score
			global.ai_score  = global.ai_score + 1 ;
			audio_play_sound(snd_lose,1,false);
			show_debug_message("rock");
		}
		
		else {
			show_debug_message("lizard");
		}
	}
	
	else if (player_deal_card_inst.card_type==CARD_TYPE_SPOCK) {
		
		if (AI_card_selected == 2) {
			//player +score
			global.player_score = global.player_score + 1;
			audio_play_sound(snd_win,1,false);
			show_debug_message("scissor");
		}
		
		if (AI_card_selected == 0) {
			//player +score
			global.player_score = global.player_score + 1;
			audio_play_sound(snd_win,1,false);
			show_debug_message("rock");
		}
		
		else if (AI_card_selected == 1) {
			//ai +score
			global.ai_score  = global.ai_score + 1 ;
			audio_play_sound(snd_lose,1,false);
			show_debug_message("paper");
		}
		
		else if (AI_card_selected == 4) {
			//ai +score
			global.ai_score  = global.ai_score + 1 ;
			audio_play_sound(snd_lose,1,false);
			show_debug_message("lizard");
		}
		
		else {
			show_debug_message("spock");
		}
	}
		
		
	game_state = STATE_DISCARD;
	ds_list_clear(discard_list);
	m = 12 * n;
} 

else if(game_state == STATE_DISCARD){
	show_debug_message("discard state");
	
	//player reset
	//adding to dicard list
	player_deal_card_inst = obj_card;
	
	if (i < num_player_card) {
		ds_list_add(discard_list,player_cards[|i]);
		ds_list_add(discard_pile,player_cards[|i]);
		i++;
		show_debug_message("player: " + string(ds_list_size(discard_list)));
		k++;
	}
	
	
	if (j < num_ai_card) {
		ds_list_add(discard_list,ai_cards[|j]);	
		ds_list_add(discard_pile,ai_cards[|j]);
		j++;
		show_debug_message("ai: " + string(ds_list_size(discard_list)));
		k++;
	}
	
	//for(i = 0;i < num_player_card;i++) {
	//	ds_list_add(discard_list,player_cards[|i]);
	//	show_debug_message("player: " + string(ds_list_size(discard_list)));
	//}
	
	
	
	
	//for (j = 0; j < num_ai_card; j++) {	
	//	ds_list_add(discard_list,ai_cards[|j]);	
	//	show_debug_message("ai: " + string(ds_list_size(discard_list)));
	//}
	
	
	
		
	//go over discard list with for loop
	
	
	if (k == 6) {
		ds_list_clear(player_cards);
		ds_list_clear(ai_cards);
		if (timer < 20) {
			timer++;
			show_debug_message("timer: " + string(timer));
		}
			
		if (l < 6 and timer == 20) {
			show_debug_message("a card is discarded");
			discard_list[|l].target_x = 650;
			discard_list[|l].target_y = card_y + l*2 + m;
			discard_list[|l].facedown = false;
			discard_list[|l].card_holder = ch_ai;
			discard_list[|l].depth = m;
			timer = 0;
			l++;
		}
		
		show_debug_message("m: " + string(m));
		show_debug_message("l: " + string(l));
		show_debug_message("discard pile: " + string(ds_list_size(discard_pile)));
			//for (i = 0; i < ds_list_size(discard_list); i++) {
		
			//	discard_list[|i].target_x = 650
			//	discard_list[|i].target_y = card_y - i*2;
			//	discard_list[|i].facedown = false;
			//	discard_list[|i].depth = -i;
			
			//}
		if (l == 6) {
			if (num_cards > 0) {
				show_debug_message("next round")
				l = 0;
				game_state = STATE_DEAL_CARDS_AI;
			}
	
			if (ds_list_size(discard_pile) == 30) {
				if (ds_list_size(discard_pile) == 30 and o < 30 and timer == 10) {
					discard_pile[|o].target_x = card_x;
					discard_pile[|o].target_y = card_y - o * 2.2;
					discard_pile[|o].facedown = true;
					discard_pile[|o].depth = -o;
					audio_play_sound(snd_deal_cards,1,false);
						//if(discard_pile[|i].target_x == card_x){
						//instance_destroy(discard_pile[|i]);
						//}
					ds_list_add(cards,discard_pile[|o]);
					show_debug_message("card pile: " + string(cards));
					show_debug_message(string(ds_list_size(cards)));
					o++
					timer = 0;
				}
				
				waiting_for_alarm = true;
				if (waiting_for_alarm and ds_list_size(cards) == 30) {
					game_state = -4;
					alarm[4] = 1 * room_speed;
					show_debug_message("game ends");
					//waiting_for_alarm = true;
				}		
			}
		}
	}
}