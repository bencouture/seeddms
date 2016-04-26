# seeddms
Container php5 + apache to run SeedDMS 

`cd this_folder`
`docker build -t seeddms .`
`docker run -it --link mysql:mysql --rm -p 8000:80 seeddms /bin/bash`  # yes this is wrong!
`root@container# service apache2 start`  
