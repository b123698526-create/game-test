class_name plant extends Node2D # 植物節點，繼承 Node2D

func _ready() -> void :
	$HitBox.damaged.connect( TakeDamage ) # 綁定 HitBox 的受傷信號到自身處理


func TakeDamage( hurt_box : HurtBox ) -> void: # 收到傷害時的處理
	queue_free()  
