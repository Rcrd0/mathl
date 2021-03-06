function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
a1 = [ones(m,1), X];
z2 = a1 * Theta1';
a2 = [ones(m,1), sigmoid(z2)];
z3 = a2 * Theta2';
a3 = sigmoid(z3);

J = 0;
for k = 1:num_labels
   yk = y == k;
   J -=  yk'    * log(  a3(:,k));
   J -= (1-yk)' * log(1-a3(:,k));
endfor
   
J *= (1/m);
J += (lambda/(2*m)) * (sum(sum(Theta1(:,2:end) .^2)) + sum(sum(Theta2(:,2:end) .^2)));

% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%

comp = (1:num_labels)';
%Delta2 = Theta2;
%Delta2(:,:)=0;
%Delta1 = Theta1;
%Delta1(:,:)=0;
for t = 1:m
    % 1 Forward pass of training sample t
    a1 = ([1, X(t,:)])';
    z2 = Theta1 * a1;
    a2 = [1; sigmoid(z2)];
    z3 = Theta2 * a2;
    a3 = sigmoid(z3);
    
    % 2 delta 3 = a3 - yk
    d3 = a3 - (y(t) == comp);
    
    % 3 delta2 = Theta2' * d3 .* g'(z2)
    d2 = (Theta2' * d3) (2:end,1);
    d2 = d2 .* sigmoidGradient(z2);    
    
    % 4 accumulate the gradint
    Theta2_grad += (a2 * d3')';
    Theta1_grad += (a1 * d2')';
endfor

% 5 Unregularized gradinets = Dij = Delta_ij / m
%Theta1_grad *= 1/m;
%Theta2_grad *= 1/m;
%grad = [Theta1_grad(:); Theta2_grad(:)];

% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

Theta1b = Theta1;
Theta2b = Theta2;
Theta1b(:,1)=0;
Theta2b(:,1)=0;

Theta1_grad = (1/m)*Theta1_grad + (lambda/m) * Theta1b;
Theta2_grad = (1/m)*Theta2_grad + (lambda/m) * Theta2b;
grad = [Theta1_grad(:); Theta2_grad(:)];

% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
