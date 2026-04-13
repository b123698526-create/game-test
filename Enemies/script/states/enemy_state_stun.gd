class_name EnemyStateStun extends EnemyState

@export var anim_name : String = "stun"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("AI")
@export var next_state : EnemyState

var _direction : Vector2
var _animation_finished : bool = false


func init() -> void:
	enemy.enemy_damage.connect( _on_enemy_damaged )

	
func _ready() -> void:
	pass 

func enter() -> void:# 狀態進入時的掛鉤
	enemy.invulnerable = true
	_animation_finished = false
	_direction = enemy.global_position.direction_to(enemy.player.global_position)
	#捕捉PLAYER反向量
	enemy.velocity = _direction * -knockback_speed
	enemy.set_direction(_direction)
	
	enemy.update_animation(anim_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)	

func exit() -> void: # 狀態退出時的掛鉤
	enemy.animation_player.animation_finished.disconnect(_on_animation_finished)
	enemy.invulnerable = false


func process(_delta : float) -> EnemyState:# 每幀更新，可返回要切換的狀態
	if _animation_finished == true :
		return next_state
	
	enemy.velocity = enemy.velocity * decelerate_speed * _delta
	return null

func physics(_delta : float) -> EnemyState:# 物理幀更新，可返回要切換的狀態
	return null
	
func _on_enemy_damaged() -> void:
	state_machine.change_state( self )

func _on_animation_finished( _a : String ) -> void :
	_animation_finished = true 
