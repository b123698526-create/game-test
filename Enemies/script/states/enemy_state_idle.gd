class_name EnemyStateIdle extends EnemyState

@export var anim_name : String = "idle"

@export_category("AI")
@export var state_dration_min : float = 0.5
@export var state_dration_max : float = 1.5
@export var after_idle_state : EnemyState

var _timer : float = 0.0

func init() -> void:
	if after_idle_state == null or after_idle_state == self:
		after_idle_state = state_machine.get_node_or_null("wander") as EnemyState

func _ready() -> void:# 基類初始化暫不處理
	
	pass # 佔位以便子類覆寫

func enter() -> void:# 狀態進入時的掛鉤
	enemy.velocity = Vector2.ZERO
	_timer = randf_range(state_dration_min,state_dration_max)
	enemy.update_animation(anim_name)

	

func exit() -> void: # 狀態退出時的掛鉤
	pass# 留空供子類實現

func process(_delta : float) -> EnemyState:# 每幀更新，可返回要切換的狀態
	_timer -= _delta
	if _timer <= 0 :
		return after_idle_state

	return null# 預設不切換狀態

func physics(_delta : float) -> EnemyState:# 物理幀更新，可返回要切換的狀態
	return null# 預設不切換狀態
	
