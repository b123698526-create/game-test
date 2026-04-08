class_name plant extends Node2D # 植物節點，繼承 Node2D

func _ready() -> void: # 初始化時連接受擊信號
	$HitBox.Damaged.connect( TakeDamage ) # 綁定 HitBox 的受傷信號到自身處理
	pass # 佔位以便擴展

func TakeDamage( _damage : int) -> void: # 收到傷害時的處理
	queue_free()  # 受擊後從場景移除自己
	pass # 保留佔位
