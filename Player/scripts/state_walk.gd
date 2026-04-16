class_name State_stun extends State # 行走狀態，繼承 State

@export var move_speed : float = 100 # 行走速度導出到 Inspector，預設 100
@onready var idle: State = $"../Idle"# 待機狀態引用
@onready var attack: State = $"../Attack"# 攻擊狀態引用

func enter() -> void:# 進入行走狀態時設定動畫
	if player != null: # 確保玩家引用存在
		player.update_animation("stun") # 播放行走動畫
	pass# 佔位

func exit() -> void: # 離開行走狀態暫不處理
	pass# 佔位

func process(_delta : float) -> State:# 每幀更新移動並判斷切換
	if player.direction == Vector2.ZERO: # 無輸入則轉為待機
		return idle # 切換到待機
	
	player.velocity = player.direction * move_speed # 根據輸入和速度計算移動向量
	
	if player.set_direction(): # 若朝向發生變化
		player.update_animation("walk") # 播放對應方向的行走動畫
	return null# 預設保持當前狀態

func physics(_delta : float) -> State:# 物理幀未額外處理
	return null# 保持當前狀態
	
func handle_input( _event : InputEvent ) -> State:# 處理攻擊輸入
	if _event.is_action_pressed("attack"): # 按下攻擊鍵時切換
		return attack # 切換到攻擊
	return null# 其他輸入不切換
