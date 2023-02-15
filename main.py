import os
import sys
import logging
import subprocess
import time

#sys.path.append(os.path.dirname(__file__))

logging.basicConfig(filename=os.getenv('DECKY_PLUGIN_LOG_DIR') + "/log.txt",
                    format='[MagicPacket] %(asctime)s %(levelname)s %(message)s',
                    filemode='w+',
                    force=True)
logger=logging.getLogger()
logger.setLevel(logging.DEBUG) # Options: logging.INFO, logging.DEBUG
logger.info("Starting " + os.environ.get('DECKY_PLUGIN_NAME'))
logger.info("MagicPacket Version: " + os.environ.get('DECKY_PLUGIN_VERSION'))
logger.info("Decky Version: " + os.environ.get('DECKY_VERSION'))
logger.info("Settings Directory: " + os.environ.get('DECKY_PLUGIN_SETTINGS_DIR'))

SETTINGSFILE = str(os.environ.get('DECKY_PLUGIN_SETTINGS_DIR') + "/settings.json")
PLUGIN_BIN_DIR = str(os.environ.get('DECKY_PLUGIN_DIR') + "/bin")

subprocess.run("chmod +x ./*.sh", cwd=PLUGIN_BIN_DIR, shell=True)
logger.debug("Made bash scripts executable")

class Plugin:
    async def sendpacket(self):
        logger.debug("Called 'sendpacket'")
        #subprocess.run("./sendpacket.sh", cwd=PLUGIN_BIN_DIR, shell=True)
    
    async def configurator(self):
        logger.debug("Called 'configurator'")
        #subprocess.run("./configurator.sh", cwd=PLUGIN_BIN_DIR, shell=True)

    async def _main(self):
        while(True):
            logger.debug("Called 'statuscheck'")
            subprocess.run("./statuscheck.sh", cwd=PLUGIN_BIN_DIR, shell=True)
            time.sleep(5)
