# MIX
Simulator for Knuth's MIX machine. The Art of Computer Programming
(3rd edition) section 1.3 onward.

## MIX definitions and internals

### MIX Bytes

A MIX byte must be capable of representing at least 64
different values, and not more than 100 different values.
We choose the Free Pascal byte type (unsigned 0 to 255)
as a MIX byte, with the constraint that we will not 
use more than 100 of these values and not less than 64.

Since we have to make a decision on what exactly our 
bytes mean, we will take these values to be between
0 and 63 inclusive. Compare this to a regular machine
architecture byte on all computers of today, which
has 256 different values.

Rather than working with base-2 bits or hex or octal,
we will simply store decimal numbers into our bytes
and make sure no value in any byte is larger than 63.

### MIX Words

Mix words fit perfectly into MIX main registers, and 
they constitute the smallest pieces of MIX RAM memory
that can be directly addressed. A mix word is a sign
followed by 5 MIX bytes. We choose to represent the
sign by a byte and the MIX word will be a 6-element
array of MIX bytes. 1 in the sign byte means negative,
0 means positive.

### MIX Registers

MIX has two full registers: rA (accumulator), rX (extension)
and six smaller ones: rI1, rI2, rI3, rI4, rI5, rI6 (index),
rJ (jump).
All registers will be represented in the same way internally,
as 6-element arrays of MIX byte, with the 0th element resered
for sign (0 or 1).

The index registers are limited to three usable bytes.
We can only access and use the sign byte and the last two
bytes (bytes 4 and 5) of the index registers. Same goes
for the jump register exept that the sign byte is always 0
(positive).

### MIX Memory Addresses

Addresses in the MIX machine are limited to 2 MIX bytes,
so for our case of 64-valued bytes, that makes 4096 addressable
words in memory. However we only have 4000 words of "physical"
memory, so we use less values: 0 to 3999.

### MIX Indicators

OI (overflow indicator) is represented by an enum: ON, OFF.
CI (comparison indicator) is an enum: LESS, EQUAL, GREATER.


### MIX Units


### MIX Instructions



