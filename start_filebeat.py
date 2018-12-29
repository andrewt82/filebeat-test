import subprocess
import os
command = "service filebeat start"
#comm = subprocess.Popen(command, stdout=subprocess.PIPE,
#                        shell=True, stderr=subprocess.PIPE)
os.system(command)