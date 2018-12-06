#!/usr/bin/python

import getpass
import os
from os.path import expanduser


HOMEDIR_REPARTITION = ['a', 'e', 'l', 'o']
HOMEDIR_NETWORK_PATH1 = 'fs0'
HOMEDIR_NETWORK_PATH2 = '.gyyv.vd.ch/dataperso/'

server_nb = 1
logged_user = getpass.getuser()

if 'UsersTmp' in expanduser("~"):
        for i in range(1,4):
                if logged_user[0] >= HOMEDIR_REPARTITION[i]:
                        server_nb += 1
        #mount_dir_path = "afp://" + HOMEDIR_NETWORK_PATH1 + str(server_nb) + HOMEDIR_NETWORK_PATH2 + logged_user
        mount_dir_path = "afp://" + logged_user + "@" + HOMEDIR_NETWORK_PATH1 + str(server_nb) + HOMEDIR_NETWORK_PATH2 + logged_user

        #cmd = "osascript -e 'mount volume \"" + mount_dir_path + "\" as user name \"" + logged_user + "\"'"
        cmd = "osascript -e 'mount volume \"" + mount_dir_path + "\"'"
        os.system(cmd)

# if 'fima' in expanduser("~"):
#         mount_dir_path = "afp://" + logged_user + "@" + "fima.gyyv.vd.ch/groups/"
# 
#         cmd = "osascript -e 'mount volume \"" + mount_dir_path + "\"'"
#         os.system(cmd)
