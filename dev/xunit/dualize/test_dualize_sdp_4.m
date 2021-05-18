function tests = test_sdpvar_dualize_sdp_4
tests = functiontests(localfunctions);

function test1(dummy)

A = randn(3,3);A = -A*A';
P = sdpvar(3,3);
t = sdpvar(1,1);
y = sdpvar(1,1);
F = (A'*P+P*A <= -eye(3));
F = F + (P >= 0) + (P(3,3)>=0) + (t-y >= 7) + (P(2,2)>=4)+(P(1,1:2)>=t) + (t>=0);
obj = trace(P);

sol1  = optimize(F,obj);
obj1 = value(obj);
p1   = check(F);

sol2 = optimize(F,obj,sdpsettings('dualize',1));
obj2 = value(obj);
p2   = check(F);

assert(sol1.problem == 0);
assert(sol2.problem == 0);
assert(abs(obj1 - obj2) <= 1e-4);
assert(abs(min(p1))<= 1e-4)
assert(abs(min(p2))<= 1e-4)