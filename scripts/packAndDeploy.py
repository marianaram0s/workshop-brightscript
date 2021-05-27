from zipfile import ZipFile, ZIP_DEFLATED
import os
import re
import requests
from requests.auth import HTTPDigestAuth

DIRECTORY = '../'
CHANNEL_NAME = 'workshop-brightscript'
ROKU_DEVICE_IP = os.environ.get('ROKU_DEVICE_IP') or '192.168.1.6'
ROKU_USER = os.environ.get('ROKU_DEVICE_USER') or 'rokudev'
ROKU_PASS = os.environ.get('ROKU_DEVICE_PWD') or 'webmedia'


def zip_channel():
    print('Packing sample app...')
    file_paths = get_all_file_paths(DIRECTORY, filtered_dirs=['/out'])
    
    if os.path.exists(CHANNEL_NAME + '.zip'):
        os.remove(CHANNEL_NAME + '.zip')
    
    with try_creating_zip_file_with_compression_level(CHANNEL_NAME) as zip:
        for path in file_paths:
            zip.write(path[0], path[1])
    print('Done')


def try_creating_zip_file_with_compression_level(file_name):
    try:
        return ZipFile(file_name + '.zip', 'w', compression=ZIP_DEFLATED, compresslevel=9)
    except:
        return ZipFile(file_name + '.zip', 'w', compression=ZIP_DEFLATED)


def isFilteredDir(filtered_dirs, folder):
    for filtered_dir in filtered_dirs:
        if folder.startswith(filtered_dir):
            return True
    return False


def get_all_file_paths(directory, filtered_dirs=[], filtered_files=[]):
    length = len(directory)
    file_paths = []
    for root, directories, files in os.walk(directory):
        folder = root[length:]
        if isFilteredDir(filtered_dirs, folder): continue

        for filename in files:
            if filename in filtered_files: continue
            if re.match('.*xml|.*brs|.*json|.*png|manifest|.*ttf', filename):
                filepath = (os.path.join(root, filename), os.path.join(folder, filename))
                file_paths.append(filepath)
    return file_paths


def sideload_channel():
	send_home_key_command()
	remove_existing_channel()
	load_new_channel()
	print('Done')


def send_home_key_command():
	print('Sending Home key...')
	print(requests.post('http://' + ROKU_DEVICE_IP + ':8060/keypress/HOME'))
    

def remove_existing_channel():
	files = {
        'mysubmit': (None, 'Delete'),
        'archive': (None, ''),
        'passwd': (None, ''),
    }
	print('Removing sideloaded app...')
	print(requests.post('http://' + ROKU_DEVICE_IP + '/plugin_install', files=files, auth=HTTPDigestAuth(ROKU_USER, ROKU_PASS)))
    

def load_new_channel():
	files = {
        'mysubmit': (None, 'Install'),
        'archive': open(CHANNEL_NAME + '.zip', 'rb'),
        'passwd': (None, ''),
    }
	print('Loading app...')
	print(requests.post('http://' + ROKU_DEVICE_IP + '/plugin_install', files=files, auth=HTTPDigestAuth(ROKU_USER, ROKU_PASS)))

   
if __name__ == '__main__':
    zip_channel()
    sideload_channel()