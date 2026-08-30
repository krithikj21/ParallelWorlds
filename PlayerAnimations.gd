extends AnimationPlayer

@onready var player = get_parent()
@onready var sprite = %Sprite2D
@onready var cs_2d = %CollisionShape2D
@onready var feet = %feet

var last_direction = 0.1

var coyote_timer = 0.0
@export var coyote_time = 0.1
@export var fall_velocity_threshold = 320.0

func _ready():
	pass

func _process(delta):
	if player.velocity.x != 0:
		last_direction = player.velocity.x
	if player.is_on_floor():
		coyote_timer = coyote_time
	else:
		coyote_timer -= delta
	var effectively_grounded = coyote_timer > 0.0
	if current_animation == "landing":
		pass
	elif effectively_grounded:
		if player.velocity.x == 0:
			if current_animation != "idle_right":
				play("idle_right")
		else:
			if current_animation != "run_right":
				play("run_right")
	if not effectively_grounded:
		player.falling = true
		if player.velocity.y < 0:
			if current_animation != "jump_right":
				play("jump_right")
		elif player.velocity.y > fall_velocity_threshold:
			if current_animation != "falling":
				play("falling")
	elif player.falling:
		play("landing")
		player.falling = false
	if last_direction < 0:
		sprite.flip_h = true
		cs_2d.position = Vector2(36, 33.5)
		feet.position = Vector2(38, 47.375)

	if last_direction > 0:
		sprite.flip_h = false
		cs_2d.position = Vector2(44, 33.5)
		feet.position = Vector2(42, 47.375)

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "landing":
		if player.velocity.x == 0:
			play("idle_right")
		else:
			play("run_right")
