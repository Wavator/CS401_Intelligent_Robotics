import rospy
from learning_topic.srv import *

def client(id):
    rospy.wait_for_service('student_info')
    try:
        student_info = rospy.ServiceProxy('student_info', Student1)
        res = student_info(id)
        return res.name, res.id, res.grade, res.score
    except rospy.ServiceException, e:
        print "Service call failed: %s"

if __name__ == "__main__":
    print "id(1-2):"
    id = input()
    if int(id) >= 1 and int(id) <= 2:
        print "Requesting id %s" % (id)
        print "The res of %s is" % (id) + str(client(id))
    else:
        print "id not in range"
