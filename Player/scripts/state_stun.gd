class_name State_stun extends State # 行走狀態，繼承 State

@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0
@export var invulnerable_duration : float = 1.0

@onready var idle: State = $"../Idle"# 待機狀態引用


var hurt_box : HurtBox
var direction : Vector2

var next_state : State = null

func init() -> void:
	print("player stun init connect player_damage")
	player.player_damage.connect( _player_damage)


func enter() -> void:# 進入行走狀態時設定動畫
	
	player.update_animation("stun")
	player.animation_player.animation_finished.connect(_animation_finished)
	print("enter player stun")
	print("play anim =", "stun_" + player.anim_direction())

func exit() -> void: # 離開行走狀態暫不處理
	print("exit player stun")
	next_state =null
	player.animation_player.animation_finished.disconnect(_animation_finished)
	
	direction = player.global_position.direction_to(hurt_box.global_position)
	player.velocity = direction * -knockback_speed
	player.set_direction()
	
	player.make_invulnerable( invulnerable_duration )
	player.effect_animation_player.play("damage")
	
func process(_delta : float) -> State:# 每幀更新移動並判斷切換	
	print("stun process, animation_finished =", _animation_finished, "next_state =", next_state)
	return next_state


func physics(_delta : float) -> State:# 物理幀未額外處理
	return null# 保持當前狀態

	
func handle_input( _event : InputEvent ) -> State:# 處理攻擊輸入
	return null# 其他輸入不切換

func _player_damage( _hurt_box : HurtBox ) -> void :
	
	print("player stun received =", hurt_box)
	state_machine.change_state(self)
	
	hurt_box = _hurt_box
	state_machine.change_state(self)


func _animation_finished() -> void:
	next_state = idle
	
