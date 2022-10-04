function tests = test_operator_optimizer9
tests = functiontests(localfunctions);

function test1(testCase)
sdpvar x y u z 

P1 = optimizer([x <= u,y <= z], -x-y,[],{u,z},[x;y]);
sol1 = P1{{2,3}};
testCase.assertTrue(norm(sol1-[2;3]) <= 1e-4);

sol1 = P1{{[2 4],[3 7]}};
testCase.assertTrue(norm(sol1-[2 4;3 7]) <= 1e-4);



