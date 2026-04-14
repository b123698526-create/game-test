class_name EnemyStateDestroy extends EnemyState

@export var anim_name : String = "destroy"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("AI")

var _damaged_position : Vector2
var _direction : Vector2



func init() -> void:
	enemy.enemy_destroyed.connect( _on_enemy_destroyed )

	
func _ready() -> void:# 基類初始化暫不處理
	pass # 佔位以便子類覆寫

func enter() -> void:# 狀態進入時的掛鉤
	
	enemy.invulnerable = true
	_direction = enemy.global_position.direction_to(_damaged_position)
	#捕捉PLAYER反向量
	
	enemy.velocity = _direction * -knockback_speed
	enemy.set_direction(_direction)
	
	enemy.update_animation(anim_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)	

func exit() -> void: # 狀態退出時的掛鉤
	pass


func process(_delta : float) -> EnemyState:# 每幀更新，可返回要切換的狀態 
	
	enemy.velocity = enemy.velocity * decelerate_speed * _delta
	return null# 預設不切換狀態

func physics(_delta : float) -> EnemyState:# 物理幀更新，可返回要切換的狀態
	return null# 預設不切換狀態
	
func _on_enemy_destroyed( hurt_box : HurtBox ) -> void:
	_damaged_position = hurt_box.global_position
	state_machine.change_state( self )

func _on_animation_finished( _a : String ) -> void :
	enemy.queue_free()
