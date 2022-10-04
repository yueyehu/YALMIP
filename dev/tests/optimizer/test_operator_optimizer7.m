function tests = test_operator_optimizer7
tests = functiontests(localfunctions);

function test1(testCase)

X = sdpvar(2,4,2);
Y = sdpvar(2,4,2);
P = optimizer([],sum(sum(abs(X(:)-Y(:)))),[],Y,X);
Z = reshape(magic(4),2,4,2);
U = P{Z};
testCase.assertTrue(norm(Z(:)-U(:))<1e-7);

function test2(testCase)
% Test nD parameter in cells
X = sdpvar(2,4,2);
Y1 = sdpvar(2,4,2);
Y2 = sdpvar(2,4,2);
P = optimizer([],sum(sum(abs(X(:)-Y1(:))))+sum(sum(abs(X(:)-Y2(:)))),[],{Y1,Y2},X);
Z = reshape(magic(4),2,4,2);
U = P{{Z,Z}};
testCase.assertTrue(norm(Z(:)-U(:))<1e-8);

function test3(testCase)
% Test nD outputs in cells
X = sdpvar(2,4,2);
Y1 = sdpvar(2,4,2);
P = optimizer([],sum(sum(abs(X(:)-Y1(:)))),[],Y1,{X,2*X});
Z = reshape(magic(4),2,4,2);
U = P{Z};
testCase.assertTrue(norm(Z(:)-U{1}(:))<1e-7);
testCase.assertTrue(norm(2*Z(:)-U{2}(:))<1e-7);

