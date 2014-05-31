=========
#Cloud Foundry in Docker

Summary:  CF components in Docker containers.

Goal: Deployment of a full CF installation on a single machine, in multiple containers, with required inter-component/container communication allowed.

Will be made up of:
- Dockerfiles (build instructions for Docker containers)
- Submodules (the relevant cloud foundry components)
- Scripts (to automate the process as much as possible)
- Templates/Config files

Additional goals: 
- Be able to ssh into the containers (as this is useful for diagnosis)
- Expose the relevant component's logs to the docker logs command


##What's the point?

I've worked extensively with Cloud Foundry, both V1 (Ruby based, no BOSH) and V2 (Migrating to Go, BOSH required), and of the two, I think CF1 had some significant advantages, including:
- Lack of BOSH
- Ability to run on a single machine
- Not tied (without extensive coding) to infrastructure.
- Expensive to run for an individual (10+VMs on Amazon is outside my personal affordabilty for experimenting with a technology that interests me)
- Using monit as the process management tool instead of something vaguely standard.

Basically, CF1 rocked my world, and I fell in love with the tech.  CF2 (particularly BOSH, and the whole "Only bother if you have a corporate budget" idea) bugged the crap out of me, and pretty much the WHOLE time I was working on it, I wished that its creators hadn't 'broken'* it.

My aim with this project is to create a way to run an instance of cloud foundry V2 that can run on a single machine/vm of moderate spec (my initial docker host vm is a VMWare fusion 5 hosted deployment of ubuntu server 14.04, configured to have 2 processor cores and 4 gig of ram - chosen rather arbitrarily as seeming roughly appropriate), deployed without needing infrastructure other than a host machine/vm (ie, no need for a BOSH director, etc).

[* for my purposes]