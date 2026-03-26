extends CharacterBody3D

enum side{
	front,
	left,
	right,
	back
}

@export var sprites: Dictionary[side, Texture2D]={
	side.front: null,
	side.left: null,
	side.right: null,
	side.back: null
}
