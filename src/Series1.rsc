module Series1

import IO;
/*
 * Documentation: https://www.rascal-mpl.org/docs/GettingStarted/
 */

/*
 * Hello world
 *
 * - Import IO, write a function that prints out Hello World!
 * - open the console (click "Import in new Rascal Terminal")
 * - import this module and invoke helloWorld.
 */
 
void helloWorld() {
println("Hello World!");
} 


/*
 * FizzBuzz (https://en.wikipedia.org/wiki/Fizz_buzz)
 * - implement imperatively
 * - implement as list-returning function
 */
 
void fizzBuzz() {
    for (int i <- [1..100]) {
        if (i % 15 == 0) {
            println("FizzBuzz");
        } else if (i % 3 == 0) {
            println("Fizz");
        } else if (i % 5 == 0) {
            println("Buzz");
        } else {
            println(i);
        }
    }
}

list[str] fizzBuzz() {
return [i % 15 == 0 ? "FizzBuzz" : (i % 3 == 0 ? "Fizz" : (i % 5 == 0 ? "Buzz" : str(i))) | i <- [1..100]];
}

/*
 * Factorial
 * - first using ordinary recursion
 * - then using pattern-based dispatch 
 *  (complete the definition with a default case)
 */
 


int fact(0) = 1;
int fact(1) = 1;
default int fact(int n) {
  return fact(n - 1) * n;
}

int factorial(int n) {
  return n == 0 ? 1 : n * factorial(n - 1);
}




/*
 * Comprehensions
 * - use println to see the result
 */
 
void comprehensions() {

  // construct a list of squares of integer from 0 to 9 (use range [0..10])
  list[int] squares = [i * i | i <- [0..10]];
  // same, but construct a set
  set[int] squaresSet = {i * i | i <- [0..10]};
  // same, but construct a map
  map[int,int] squaresMap = [<i, i * i> | i <- [0..10]];
  // construct a list of factorials from 0 to 9
  list[int] factorials = [factorial(i) | i <- [0..10]];
  // same, but now only for even numbers
  list[int] evenFactorials = [factorial(i) | i <- [0..10], i % 2 == 0];
}
 

/*
 * Pattern matching
 * - fill in the blanks with pattern match expressions (using :=)
 */
 

void patternMatching() {
  str hello = "Hello World!";
  
  
 
  // print all splits of list
  list[int] aList = [1,2,3,4,5];
  for ([head, *tail] := aList) {
    println("<head> | <tail>");
  
  }
  
  // print all partitions of a set
  set[int] aSet = {1,2,3,4,5};
  for ({head, *tail} := aSet) {
    println("<head> | <tail>");
  } 

  

}  
 
 
 
/*
 * Trees
 * - complete the data type ColoredTree with
 *   constructors for binary red and black branches
 * - use the exampleTree() to test in the console
 */
 
data ColoredTree
  = leaf(int n);
  | red(ColoredTree left, ColoredTree right);
  | black(ColoredTree left, ColoredTree right);
  

ColoredTree exampleTree()
  =  red(black(leaf(1), red(leaf(2), leaf(3))),
              black(leaf(4), leaf(5)));  
  
  
// write a recursive function summing the leaves
// (use switch or pattern-based dispatch)
int sumLeaves(leaf(int n)) = n;
int sumLeaves(ColoredTree t) = sumLeaves(t.left) + sumLeaves(t.right);

// same, but now with visit
int sumLeavesWithVisit(ColoredTree t) {
  return visit(int n := t) {case leaf(n) : return n;}
}

// same, but now with a for loop and deep match
int sumLeavesWithFor(ColoredTree t) {
  int sum = 0;
  for (leaf(n) := t) {
    sum += n;
  }
  return sum;
}

// same, but now with a reducer and deep match
// Reducer = ( <initial value> | <some expression with `it` | <generators> )
int sumLeavesWithReducer(ColoredTree t) = (0 | it + n | leaf(int n) := t);


// add 1 to all leaves; use visit + =>
ColoredTree inc1(ColoredTree t) {
  return visit(ColoredTree t) { case leaf(n): return leaf(n + 1); }
}

// write a test for inc1, run from console using :test
test bool testInc1() = inc1(leaf(1)) == leaf(2);

// define a property for inc1, i.e. a boolean
// function that checks if one tree is inc1 of the other
// (without using inc1).
// Use switch on the tupling of t1 and t2 (`<t1, t2>`)
// or pattern based dispatch.
// Hint! The tree also needs to have the same shape!

bool isInc1(leaf(int n1), leaf(int n2)) = n2 == n1 + 1;
default bool isInc1(ColoredTree t1, ColoredTree t2) = isInc1(t1.left, t2.left) && isInc1(t1.right, t2.right);

 
// write a randomized test for inc1 using the property
// again, execute using :test
test bool testInc1Randomized() {
  ColoredTree t1 = randomTree();
  return isInc1(t1, inc1(t1));
}
 

 
  
  
