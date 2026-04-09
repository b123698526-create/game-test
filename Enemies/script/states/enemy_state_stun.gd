class_name EnemyStateStun extends EnemyState

@export var anim_name : String = "Stun"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("AI")
@export var next_state : EnemyState

var _direction : Vector2
var _animation_finished : bool = false


func init() -> void:
	enemy.enemy_damage.connect( _on_enemy_damaged )

	
func _ready() -> void:# 基類初始化暫不處理
	pass # 佔位以便子類覆寫

func enter() -> void:# 狀態進入時的掛鉤
	_animation_finished = false
	#_direction = enemy.DIR_4[ rand ]

	enemy.velocity = _direction * -knockback_speed
	enemy.set_direction(_direction)
	
	enemy.update_animation(anim_name)

	

func exit() -> void: # 狀態退出時的掛鉤
	pass# 留空供子類實現

func process(_delta : float) -> EnemyState:# 每幀更新，可返回要切換的狀態
	if _animation_finished == true :
		return next_state
	
	enemy.velocity = enemy.velocity * decelerate_speed * _delta
	return null# 預設不切換狀態

func physics(_delta : float) -> EnemyState:# 物理幀更新，可返回要切換的狀態
	return null# 預設不切換狀態
	
func _on_enemy_damaged() -> void:
	state_machine.change_state( self )
