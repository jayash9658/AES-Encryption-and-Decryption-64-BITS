# AES-Encryption-and-Decryption-64-BITS
Verilog implementation of a 64-bit AES block supporting encryption and decryption. Features key expansion, SubBytes, ShiftRows, MixColumns, and AddRoundKey. Verified using a scoreboard with random tests, achieving 100% correctness.


AES Encryption and Decryption
Overview
AES (Advanced Encryption Standard) is a symmetric block cipher used for secure data encryption and decryption. It works on 128-bit data blocks and supports key sizes of 128, 192, or 256 bits. The transformation process consists of several rounds, each comprising specific operations depending on whether encryption or decryption is being performed.
Encryption Process
W0	w1	w2	w3
w4	w5	w6	w7

Initial Key Expansion
The encryption uses a set of keys W0 to W7 generated from the original key.
Total number of rounds: 8
Round-wise Operations
Round 0:
  - 1 Transformation:
    • AddRoundKey (XOR with the key)
Rounds 1 to 7:
  - 4 Transformations:
    1. SubBytes
    2. ShiftRows
    3. MixColumns
    4. AddRoundKey
Round 8:
  - 3 Transformations:
    1. SubBytes
    2. ShiftRows
    3. AddRoundKey (Note: No MixColumns in final round)

Transformation Details
1. SubBytes
Each byte in the state matrix is replaced using a fixed S-Box (substitution box).
<img width="765" height="463" alt="image" src="https://github.com/user-attachments/assets/b977c144-81f4-448d-9e14-ae23f6ab07dd" />

 
3. ShiftRows
This operation shifts the rows of the state matrix:
Before:
[ b0  b1  b2  b3 ]
[ b4  b5  b6  b7 ]
[ b8  b9  b10 b11 ]
[ b12 b13 b14 b15 ]
After:
[ b0  b1   b2   b3  ]
[ b5  b6   b7   b4  ]
[ b10 b11  b8   b9  ]
[ b15 b12  b13  b14 ]
3.Mix columns
<img width="900" height="860" alt="image" src="https://github.com/user-attachments/assets/1455b706-cd62-489f-9c92-d94082e6ead7" />

 
Matrix we could use - 
 
<img width="159" height="123" alt="image" src="https://github.com/user-attachments/assets/07b06d2e-be0f-4f36-bfec-51e0eb9bc686" />



4.Round key transformation
	Word matrix XOR operation with round key matrix
 

Decryption Process
Decryption follows the reverse of encryption operations.
Round-wise Operations
1. InvShiftRows
2. InvSubBytes
3. InvMixColumns
4. AddRoundKey
Transformation Notes
- InvShiftRows: Reverses the byte shifts applied during encryption.

<img width="630" height="393" alt="image" src="https://github.com/user-attachments/assets/0594574e-cb9c-4b43-81e5-c58e2210ba5d" />

 

- InvSubBytes: Uses the inverse S-Box to reverse substitution.

 <img width="729" height="468" alt="image" src="https://github.com/user-attachments/assets/f986e613-1725-41ee-84b0-b00410002bef" />


- 3.INVMIXCOLUMNS() 

INVMIXCOLUMNS() is the inverse of MIXCOLUMNS(). In particular, INVMIXCOLUMNS() multiplies each of the four columns of the state by a single fixed matrix.

<img width="900" height="398" alt="image" src="https://github.com/user-attachments/assets/39aea757-2ddd-4903-945a-bbcd3aaa187c" />

 
The Matrix we are going to use is 
 <img width="689" height="118" alt="image" src="https://github.com/user-attachments/assets/bec4b3f0-a6b8-4769-b9c9-364d588e4f78" />


4.Inverse of ADDROUNDKEY() 

ADDROUNDKEY() is its own inverse. 



<img width="900" height="535" alt="image" src="https://github.com/user-attachments/assets/393ca88a-bf81-4412-9050-a5129722fe4c" />


<img width="905" height="664" alt="image" src="https://github.com/user-attachments/assets/bf5d29dc-ceca-4936-b37d-9fb35774aeb8" />


