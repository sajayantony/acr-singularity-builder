# ACR Singularity Image builder 

The singularity builder image can be created in your registry using the Docker file in [builder](/builder)
> Currently we are using a branch that is capable of doing an oras push from https://github.com/bauerm97/singularity.git

```bash
$ az acr build -t singularity-builder:v3 ./builder/
```

Once you have base builder image you can use that to driving building definition files which can produce ORAS images in ACR. 

```bash
$ az acr run -f acb.yaml \
    --set DefinitionFile=hello-debian.def \
    --set SIFOutput=test.sif \
    --set Image="builder-test-temp:v1"  \
    .
```
