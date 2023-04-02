extends CharacterBody2D
signal hit
signal death


@export var speed = 400 # Speed the player has at the start.
@export var health = 100 #Health, or patience, depending on how we want to flavor it.
@export var damage_taken = 10 #Damage, Might change depending on how signals work between nodes.
var screen_size
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
#	move_and_slide()
	#Clamping Position for testing only. Will need to set up map boundaries
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "default"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x > 0

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false



	

