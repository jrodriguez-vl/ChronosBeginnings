extends ProgressBar
class_name BaseBar

func Init(maxVal: float, currentVal: float):
	UpdateMax(maxVal)
	UpdateCurrent(currentVal)

func UpdateCurrent(currentVal: float):
	self.value = currentVal

func UpdateMax(maxVal: float):
	self.max_value = maxVal

# func _process(delta: float) -> void:
	
