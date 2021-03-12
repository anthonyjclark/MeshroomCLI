# MeshroomCLI

**This repository is unnecessary. Use the `meshroom_photogrammetry` tool.**

A simple CLI script for running AliceVision/Meshroom software from the command line.

# Tutorial

This tutorial and my code is based entirely on [Command-Line Photogrammetry with AliceVision (Tutorial/Guide)](http://filmicworlds.com/blog/command-line-photogrammetry-with-alicevision/) by John Hable.

I've simply taken his code (which was provided with a CC0 license) and updated it a bit so that it was easier to work with.

Steps to take:

1. Download Meshroom (semi-optional)
2. Install Meshroom
3. Clone meshroomCLI
4. Clone Image Data
5. Run meshroomCLI

## 1. Download Meshroom

**You will not need to perform this step if you are working on `pom-itb-dgx01.campus.pomona.edu`.**

Download the Meshroom release from the [GitHub releases pages for Meshroom](https://github.com/alicevision/meshroom/releases) (it will redirect you to a different site).

I had to manually download Meshroom and then upload it to the server. It should be there, but if you are curious, this is the command I used to copy it to the server after downloading it.

```bash
rsync -arv Meshroom-2020.1.0-linux-cuda10.tar.gz ajcd2020@pom-itb-dgx01.campus.pomona.edu:/tmp/
```

## 2. Install Meshroom

You will next install Meshroom in your local user space with the following command.

```bash
tar xvf /tmp/Meshroom-2020.1.0-linux-cuda10.tar.gz -C ~/.local/
```

This should extract the files to a directory called `.local` inside your home directory.

At this point, if you were sitting at the server with a monitor plugged in you could run Meshroom (with `./Meshroom`).

## 3. Clone meshroomCLI

Now you will need this repository. I recommend putting all meshroom related projects together, but feel free to put them whereever you'd like.

```bash
mkdir ~/meshroom
cd ~/meshroom
git clone https://github.com/anthonyjclark/MeshroomCLI.git
```

## 4. Clone Image Data

These images are a good place to start when playing around with Meshroom/AliceVision from the commnad line.

```bash
cd ~/meshroom
git clone https://github.com/alicevision/dataset_monstree.git
```

## 5. Run meshroomCLI

I've added a simple `run_example.sh` script for testing the tool with this tutorial.

```bash
./run_example
```
