class_name State_stun extends State # 行走狀態，繼承 State

@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0
@export var invulnerable_duration : float = 1.0

@onready var idle: State = $"../Idle"# 待機狀態引用

var animation_finished_flag: bool = false
var hurt_box : HurtBox
var direction : Vector2

var next_state : State = null

func init() -> void:
	player.player_damaged.connect( _player_damage)


func enter() -> void:# 進入行走狀態時設定動畫
	
	player.animation_player.animation_finished.connect(animation_finished)

	direction = player.global_position.direction_to(hurt_box.global_position)
	player.velocity = direction * -knockback_speed
	player.set_direction()
	player.update_animation("stun")
	
	player.make_invulnerable( invulnerable_duration )
	player.effect_animation_player.play("damaged" )
	

func exit() -> void: # 離開行走狀態暫不處理
	next_state =null
	player.animation_player.animation_finished.disconnect(animation_finished)
	
	
	
func process( _delta : float) -> State:# 每幀更新移動並判斷切換	
	player.velocity = player.velocity * decelerate_speed * _delta
	return next_state
	

func physics(_delta : float) -> State:# 物理幀未額外處理
	return null# 保持當前狀態

	
func handle_input( _event : InputEvent ) -> State:# 處理攻擊輸入
	return null# 其他輸入不切換

func _player_damage( _hurt_box : HurtBox ) -> void :
	
	hurt_box = _hurt_box
	state_machine.change_state(self)


func animation_finished(_anim_name) -> void:
	next_state = idle
	
