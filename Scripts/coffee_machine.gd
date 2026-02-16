extends TaskItem

@onready var coffee_place = $CoffeePlace
@onready var coffee_cup_scene = preload("res://Scenes/Furniture/coffee_cup.tscn")

func interact():
	super()
	var coffe_cup = coffee_cup_scene.instantiate()
	coffee_place.add_child(coffe_cup)
