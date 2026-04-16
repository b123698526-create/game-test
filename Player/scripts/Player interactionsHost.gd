class_name interactionsHost extends Node2D # 交互指示節點，繼承 Node2D

@onready var player : Player = $".." # 取得父級的玩家引用

func _ready() -> void: # 初始化時建立信號連接
	player.direction_changed.connect( update_direction ) # 監聽玩家方向變化以同步旋轉
	pass # 佔位便於擴展

func update_direction( new_direction : Vector2 ) -> void: # 接收方向變化更新旋轉
	match new_direction: # 根據玩家朝向旋轉自身
		Vector2.DOWN: # 朝下
			rotation_degrees = 0 # 朝下保持 0 度
		Vector2.UP: # 朝上
			rotation_degrees = 180 # 朝上旋轉 180 度
		Vector2.RIGHT: # 朝右
			rotation_degrees = -90 # 朝右旋轉 -90 度
		Vector2.LEFT: # 朝左
			rotation_degrees = 90 # 朝左旋轉 90 度
		_: # 其他方向
			rotation_degrees = 0 # 預設重置為 0 度
