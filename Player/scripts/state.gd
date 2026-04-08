class_name State extends Node # 狀態基類，繼承 Node

var player: Player # 玩家引用，供子類訪問

func _ready() -> void:# 基類初始化暫不處理
	pass # 佔位以便子類覆寫

func Enter() -> void:# 狀態進入時的掛鉤
	pass# 留空供子類實現

func Exit() -> void: # 狀態退出時的掛鉤
	pass# 留空供子類實現

func Process(_delta : float) -> State:# 每幀更新，可返回要切換的狀態
	return null# 預設不切換狀態

func Physics(_delta : float) -> State:# 物理幀更新，可返回要切換的狀態
	return null# 預設不切換狀態
	
func HandleInput( _event : InputEvent ) -> State:# 輸入事件處理，可返回要切換的狀態
	return null# 預設不處理輸入
