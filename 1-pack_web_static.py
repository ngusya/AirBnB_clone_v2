#!/usr/bin/python3
""" Fabfile generates a .tgz archive from the contents of web_static folder."""

from fabric.operations import local
from datetime import datetime
"""from fabric.api import local"""

env.user = 'ubuntu'
env.hosts = ['100.24.209.37', '3.237.5.93']

def do_pack():
    """Compress files from the directory /web_static."""
    dt = datetime.now()
    file = "versions/web_static_{}{}{}{}{}{}.tgz".format(dt.year,
                                                         dt.month,
                                                         dt.day,
                                                         dt.hour,
                                                         dt.minute,
                                                         dt.second)
    if os.path.isdir("versions") is False:
        if local("mkdir -p versions").failed is True:
            return None
    if local("tar -cvzf {} web_static".format(file)).failed is True:
        return None
    return file
