#!/usr/bin/env python
import os
import yaml
from sensor_msgs.msg import CameraInfo


class Utility:
    @staticmethod
    def yaml_to_camera_info(yaml_file_path):
        if not os.path.isfile(yaml_file_path):
            raise Exception("invalid yaml file path: {}".format(yaml_file_path))

        with open(yaml_file_path, "r") as file_handle:
            calib_data = yaml.safe_load(file_handle)
            camera_info = CameraInfo()
            camera_info.width = calib_data["image_width"]
            camera_info.height = calib_data["image_height"]
            camera_info.K = calib_data["camera_matrix"]["data"]
            camera_info.D = calib_data["distortion_coefficients"]["data"]
            camera_info.R = calib_data["rectification_matrix"]["data"]
            camera_info.P = calib_data["projection_matrix"]["data"]

            assert ("distortion_model" in calib_data) or ("camera_model" in calib_data)
            model_key = "distortion_model" if ("distortion_model" in calib_data) else "camera_model"
            camera_info.distortion_model = calib_data[model_key]

            return camera_info
