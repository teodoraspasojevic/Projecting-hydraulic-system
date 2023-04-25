# Projecting-hydraulic-system
Creating simulation for the given mechanical system and finding the parameters for hydraulic system that will control it.

**Phase 1 - Creating simulation of the mechanical system**

Firstly, we need to analyze the scheme of the mechanical system we are controlling with hydraulic system we are projecting. We find actuator and load model equations from which we find equations of system in state space in a matrix form. When we find the matrices that describe the mechanical system in state space, we can find transfer function of our system. Using Simulink and the calculated transfer function we can simulate our system. Now that we have the simulation of our system, we can analyze it in a much better way and can control it.

**Phase 2 - System control**

In order to find the parameters of our hydraulic system we are projecting for controlling the mechanical system, we need to control the system in simulation, and find the values if relevant signals for parameter calculations. To achieve this, we created Control-generating subsystem, PID controller subsystem and added block that introduces physical limitations of the system. By adjusting the parameters of the PID controller we menage to control the system in a way it follows the referent values of the wanted output.

**Phase 3 - Calculating parameters of hydraulic system**

After we have achieved to control system in our simulation, where the actual output follows the wanted output in a correct way, we can measure the values of relevant signals, and use them to calculate the parameters of the hydraulic system that controls the mechanical system.

Please refer to Project report.pdf for much more detailed explanation of the project implementation.
