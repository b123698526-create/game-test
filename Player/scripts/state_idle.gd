class_name State_Idle extends State # 待機狀態，繼承 State

@onready var walk: State = $"../Walk" # 行走狀態引用
@onready var attack: State = $"../Attack" # 攻擊狀態引用

func enter() -> void:# 進入待機時設定動畫
	if player != null: # 確保玩家已注入
		player.update_animation("idle") # 播放待機動畫
	pass# 佔位便於擴展

func exit() -> void: # 離開待機時暫不處理
	pass# 佔位

func process(_delta : float) -> State:# 每幀判斷是否需要轉行走
	if player.direction != Vector2.ZERO: # 有輸入時切換到行走
		return walk # 切換為行走
	player.velocity = Vector2.ZERO # 待機時速度清零
	return null# 不切換時返回空

func physics(_delta : float) -> State:# 待機物理更新暫不處理
	return null# 保持當前狀態
	
func handle_input( _event : InputEvent ) -> State:# 處理輸入以切換攻擊
	if _event.is_action_pressed("attack"): # 按下攻擊鍵時切換
		return attack # 切換到攻擊
	return null# 其他情況不切換
