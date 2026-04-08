class_name PlayerStateMachine extends Node # 玩家狀態機節點，繼承 Node

var states : Array[ State ] = [] # 存儲全部子狀態的列表
var prev_state : State # 記錄上一個狀態
var current_state : State # 記錄當前狀態

func _ready() -> void: # 初始化時先禁用處理
	process_mode = Node.PROCESS_MODE_DISABLED # 預設禁用處理，待初始化後開啟
	pass # 佔位便於擴展

func _process( delta: float ) -> void: # 每幀調用當前狀態的邏輯更新
	Change_State(current_state.Process( delta ) ) # 執行 Process 並依據返回值切換狀態
	pass # 佔位便於擴展
	
func _physics_process(delta: float) -> void: # 物理幀調用當前狀態的物理更新
	Change_State(current_state.Physics( delta ) ) # 執行 Physics 並處理可能的切換
	pass # 佔位
	
func _unhandled_input(event: InputEvent) -> void:# 捕獲未處理的輸入事件
	Change_State(current_state.HandleInput( event )) # 將輸入交給當前狀態並嘗試切換
	pass # 佔位

func Initialize( _player : Player) -> void:# 初始化狀態機並注入玩家引用
	for c in get_children():# 遍歷子節點
		if c is State:# 若子節點是 State
			states.append(c)# 收集到狀態列表
	
	for s in states:# 遍歷收集到的狀態
		s.player = _player# 為每個狀態注入玩家引用
	
	if states.size() > 0:# 若存在至少一個狀態
		states[0].player = _player# 再次保證首個狀態綁定玩家
		Change_State( states[0] )# 切換到首個狀態作為初始狀態
		process_mode = Node.PROCESS_MODE_INHERIT# 啟用處理邏輯
		
func Change_State(new_state : State ) ->void:# 負責狀態切換
	if new_state == null || new_state == current_state:# 若無新狀態或重複狀態
		return# 直接返回不做改變

	if current_state:# 若已有當前狀態
		current_state.Exit()# 調用當前狀態的退出
	
	prev_state = current_state # 記錄剛離開的狀態
	current_state = new_state# 更新當前狀態
	current_state.Enter() # 調用新狀態的進入邏輯
