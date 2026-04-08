extends Node

var current_tilemap_bounds : Array[Vector2]# 當前地圖邊界（如左上、右下）
signal TileMapBoundsChanged(  bounds : Array[Vector2 ])# 邊界變更訊號，攜帶新的邊界

func ChangeTilemapBounds(bounds : Array[ Vector2]) -> void:# 更新邊界並通知外部
	current_tilemap_bounds = bounds# 寫入新的邊界資料
	TileMapBoundsChanged.emit(bounds)# 發出變更訊號
