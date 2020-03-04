import rospy
from learning_topic.srv import Student1, Student1Response

students = {'1':
                ('zy', 20, 80),
            '2':
                ('mjh', 100, 100)
            }

def handle_student(req):
    rospy.loginfo("Returning integrated info of id %s"%(req.id))
    return Student1Response(name=students[req.id][0], id=req.id, grade=students[req.id][1], score=students[req.id][2])


if __name__ == '__main__':
    rospy.init_node('student_server')
    s = rospy.Service('student_info', Student1, handle_student)
    print 'Ready'
    rospy.spin()
    