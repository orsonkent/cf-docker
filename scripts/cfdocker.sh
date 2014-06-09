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

if [ !$# = '2' ]; then
	echo "Usage:  $0 [build|run|start|stop|delete|test] [base|nats|test|all]"
	exit 1
fi
 
task=$1
container=$2


case $task in
	build)
		case $container in
			base)
				echo "This may take some time..."
				echo ""
				echo "but it speeds up subsequent builds enormously"
				docker build -t cfd/base cfdbase/
				docker build -t cfd/gobase cfdgobase/
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
				docker run --name=cfdnats -i -t cfd/nats
				./pipework/pipework br1 cfdnats 192.168.78.1/24

			;;
			test)
				docker run --name=cfdtest -i -t cfdtest 
			;;
		esac
	;;
	start)
		case $container in
			base)
			echo "The base platform is never run."
			;;
			nats)
				docker start cfdnats
			;;
			test)
				docker start cfdtest
			;;
		esac
	;;
	stop)
		case $container in
			base)
				echo "The base platform is never run."
			;;
			nats)
				docker stop cfdnats
			;;
			test)
				docker stop cfdtest
			;;
		esac
	;;
	delete)
		case $container in
			base)
				echo "The base platform is never run."
			;;
			nats)
				docker rm -f cfdnats
			;;
			test)
				docker rm -f cfdtest
			;;
		esac
	;;
	test)
		case $container in
			base)
				echo "The base platform is never tested."
			;;
			nats)
				# NATS container tests go here.
			;;
			test)
				echo "testing the test container is meaningless."
			;;
		esac
	;;
esac

