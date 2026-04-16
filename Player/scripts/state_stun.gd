class_name State_walk extends State # 行走狀態，繼承 State

@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0
@export var invulnerable_duration : float = 1.0

@onready var idle: State = $"../Idle"# 待機狀態引用


var hurt_box : HurtBox
var direction : Vector2

var next_steat : State = null



func enter() -> void:# 進入行走狀態時設定動畫
	pass

func exit() -> void: # 離開行走狀態暫不處理
	pass# 佔位


func process(_delta : float) -> State:# 每幀更新移動並判斷切換	
	return next_steat


func physics(_delta : float) -> State:# 物理幀未額外處理
	return null# 保持當前狀態

	
func handle_input( _event : InputEvent ) -> State:# 處理攻擊輸入
	return null# 其他輸入不切換
