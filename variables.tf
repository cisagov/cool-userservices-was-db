# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "aws_region" {
  default     = "us-east-1"
  description = "The AWS region to deploy into (e.g. us-east-1)."
  type        = string
}

variable "partition_key" {
  default     = "id"
  description = "The name of the DynamoDB table partition (hash) key.  It's best to choose an attribute with a wide range of values that is likely to have evenly distributed access patterns."
  type        = string
}

variable "partition_key_type" {
  default     = "S"
  description = "The data type of the DynamoDB table partition (hash) key.  See `https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.NamingRulesDataTypes.html#HowItWorks.DataTypeDescriptors` for a list of valid values."
  type        = string

  validation {
    condition     = contains(["B", "BOOL", "BS", "L", "M", "N", "NS", "NULL", "S", "SS"], var.partition_key_type)
    error_message = "The partition key type must be one of the following valid values: B, BOOL, BS, L, M, N, NS, NULL, S, SS"
  }
}

variable "point_in_time_recovery" {
  default     = false
  description = "Whether to enable point-in-time recovery for the DynamoDB table."
  type        = bool
}

variable "provisionwasdb_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows provisioning of the WAS DB in the User Services account."
  default     = "Allows provisioning of the WAS DB in the User Services account."
}

variable "provisionwasdb_policy_name" {
  type        = string
  description = "The name to assign the IAM policy that allows provisioning of the WAS DB in the User Services account."
  default     = "ProvisionWASDB"
}

variable "read_capacity" {
  default     = 5
  description = "The number of read units for the DynamoDB table."
  type        = number
}

variable "read_only_policy_role_description" {
  default     = "Allows read-only access to the WAS DB in the User Services account."
  description = "The description to associate with the IAM policy and role that allows read-only access to the WAS DB in the User Services account."
  type        = string
}

variable "read_only_policy_role_name" {
  default     = "WAS-DB-ReadOnly"
  description = "The name to assign the IAM policy and role that allows read-only access to the WAS DB in the User Services account."
  type        = string
}

variable "read_write_policy_role_description" {
  default     = "Allows read-write access to the WAS DB in the User Services account."
  description = "The description to associate with the IAM policy and role that allows read-write access to the WAS DB in the User Services account."
  type        = string
}

variable "read_write_policy_role_name" {
  default     = "WAS-DB-ReadWrite"
  description = "The name to assign the IAM policy and role that allows read-write access to the WAS DB in the User Services account."
  type        = string
}

variable "sort_key" {
  default     = "name"
  description = "The name of the DynamoDB table sort (range) key."
  type        = string
}

variable "sort_key_type" {
  default     = "S"
  description = "The data type of the DynamoDB table sort (range) key.  See `https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.NamingRulesDataTypes.html#HowItWorks.DataTypeDescriptors` for a list of valid values."
  type        = string

  validation {
    condition     = contains(["B", "BOOL", "BS", "L", "M", "N", "NS", "NULL", "S", "SS"], var.sort_key_type)
    error_message = "The sort key type must be one of the following valid values: B, BOOL, BS, L, M, N, NS, NULL, S, SS"
  }
}

variable "table_name" {
  default     = "was"
  description = "The name of the DynamoDB table."
  type        = string
}

variable "tags" {
  default     = {}
  description = "Tags to apply to all AWS resources created."
  type        = map(string)
}

variable "write_capacity" {
  default     = 5
  description = "The number of write units for the DynamoDB table."
  type        = number

}
