#!/usr/bin/env python3

import sys
import os
from subprocess import Popen
from time import sleep


SCRIPTS_HOME = os.path.dirname(os.path.realpath(__file__))
DEPENDENCIES_HOME = f'{SCRIPTS_HOME}/dependencies'
GO_HOME = f'{DEPENDENCIES_HOME}/go'
ACT_HOME = f'{DEPENDENCIES_HOME}/automated-channel-testing'
ROKU_DEVICE_IP = os.environ.get('ROKU_DEVICE_IP') or '192.168.0.11'


def is_go_installed():
	return os.path.exists(GO_HOME)


def download_and_install_go():
	go_url = 'https://golang.org/dl/go1.14.4.darwin-amd64.tar.gz'
	go_package = f'{DEPENDENCIES_HOME}/go_pack.tar.gz'

	print(f'Downloading go into {DEPENDENCIES_HOME}...')
	curl_command = f'curl -L {go_url} --create-dirs --output {go_package}'
	os.system(curl_command)
	print(f'Extracting {go_package} into {DEPENDENCIES_HOME}...')
	tar_command = f'tar -xf {go_package} -C {DEPENDENCIES_HOME}'
	os.system(tar_command)
	print(f'Deleting {go_package}...')
	os.system(f'rm -rf {go_package}')
	

def go_install():
	if is_go_installed():
		os.system(f'rm -rf {GO_HOME}')

	download_and_install_go()


def clone_automated_channel_testing():
	if os.path.exists(ACT_HOME):
		os.system(f'rm -rf {ACT_HOME}')

	print('Clone Automated Channel Testing')
	os.system(f'git clone https://github.com/rokudev/automated-channel-testing.git {ACT_HOME}')


def set_go_path():
	os.environ['GOPATH'] = ACT_HOME


def install_go_dependencies():
	print('Install Go dependencies')
	path = f'{ACT_HOME}/src'
	os.chdir(path)
	os.system(f'{GO_HOME}/bin/go get github.com/gorilla/mux')
	os.system(f'{GO_HOME}/bin/go get github.com/sirupsen/logrus')


def build_roku_web_driver():
	print('Build Roku WebDriver')
	os.system(f'{GO_HOME}/bin/go build main.go')


def setup():
	go_install()
	clone_automated_channel_testing()
	set_go_path()
	install_go_dependencies()
	build_roku_web_driver()


def run_web_driver():
	print('Run Roku Web Driver')
	os.chdir(f'{ACT_HOME}/src')
	p = Popen(['./main'])
	return p.pid


def run_pack_and_deploy():
	os.chdir(SCRIPTS_HOME)
	os.system('python3 pack_and_deploy_channel.py')


def check_web_driver():
	web_driver_url = 'http://localhost:9000/v1/status'
	check_retries = 1
	success = False

	while check_retries < 6:
		print(f'Checking Web Driver, attempt {check_retries}...')
		curl = "curl -X GET -s -I {} | grep HTTP/ | awk {{'print $2'}}".format(web_driver_url)
		status = os.popen(curl).read().strip()

		if '200' in status:
			success = True
			check_retries = 6
		else:
			check_retries += 1
			sleep(1)

	return success


def kill_web_driver(web_driver_pid):
	os.system(f'kill -9 {web_driver_pid}')
	print(f'Killed web driver process: {web_driver_pid}')


def run_user_journey(web_driver_pid):
        exit_code = 0

        if check_web_driver():
            end2end_path =  '{}/end_to_end/'.format(SCRIPTS_HOME)
            os.chdir(end2end_path)

            end2end_run_command = 'python3 user_journey.py {}'.format(ROKU_DEVICE_IP)
            e2e_output = os.system(end2end_run_command)
            exit_code = os.WEXITSTATUS(e2e_output)
        else:
            print('Error: Web driver server could not be started.')
        
        kill_web_driver(web_driver_pid)

        if exit_code != 0:
            raise Exception('E2E tests finished with failed scenarios')


def run():
	run_pack_and_deploy()
	web_driver_pid = run_web_driver()
	run_user_journey(web_driver_pid)


if __name__ == '__main__':
	if len(sys.argv) < 2:
		print("Usage: ./run_e2e.py <setup|run>")
	else:
		command = sys.argv[1]
		
		if command in ['setup', 'run']:
			locals()[sys.argv[1]]()
		else:
			print("Usage: ./run_e2e.py <setup|run>")