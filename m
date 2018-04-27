Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH 00/10] Add MSI-X support on pcitest tool
Date: Fri, 27 Apr 2018 17:57:37 +0100
Message-Id: <cover.1524845816.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Depends of the following serie [1].

Add MSI-X support on pcitest tool.

Add new callbacks methods and handlers to trigger the MSI-X interrupts
on the EP DesignWare IP driver.

Allow to set/get MSI-X EP maximum capability number.

Rework on set/get and triggering MSI methods on EP DesignWare IP driver.

Add a new input parameter (msix) to pcitest tool to test MSI-X feature.

Update the pcitest.sh script to support MSI-X feature tests.

[1] -> https://lkml.org/lkml/2018/4/27/342

Gustavo Pimentel (10):
  PCI: endpoint: Add MSI-X interfaces
  PCI: dwc: Add MSI-X callbacks handler
  PCI: cadence: Update cdns_pcie_ep_raise_irq function signature
  PCI: dwc: Rework MSI callbacks handler
  PCI: dwc: Add legacy interrupt callback handler
  misc: pci_endpoint_test: Add MSI-X support
  misc: pci_endpoint_test: Replace lower into upper case characters
  PCI: endpoint: functions/pci-epf-test: Replace lower into upper case
    characters
  tools: PCI: Add MSI-X support
  misc: pci_endpoint_test: Use pci_irq_vector function

 Documentation/misc-devices/pci-endpoint-test.txt |   3 +
 drivers/misc/pci_endpoint_test.c                 | 147 +++++++++++------
 drivers/pci/cadence/pcie-cadence-ep.c            |   2 +-
 drivers/pci/dwc/pci-dra7xx.c                     |   2 +-
 drivers/pci/dwc/pcie-artpec6.c                   |   2 +-
 drivers/pci/dwc/pcie-designware-ep.c             | 202 +++++++++++++++++++++--
 drivers/pci/dwc/pcie-designware-plat.c           |   7 +-
 drivers/pci/dwc/pcie-designware.h                |  31 ++--
 drivers/pci/endpoint/functions/pci-epf-test.c    | 104 ++++++++----
 drivers/pci/endpoint/pci-ep-cfs.c                |  24 +++
 drivers/pci/endpoint/pci-epc-core.c              |  60 ++++++-
 include/linux/pci-epc.h                          |  11 +-
 include/linux/pci-epf.h                          |   1 +
 include/uapi/linux/pcitest.h                     |   1 +
 tools/pci/pcitest.c                              |  18 +-
 tools/pci/pcitest.sh                             |  25 +++
 16 files changed, 517 insertions(+), 123 deletions(-)

-- 
2.7.4
