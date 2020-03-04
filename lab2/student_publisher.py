import rospy
from learning_topic.msg import Student


if __name__ == '__main__':
    pub = rospy.Publisher('student', Student, queue_size=10)
    rospy.init_node('student_publisher')
    rate = rospy.Rate(10)
    while not rospy.is_shutdown():
        stu_msg = Student(name='zy', id='1', grade=80, score=100)
        pub.publish(stu_msg)
        rospy.\
            loginfo('Publish name {0} , id {1}, grade {2}'.format(stu_msg.name, stu_msg.id, stu_msg.grade))
        rate.sleep()
