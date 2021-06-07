import requests
from requests.auth import HTTPDigestAuth
import shutil
import json
from support.ui.component import Component
from time import sleep
import os
from pathlib import Path

class WebDriver:
    def __init__(self, roku_ip_address: str):
        data = {'ip' : roku_ip_address}
        request_url = self._build_request_url('')
        response = self._post(request_url, data)
        res = json.loads(response.text)

        self._session_id = res['sessionId']
        self.roku_ip_address = roku_ip_address

    def _send_launch_channel(self, channel_code: str):
        data = {'channelId' : channel_code}
        request_url = self._build_request_url(f"/{self._session_id}/launch")
        return self._post(request_url, data)
    
    def _send_sequence(self, sequence):
        data = {'button_sequence' : sequence}
        request_url = self._build_request_url(f"/{self._session_id}/press")
        return self._post(request_url, data)

    def _get_ui_element(self, data: object):
        request_url = self._build_request_url(f"/{self._session_id}/element")
        return self._post(request_url, data)

    def _get_ui_active_element(self):
        request_url = self._build_request_url(f"/{self._session_id}/element/active")
        return self._post(request_url, None)

    def _send_keypress(self, key_press: str):
        data = {'button' : key_press}
        request_url = self._build_request_url(f"/{self._session_id}/press")
        return self._post(request_url, data)

    def _build_request_url(self, endpoint: str):
        return f"http://localhost:9000/v1/session{endpoint}"

    def quiet(self):
        request_url = self._build_request_url(f"/{self._session_id}")
        self._delete(request_url)

    def _post(self, request_url: str, data: object):
        return requests.post(url = request_url, data = json.dumps(data))

    def _get(self, request_url: str):
        return requests.get(request_url)
    
    def _delete(self, request_url: str):
        return requests.delete(request_url)

    def launch_the_channel(self, channel_code):
        launch_response = self._send_launch_channel(channel_code)
        if launch_response.status_code != 200:
            raise Exception("Wrong launch response code")
        return launch_response.text

    def verify_component_is_loaded(self, data: object, invoke_error = True, retries = 10):
        while retries > 0:
            ui_layout_response = self._get_ui_element(data)
            if ui_layout_response.status_code != 200:
                retries -= 1
                sleep(1)
            else:
                return True
        if invoke_error == True:
            raise Exception(f"Can't find element with data {data}")
        else:       
            return False

    def press_btn(self, key_press: str):
        sleep(2)
        key_press_response = self._send_keypress(key_press)
        if key_press_response.status_code != 200:
            raise Exception("Wrong keypress response code")

    def send_word(self, word: str):
        sleep(2)
        for c in word:
            key_press_response = self._send_keypress(f"LIT_{c}")
            if key_press_response.status_code != 200:
                raise Exception("Wrong keypress response code")

    def send_button_sequence(self, sequence):
        key_press_response = self._send_sequence(sequence)
        if key_press_response.status_code != 200:
            raise Exception("Wrong keypress response code")
    
    def get_component_by_attribute(self, attr_name: str, attr_value: str, retries = 10):
        while retries > 0:
            ui_layout_response = self._get_ui_element({"elementData": [{
                "using": "attr",
                "attribute": attr_name,
                "value": attr_value
            }]})

            if ui_layout_response.status_code != 200:
                retries -= 1
                sleep(1)
            else:
                return Component(ui_layout_response.text)
        raise Exception(f"Can't find element with attribute {attr_name} equals to {attr_value}")

    def get_component_by_name(self, name, retries = 10):
        return self.get_component_by_attribute('name', name, retries)
    
    def wait_component_to_show_up(self, name, retries = 10):
        return self.wait_components_to_show_up([name], retries)

    def wait_components_to_show_up(self, names, retries = 10):
        while retries > 0:
            index = retries%len(names)
            component = self.get_component_by_name(names[index])

            if component.is_visible():
                return component
            else:
                retries -= 1
                sleep(1)
        
        raise Exception(f"Component {names} did not show up")


    def get_all_screen_components(self):
        url = self._build_request_url(f"/{self._session_id}/source")
        return self._get(url).text


    def get_all_apps(self):
        url = self._build_request_url(f"/{self._session_id}/apps")
        return self._get(url).text

    
    def get_current_app(self):
        url = self._build_request_url(f"/{self._session_id}/current_app")
        return self._get(url).text


    def take_screenshot(self, file_name, sleep_before_screenshot=2):
        sleep(sleep_before_screenshot)
        
        roku_user = os.environ['ROKU_DEVICE_USER']
        roku_pwd = os.environ['ROKU_DEVICE_PWD']
        download_ss_curl = f'curl -fSs --digest --user {roku_user}:{roku_pwd} -F "mysubmit=Screenshot" http://{self.roku_ip_address}/plugin_inspect'
        print(f'Taking screenshot...')
        os.system(download_ss_curl)

        roku_auth = HTTPDigestAuth(roku_user, roku_pwd)
        ss_download_url = f'http://{self.roku_ip_address}/pkgs/dev.jpg'
        print(f'Downloading screenshot...')
        response = requests.get(url=ss_download_url, auth=roku_auth, data = "mysubmit=Screenshot", stream=True)

        ss_dir = f'{os.path.dirname(os.path.realpath(__file__))}/../screenshots/'
        ss_path = f'{ss_dir}{file_name}.jpg'
        
        with open(ss_path, 'wb') as ss:
            response.raw.decode_content = True
            shutil.copyfileobj(response.raw, ss)

        print(f'Screenshot downloaded.')