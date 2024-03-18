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

variable "provisionwasdb_policy_description" {
  default     = "Allows provisioning of the WAS DB in the User Services account."
  description = "The description to associate with the IAM policy that allows provisioning of the WAS DB in the User Services account."
  type        = string
}

variable "provisionwasdb_policy_name" {
  default     = "ProvisionWASDB"
  description = "The name to assign the IAM policy that allows provisioning of the WAS DB in the User Services account."
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

variable "stakeholders_table_name" {
  default     = "stakeholders"
  description = "The name of the stakeholders DynamoDB table."
  type        = string
}

variable "stakeholders_table_partition_key" {
  default     = "id"
  description = "The name of the stakeholders DynamoDB table partition (hash) key.  It's best to choose an attribute with a wide range of values that is likely to have evenly distributed access patterns."
  type        = string
}

variable "stakeholders_table_partition_key_type" {
  default     = "S"
  description = "The data type of the stakeholders DynamoDB table partition (hash) key.  See `https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.NamingRulesDataTypes.html#HowItWorks.DataTypeDescriptors` for a list of valid values."
  type        = string

  validation {
    condition     = contains(["B", "BOOL", "BS", "L", "M", "N", "NS", "NULL", "S", "SS"], var.stakeholders_table_partition_key_type)
    error_message = "The partition key type must be one of the following valid values: B, BOOL, BS, L, M, N, NS, NULL, S, SS"
  }
}

variable "stakeholders_table_point_in_time_recovery" {
  default     = false
  description = "Whether to enable point-in-time recovery for the stakeholders DynamoDB table."
  type        = bool
}

variable "stakeholders_table_read_capacity" {
  default     = 5
  description = "The number of read units for the stakeholders DynamoDB table."
  type        = number
}

variable "read_only_policy_role_description" {
  default     = "Allows read-only access to the WAS DB in the User Services account."
  description = "The description to associate with the IAM policy and role that allows read-only access to the WAS DynamoDB tables in the User Services account."
  type        = string
}

variable "stakeholders_table_sort_key" {
  default     = ""
  description = "The name of the stakeholders DynamoDB table sort (range) key."
  type        = string
}

variable "stakeholders_table_sort_key_type" {
  default     = "S"
  description = "The data type of the stakeholders DynamoDB table sort (range) key.  See `https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.NamingRulesDataTypes.html#HowItWorks.DataTypeDescriptors` for a list of valid values."
  type        = string

  validation {
    condition     = contains(["B", "BOOL", "BS", "L", "M", "N", "NS", "NULL", "S", "SS"], var.stakeholders_table_sort_key_type)
    error_message = "The sort key type must be one of the following valid values: B, BOOL, BS, L, M, N, NS, NULL, S, SS"
  }
}

variable "tags" {
  default     = {}
  description = "Tags to apply to all AWS resources created."
  type        = map(string)
}

variable "stakeholders_table_write_capacity" {
  default     = 5
  description = "The number of write units for the stakeholders DynamoDB table."
  type        = number

}
