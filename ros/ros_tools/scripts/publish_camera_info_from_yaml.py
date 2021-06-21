#!/usr/bin/env python
import sys
import rospy
from sensor_msgs.msg import CameraInfo
from utility import Utility


class CameraInfoPubliserNode(object):
    def __init__(self, internal_rospy):
        self._rospy = internal_rospy

        self._camera_info_yaml_path = self._rospy.get_param("~camera_info_yaml_path", "")
        self._publish_rate = self._rospy.get_param("~publish_rate", 30)

        self._camera_info_msg = Utility.yaml_to_camera_info(self._camera_info_yaml_path)
        self._camera_info_pub = self._rospy.Publisher("~camera_info", CameraInfo, queue_size=1)
        self._rate = self._rospy.Rate(self._publish_rate)

    def publish(self, time_stamp=None):
        if not time_stamp:
            time_stamp = self._rospy.Time.now()
        while not self._rospy.is_shutdown():
            self._camera_info_msg.header.stamp = time_stamp
            self._camera_info_pub.publish(self._camera_info_msg)
            self._rate.sleep()


def main():
    try:
        rospy.init_node("camera_publisher", anonymous=False)
        camera_publisher = CameraInfoPubliserNode(rospy)
        camera_publisher.publish()
    except rospy.ROSInterruptException:
        rospy.logfatal("error with publishing camera info")
        sys.exit()


if __name__ == "__main__":
    main()
