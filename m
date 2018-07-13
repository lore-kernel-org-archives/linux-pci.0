Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728140AbeGMNh4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Jul 2018 09:37:56 -0400
Date: Fri, 13 Jul 2018 14:25:13 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, kishon@ti.com
Cc: bhelgaas@google.com, Joao.Pinto@synopsys.com, jingoohan1@gmail.com,
        kishon@ti.com, adouglas@cadence.com, jesper.nilsson@axis.com,
        shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 00/12] Add MSI-X support on pcitest tool
Message-ID: <20180713132513.GD18515@red-moon>
References: <cover.1531155252.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1531155252.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 09, 2018 at 06:42:38PM +0100, Gustavo Pimentel wrote:
> Patch series made against Lorenzo's master branch.
> 
> Fix EP link notification implementation.
> 
> Add MSI-X support on pcitest tool.
> 
> Add new callbacks methods and handlers to trigger the MSI-X interrupts
> on the EP DesignWare IP driver.
> 
> Allow to set/get MSI-X EP maximum capability number.
> 
> Rework on set/get and triggering MSI methods on EP DesignWare IP driver.
> 
> Add a new input parameter (msix) to pcitest tool to test MSI-X feature.
> 
> Update the pcitest.sh script to support MSI-X feature tests.
> 
> Gustavo Pimentel (12):
>   PCI: dwc: Fix EP link notification implementation
>   PCI: endpoint: Add MSI-X interfaces
>   PCI: Update xxx_pcie_ep_raise_irq() and pci_epc_raise_irq() signatures
>   PCI: dwc: Add MSI-X callbacks handler
>   PCI: dwc: Rework MSI callbacks handler
>   PCI: dwc: Add legacy interrupt callback handler
>   pci-epf-test/pci_endpoint_test: Cleanup PCI_ENDPOINT_TEST memspace
>   pci-epf-test/pci_endpoint_test: Use irq_type module parameter
>   pci-epf-test/pci_endpoint_test: Add MSI-X support
>   pci_endpoint_test: Add 2 ioctl commands
>   tools: PCI: Add MSI-X support
>   PCI: endpoint: Add MSI set maximum restriction
> 
>  Documentation/PCI/endpoint/pci-test-function.txt  |   8 +-
>  Documentation/ioctl/ioctl-number.txt              |   1 +
>  Documentation/misc-devices/pci-endpoint-test.txt  |   6 +
>  drivers/misc/pci_endpoint_test.c                  | 260 ++++++++++++++++------
>  drivers/pci/controller/dwc/pci-dra7xx.c           |   2 +-
>  drivers/pci/controller/dwc/pcie-artpec6.c         |   2 +-
>  drivers/pci/controller/dwc/pcie-designware-ep.c   | 217 ++++++++++++++++--
>  drivers/pci/controller/dwc/pcie-designware-plat.c |  11 +-
>  drivers/pci/controller/dwc/pcie-designware.h      |  31 ++-
>  drivers/pci/controller/pcie-cadence-ep.c          |   3 +-
>  drivers/pci/controller/pcie-rockchip-ep.c         |   2 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c     |  86 +++++--
>  drivers/pci/endpoint/pci-ep-cfs.c                 |  24 ++
>  drivers/pci/endpoint/pci-epc-core.c               |  68 +++++-
>  include/linux/pci-epc.h                           |  16 +-
>  include/linux/pci-epf.h                           |   1 +
>  include/uapi/linux/pcitest.h                      |   3 +
>  tools/pci/pcitest.c                               |  51 ++++-
>  tools/pci/pcitest.sh                              |  15 ++
>  19 files changed, 664 insertions(+), 143 deletions(-)

Gustavo, Kishon,

it seems like this series has been thoroughly reviewed and it is
ready to go, please let me know if there is any pending change.

Lorenzo
