class_name HurtBox extends Area2D # 傷害判定節點，繼承 Area2D
@export var damage : int = 1 # 暴露傷害數值到 Inspector，預設 1 點

func _ready() -> void: # 場景進入時連接進入信號
	area_entered.connect(AreaEnterd) # 有 Area2D 進入時觸發 AreaEnterd
	pass # 佔位便於後續擴展

func _process(_delta: float) -> void: # 每幀處理未使用，保持接口
	pass # 暫無邏輯

func AreaEnterd( a : Area2D ) -> void: # 處理進入區域的 Area2D
	if a is HitBox : # 若進入者是 HitBox
		a.TakeDamage( damage ) # 調用 HitBox 的受擊邏輯，傳入傷害值
	pass # 保留佔位
