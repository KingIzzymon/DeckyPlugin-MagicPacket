import subprocess
import pathlib
import time

PLUGIN_DIR = str(pathlib.Path(__file__).parent.resolve())
PLUGIN_BIN_DIR = str(PLUGIN_DIR + "/bin")

# Make scripts executable
subprocess.run("chmod +x *.sh", cwd=PLUGIN_BIN_DIR)

class Plugin:
    # If asleep, then wake. Else iff awake, then sleep
    async def sendpacket(self):
        subprocess.run("./sendpacket.sh", cwd=PLUGIN_BIN_DIR)
    
    # Launch configurator
    async def configurator(self):
        subprocess.run("./configurator.sh", cwd=PLUGIN_BIN_DIR)

    # Update status of server PC in config every 5 seconds
    async def _main(self):
        while(True):
            subprocess.run("./statuscheck.sh", cwd=PLUGIN_BIN_DIR)
            time.sleep(5)
