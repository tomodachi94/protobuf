/*
 * upb - a minimalist implementation of protocol buffers.
 *
 * Copyright (c) 2009 Joshua Haberman.  See LICENSE for details.
 *
 * upb_struct defines an in-memory byte-level format for storing protobufs.  It
 * is very much like a C struct that you can define at run-time, but also
 * supports reflection.  Like C structs it supports offset-based access, as
 * opposed to the much slower name-based lookup.  The format represents both
 * the values themselves and bits describing whether each field is set or not.
 *
 * The upb compiler emits C structs that mimic this definition exactly, so that
 * you can access the same hunk of memory using either this run-time
 * reflection-supporting interface or a C struct that was generated by the upb
 * compiler.
 *
 * Like C structs the format depends on the endianness of the host machine, so
 * it is not suitable for exchanging across machines of differing endianness.
 * But there is no reason to do that -- the protobuf serialization format is
 * designed already for serialization/deserialization, and is more compact than
 * this format.  This format is designed to allow the fastest possible random
 * access of individual fields.
 *
 * Note that no memory management is defined, which should make it easier to
 * integrate this format with existing memory-management schemes.  Any memory
 * management semantics can be used with the format as defined here.
 */

#ifndef PBSTRUCT_H_
#define PBSTRUCT_H_

#include "upb.h"
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <string.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Structure definition. ******************************************************/

/* One single field of the struct. */
struct upb_struct_field {
  ptrdiff_t byte_offset;        /* Where to find the data. */
  ptrdiff_t isset_byte_offset;  /* The byte where the "set" bit lives. */
  uint8_t isset_byte_mask;
};

/* Definition of a complete struct. */
struct upb_struct_definition {
  size_t size;
  int num_fields;
  int set_flags_bytes;
  int num_required_fields;  /* Required fields have the lowest set bytemasks. */
  struct upb_struct_field fields[];
};

/* While these are written to be as fast as possible, it will still be faster
 * to cache the results of this lookup if possible.  These return NULL if no
 * such field is found. */
struct upb_struct_field *upb_struct_find_field_by_name(
  struct upb_struct_definition *d, char *name);
struct upb_struct_field *upb_struct_find_field_by_number(
  struct upb_struct_definition *d, uint32_t number);

/* Variable-length data (strings and arrays).**********************************/

/* Represents a string or bytes. */
struct upb_string {
  size_t byte_len;
  uint8_t *data;
};

/* Represents an array (a repeated field) of any type.  The interpretation of
 * the data in the array depends on the type. */
struct upb_array {
  size_t len;     /* Measured in elements. */
  uint8_t *data;  /* Size of individual elements is based on type. */
};

/* A generic array of structs, using void* instead of specific types. */
struct upb_struct_array {
  size_t len;
  void **elements;
};

/* An array of strings. */
struct upb_string_array {
  size_t len;
  struct upb_string **elements;
};

/* Specific arrays of all the primitive types. */
#define UPB_DEFINE_PRIMITIVE_ARRAY(type, name) \
  struct upb_ ## name ## _array { \
    size_t len; \
    type *elements; \
  };

UPB_DEFINE_PRIMITIVE_ARRAY(double,   double)
UPB_DEFINE_PRIMITIVE_ARRAY(float,    float)
UPB_DEFINE_PRIMITIVE_ARRAY(int32_t,  int32)
UPB_DEFINE_PRIMITIVE_ARRAY(int64_t,  int64)
UPB_DEFINE_PRIMITIVE_ARRAY(uint32_t, uint32)
UPB_DEFINE_PRIMITIVE_ARRAY(uint64_t, uint64)
UPB_DEFINE_PRIMITIVE_ARRAY(bool,     bool)
#undef UPB_DEFINE_PRMITIVE_ARRAY

#define UPB_STRUCT_ARRAY(struct_type) struct struct_type ## _array

#define UPB_DEFINE_STRUCT_ARRAY(struct_type) \
  UPB_STRUCT_ARRAY(struct_type) { \
    size_t len; \
    struct_type **elements; \
  };

/* Accessors for primitive types.  ********************************************/

