#!/usr/bin/python

import getpass
import os
from os.path import expanduser


HOMEDIR_NETWORK_PATH = 'fima.gyyv.vd.ch/data/homes/dataperso/'

logged_user = getpass.getuser()

if 'fima' in expanduser("~"):
	mount_dir_path = "afp://" + logged_user + "@" + "fima.gyyv.vd.ch/groups/"

    cmd = "osascript -e 'mount volume \"" + mount_dir_path + "\"'"
	os.system(cmd)

if 'TeachersTmp' in expanduser("~"):
	mount_dir_path = "afp://" + logged_user + "@" + HOMEDIR_NETWORK_PATH + logged_user
	
	cmd = "osascript -e 'mount volume \"" + mount_dir_path + "\"'"
    os.system(cmd)