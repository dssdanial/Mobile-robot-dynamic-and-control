# Mobile-robot-dynamic-and-control

## Mobile Robots Dynamic
Wheeled Mobile Robots (WMRs) are the most widely used among the class of Mobile Robots. This is due to their fast manoeuvring, simple control and energy saving characteristics. These devices are becoming increasingly important in industry as a means of transport, inspection, and operation because of their efficiency and flexibility. In addition, mobile robots are useful for intervention in hostile environments performing tasks such as handling solid radioactive waste, decontaminating nuclear reactors, handling filters, patrolling buildings, minesweeping, etc. Furthermore, mobile robots can serve as a test platform for a variety of experiments in sensing the environment and making intelligent choices in response to it.
The mobile robot is designed to move by two active wheels on the floor. The kinematic model of a wheeled mobile robot is configured as follows.


![image](https://user-images.githubusercontent.com/32397445/153769271-dfc1cdc6-684f-4797-a2d1-a602bdae06d1.png)

 r is the instantaneous curvature radius of the robot trajectory, d is distance between two wheels, R is wheel radius, and α is angle between the robot’s orientation and x-axis path. This robot configuration uses independent linear velocities, vR for the right wheel and vL for the left wheel to move to a desired point (x; y) and a desired orientation α. The linear velocity of a wheel is directly proportional to its angular velocity. The relation between the linear velocity v(t) and angular velocity ω(t) of the robot depends on the linear velocities of the left and right wheel. The angular velocity of the robot is calculated by the following equations.
 ![image](https://user-images.githubusercontent.com/32397445/153769291-fca24e42-4a1c-4aff-9ba2-2c3aa4b6ab91.png)

Where the angular velocity can be derived as:

![image](https://user-images.githubusercontent.com/32397445/153769307-287593f7-4e42-485f-a338-06ca2584eec9.png)

Then, the linear velocity v is obtained as the following equation.

![image](https://user-images.githubusercontent.com/32397445/153769318-01ee57d3-4cbe-4209-98b0-2c6e17ad3775.png)

In addition, the robots position is calculated based on the linear velocity v and the angular velocity as bellows.

![image](https://user-images.githubusercontent.com/32397445/153769329-5662a189-046c-44c4-8dd3-1af4cbec2327.png)

The model of the mobile robot can be written as

![image](https://user-images.githubusercontent.com/32397445/153769335-4fed8258-0ed4-4b05-bfab-903809675f5e.png)

By obtaining the robot’s model, we can imply various type of controller. Since we do not have high dynamic or rapid motions, by using a PID controller we would have good enough tracking of robot. 


## Adaptive PID Controller design

This section discusses asymptotically stable tracking control. The controller is designed using Lyapunov stability theory.

![image](https://user-images.githubusercontent.com/32397445/153769372-b1cbabc7-f6bc-405b-a993-b5f0855fd4dc.png)


The above figure shows the block diagram of a tracking control system for the non-holonomic mobile robot where the reference posture pr=[xr,yr,θr], and reference velocities, qr=[υr,ωr], are inputs from the discrete path information. This control structure is composed of an error block, a control rule, and a velocity limiter. 
Our velocity Limiter caused the PID controller as an adaptive controller, which its coefficients can be changed based on the position and attitude errors.
First, the error posture, pe=[xe,ye,θe], is a transformation of the difference between the reference posture, [xr, yr, θr], and the current posture, [xc,yc,θc].

![image](https://user-images.githubusercontent.com/32397445/153769381-af94c888-c20f-4eb4-813b-bd0060aa3cf6.png)

Then the tracking control input is calculated by feed-forward and feedback actions as

![image](https://user-images.githubusercontent.com/32397445/153769391-1428823d-4234-4efb-a710-fa78b523dcc4.png)

The control rule part is developed using a Lyapunov function. Moreover, the gains Kx, Ky, and Kθ of the state feedback can be found by trial and error, and velocity limiter is used to limit the translational and rotational velocities which are harmful for hardware of the WMR. In addition, to make the robot more robust in order to overcome different paths, we used adaptive algorithm which varies based on robot’s velocity, position and attitude errors. The initial parameters are set based on experience. Furthermore, to prove the stability of the control system, the following Lyapunov function is used.  

![image](https://user-images.githubusercontent.com/32397445/153769394-f46fbeaf-cb97-4784-b0da-300c62141a5c.png)


## Results
To show the results of the first algorithm, as discussed before, a circle like path is assumed for robot to follow it. As we can see from figure (1), a XY-trajectory is designed.

![image](https://user-images.githubusercontent.com/32397445/153769550-4a3c274a-8aeb-4640-90b8-5a0d0ef79419.png)

If our robot path would be a circle shape and the maximum linear velocity set to 0.5 m/s, the proposed algorithm will show this excellent trajectory as illustrated in the following figure.

![image](https://user-images.githubusercontent.com/32397445/153769577-c8c1e5ac-de1c-4ff7-8b2e-ebe9318abd70.png)

Furthermore, we can consider the yaw angle performance of the robot as:
![image](https://user-images.githubusercontent.com/32397445/153769655-c6e3a197-c5fc-4388-8dd2-53e963cf0670.png)

As illustrated, it can be realized that the performance of the robot algorithm is as well as position tracking. 
Generally, by tuning the PID controller coefficients, we can change the performance of the system, although we can use other algorithms to tune them automatically like using Fuzzy PID controller.
According to our first simulations, it is proved that this algorithm is good enough to get operator commands and apply them to robot successfully. Since we wanted to assess the algorithm with different paths, we used MATLAB toolbox, which has more details and can help us to perform our goals better.


