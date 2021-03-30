# duologsync-docker
Docker image based on [Duo Log Sync](https://github.com/duosecurity/duo_log_sync) utility for fetching logs to feed [Devo Data Analytics Platform](https://devo.com) (or another SIEM). 

The goal was to make an easy, ready-to-use, lightweight Docker image (only 67 MB!) for Duo users to send logs to Devo without having to install the utility and its dependencies.


## How to use this image

### 1. Duo 
- Create an [Admin API](https://duo.com/docs/adminapi#first-steps) application in the Duo Admin Panel.
- Get your **integration key**, **secret key**, and **API hostname**.

### 2. Devo
- Set up 4 custom [Devo relay rules](https://docs.devo.com/confluence/ndt/sending-data-to-devo/the-devo-in-house-relay/configuring-the-in-house-relay/relay-rules/defining-a-relay-rule) for these tables:
  - auth.duo.administrator.login (for "*admin_*" actions)
  - auth.duo.administrator.events
  - auth.duo.authentication.events
  - auth.duo.telephony.events

### 3. Duo Log Sync
- Edit the `config.yml` file:
	- Provide your Admin API credentials (from Step 1).
	- Provide your Devo relay connection settings (from Step 2).
  
### 4. Run the image  
- Execute the command: `./run.sh`

### 5. Validation
- Check that `/tmp/duologsync.log` was generated on the host without errors.
- Go to the [Devo](https://us.devo.com) webapp and see if you have Duo events in all `auth.duo.*` tables.


## Building a custom image

This image uses the official Docker build of [Python 3.9](https://hub.docker.com/_/python) that runs on [Alpine Linux](https://alpinelinux.org/). I choose that version and distro to have a minimal image with the latest Python available. If you need a different Python/Linux version, or you just want to add/remove packages, you can build your own image:

- Modify the `Dockerfile` file.
- Run the `build.sh` script to create your custom image.
- Edit the image name in the `run.sh` script to use your new image.


## License
duologsync Docker image is licensed under the terms of the MIT License. See the `LICENSE` file for details.


## Contact 
Find me as __rcmelendez__ on [LinkedIn](https://www.linkedin.com/in/rcmelendez/), [Medium](https://medium.com/@rcmelendez), and of course [GitHub](https://github.com/rcmelendez/).
