#!/usr/bin/python
from subprocess import Popen, PIPE
import os, unittest

class BuildDockerTest(unittest.TestCase):

    def test_buildDocker(self):
        imageExists = False
        print 'Build docker'
        dirPath = os.path.dirname(os.path.realpath(__file__))
        dockerFile = dirPath + '/' + '../Dockerfile'
        print dockerFile
        process = Popen(['/usr/local/bin/docker', 'build', '--file', dockerFile, '--tag', 'elmodaddyb/builddocker.test', '../'], stdout=PIPE, stderr=PIPE)
        stdout, stderr = process.communicate()
        
        for ln in stdout.split('\n'):
            print ln
            if 'Successfully built' in ln:
                self.imageId = ln.split()[2]
                print 'Image ID built:' + self.imageId
                imageExists = True
        
        if process.returncode != 0:
            print stderr
            
        self.assertTrue(process.returncode == 0)
        self.assertTrue(imageExists)
        
    def tearDown(self):
        process = Popen(['/usr/local/bin/docker', 'rmi', self.imageId], stdout=PIPE, stderr=PIPE)
        stdout, stderr = process.communicate()
        
        for ln in stdout.split('\n'):
            print ln
            
        if process.returncode != 0:
            print stderr
            
if __name__ == '__main__':
    unittest.main()
