# -*- mode: snippet -*-
# name: visualize_bbox
# key: visualize_bbox
# --

def visualize_bboxes(image, classes, colors, all_bboxes, all_category_ids):
    import cv2

    for (bbox, label) in zip(all_bboxes, all_category_ids):
        x_min, y_min, x_max, y_max = [int(elem) for elem in bbox]

        cv2.rectangle(image, (x_min, y_min), (x_max, y_max), colors[label], 2)

        label_text = classes[label]
        label_size = cv2.getTextSize(label_text, cv2.FONT_HERSHEY_SIMPLEX, 0.35, 1)

        cv2.rectangle(
            image,
            (x_min, y_min),
            (x_min + label_size[0][0], y_min + int(1.3 * label_size[0][1])),
            colors[label],
            -1,
        )
        cv2.putText(
            image,
            label_text,
            org=(x_min, y_min + label_size[0][1]),
            fontFace=cv2.FONT_HERSHEY_SIMPLEX,
            fontScale=0.35,
            color=(255, 255, 255),
            lineType=cv2.LINE_AA,
        )

    return image