/* For each primitive type we define a set of six functions:
 *
 *  // For fetching out of a struct (s points to the raw struct data).
 *  int32_t *upb_struct_get_int32_ptr(uint8_t *s, struct upb_struct_field *f);
 *  int32_t upb_struct_get_int32(uint8_t *s, struct upb_struct_field *f);
 *  void upb_struct_set_int32(uint8_t *s, struct upb_struct_field *f, int32_t val);
 *
 *  // For fetching out of an array.
 *  int32_t *upb_array_get_int32_ptr(struct upb_array *a, int n);
 *  int32_t upb_array_get_int32(struct upb_array *a, int n);
 *  void upb_array_set_int32(struct upb_array *a, int n, ctype val);
 *
 * For arrays we provide only the first three because protobufs do not support
 * arrays of arrays.
 *
 * These do no existence checks, bounds checks, or type checks. */

#define UPB_DEFINE_ACCESSORS(ctype, name, INLINE) \
  INLINE ctype *upb_struct_get_ ## name ## _ptr( \
      uint8_t *s, struct upb_struct_field *f) { \
    return (ctype*)(s + f->byte_offset); \
  } \
  INLINE ctype upb_struct_get_ ## name( \
      uint8_t *s, struct upb_struct_field *f) { \
    return *upb_struct_get_ ## name ## _ptr(s, f); \
  } \
  INLINE void upb_struct_set_ ## name( \
      uint8_t *s, struct upb_struct_field *f, ctype val) { \
    *upb_struct_get_ ## name ## _ptr(s, f) = val; \
  }

#define UPB_DEFINE_ARRAY_ACCESSORS(ctype, name, INLINE) \
  INLINE ctype *upb_array_get_ ## name ## _ptr(struct upb_array *a, int n) { \
    return ((ctype*)a->data) + n; \
  } \
  INLINE ctype upb_array_get_ ## name(struct upb_array *a, int n) { \
    return *upb_array_get_ ## name ## _ptr(a, n); \
  } \
  INLINE void upb_array_set_ ## name(struct upb_array *a, int n, ctype val) { \
    *upb_array_get_ ## name ## _ptr(a, n) = val; \
  }

#define UPB_DEFINE_ALL_ACCESSORS(ctype, name, INLINE) \
  UPB_DEFINE_ACCESSORS(ctype, name, INLINE) \
  UPB_DEFINE_ARRAY_ACCESSORS(ctype, name, INLINE)

UPB_DEFINE_ALL_ACCESSORS(double,   double, INLINE)
UPB_DEFINE_ALL_ACCESSORS(float,    float,  INLINE)
UPB_DEFINE_ALL_ACCESSORS(int32_t,  int32,  INLINE)
UPB_DEFINE_ALL_ACCESSORS(int64_t,  int64,  INLINE)
UPB_DEFINE_ALL_ACCESSORS(uint32_t, uint32, INLINE)
UPB_DEFINE_ALL_ACCESSORS(uint64_t, uint64, INLINE)
UPB_DEFINE_ALL_ACCESSORS(bool,     bool,   INLINE)
UPB_DEFINE_ALL_ACCESSORS(struct upb_struct_delimited*, bytes, INLINE)
UPB_DEFINE_ALL_ACCESSORS(struct upb_struct_delimited*, string, INLINE)
UPB_DEFINE_ALL_ACCESSORS(uint8_t*, substruct, INLINE)
UPB_DEFINE_ACCESSORS(struct upb_array*, array, INLINE)

/* Functions for reading and writing the "set" flags in the pbstruct.  Note
 * that these do not perform any memory management associated with any dynamic
 * memory these fields may be referencing; that is the client's responsibility.
 * These *only* set and test the flags. */
INLINE void upb_struct_set(uint8_t *s, struct upb_struct_field *f)
{
  s[f->isset_byte_offset] |= f->isset_byte_mask;
}

INLINE void upb_struct_unset(uint8_t *s, struct upb_struct_field *f)
{
  s[f->isset_byte_offset] &= ~f->isset_byte_mask;
}

INLINE bool upb_struct_is_set(uint8_t *s, struct upb_struct_field *f)
{
  return s[f->isset_byte_offset] & f->isset_byte_mask;
}

INLINE bool upb_struct_all_required_fields_set(
    uint8_t *s, struct upb_struct_definition *d)
{
  int num_fields = d->num_required_fields;
  int i = 0;
  while(num_fields > 8) {
    if(s[i++] != 0xFF) return false;
    num_fields -= 8;
  }
  if(s[i] != (1 << num_fields) - 1) return false;
  return true;
}

INLINE void upb_struct_clear(uint8_t *s, struct upb_struct_definition *d)
{
  memset(s, 0, d->set_flags_bytes);
}

#ifdef __cplusplus
}  /* extern "C" */
#endif

#endif  /* PBSTRUCT_H_ */
