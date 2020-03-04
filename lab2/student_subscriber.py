import rospy
from learning_topic.msg import Student

def callback(stu_msg):
    rospy.loginfo(
        rospy.get_caller_id() +
        'Received name {0} , id {1}, grade {2}'.format(stu_msg.name, stu_msg.id, stu_msg.grade))


if __name__ == '__main__':
    rospy.init_node('subscriber')
    rospy.Subscriber('student', Student, callback)
    rospy.spin()
