# Looking Glass Builder

The objective of this project is to provide pre-built binaries for [Looking Glass](https://github.com/gnif/LookingGlass).

## Quickstart
Open a Terminal window and run the commands below one by one:
```bash
git clone https://github.com/qubetzl/looking-glass-builder.git
cd looking-glass-builder/
./rebuild-debian.sh "Release/B5"
```
This would produce a binary in the following format `looking-glass-client-<version>` in the current directory e.g. `looking-glass-client-B5.0.1` or `looking-glass-client-B5-292-g88d60d4b3d` in the case of a bleeding edge build.

This is the Looking Glass Client executable.  
You can run it with:
```bash
./looking-glass-client-B5.0.1
```

## Why?
As of now (05.10.2021) building from source is the only option for acquiring a _client_ binary for Looking Glass. (There are likely good reasons for it to remain that way, but that doesn't mean we have to like it.)  
For most people building from source can be intimidating and/or uncomfortable.  
This project aims to bridge that gap and allow for easier user installation experience.

Separately, I'm a _crazy person_ and I like to keep my OS installation as clean from extraneous software as possible. I consider development tools and dependencies as such software.  

This project is as much for me as it is for everyone else.

# Artifact directory
Build artifacts are copied to the `/build/ ` directory.  
Volume the `/build/` directory in order to get the binary out e.g.
```
-v $(pwd):/build
```

# Inspirations

Inspiration for templating system comes from [Docker Library Official Images](https://github.com/docker-library/official-images) setup.

"Official images" have a library definition file that lives in the [`library/` directory of the `official-images` repository](https://github.com/docker-library/official-images/tree/master/library).

These definition files are used to describe settings for the generated image [update.sh](https://github.com/docker-library/python/blob/master/update.sh), documentation and CI strategy/matrix via [bashbrew](https://github.com/docker-library/bashbrew).  
[See Generate Jobs](https://github.com/docker-library/python/runs/3806298099?check_suite_focus=true).  
This setup allows for easier update to software version and tags, by only changing the libray definition file (As far as I can tell at least).

**Dart Example (simpler due to the number of image variants):**  
Library Definition: https://github.com/docker-library/official-images/blob/master/library/dart  
CI Workflow action: https://github.com/dart-lang/dart-docker/blob/main/.github/workflows/docker-image.yml

**Python Example:**  
Library Definition: https://github.com/docker-library/official-images/blob/master/library/python  
CI Workflow action: https://github.com/docker-library/python/blob/master/.github/workflows/ci.yml

More info: [Docker Library FAQ: Library definition files](https://github.com/docker-library/official-images#library-definition-files)
