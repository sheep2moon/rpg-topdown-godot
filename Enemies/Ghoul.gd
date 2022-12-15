extends Enemy

func _ready():
	loot = {
		"1000": {
			"quantity": [5,10],
			"chance": 1
		},
		"10003":{
			"quantity": [1,1],
			"chance": 0.4
		}
	}
