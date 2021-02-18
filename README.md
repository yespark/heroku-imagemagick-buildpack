heroku-buildpack-imagemagick-heif
=================================

The rise in popularity and use of HEIF/HEIC(High Efficency Image Format) means your project's image processing also needs to be able to handle this format.
The current default version of imagemagick installed on heroku:20 dynos is a version 6.xx and does not support processing heic image files.

This [Heroku buildpack](https://devcenter.heroku.com/articles/buildpacks) vendors a version of ImageMagick with **WEBP and HEIF support** binaries into your project.

This one works was built for [**Heroku stack 20**](https://devcenter.heroku.com/articles/stack).

The tar file in the [/build folder](./build) currently contains: 

Version: ImageMagick 7.0.11-0

You will need to build a new binary if you want to use a newer or different version. To build a new binary see [How to Build a New Binary](#how-to-build-a-new-binary)

# Usage
## Step 1 : Adding the buildpack

From your projects "Settings" tab add this buildpack to your app in the 1st position:

```bash
https://github.com/yespark/heroku-imagemagick-buildpack
```
**NOTE:** __To ensure the newer version of imagemagick is found in the $PATH and installed first make sure this buildpack is added to the top of the buildpack list or at "index 1"._


## Step 2 : Clear the cache(__Not Sure if this is necessary__)
Since the installation is cached you might want to clean it out due to config changes.

```bash
heroku plugins:install heroku-repo
heroku repo:purge_cache -app HEROKU_APP_NAME
```

# How to Build a New Binary (if you want to make somes changes)

The binary in this repo was built in a heroku:20 docker image running in a local dev environment.
However, there is a script called [**build.sh**](./build.sh) made to build a tar file through docker easily, it will be copied to the `build` directory. Then you should commit this changes to your git, and adjust the buildpack url previously mentionned just above.

## Prerequisites

- Docker installed and running in local dev environment. [Get Docker](https://docs.docker.com/get-docker/)
## Credits
- https://medium.com/@eplt/5-minutes-to-install-imagemagick-with-heic-support-on-ubuntu-18-04-digitalocean-fe2d09dcef1
- https://github.com/brandoncc/heroku-buildpack-vips
- https://github.com/steeple-dev/heroku-buildpack-imagemagick
- https://github.com/retailzipline/heroku-buildpack-imagemagick-heif
