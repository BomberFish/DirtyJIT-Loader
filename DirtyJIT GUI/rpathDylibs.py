#!/usr/bin/python

import os

	
def oToolIdPatch(path, name):
	command = 'install_name_tool -id @rpath/{name} {path}'.format(name = name, path = path)
	os.system(command)
	
def oToolPatchDependencies(path, libs):
	command = "otool -L " + path
	response = os.popen(command).read()
	dependenciesLines = response.splitlines()[1:]
	
	for line in dependenciesLines:
		depPath = (line.split(" ")[0].replace('\t',''))
		depName = os.path.split(depPath)[1]
		if depName in libs:
		
			command = "install_name_tool -change {depPath} @rpath/{name} {out}".format(
				depPath = depPath,
				name = depName,
				out = path
			)
			os.system(command)
	#print (dependenciesLines)

directory = "./libimobiledevice"
libFiles = list(filter(lambda p: p.endswith(".dylib"), os.listdir(directory)))
print (libFiles)
for file in libFiles:
	path = os.path.join(directory, file)
	
	# Change lib id to relative path
	oToolIdPatch(path, file)
	
	
	# Change dependencies
	oToolPatchDependencies(path, libFiles)
	
	
