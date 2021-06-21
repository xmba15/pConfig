#!/usr/bin/env python
import message_filters
import enum
import sys
import rospy
from sensor_msgs.msg import CameraInfo, Image
from utility import Utility


DATA_PATH = "/home/btran/publicWorkspace/data/robovision_livox"
camera_info_yaml_lens_map = {
    "inner": {
        "left": DATA_PATH + "/inner_left.yaml",
        "right": DATA_PATH + "/inner_right.yaml",
    },
    "outer": {
        "left": DATA_PATH + "/outer_left.yaml",
        "right": DATA_PATH + "/outer_right.yaml",
    },
}

camera_info_map = {
    "inner": {
        "left": Utility.yaml_to_camera_info(camera_info_yaml_lens_map["inner"]["left"]),
        "right": Utility.yaml_to_camera_info(camera_info_yaml_lens_map["inner"]["right"]),
    },
    "outer": {
        "left": Utility.yaml_to_camera_info(camera_info_yaml_lens_map["outer"]["left"]),
        "right": Utility.yaml_to_camera_info(camera_info_yaml_lens_map["outer"]["right"]),
    },
}

camera_info_publisher_map = {
    "inner": {
        "left": rospy.Publisher("/inner/left/camera_info", CameraInfo, queue_size=1),
        "right": rospy.Publisher("/inner/right/camera_info", CameraInfo, queue_size=1),
    },
    "outer": {
        "left": rospy.Publisher("/outer/left/camera_info", CameraInfo, queue_size=1),
        "right": rospy.Publisher("/outer/right/camera_info", CameraInfo, queue_size=1),
    },
}


camera_info_publisher_map = {
    "inner": {
        "left": rospy.Publisher("/inner/left/camera_info", CameraInfo, queue_size=1),
        "right": rospy.Publisher("/inner/right/camera_info", CameraInfo, queue_size=1),
    },
    "outer": {
        "left": rospy.Publisher("/outer/left/camera_info", CameraInfo, queue_size=1),
        "right": rospy.Publisher("/outer/right/camera_info", CameraInfo, queue_size=1),
    },
}


new_image_publisher_map = {
    "inner": {
        "left": rospy.Publisher("/inner/left/image_raw", Image, queue_size=1),
        "right": rospy.Publisher("/inner/right/image_raw", Image, queue_size=1),
    },
    "outer": {
        "left": rospy.Publisher("/outer/left/image_raw", Image, queue_size=1),
        "right": rospy.Publisher("/outer/right/image_raw", Image, queue_size=1),
    },
}


image_subsciber_map = {"inner": {"left": None, "right": None}, "outer": {"left": None, "right": None}}

for camera_type in ["inner", "outer"]:
    for len_side in ["left", "right"]:
        image_subsciber_map[camera_type][len_side] = message_filters.Subscriber(
            "/{}/{}/image_demosaiced_bgr8".format(camera_type, len_side), Image
            # "/{}/{}/image_raw".format(camera_type, len_side), Image
        )


def callback(inner_left_msg, inner_right_msg, outer_left_msg, outer_right_msg):
    camera_info_map["inner"]["left"].header = inner_left_msg.header
    camera_info_map["inner"]["right"].header = inner_right_msg.header
    camera_info_map["outer"]["left"].header = outer_left_msg.header
    camera_info_map["outer"]["right"].header = outer_right_msg.header

    message_map = {
        "inner": {
            "left": inner_left_msg,
            "right": inner_right_msg,
        },
        "outer": {
            "left": outer_left_msg,
            "right": outer_right_msg,
        }
    }

    for camera_type in ["inner", "outer"]:
        for len_side in ["left", "right"]:
            camera_info_publisher_map[camera_type][len_side].publish(camera_info_map[camera_type][len_side])
            new_image_publisher_map[camera_type][len_side].publish(message_map[camera_type][len_side])


class SynchronizerType(enum.IntEnum):
    TIME_SYNCHRONIZER = 0
    APPROX_TIME_SYNCHRONIZER = 1
    MAX = APPROX_TIME_SYNCHRONIZER


def _to_synchronizer(synchronizer_type: SynchronizerType, fs, queue_size=10, slop=0.1):
    if synchronizer_type > SynchronizerType.MAX:
        rospy.logfatal("Not supported synchronizer type")
        sys.exit()

    if synchronizer_type == 0:
        return message_filters.TimeSynchronizer(fs=fs, queue_size=queue_size)
    if synchronizer_type == 1:
        return message_filters.ApproximateTimeSynchronizer(fs=fs, queue_size=queue_size, slop=slop)


try:
    rospy.init_node("process_robovision3", anonymous=False)
    _synchronizer = _to_synchronizer(
        synchronizer_type=1,
        fs=[
            image_subsciber_map["inner"]["left"],
            image_subsciber_map["inner"]["right"],
            image_subsciber_map["outer"]["left"],
            image_subsciber_map["outer"]["right"],
        ],
    )
    _synchronizer.registerCallback(callback)
    rospy.spin()
except rospy.ROSInterruptException:
    rospy.logfatal("error with stereo_matcher setup")
    sys.exit()
