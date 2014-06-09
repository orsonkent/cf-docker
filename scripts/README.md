The home for the scripts that support this project

1. cfdocker.sh

 TASKS:
 	build (from a configured Dockerfile)
	run (run from a previously created image)
	start (starts a container that has been run previously)
 	stop (stops a running container)
	delete (deletes a previously run container)

 CONTAINERS:
 	nats (should always start first, as other container contents depend on it being present.)
 	test (should always start last, as it will run tests on everything else)

 Usage:  ./cfdocker.sh [build|run|start|stop|delete|rebuild] [nats|test|all]