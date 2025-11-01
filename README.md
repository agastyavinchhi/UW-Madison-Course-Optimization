# Optimizing the Schedule of a Triple Major Student at UW-Madison #

#### Agastya Vinchhi, Haoyang Ding, Lauren Haefer

## Introduction

- Pursuing a triple major in Data Science, Economics, and Computer Science at the University of Wisconsin-Madison is an ambitious goal that offers a powerful combination of skills. These fields complement each other well with data analysis, economic modeling, and programming all playing a big role in the modern world. However, figuring out how to fit the core requirements for three majors into one manageable schedule is no easy task.
- Furthermore, our project aims to tackle this challenge by creating an optimization model that helps students map out the most efficient class schedule, utilizing overlapping courses between the three majors, to save time and reduce stress.
- The goal is to create a practical tool that students and advisors can use to make smarter decisions about course planning. Instead of spending hours piecing together schedules, students can use this model to get a personalized plan that balances efficiency and flexibility. Plus, the approach could work for other combinations of majors in the future.


## Running & Viewing the Optimization Model

- **`main.ipynb`** is the project notebook. It contains:
  - A readable walkthrough of the formulation (decision variables, constraints, and objectives),
  - Design rationales and modeling trade-offs,
  - Solvers runs for multiple variants.

We provide four model configurations:

1) **Base model** - Optimal schedule to satisfy minimum requirements across all three majors.
2) **Case Study A** - Weighted Objective for CS Courses.
3) **Case Study B** – Focused Curriculum.
4) **Case Study C** – Late Major Addition.

- Open **`main.ipynb`**, to run the setup and data cells, then execute the section for the desired scenarios. Parameters (course lists, weights, timing flags) are clearly defined and explained in the notebook.

**Data files**
- **`uwcourses_updated.csv`** – Course-level data used by the model (IDs/titles, credits, terms offered, tags/requirements as available).
- **`CS524-optimization-courses-credit-courses.csv`** – Supporting mappings for requirement groups and credit accounting.



## Model Overview

Base Model: 
Bellow, we have formed a mathematical optimization model to achieve our desired output. This is a Mixed Interger Programing model since we define binary vairables for the courses we take for all x_i.


$$
\begin{aligned}
\underset{x, e}{\text{minimize}}\qquad & c^\top x \\
\text{subject to:} \qquad & A x + e \geq b \\
& x \in \{0, 1\}, \quad e \geq 0, \quad b \geq 0
\end{aligned}
$$

1) Decision Variable: 
    - Let x ∈ {0,1}, which is a Binary Variable whetjher each course is taken or not; here x_i indicate whether a course is taken (x_i = 1) or not (x_i = 0). 

2) Objective Function: 
    - Let c' be a vector of ones and let x_i be the decision variable we aim to minimize. It is clear that here, we minimize the total number of courses taken while satisfying core, elective, and credit requirements.

3) Constraints: 
    - Let A be a matrix where each row represents a constraint equation's coefficients for courses. Consequently, we have the vector b representing the total number of required courses for each constraints. Hence, this will help us formulate each constraint, where out of all the different options of courses from matrix A, we must take exactly b number of courses to satisfy the major requiremnt. Notice the greater than equal to sign, ensuring that we are always taking atleast a total of b number of courses.

    - Finally, we define e >= 0, which is an auxilary slack variable for elective constraints. Some majors have electives, where you can take a course from the elective requiremnt or from a core requirement. In such cases, we utilize an external variable e to either remove or add the total number of courses required from the requiremnt constraint (to understand this more, view the comments in the base model). The introduction of this variable will disallow the model to "double dip" elective courses, furthermore, producing incorrect outputs.
