function tests = test_sdpvar_times
tests = functiontests(localfunctions);

function test1(testCase)
sdpvar x y
testCase.assertTrue(isequal(value(isequal([x*x x*x;x*x x*x]-x.*[x x;x x],zeros(2))),1))
testCase.assertTrue(isequal(value(isequal([x*x x*x;x*x x*x]-[x x;x x].*x,zeros(2))),1))
testCase.assertTrue(isequal(value(isequal([x*y x*y;x*y x*y]-[x x;x x].*y,zeros(2))),1))
testCase.assertTrue(isequal(value(isequal([x*y x*y;x*y x*y]-y.*[x x;x x],zeros(2))),1))

x = sdpvar(2,1,'full','complex');
w = randn(2,1) + sqrt(-1)*randn(2,1);
v = randn(2,1) + sqrt(-1)*randn(2,1);
assign(x,w);
testCase.assertTrue(all(value(w.*v - x.*v) <= 1e-12))