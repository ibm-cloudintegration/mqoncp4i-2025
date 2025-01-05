# mqoncp4i

## Working directory for MQ on CP4I PoT

Check the **setup.properties** to make sure you have the correct license and version for MQ 

```
Usage:
./MQ_setup.sh -i <student number> -n <student namespace>
```

This example is using student2 with namespace of student2
```
./MQ_setup.sh -i 2 -n student2
```

You will be asked if the Namespace and instance number are correct.  enter y/n

This will then create all build scripts for the MQ labs [streamQ, nativeHA, and unicluster].

The following is the output from the command above:
```
Are these correct?  The instance number is zero filled for numbers 1-9. (Y/N)y
...
[INFO] Build the deployment yamls and test scripts for streamQ labs.  
[INFO] StreamQ build yaml script is complete.
....
[INFO] Build the deployment yamls and test scripts for navtiveHA labs.  
[INFO] nativeHA build yaml script is complete.
....
[INFO] Build the deployment yamls and test scripts for unicluster labs.  
[INFO] unicluster build yaml scripts is complete.
```