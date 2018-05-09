# browser-docker
Run chromium and selenium with docker

[![](https://images.microbadger.com/badges/image/puteulanus/browser-docker.svg)](https://microbadger.com/images/puteulanus/browser-docker "Get your own image badge on microbadger.com")

### Run:
```bash
docker run -d -p 80:80 -e VNC_PASSWD="Your Password" puteulanus/browser-docker
```

Then go to http://localhost/vnc to see the remote desktop.

Go http://localhost/ to edit the init.py code with Cloud9 Web IDE, or mount your code folder to /root/workspace. The endpoint program must named init.py.

Username for Cloud9 is admin and password is VNC's password.
