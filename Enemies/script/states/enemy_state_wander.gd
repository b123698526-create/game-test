class_name EnemyStateWander extends EnemyState

@export var anim_name : String = "walk"
@export var wander_speed : float = 20

@export_category("AI")
@export var state_animation_durtion : float = 0.5
@export var state_cycles_min : int = 1
@export var state_cycles_mix : int = 3
@export var next_state : EnemyState

var _timer : float = 0.0
var _direction :Vector2
func init() -> void:
	if next_state == null or next_state == self:
		next_state = state_machine.get_node_or_null("Idle") as EnemyState

func _ready() -> void:# 基類初始化暫不處理
	pass # 佔位以便子類覆寫

func Enter() -> void:# 狀態進入時的掛鉤
	_timer = randi_range(state_cycles_min,state_cycles_mix) * state_animation_durtion
	var  rand = randi_range( 0 , 3 )
	_direction = enemy.DIR_4[ rand ]
	enemy.velocity = _direction * wander_speed
	enemy.set_direction(_direction)
	enemy.update_animation(anim_name)
	pass# 留空供子類實現
	

func Exit() -> void: # 狀態退出時的掛鉤
	pass# 留空供子類實現

func Process(_delta : float) -> EnemyState:# 每幀更新，可返回要切換的狀態
	_timer -= _delta
	
	if _timer <= 0:
		return next_state
	return null# 預設不切換狀態

func Physics(_delta : float) -> EnemyState:# 物理幀更新，可返回要切換的狀態
	return null# 預設不切換狀態
	
