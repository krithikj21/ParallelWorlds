extends CharacterBody2D

var speedMultiplier: int = 300
var jump_force = -600
var gravity = 1200
var falling = false
var is_mc = true
# Called when the node enters the scene tree for the first time.
func _ready():
	floor_snap_length = 16.0
	for layer in get_tree().get_nodes_in_group("mc_layers"):
		layer.enabled = is_mc
	for layer in get_tree().get_nodes_in_group("rc_layers"):
		layer.enabled = !is_mc
	for textures in get_tree().get_nodes_in_group("mc_textures"):
		textures.visible = is_mc
	for textures in get_tree().get_nodes_in_group("rc_textures"):
		textures.visible = !is_mc
	position = Vector2(24, 397)

func _physics_process(delta):
	velocity.x = 0
	movement()
	velocity.x *= speedMultiplier
	velocity.y += gravity * delta
	if is_on_floor():
		jump()
	if Input.is_action_just_pressed("swap"):
		swap_world()
	set_velocity(velocity)
	set_up_direction(Vector2.UP)
	move_and_slide()
	print(velocity)
	
	# ****Start Working On Gravity Logic And Basic Tilemap


func movement():
	if Input.is_action_pressed("ui_right"):
		velocity.x = 1
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -1
			
			
func jump():
	if Input.is_action_just_pressed("ui_up"):
		velocity.y = jump_force
		
func swap_world():
	is_mc = !is_mc
	for layer in get_tree().get_nodes_in_group("mc_layers"):
		layer.enabled = is_mc
	for layer in get_tree().get_nodes_in_group("rc_layers"):
		layer.enabled = !is_mc
	for textures in get_tree().get_nodes_in_group("mc_textures"):
		textures.visible = is_mc
	for textures in get_tree().get_nodes_in_group("rc_textures"):
		textures.visible = !is_mc
