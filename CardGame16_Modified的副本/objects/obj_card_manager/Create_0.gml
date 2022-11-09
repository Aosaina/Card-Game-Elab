/// @description 在此处插入描述 
// 你可以在此编辑器中写入代码 

randomize();
cards = ds_list_create();
ai_cards = ds_list_create();
player_cards = ds_list_create();
discard_list = ds_list_create();
discard_pile = ds_list_create();

waiting_for_alarm = false;

num_card_types = 5;
num_cards = num_card_types*6;

STATE_DEAL_CARDSTACK = 0;
STATE_DEAL_CARDS_AI = 1;
STATE_DEAL_CARDS_PLAYER = 1.5;

STATE_CARD_SELECTION =2;
STATE_CARD_SELECTION_AI =3;
STATE_CARD_COMP = 4;
STATE_CARD_SELECTION_AI_FACEUP = 7;
//STATE_PLAYER_DISCARD = 8;
//STATE_AI_DISCARD = 9;
STATE_DISCARD = 10;
//STATE_CARD_WIN=5;

//STATE_DEAL_TEST=100;
 
ch_player = 11;
ch_ai = 12;
ch_deal = 13;

CARD_TYPE_ROCK = 0;
CARD_TYPE_PAPER = 1;
CARD_TYPE_SCISSOR =2;
CARD_TYPE_SPOCK = 3;
CARD_TYPE_LIZARD = 4;

//STATE_CARD_DISPLAY =1;

//duration = 2;
timer = 0;

ai_card_i = 0;
player_card_i = 0;
discard_card_i = 6;	


game_state = STATE_DEAL_CARDSTACK;
//card_x = 100;
//card_y = room_width/2;

global.ai_score = 0;
global.player_score = 0;

//card_number = 0;

ai_index = -1;
player_deal_card_inst = obj_card;

num_player_card = 3;


card_x = 100;
card_y = room_height/2;


for(i = 0; i<num_cards;i++) {
	card_inst = instance_create_layer(card_x,card_y,"Instances",obj_card);
	card_inst.card_type = i%num_card_types;
		
	ds_list_add(cards,card_inst);
}
	
AI_card_selected = 100;

l = 0
n = -1;
o = 0;

//function card_movement(card_inst, goal_x, goal_y){
//	card_inst.x = lerp(card_inst.x, goal_x, 0.5*room_speed);
//	card_inst.y = lerp(	card_inst.y, goal_y, 0.5*room_speed);
//}




