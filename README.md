# PANDORA.DOSBOX

This project builds the PND file for the DOSBox IBM-PC Emulator. The PND file can be used on the [OpenPandora](https://pyra-handheld.com/boards/pages/pandora/).

This project does not contain the DOSBox binary. You have to compile it by yourself (see [Compile DOSBox on the Pandora](#compile-dosbox-on-the-pandora). Place the binary in the `src` directory.

# Build the PND file

You will need `mksquashfs`. Install it using the package manager of your choice.

```
./build.sh
```

This will create the `pandora.dosbox.thred.pnd` file.

# Compile DOSBox on the Pandora

## Prepare the environment

You will need an [OpenPandora](https://pyra-handheld.com/boards/pages/pandora/) for this.

Install the [C/C++ Development Tools](http://repo.openpandora.org/?page=detail&app=cdevtools.freamon.40n8e). Placing it on an ext2-formated card is highly recommended (and is required for `addipk` to work).

Make sure, your Pandora is connected to the internet. Enable the SSH daemon by using the configuration tool.

Connect to your Pandora with your user (because it's more fun to use your computer keyboard):

```
ssh <YOU>@<ADDRESS>
```

Prepare the compilation target! Most app will compile to `/usr/local`, but that's on your NAND memory (on the CPU), so let's move the `/usr/local` to the `SDCARD`:

```
mkdir /media/SDCARD/UsrLocal
sudo ln -s /media/SDCARD/UsrLocal/ /usr/local
```

Make yourself a place on the `SDCARD`:

```
mkdir /media/SDCARD/home
```

Now, start the Development Tools:

```
/usr/pandora/scripts/pnd_run.sh -p /media/SDCARD/pandora/menu/cdevtools.freamon.40n8e.pnd -e "setup/start.sh"
```

Provide the password and swith to your new home:

```
cd /media/SDCARD/home
```

## Download the source

```
svn checkout svn://svn.code.sf.net/p/dosbox/code-0/dosbox/trunk dosbox-code-0
```

Make sure, your `SDCARD` is ext-formatted!

## Prepare the first build

```
cd dosbox-code-0

./autogen.sh

export CFLAGS="-O2 -march=armv7-a -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp -fassociative-math -funsafe-math-optimizations -ffast-math -pipe"

export CXXFLAGS="${CFLAGS}" 

./configure --disable-opengl --disable-ddraw
```

## Compile it

Now, you need to be patient:

```
make
```

Copy the `dosbox` binary file in the `src/` folder to the `src/` folder of this project.

