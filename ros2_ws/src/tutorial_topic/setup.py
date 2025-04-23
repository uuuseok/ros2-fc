from setuptools import find_packages, setup

package_name = 'tutorial_topic'

setup(
    name=package_name,
    version='0.0.0',
    packages=find_packages(exclude=['test']),
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='root',
    maintainer_email='useok2791@gmail.com',
    description='TODO: Package description',
    license='TODO: License declaration',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            'move_publisher = tutorial_topic.move_publisher:main',
            'lidar_subscriber = tutorial_topic.lidar_subscriber:main',
            'continuous_wall_finder = tutorial_topic.continuous_wall_finder:main'
        ],
    },
)
