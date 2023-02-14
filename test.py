import subprocess
import pathlib
import os

print('getcwd:      ', os.getcwd())
print('__file__:    ', __file__)

PLUGIN_DIR = str(pathlib.Path(__file__).parent.resolve())

# Make scripts executable
subprocess.run("echo hello")
