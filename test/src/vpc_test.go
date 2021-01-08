package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/gcp"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestExampleVpc(t *testing.T) {
	t.Parallel()

	network_name := "test-vpc"
	project_id := gcp.GetGoogleProjectIDFromEnvVar(t)
	default_routes_on_create := true
	terraformDir := "../../examples/simple_network"

	terraformOptions := &terraform.Options{

		TerraformDir: terraformDir,

		Vars: map[string]interface{}{
			"network_name":                    network_name,
			"project_id":                      project_id,
			"delete_default_routes_on_create": default_routes_on_create,
		},
		EnvVars: map[string]string{
			"GOOGLE_CLOUD_PROJECT": project_id,
		},
	}
	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
	vpc_output_name := terraform.Output(t, terraformOptions, "network_name")
	vpc_name_expected := "test-vpc"
	assert.Equal(t, vpc_name_expected, vpc_output_name)
}
