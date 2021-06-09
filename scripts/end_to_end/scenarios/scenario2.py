from scenarios.scenario import Scenario

class Scenario2(Scenario):
    def title(self):
        return 'Video Details'

    def run(self):
        self.given_i_am_on_main_scene()
        self.web_driver.press_btn("select")
        self.web_driver.press_btn("select")
        self.web_driver.get_component_by_attribute("text", "Learn how streaming works")
        self.web_driver.press_btn("back")

    def given_i_am_on_main_scene(self):
        self.web_driver.verify_component_is_loaded({"elementData": [{
			"using": "text",
			"value": "shortFormVideos"
		}]})
