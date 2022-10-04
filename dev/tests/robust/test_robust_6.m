function tests = test_robust_5
tests = functiontests(localfunctions);

function test1(testCase)

% Exact automatic
yalmip('clear')
n = 1;
r = 1;
m = 1;

x = sdpvar(n,1);
w = sdpvar(m,1);
sdpvar t

model = [uncertain(w), norm(w,2) <= 1];
objective = norm(2*x + 3 + 4*w,1);

[F1,h] = robustify([model,objective <= t],t,sdpsettings('robust.auxreduce','none','verbose',0));
optimize(F1,h,sdpsettings('verbose',0));
o1 = value(h);
[F1,h] = robustify([model,objective <= t],t,sdpsettings('robust.auxreduce','affine','verbose',0));
optimize(F1,h,sdpsettings('verbose',0));
o2 = value(h);
testCase.assertTrue(abs(o1-o2) <= 1e-5)