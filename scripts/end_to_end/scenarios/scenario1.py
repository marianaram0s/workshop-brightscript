from scenarios.scenario import Scenario
from support.web_driver import WebDriver

from time import sleep

class Scenario1(Scenario):
	def title(self):
		return 'Browsing content'
    
	def run(self):
		self.given_i_am_on_main_scene()
		self.then_i_move_cursor_over_all_elements()

	def given_i_am_on_main_scene(self):
		self.web_driver.verify_component_is_loaded({"elementData": [{
			"using": "text",
			"value": "shortFormVideos"
		}]})

	def then_i_move_cursor_over_all_elements(self):
		self.web_driver.press_btn("right")
		self.web_driver.press_btn("right")
		self.web_driver.press_btn("down")
		self.web_driver.press_btn("left")
		self.web_driver.press_btn("left")