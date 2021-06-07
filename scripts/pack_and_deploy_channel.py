#!/usr/bin/env python3

# Requirements:
#   - Install resuqest lib: python3 -m pip install --user requests
#   - Update ROKU_DEVICE_IP, ROKU_DEVICE_USER, ROKU_DEVICE_PWD

from zipfile import ZipFile, ZIP_DEFLATED
import os
import re
import requests
from requests.auth import HTTPDigestAuth


ROOT_DIRECTORY = '../'
CHANNEL_NAME = 'workshop-brightscript-channel'
RELEASE_DIR = "../out"
ROKU_DEVICE_IP = os.environ.get('ROKU_DEVICE_IP') or '192.168.1.6'
ROKU_DEVICE_USER = os.environ.get('ROKU_DEVICE_USER') or 'rokudev'
ROKU_DEVICE_PWD = os.environ.get('ROKU_DEVICE_PWD') or 'webmedia'


def zip_files():
    file_paths = get_all_file_paths(ROOT_DIRECTORY, filtered_dirs=['/out', 'scripts'])

    destination_zip_file_path = "%s/%s" % (RELEASE_DIR, CHANNEL_NAME)
    if os.path.exists(destination_zip_file_path + '.zip'):
        os.remove(destination_zip_file_path + '.zip')
    with try_creating_zip_file_with_compression_level(destination_zip_file_path) as zip:
        for path in file_paths:
            zip.write(path[0], path[1])


def try_creating_zip_file_with_compression_level(file_name):
    try:
        return ZipFile(file_name + '.zip', 'w', compression=ZIP_DEFLATED, compresslevel=9)
    except:
        return ZipFile(file_name + '.zip', 'w', compression=ZIP_DEFLATED)


def get_all_file_paths(directory, filtered_dirs=[], filtered_files=[]):
    length = len(directory)
    file_paths = []
    for root, directories, files in os.walk(directory):
        folder = root[length:]
        if is_filtered_dir(filtered_dirs, folder): continue

        for filename in files:
            if filename in filtered_files: continue
            if re.match('.*xml|.*brs|.*json|.*png|manifest', filename):
                filepath = (os.path.join(root, filename), os.path.join(folder, filename))
                file_paths.append(filepath)
    return file_paths


def is_filtered_dir(filtered_dirs, folder):
    for filtered_dir in filtered_dirs:
        if folder.startswith(filtered_dir):
            return True
    return False


def pack_channel():
    print('Packing channel...')
    zip_files()


def send_home_key():
	print('Sending Home key...')
	print(requests.post('http://' + ROKU_DEVICE_IP + ':8060/keypress/HOME'))


def plugin_install_request(files):
	try:
		print(requests.post('http://' + ROKU_DEVICE_IP + '/plugin_install', files=files, auth=HTTPDigestAuth(ROKU_DEVICE_USER, ROKU_DEVICE_PWD)))
	except Exception as e:
		print(e)


def getRequestFiles(submitType, archive=''):
	return {
        'mysubmit': (None, submitType),
        'archive': archive,
        'passwd': (None, ''),
    }


def upload_channel():
	send_home_key()

	print('Removing existing channel...')
	plugin_install_request(getRequestFiles('Delete'))

	print('Loading channel...')
	destination_zip_file_path = "%s/%s" % (RELEASE_DIR, CHANNEL_NAME)
	
	plugin_install_request(getRequestFiles('Install', open(destination_zip_file_path + '.zip', 'rb')))

	print('Done')


if __name__ == '__main__':
    pack_channel()
    upload_channel()
