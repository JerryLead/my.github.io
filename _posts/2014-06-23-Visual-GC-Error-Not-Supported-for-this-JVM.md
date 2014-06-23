---
layout: post
category: Experience
tags : [JVM, GC]
---
{% include JB/setup %}

From [Fahd Shariff's blogspot](http://fahdshariff.blogspot.com/2012/02/visual-gc-error-not-supported-for-this.html)


The Visual GC plugin for Visual VM graphically displays garbage collection, class loader, and HotSpot compiler performance data.

If you install this plugin and, like me, get the error "**Not Supported for this JVM**", when you try to start Visual GC, try the following steps:

1. Start jstatd on the remote host. You need to specify a policy file, otherwise you will get an AccessControlException: access denied exception. Create a policy file e.g.` /tmp/tools.policy` containing:


		grant codebase "file:${java.home}/../lib/tools.jar" {
   			permission java.security.AllPermission;
		};

	Then start jstatd using the command below:

		jstatd -J-Djava.security.policy=/tmp/tools.policy

2. Start Visual VM. Add a Remote Host and then add a "jstatd connection" to it. Your JVM should appear in the list. You can then click on it and look at the "Visual GC" tab for garbage collection information.