class_name State_Attack extends State # 攻擊狀態，繼承 State

var attacking : bool = false # 是否處於攻擊動作中
@export var attack_sound : AudioStream # 攻擊音效資源
@export_range(1,20,0.5) var decelerate_speed : float = 5.0 # 攻擊時速度衰減係數

@onready var attack_anim : AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer" # 攻擊特效動畫播放器
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer" # 角色主動畫播放器
@onready var idle: State = $"../Idle" # 待機狀態引用
@onready var walk: State = $"../Walk" # 行走狀態引用
@onready var audio : AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D" # 攻擊音效播放器
@onready var hurt_Box : HurtBox = %AttackHurtBox # 攻擊判定盒引用

func enter() -> void:# 進入攻擊狀態時觸發動畫與音效
	print("ENTER ATTACK")
	player.update_animation("attack") # 切換角色動畫到攻擊
	attack_anim.play("attack_" + player.anim_direction()) # 播放對應方向的攻擊特效
	animation_player.animation_finished.connect(end_attack) # 動畫結束時回調 EndAttack
	audio.stream = attack_sound # 設定攻擊音效資源
	audio.pitch_scale = randf_range(0.9,1.1) # 隨機微調音高
	audio.play() # 播放攻擊音效
	attacking = true# 標記正在攻擊
	hurt_Box.monitoring = true # 打開攻擊判定
	await get_tree().create_timer( 0.075 ).timeout # 短暫延遲保持判定開啟


func exit() -> void: # 離開攻擊狀態時清理
	animation_player.animation_finished.disconnect(end_attack) # 取消動畫結束回調
	attacking = false # 重置攻擊標記
	hurt_Box.monitoring = false # 關閉攻擊判定
	

func process(_delta : float) -> State:# 攻擊期間衰減速度並決定切換
	player.velocity -= player.velocity * decelerate_speed * _delta # 按係數逐漸減速
	if attacking == false: # 攻擊結束後決定下一狀態
		if player.direction == Vector2.ZERO: # 無方向輸入則待機
			return idle # 切到待機
		else: # 有方向輸入
			return walk # 切到行走
	return null# 預設保持當前狀態

func physics(_delta : float) -> State:# 物理幀無特殊處理
	return null# 保持當前狀態
	
func handle_input( _event : InputEvent ) -> State:# 攻擊狀態下不處理輸入切換
	return null# 返回空表示不變更

func end_attack(_newAnimName : String) ->void:  # 動畫結束的回調
	attacking = false # 標記攻擊完成
