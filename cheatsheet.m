% Mathlab/Octave cheatsheet

% Basic Operations
5+6
3-2
5*8
1/2
2^6

% Comparissons
1 == 2
1 ~= 2
1 && 0
1 || 0
xor(1,0)

% Change prompt
PS1('>> ')

% Assignments
a = 3
a = 3; % semicolon => not visible
b = 'hi'
c = (3 >=1)

% display
a = pi;
disp(a);
disp(sprintf('2 decimals: %0.2f', a));
format long
a
format short
a

% matrices
A = [1 2; 3 4; 5 6]
v = [1 2 3]
w = [1; 2; 3]
x = 1:0.1:2 % secuence from 1 to 2 by .1
y = 1:6
ones (2,3)
o1 = ones(1,3)
z1 = zeros(1,3)
e1 = eye(4) % identity matrix

% statistics
w = rand(1,3) % uniform
rand(3, 3)
randn(1,3) % gaussian
h = -6 + sqrt(10) * (randn(1,10000));
hist(h)
hist(h, 50) % 50 bins

help eye
help rand
help he
