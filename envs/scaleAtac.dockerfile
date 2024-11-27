FROM nfcore/base:2.1

RUN apt-get clean && apt-get update && \
 DEBIAN_FRONTEND=noninteractive apt-get -y install \
 build-essential \
 curl libz-dev \
 unzip && \
rm -rf /var/lib/apt/lists/*

# Install the conda environment
COPY scaleAtac.conda.yml /environment.yml
RUN conda env create --quiet -f /environment.yml && \
 conda clean -a --yes && \
 conda env export --name scaleAtacNf > scaleAtacNf.yml
# Instead of 'conda activate'
ENV PATH="/opt/conda/envs/scaleAtacNf/bin:${PATH}"

# bc_parser, etc.
COPY download-scale-tools.sh /
RUN /download-scale-tools.sh /tools
ENV PATH="/tools:${PATH}"
