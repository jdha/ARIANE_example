# ARIANE_example
Setting up and running ARIANE on JASMIN. The following compilation a testing is done on one of the jasmin-sci[1-6] machines.

Create a directory for the ariane package:

```
export ARIANE_ROOT_DIR=path_to_araine
[ -d $ARIANE_ROOT_DIR ] || mkdir -p $ARIANE_ROOT_DIR
cd $ARIANE_ROOT_DIR
```

Get code source (a username and password will be required. See the [ARIANE](http://stockage.univ-brest.fr/~grima/Ariane/) web site for more details):

```wdget --user user --password pass http://stockage.univ-brest.fr/~grima/Ariane/download/ariane-2.2.8_04.tar.gz```

Load modules:

```
module load intel/14.0
module load netcdf/intel/14.0/4.3.2
module load netcdff/intel/14.0/4.2
module load libPHDF5/intel/14.0/1.8.12
```

Alternatively if you want this as default, add to `~/.bashrc`:

```
if [[ $HOSTNAME != jasmin-login1.ceda.ac.uk ]] && [[ $HOSTNAME != jasmin-login2.ceda.ac.uk ]] && [[ $HOSTNAME != jasmin-xfer1.ceda.ac.uk ]]; then
echo $HOSTNAME
module load intel/14.0
module load netcdf/intel/14.0/4.3.2
module load netcdff/intel/14.0/4.2
module load libPHDF5/intel/14.0/1.8.12
fi
```

Set environment variables:

```
export HDF5_LIB="${HDF5_LIBDIR}"
export HDF5_INC="${HDF5_INCDIR}"
export NETCDF_INC="${NETCDF_FORTRAN_ROOT}/include"
export NETCDF_LIB="${NETCDF_ROOT}/lib"
export FC=ifort
export FCFLAGS="-O2 -I${HDF5_INC} -I${NETCDF_INC}"
export LIBS="-L${NETCDF_FORTRAN_ROOT}/lib -lnetcdff "
```

For some reason the HDF5 path is not added to the `LD_LIBRARY_PATH` so we do that now:

```
export LD_LIBRARY_PATH="${HDF5_LIB}:${LD_LIBRARY_PATH}"
```

Run configure script:

```
cd ariane-2.2.8_04
mkdir intel
./configure --prefix=$ARIANE_ROOT_DIR/ariane-2.2.8_04/intel  --enable-hdf5
```

Hopefully this runs successfully. Otherwise check the `config.log` for possible sources of error. Next compile ARIANE:

```
make
make check
make install
```

For ease, put the executable in your path by link from `~/bin`:

```
[ -d ~/bin ] || mkdir ~/bin
cd ~/bin
ln -s $ARIANE_ROOT_DIR/ariane-2.2.8_04/intel/bin/ariane ariane
```

Now to run a simple test.
