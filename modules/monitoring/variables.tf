variable "enable_logging" {
    description = "Enables logging on CloudTrail trail."
    type        = bool
    default     = true
}

variable "enable_log_file_validation" {
    description = "Enables validation of delivered log files."
    type        = bool
    default     = true
}