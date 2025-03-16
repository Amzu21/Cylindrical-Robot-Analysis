% Create rigidBodyTree
robot = rigidBodyTree('DataFormat', 'row', 'MaxNumBodies', 3);

% Link_1 (Rotating Link)
link1 = rigidBody('Body1_1_RIGID'); % Use the actual name from Simscape
joint1 = rigidBodyJoint('RotatingJoint', 'revolute');
setFixedTransform(joint1, trvec2tform([0, 0, 0])); % Define the base position
link1.Joint = joint1;
addBody(robot, link1, 'base');

% Link_2 (Sliding Link)
link2 = rigidBody('Body2_2_RIGID'); % Use the actual name from Simscape
joint2 = rigidBodyJoint('PrismaticJoint', 'prismatic');
setFixedTransform(joint2, trvec2tform([0, 0, 0.5])); % Adjust position
joint2.JointAxis = [0, 0, 1]; % Motion along Z-axis
link2.Joint = joint2;
addBody(robot, link2, 'Body1_1_RIGID');

% Link_3 (Moving Arm)
link3 = rigidBody('Body4_1_RIGID'); % Use the actual name from Simscape
joint3 = rigidBodyJoint('LinearJoint', 'prismatic');
setFixedTransform(joint3, trvec2tform([0, 0, 0])); % Adjust position
joint3.JointAxis = [1, 0, 0]; % Motion along X-axis
link3.Joint = joint3;
addBody(robot, link3, 'Body2_2_RIGID');

% Visualize the robot
show(robot);
view(3); % Set 3D view

% Add trajectories
% Straight Line Trajectory
q0 = [0, 0, 0]; % Start configuration
qf = [pi/2, 0.3, 1.0]; % Larger end configuration
 % End configuration
t = linspace(0, 5, 50); % Time vector
qTraj = interp1([0, 5], [q0; qf], t);

% Visualize straight line motion
disp('Visualizing straight line trajectory...');
for i = 1:length(t)
    show(robot, qTraj(i, :));
    pause(0.02);
end

% Circular Path Trajectory
theta = linspace(0, 2*pi, 100);
qCirc = [theta; 0.2*ones(1, 100); 0.5*ones(1, 100)]';

disp('Visualizing circular trajectory...');
for i = 1:length(theta)
    show(robot, qCirc(i, :));
    pause(0.02);
end