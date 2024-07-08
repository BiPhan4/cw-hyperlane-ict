package interchaintest

import (
	"context"
	"fmt"
	"testing"
	"time"

	"github.com/stretchr/testify/require"

	"github.com/strangelove-ventures/interchaintest/v7"
	"github.com/strangelove-ventures/interchaintest/v7/chain/ethereum"
	"github.com/strangelove-ventures/interchaintest/v7/testreporter"
)

func TestEthereum(t *testing.T) {

	if testing.Short() {
		t.Skip()
	}

	t.Parallel()

	client, network := interchaintest.DockerSetup(t)

	// Log location
	f, err := interchaintest.CreateLogFile(fmt.Sprintf("%d.json", time.Now().Unix()))
	require.NoError(t, err)
	// Reporter/logs
	rep := testreporter.NewReporter(f)
	eRep := rep.RelayerExecReporter(t)

	ctx := context.Background()

	// Get default ethereum chain config for anvil
	anvilConfig := ethereum.DefaultEthereumAnvilChainConfig("ethereum")

	fmt.Println(f)
	fmt.Println(client)
	fmt.Println(network)

}
