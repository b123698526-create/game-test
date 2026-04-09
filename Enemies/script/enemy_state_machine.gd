class_name EnemyStateMachine extends Node	# 敵人狀態機

var states: Array[EnemyState] = []	# 收集到的敵人狀態
var prev_state: EnemyState	# 前一個狀態
var current_state: EnemyState	# 目前狀態


func _ready() -> void:	# 初始化：先停用更新
	process_mode = Node.PROCESS_MODE_DISABLED
	pass


func _process(delta: float) -> void:	# 每幀邏輯更新
	if current_state == null or current_state.enemy == null:
		return
	change_state(current_state.process(delta))
	pass


func _physics_process(delta: float) -> void:# 每幀物理更新
	
	if current_state == null or current_state.enemy == null:
		return
	change_state(current_state.physics(delta))
	pass


func initialize(_enemy: Enemy) -> void:	# 初始化：注入 Enemy 並收集狀態
	states.clear()
	for c in get_children():	# 掃描子節點
		if c is EnemyState:
			states.append(c)
	
	for s in states:	# 注入引用並初始化
		s.enemy = _enemy
		s.state_machine = self
		s.init()

	if states.size() > 0:
		change_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT
	pass


func change_state(new_state: EnemyState) -> void:	# 狀態切換
	if new_state == null or new_state == current_state:
		return
	if current_state:
		current_state.exit()
	prev_state = current_state
	current_state = new_state
	current_state.enter()
