#!/bin/bash

# Basic init style script to handle start/stop/destroy/restart/etc of all containers

# TASKS:
# 	build (from a configured Dockerfile)
#	run (run from a previously created image)
#	start (starts a container that has been run previously)
# 	stop (stops a running container)
#	delete (deletes a previously run container)

# CONTAINERS:
# 	nats (should always start first, as other container contents depend on it being present.)
# 	test (should always start last, as it will run tests on everything else)

# Usage:  ./cfdocker.sh [build|run|start|stop|delete|rebuild] [nats|test|all]

if ![ $# = '2' ]; then
	echo "Usage:  $0 [build|run|start|stop|delete] [base|nats|test|all]"
	exit 1
fi
 
task = $1
container = $2


case $task in
	build)
		case $container in
			base)
				docker build -t cf-d-base cf-d-base/
			;;
			nats)
				docker build -t cfdnats nats/
			;;
			test)
				docker build -t cfdtest test/
			;;
		esac
	;;
	run)
		case $container in
			base)
				echo "The base platform is never run."
			;;
			nats)
				docker run --name=cfdnats -t cfdnats 
			;;
			test)
				docker run --name=cfdnats -t cfdnats 
			;;
		esac
	;;
	start)
		case $container in
			base)
			echo "The base platform is never run."
			;;
			nats)
				docker start $(docker ps -a | grep cfdnats | awk '{print $1}')
			;;
			test)
				docker start $(docker ps -a | grep cfdtest | awk '{print $1}')
			;;
		esac
	;;
	stop)
		case $container in
			base)
				echo "The base platform is never run."
			;;
			nats)
				docker stop $(docker ps -a | grep cfdnats | awk '{print $1}')
			;;
			test)
				docker stop $(docker ps -a | grep cfdtest | awk '{print $1}')
			;;
		esac
	;;
	delete)
		case $container in
			base)
				echo "The base platform is never run."
			;;
			nats)
				docker rm -f $(docker ps -a | grep cfdnats | awk '{print $1}')
			;;
			test)
				docker rm -f $(docker ps -a | grep cfdtest | awk '{print $1}')
			;;
		esac
	;;
esac

