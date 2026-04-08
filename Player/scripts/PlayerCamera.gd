class_name PlayerCamera extends Camera2D # 玩家攝像機節點，繼承 Camera2D

func _ready() -> void:# 初始化時暫不處理
	LevelManager.TileMapBoundsChanged.connect( UpdateLimits )
	UpdateLimits(LevelManager.current_tilemap_bounds)
	pass # 佔位便於擴展

func UpdateLimits( bounds : Array[ Vector2 ] ) -> void: # 更新攝像機限制邊界（尚未實作）
	if bounds == []:
		return 
	limit_left = int( bounds[0].x )# 左界：取 bounds[0] 的 x
	limit_top = int( bounds[0].y )# 上界：取 bounds[0] 的 y
	limit_right = int( bounds[1].x )# 右界：取 bounds[1] 的 x
	limit_bottom = int( bounds[1].y )# 下界：取 bounds[1] 的 y
	pass # 佔位待填寫
