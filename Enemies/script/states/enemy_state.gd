class_name EnemyState extends Node

##store a reference to the enemy  that this belongs to belongs to
var enemy : Enemy
var state_machine : EnemyStateMachine


func init() -> void:
	pass


func _ready() -> void:# 基類初始化暫不處理
	pass # 佔位以便子類覆寫


func enter() -> void:# 狀態進入時的掛鉤
	pass# 留空供子類實現


func exit() -> void: # 狀態退出時的掛鉤
	pass# 留空供子類實現


func process(_delta : float) -> EnemyState:# 每幀更新，可返回要切換的狀態
	return null# 預設不切換狀態


func physics(_delta : float) -> EnemyState:# 物理幀更新，可返回要切換的狀態
	return null# 預設不切換狀態
