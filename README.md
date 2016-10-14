# Coarray-with-Allocatable-Component-Example
THIS REPOSITORY CONTAINS A FORTRAN (2008) COARRAY EXAMPLE PROGRAM THAT ILLUSTRATES THE USE OF A DERIVED TYPE COARRAY WITH AN ALLOCATABLE COMPONENT (NON-SYMMETRIC COARRAY)

# Overview
Derived type coarrays with allocatable (or pointer) components might be especially useful for dynamic PGAS memory management within our MPMD-style coarray programming. Aleksandar Donev gives good insight into the implications of such 'non-symmetric objects' in his 'Rationale for Co-Arrays in Fortran 2008' paper: http://caf.rice.edu/documentation/Aleksandar-Donev-Coarray-Rationale-N1702-2007-09.pdf
This repositories example code shows how to access the array bounds of such a non-symmetric coarray array member from a different coarray image using the LBOUND and UBOUND intrinsics.
Because there's no way to get the allocation status of a derived type coarray's allocatable component from a remote image, one should track the allocation status on that remote image. I did expand the example with an AllocationStatus member. That way one can avoid nasty run-time errors when trying to access a non-allocated coarray component on a remote image.
