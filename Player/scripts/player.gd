class_name Player extends CharacterBody2D # 玩家角色，繼承 CharacterBody2D

signal DirectionChanged(new_direction : Vector2 ) # 當面向變化時對外廣播
signal player_damaged( hurt_box : HurtBox )

const DIR_4 = [ Vector2.RIGHT,Vector2.DOWN,Vector2.LEFT,Vector2.UP ] # 四向列表用於索引

var direction : Vector2 = Vector2.ZERO # 向量預設為0
var cardinal_direction : Vector2 = Vector2.DOWN # 記錄四方向朝向，初始向下

var invulnerable : bool = false
var hp : int = 6
var max_hp : int = 6

@onready var animation_player : AnimationPlayer = $AnimationPlayer # 動畫播放器節點引用
@onready var sprite : Sprite2D = $Sprite2D # 精靈節點引用，控制翻轉
@onready var state_machine: PlayerStateMachine = $StateMachine # 狀態機節點引用
@onready var hit_box: HitBox = $HitBox



func _ready() -> void: # 場景載入完成後的初始化
	PlayerManager.player = self
	state_machine.Initialize(self) # 將自身傳入狀態機完成初始化
	hit_box.damaged.connect(_take_damage)


func _process(_delta: float) -> void: # 每幀計算輸入方向
	# direction.x = Input.get_action_strength("right") - Input.get_action_strength("left") 
	# 舊寫法：透過動作強度求水平輸入
	# direction.y = Input.get_action_strength("down") - Input.get_action_strength("up") 
	# 舊寫法：透過動作強度求垂直輸入
	direction = Vector2( # 採用 get_axis 組合成方向
		Input.get_axis("left","right"), # 取得水平軸輸入，範圍 -1 到 1
		Input.get_axis("up","down") # 取得垂直軸輸入，範圍 -1 到 1
		).normalized() # 歸一化防止斜向超速
	pass # 保留接口
	
func _physics_process(_delta):	 # 物理幀更新移動
	move_and_slide()	# 根據 velocity 執行滑移移動
	pass # 佔位便於擴展

func set_direction() -> bool:# 根據輸入更新面向
	if direction == Vector2.ZERO: # 無輸入時不改變面向
		return false# 返回 false 表示方向未變
	
	var direction_id : int = int( round(( direction + cardinal_direction * 0.1 ).angle() / TAU * DIR_4.size() ) ) # 將角度映射到四向索引
	var new_dir = DIR_4[ direction_id] # 用索引取得新的朝向
	
	
	if new_dir == cardinal_direction: # 若朝向未變化
		return false # 返回 false 跳過後續
	cardinal_direction = new_dir# 記錄新的朝向
	DirectionChanged.emit(new_dir) # 通知監聽者方向變化
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1# 根據左右朝向翻轉精靈
	return true	# 返回 true 表示更新成功


func update_animation(state : String) -> void:# 切換動畫狀態
	animation_player.play(state + "_" + AnimDirection())# 播放帶朝向後綴的動畫


func AnimDirection() -> String:# 生成動畫方向字串
	if cardinal_direction == Vector2.DOWN: # 面向下時
		return "down"# 返回 down
	elif cardinal_direction == Vector2.UP: # 面向上時
		return "up"	# 返回 up
	else: # 左右時
		return "side"# 返回 side


func _take_damage(hurt_box : HurtBox) -> void:
	
	pass


func update_hp( _delta : int ) -> void:
	
	pass
	
	
func make_invulnerable() -> void:
	
	pass
