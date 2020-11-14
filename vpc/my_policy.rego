package terraform.analysis

import input as tfplan

deny_resources = [
"aws_subnet"
]

array_contains(arr, elem) {
arr[_] = elem
}

deny[reason] {
resource := tfplan.resource_changes[_]
action := resource.change.actions[count(resource.change.actions) - 1]
array_contains(["create"], action)  # allow update and destroy action

array_contains(deny_resources, resource.type)

reason := sprintf(
  "%s: resource type %q is not allowed",
  [resource.address, resource.type]
)
}
