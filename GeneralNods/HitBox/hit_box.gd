class_name HitBox extends Area2D # 傷害判定盒，繼承自 Area2D

signal damaged(hurt_box: HurtBox)# 受擊時對外廣播傷害值

func _ready() -> void: # 初始化時暫未處理
	pass # 佔位以便後續補邏輯



func Take_Damage( hurt_box : HurtBox ) -> void: # 接收外部傳入的傷害
	damaged.emit( hurt_box ) # 發射 Damaged 信號給上方signal
