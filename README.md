Calculator
==========

In order to implement the calculator application, I believe we will need to have two First-In-First-Out Stacks. One of the stacks will be responsible for the numerics while the other stack will be used for the operations.

With every number clicked, we want to append to the display string.

When an operation button is clicked, we push it into the stack.

When a second operation button is clicked, we will examine its priority compared with the previous operation.
1.If the second operation is of higher priority, we calculate the expression
2.If the second operation is of lower priority, we calculate the first expression and store the answer and wait for the next operation

Finally, when we finish with all the inputs, we simply pop two numbers from the numbers stack and pop the operations and compute

Translated the algorithm written in Java into Objective - C
Source = http://randcode.wordpress.com/2012/08/30/postfix-calculator-written-in-java/

All basic functions of implemented
Addition features include: parentheses and exponentials
Note: correct syntax of negative numbers requires parentheses
For example: 
Correct: 5 * (-1)s
Incorrect: 5 * -1