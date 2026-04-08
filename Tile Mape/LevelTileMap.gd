class_name LevelTileMap extends TileMapLayer# 關卡 TileMap，繼承 TileMapLayer



func _ready() -> void:# 初始化時
	LevelManager.ChangeTilemapBounds( GetTilemapBounds() )# 計算邊界並通知管理器
	pass # 佔位


func GetTilemapBounds() -> Array[ Vector2 ]:# 回傳已用區域的世界邊界 [左上, 右下]
	var bounds : Array[ Vector2 ] = []	# 存放邊界的陣列
	bounds.append(
		Vector2(get_used_rect().position * rendering_quadrant_size)# 左上角：已用矩形位置 * 象限大小
	)
	bounds.append(
		Vector2(get_used_rect().end * rendering_quadrant_size)	# 右下角：已用矩形結尾 * 象限大小
	)
	return bounds 	# 回傳兩個點
