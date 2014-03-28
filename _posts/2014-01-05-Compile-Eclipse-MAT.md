---
layout: post
category : Experience
tags : [MAT, Compile]
---
{% include JB/setup %}
## 1. 安装Eclipse
下载Eclipse Indigo，在Help→Install New Software的Work with里选择[Indigo](http://download.eclipse.org/releases/indigo)
安装BIRT Framework和Subversive
 ![](/assets/images/posts/2014-01-05/bird-framework.png)
再安装maven（m2e - Maven Integration for Eclipse）重启Eclipse后，会提示安装Subversive SVN connector，如果是MacOS系统选择SVNKit 1.2.3。如果没有提示安装，去Preferences→Team→SVN，这时会提示安装。全部安装好Installed Software里面大概有SWTBot可以不装。
如果要安装SWTBot
To build the org.eclipse.mat.ui.rcp.tests project, you will need the SWTBot plugins installed. Normally, just add an update site [http://download.eclipse.org/technology/swtbot/releases/latest/](http://download.eclipse.org/technology/swtbot/releases/latest/)and install all the plugins.

![](/assets/images/posts/2014-01-05/plugin.png) ## 2. Checkout MAT代码
打开Eclipse indigo- Open the 'SVN Repository Exploring' perspective- Add the MAT Subversion repository at: [https://dev.eclipse.org/svnroot/tools/](https://dev.eclipse.org/svnroot/tools/)- Select 'trunk' and open the context menu- Select 'Find/Check Out As' from the context menu- Select 'Find projects in the children of the selected resource'- Select 'recursively'- Press 'Finish'- After some time, you'll get a window with the message: 'Following list contains projects that were automatically found on the repository. You can select project set you wish to be checked out into the workspace.'- Keep all projects selected- Select 'Check out as a projects into workspace'- Select 'Respect projects hierarchy'- Press 'Finish'
## 3. 预编译prepare_build进入 <mat_src>/prepare_build/ 目录，在命令行执行
	$ mvn clean install
或者在Eclipse中在prepare_build目录中选择pom.xml，然后右键run as “Maven clean”，然后run as “Maven install”。
完成后可以在prepare_build目录下看到target目录，里面有IBM dtfj的classes。
## 4. 编译进入 <mat_src>/parent 目录，修改pom.xml，去掉不想要的平台，只留下想要的平台，这里是MacOSX	<groupId>org.eclipse.tycho</groupId>		<artifactId>target-platform-configuration</artifactId>			<version>${tycho-version}</version>			<configuration>			<environments>				<environment>					<os>macosx</os>					<ws>cocoa</ws>					<arch>x86_64</arch>				</environment>			</environments>		然后在Eclipse中选择该pom.xml，右键run as “Maven clean”，然后run as “Maven install”。
完成后可以在看到
- <mat_src>/org.eclipse.mat.updatesite/target/site/ - it contains a p2 repository with MAT features- <mat_src>/org.eclipse.mat.product/target/products/ - it contains all standalone RCP applications
## 5. 修改代码此时可以看到Eclipse里面有很多错误，先修改代码。
删掉org.eclipse.mat.ibmdumps下面的src2再设置API baseline
In order to guarantee that no API breaking changes are introduced we recomment using the PDE API Tooling and defining the latest released version of MAT as an API Baseline. Here is a short description how this could be done:- Download the latest released version in order to use it as an API Baseline	- Go to the MAT download page	- Download the "Archived Update Site" zip file for the latest release	- Unzip the file somewhere locally- Configure the API Baseline in the IDE	- In the IDE open Window -> Preferences -> Plug-in Development -> API Baselines	- Press Add Baseline	- Browse and select as Location the directory in which the zip was extracted	- Enter a name for the baseline, click Finish and confirm the rest of the dialogs
Once the API Tooling is properly setup, one will see errors reported if API changes are introduced.
如果在org.eclipse.mat.dtfj中还有错，那么Install New Software：> IBM Diagnostic Tool Framework for Java (See IBM Diagnostic Tool Framework for Java Version 1.5 to find the archived Update Site.) This is needed to compile and run with the DTFJ adapter which is part of Memory Analyzer and allows Memory Analyzer to read dumps from IBM virtual machines for Java.
接下来修改org.eclipse.mat.ui.rcp里面的mat.product：
选择Dependencies，删除org.eclipse.mat.dependecies.feature(1.3.1.qualifier)（这个根本不存在），然后Add org.eclipse.mat.dependecies.feature(1.2.1.qualifier)。
然后右键mat.product，run as Eclipse Application，可以console会曝出很多错误。
重新右键mat.product，选择Run Configuration，选择mat.product。再选择Plug-ins tab，点击Add Required Plug-ins，然后Apply，然后Validate Plug-ins，可以看到提示“No problem were detected”。
然后重新然后右键mat.product，run as Eclipse Application，运行成功，可以使用MAT的任何功能。