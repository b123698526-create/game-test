class_name State extends Node # 狀態基類，繼承 Node

var player: Player # 玩家引用，供子類訪問

func _ready() -> void:# 基類初始化暫不處理
	pass 

func _init() -> void:
	pass

func enter() -> void:# 狀態進入時的掛鉤
	pass

func exit() -> void: # 狀態退出時的掛鉤
	pass

func process(_delta : float) -> State:# 每幀更新，可返回要切換的狀態
	return null

func physics(_delta : float) -> State:# 物理幀更新，可返回要切換的狀態
	return null
	
func handle_input( _event : InputEvent ) -> State:# 輸入事件處理，可返回要切換的狀態
	return null
