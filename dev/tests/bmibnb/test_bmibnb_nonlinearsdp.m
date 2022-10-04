function tests = test_global_bmibnb_gamscontrol1
tests = functiontests(localfunctions);

function test1(testCase)

A = [1 2;-3 0];B = [1;1];
[K0,P0] = lqr(A,B,eye(2),1);
P = sdpvar(2,2);assign(P,2*P0);K0(K0>1)=1;K0(K0<-1)=-1;
K = sdpvar(1,2);assign(K,-K0);
F = (K<=1)+(K>=-1)+(P>=0)+((A+B*K)'*P+P*(A+B*K) <= -eye(2)-K'*K);
F = F+(diag(P)>=0)+(P(:)>=-151) + (P(:)<=150) + (P>=P0)+(K>=-100) + (K<=100);

obj = trace(P);

sol = optimize(F,obj,sdpsettings('solver','bmibnb','bmibnb.uppersolver','none'))

testCase.assertTrue(sol.problem == 0)
testCase.assertTrue(abs(value(obj)-5.4615) <=  2e-1)

function test2(testCase)

A = [1 2;-3 0];B = [1;1];
[K0,P0] = lqr(A,B,eye(2),1);
P = sdpvar(2,2);assign(P,2*P0);K0(K0>1)=1;K0(K0<-1)=-1;
K = sdpvar(1,2);assign(K,-K0);
F = (K<=1)+(K>=-1)+(P>=0)+((A+B*K)'*P+P*(A+B*K) <= -eye(2)-K'*K);
F = F+(diag(P)>=0)+(P(:)>=-151) + (P(:)<=150) + (P>=P0)+(K>=-100) + (K<=100);

obj = trace(P);

sol = optimize(F,obj,sdpsettings('solver','bmibnb','bmibnb.uppersolver','fmincon'))
testCase.assertTrue(sol.problem == 0)
testCase.assertTrue(abs(value(obj)-5.4615) <=  2e-2)

sol = optimize(F,obj,sdpsettings('solver','bmibnb','bmibnb.uppersolver','fmincon','bmibnb.uppersdprelax',0))
testCase.assertTrue(sol.problem == 0)
testCase.assertTrue(abs(value(obj)-5.4615) <=  2e-2)

sol = optimize(F,obj,sdpsettings('solver','bmibnb','bmibnb.uppersolver','fmincon','bmibnb.uppersdprelax',1))
testCase.assertTrue(sol.problem == 0)
testCase.assertTrue(abs(value(obj)-5.4615) <=  2e-2)
