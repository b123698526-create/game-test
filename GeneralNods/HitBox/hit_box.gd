class_name HitBox extends Area2D # 傷害判定盒，繼承自 Area2D

signal Damaged(damage : int) # 受擊時對外廣播傷害值

func _ready() -> void: # 初始化時暫未處理
	pass # 佔位以便後續補邏輯



func TakeDamage(damage : int ) -> void: # 接收外部傳入的傷害
	Damaged.emit(damage) # 發射 Damaged 信號給監聽方
