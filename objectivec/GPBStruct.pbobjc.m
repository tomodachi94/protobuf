// Generated by the protocol buffer compiler.  DO NOT EDIT!
// clang-format off
// source: google/protobuf/struct.proto

#import "GPBProtocolBuffers_RuntimeSupport.h"
#import "GPBStruct.pbobjc.h"

#if GOOGLE_PROTOBUF_OBJC_VERSION < 30007
#error This file was generated by a newer version of protoc which is incompatible with your Protocol Buffer library sources.
#endif
#if 30007 < GOOGLE_PROTOBUF_OBJC_MIN_SUPPORTED_VERSION
#error This file was generated by an older version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

#import <stdatomic.h>

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wdirect-ivar-access"
#pragma clang diagnostic ignored "-Wdollar-in-identifier-extension"

#pragma mark - Objective-C Class declarations
// Forward declarations of Objective-C classes that we can use as
// static values in struct initializers.
// We don't use [Foo class] because it is not a static value.
GPBObjCClassDeclaration(GPBListValue);
GPBObjCClassDeclaration(GPBStruct);
GPBObjCClassDeclaration(GPBValue);

#pragma mark - GPBStructRoot

@implementation GPBStructRoot

// No extensions in the file and no imports, so no need to generate
// +extensionRegistry.

@end

static GPBFileDescription GPBStructRoot_FileDescription = {
  .package = "google.protobuf",
  .prefix = "GPB",
  .syntax = GPBFileSyntaxProto3
};

#pragma mark - Enum GPBNullValue

GPBEnumDescriptor *GPBNullValue_EnumDescriptor(void) {
  static _Atomic(GPBEnumDescriptor*) descriptor = nil;
  if (!descriptor) {
    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    static const char *valueNames =
        "NullValue\000";
    static const int32_t values[] = {
        GPBNullValue_NullValue,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(GPBNullValue)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:GPBNullValue_IsValidValue
                                            flags:GPBEnumDescriptorInitializationFlag_None];
    GPBEnumDescriptor *expected = nil;
    if (!atomic_compare_exchange_strong(&descriptor, &expected, worker)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL GPBNullValue_IsValidValue(int32_t value__) {
  switch (value__) {
    case GPBNullValue_NullValue:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - GPBStruct

@implementation GPBStruct

@dynamic fields, fields_Count;

typedef struct GPBStruct__storage_ {
  uint32_t _has_storage_[1];
  NSMutableDictionary *fields;
} GPBStruct__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "fields",
        .dataTypeSpecific.clazz = GPBObjCClass(GPBValue),
        .number = GPBStruct_FieldNumber_Fields,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(GPBStruct__storage_, fields),
        .flags = GPBFieldMapKeyString,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:GPBObjCClass(GPBStruct)
                                   messageName:@"Struct"
                               fileDescription:&GPBStructRoot_FileDescription
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(GPBStruct__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown | GPBDescriptorInitializationFlag_ClosedEnumSupportKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - GPBValue

@implementation GPBValue

@dynamic kindOneOfCase;
@dynamic nullValue;
@dynamic numberValue;
@dynamic stringValue;
@dynamic boolValue;
@dynamic structValue;
@dynamic listValue;

typedef struct GPBValue__storage_ {
  uint32_t _has_storage_[2];
  GPBNullValue nullValue;
  NSString *stringValue;
  GPBStruct *structValue;
  GPBListValue *listValue;
  double numberValue;
} GPBValue__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "nullValue",
        .dataTypeSpecific.enumDescFunc = GPBNullValue_EnumDescriptor,
        .number = GPBValue_FieldNumber_NullValue,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(GPBValue__storage_, nullValue),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldHasEnumDescriptor),
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "numberValue",
        .dataTypeSpecific.clazz = Nil,
        .number = GPBValue_FieldNumber_NumberValue,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(GPBValue__storage_, numberValue),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeDouble,
      },
      {
        .name = "stringValue",
        .dataTypeSpecific.clazz = Nil,
        .number = GPBValue_FieldNumber_StringValue,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(GPBValue__storage_, stringValue),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "boolValue",
        .dataTypeSpecific.clazz = Nil,
        .number = GPBValue_FieldNumber_BoolValue,
        .hasIndex = -1,
        .offset = 0,  // Stored in _has_storage_ to save space.
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeBool,
      },
      {
        .name = "structValue",
        .dataTypeSpecific.clazz = GPBObjCClass(GPBStruct),
        .number = GPBValue_FieldNumber_StructValue,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(GPBValue__storage_, structValue),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "listValue",
        .dataTypeSpecific.clazz = GPBObjCClass(GPBListValue),
        .number = GPBValue_FieldNumber_ListValue,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(GPBValue__storage_, listValue),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:GPBObjCClass(GPBValue)
                                   messageName:@"Value"
                               fileDescription:&GPBStructRoot_FileDescription
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(GPBValue__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown | GPBDescriptorInitializationFlag_ClosedEnumSupportKnown)];
    static const char *oneofs[] = {
      "kind",
    };
    [localDescriptor setupOneofs:oneofs
                           count:(uint32_t)(sizeof(oneofs) / sizeof(char*))
                   firstHasIndex:-1];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t GPBValue_NullValue_RawValue(GPBValue *message) {
  GPBDescriptor *descriptor = [GPBValue descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:GPBValue_FieldNumber_NullValue];
  return GPBGetMessageRawEnumField(message, field);
}

void SetGPBValue_NullValue_RawValue(GPBValue *message, int32_t value) {
  GPBDescriptor *descriptor = [GPBValue descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:GPBValue_FieldNumber_NullValue];
  GPBSetMessageRawEnumField(message, field, value);
}

void GPBValue_ClearKindOneOfCase(GPBValue *message) {
  GPBDescriptor *descriptor = [GPBValue descriptor];
  GPBOneofDescriptor *oneof = [descriptor.oneofs objectAtIndex:0];
  GPBClearOneof(message, oneof);
}
#pragma mark - GPBListValue

@implementation GPBListValue

@dynamic valuesArray, valuesArray_Count;

typedef struct GPBListValue__storage_ {
  uint32_t _has_storage_[1];
  NSMutableArray *valuesArray;
} GPBListValue__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "valuesArray",
        .dataTypeSpecific.clazz = GPBObjCClass(GPBValue),
        .number = GPBListValue_FieldNumber_ValuesArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(GPBListValue__storage_, valuesArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:GPBObjCClass(GPBListValue)
                                   messageName:@"ListValue"
                               fileDescription:&GPBStructRoot_FileDescription
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(GPBListValue__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown | GPBDescriptorInitializationFlag_ClosedEnumSupportKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)

// clang-format on
