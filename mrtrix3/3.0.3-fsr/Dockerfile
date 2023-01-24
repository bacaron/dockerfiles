#FROM ubuntu:20.04
FROM neurodebian:stretch

ARG tag

ENV DEBIAN_FRONTEND noninteractive 
RUN apt update && apt-get install -y ants

## install mrtrix3 requirements
#$RUN apt update && apt-get install -y git g++ python python-numpy libeigen3-dev zlib1g-dev libqt4-opengl-dev libgl1-mesa-dev libfftw3-dev libtiff5-dev

RUN apt-get install -y git g++ python python-numpy libeigen3-dev zlib1g-dev qt5-default

## install and compile mrtrix3
RUN git clone https://github.com/MRtrix3/mrtrix3.git -b 3.0.3
RUN cd mrtrix3 && \
    ./configure -nogui \
    && ./build

## manually add to path
ENV PATH=$PATH:/mrtrix3/bin

## install fsl
#https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation/Linux
RUN apt update && apt install -y wget libgl-dev jq

#install fsl, but get rid of src 
RUN wget https://fsl.fmrib.ox.ac.uk/fsldownloads/fslinstaller.py && \
      python fslinstaller.py -d /usr/local/fsl -V 6.0.6 && rm -rf /usr/local/fsl/src

ENV FSLDIR=/usr/local/fsl
ENV PATH=$PATH:$FSLDIR/bin
ENV LD_LIBRARY_PATH=$FSLDIR/lib

RUN . $FSLDIR/etc/fslconf/fsl.sh

ENV FSLOUTPUTTYPE=NIFTI_GZ

#RUN ls /usr/local/fsl/lib
#RUN ldd /usr/local/fsl/bin/eddy_cuda9.1
#RUN du -sh /usr/local/fsl/fslpython

#RUN rm -rf $FSLDIR/fslpython
#RUN $FSLDIR/etc/fslconf/fslpython_install.sh -f $FSLDIR || cat /tmp/*/fslpython_miniconda_installer.log

#make sure fslpython is properly installed
RUN which imcp

#install fslv5 binaries (topup - v6 version runs really slow for unknown reason)
#ADD fsl5 /usr/local/fsl5
#ENV PATH=/usr/local/fsl5:$PATH

#RUN apt update && apt -y install bc #used by fslorient2std


## install freesurfer
RUN wget https://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/7.3.2/freesurfer-linux-ubuntu18_x86_64-7.3.2.tar.gz 
RUN tar xvz -C freesurfer-linux-ubuntu18_x86_64-7.3.2.tar.gz /usr/local/freesurfer

#install MCR
RUN cd /usr/local/freesurfer && \
      wget "https://surfer.nmr.mgh.harvard.edu/fswiki/MatlabRuntime?action=AttachFile&do=get&target=runtime2014bLinux.tar.gz" -o "runtime2014b.tar.gz" && \
      tar xvf runtime2014b.tar.gz && \
      rm runtime2014b.tar.gz
RUN chmod -R +rx /usr/local/freesurfer/MCRv84

ENV FREESURFER_HOME /usr/local/freesurfer
ENV FMRI_ANALYSIS_DIR /usr/local/freesurfer/fsfast
ENV FSFAST_HOME /usr/local/freesurfer/fsfast
ENV FUNCTIONALS_DIR /usr/local/freesurfer/sessions
ENV LOCAL_DIR /usr/local/freesurfer/local
ENV MINC_BIN_DIR /usr/local/freesurfer/mni/bin
ENV MINC_LIB_DIR /usr/local/freesurfer/mni/lib
ENV MNI_DATAPATH /usr/local/freesurfer/mni/data
ENV MNI_DIR /usr/local/freesurfer/mni
ENV MNI_PERL5LIB /usr/local/freesurfer/mni/share/perl5
ENV PERL5LIB /usr/local/freesurfer/mni/share/perl5
ENV PATH /usr/local/freesurfer/bin:/usr/local/freesurfer/fsfast/bin:/usr/local/freesurfer/tktools:/usr/local/freesurfer/mni/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:\$PATH

#install the latest cmake for ants
RUN apt-get -y install libssl-dev
ADD cmake-3.21.3.tar.gz /tmp 
RUN cd /tmp/cmake-3.21.3 && ./configure && make install

#reinstall ants.. apt-get install ants installs ants without a lot of stuff?
#RUN apt-get -y install cmake
#RUN git clone https://github.com/ANTsX/ANTs.git -b v2.3.5 /ants 
#RUN mkdir /ants/build && cd /ants/build && cmake .. && make
#RUN cd /ants && make install

