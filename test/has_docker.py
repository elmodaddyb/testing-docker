#!/usr/bin/python
import unittest, subprocess

class HasDockerTest(unittest.TestCase):

    def test_whichDocker(self):
        p = subprocess.Popen(['which', 'docker'], stdout=subprocess.PIPE)
        res = p.stdout.readlines()
        self.assertTrue(len(res) > 0)

if __name__ == '__main__':
    unittest.main()
