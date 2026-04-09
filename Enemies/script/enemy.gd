class_name Enemy extends CharacterBody2D# 敵人角色，繼承物理角色基底


signal direction_changed( _new_direction : Vector2 )# 朝向改變時發出的訊號
signal enemy_damage()# 受傷時的訊號


const DIR_4 = [Vector2.RIGHT,Vector2.DOWN,Vector2.LEFT,Vector2.UP]# 四方向表

@export var hp : int = 3# 血量，預設 3

var cardinal_direction : Vector2 = Vector2.DOWN# 面向方向，用於動畫/翻轉
var direction : Vector2 = Vector2.ZERO# 當前輸入或移動方向
var player : Player# 目標玩家引用（需外部設定）
var invulnerable :bool = false# 是否無敵中


@onready var animation_player : AnimationPlayer = $AnimationPlayer # 動畫播放器節點引用
@onready var sprite : Sprite2D = $Sprite2D # 精靈節點引用，控制翻轉
@onready var hit_box: HitBox = $HitBox# 受擊盒（目前關閉）
@onready var state_machine : EnemyStateMachine = $EnemyStateMachine# 敵人狀態機




func _ready() -> void:# 初始化
	state_machine.initialize(self)# 注入自己給狀態機
	player = PlayerManager.player# 取得玩家引用
	hit_box.Damaged.connect( _take_damage )


func _process(_delta: float) -> void:# 每幀邏輯（未用）
	pass# 佔位


func _physics_process(_delta: float) -> void:# 每幀物理更新
	move_and_slide()# 依 velocity 移動並處理碰撞


func set_direction(direction) -> bool:# 根據輸入更新面向
	if direction == Vector2.ZERO: # 無輸入時不改變面向
		return false# 返回 false 表示方向未變
	
	var direction_id : int = int( round(( direction + cardinal_direction * 0.1 ).angle() / TAU * DIR_4.size() ) ) # 將角度映射到四向索引
	var new_dir = DIR_4[ direction_id] # 用索引取得新的朝向
	
	
	if new_dir == cardinal_direction: # 若朝向未變化
		return false # 返回 false 跳過後續
	cardinal_direction = new_dir# 記錄新的朝向
	direction_changed.emit(new_dir) # 通知監聽者方向變化
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1# 根據左右朝向翻轉精靈
	return true	# 返回 true 表示更新成功


func update_animation(state : String) -> void:# 切換動畫狀態
	animation_player.play(state + "_" + AnimDirection())# 播放帶朝向後綴的動畫
	print(state + "_" + AnimDirection())

func AnimDirection() -> String:# 生成動畫方向字串
	if cardinal_direction == Vector2.DOWN: # 面向下時
		return "down"# 返回 down
	elif cardinal_direction == Vector2.UP: # 面向上時
		return "up"	# 返回 up
	else: # 左右時
		return "side"# 返回 side


func _take_damage ( damage : int) -> void :

	hp -= damage
	enemy_damage.emit()
