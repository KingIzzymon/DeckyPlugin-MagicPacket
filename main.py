import sys
import os
import pathlib
import logging
import subprocess
import time

# Append py_modules to PYTHONPATH
sys.path.append(os.path.dirname(os.path.realpath(__file__))+"/py_modules")

PLUGIN_DIR = str(pathlib.Path(__file__).parent.resolve())
PLUGIN_BIN_DIR = str(PLUGIN_DIR+"/bin")

logging.basicConfig(filename=PLUGIN_BIN_DIR+"/log.log",
                    format='[MagicPacket] %(asctime)s %(levelname)s %(message)s',
                    filemode='w+',
                    force=True)
logger=logging.getLogger()
logger.setLevel(logging.DEBUG) # Can be changed to logging.DEBUG for debugging issues

# Make scripts executable
subprocess.run("chmod +x *.sh", cwd=PLUGIN_BIN_DIR, shell=True)

class Plugin:
    # If asleep, then wake. Else iff awake, then sleep
    async def sendpacket(self):
        logger.debug("Called 'sendpacket'")
        subprocess.run("./sendpacket.sh", shell=True)
    
    # Launch configurator
    async def configurator(self):
        logger.debug("Called 'configurator'")
        subprocess.run("./configurator.sh", cwd=PLUGIN_BIN_DIR, shell=True)

    # Update status of server PC in config every 5 seconds
    async def _main(self):
        while(True):
            logger.debug("Called 'statuscheck'")
            subprocess.run("./statuscheck.sh", cwd=PLUGIN_BIN_DIR, shell=True)
            time.sleep(5)
