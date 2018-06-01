Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay6.synopsys.com ([198.182.37.59]:42594 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbeFAOZD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jun 2018 10:25:03 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v3 00/10] Add MSI-X support on pcitest tool
Date: Fri,  1 Jun 2018 15:24:42 +0100
Message-Id: <cover.1527862777.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Patch series made against Lorenzo's branches and also depends of:
 - pci/dwc
 - pci/endpoint

Add MSI-X support on pcitest tool.

Add new callbacks methods and handlers to trigger the MSI-X interrupts
on the EP DesignWare IP driver.

Allow to set/get MSI-X EP maximum capability number.

Rework on set/get and triggering MSI methods on EP DesignWare IP driver.

Add a new input parameter (msix) to pcitest tool to test MSI-X feature.

Update the pcitest.sh script to support MSI-X feature tests.

Gustavo Pimentel (10):
  PCI: endpoint: Add MSI-X interfaces
  PCI: dwc: Add MSI-X callbacks handler
  PCI: Update xxx_pcie_ep_raise_irq() and pci_epc_raise_irq() signatures
  PCI: dwc: Rework MSI callbacks handler
  PCI: dwc: Add legacy interrupt callback handler
  pci-epf-test/pci_endpoint_test: Cleanup PCI_ENDPOINT_TEST memspace
  pci-epf-test/pci_endpoint_test: Use irq_type module parameter
  pci-epf-test/pci_endpoint_test: Add MSI-X support
  pci_endpoint_test: Add 2 ioctl commands
  tools: PCI: Add MSI-X support

 Documentation/misc-devices/pci-endpoint-test.txt |   6 +
 drivers/misc/pci_endpoint_test.c                 | 261 +++++++++++++++++------
 drivers/pci/cadence/pcie-cadence-ep.c            |   3 +-
 drivers/pci/dwc/pci-dra7xx.c                     |   2 +-
 drivers/pci/dwc/pcie-artpec6.c                   |   2 +-
 drivers/pci/dwc/pcie-designware-ep.c             | 205 ++++++++++++++++--
 drivers/pci/dwc/pcie-designware-plat.c           |   7 +-
 drivers/pci/dwc/pcie-designware.h                |  31 +--
 drivers/pci/endpoint/functions/pci-epf-test.c    |  81 +++++--
 drivers/pci/endpoint/pci-ep-cfs.c                |  24 +++
 drivers/pci/endpoint/pci-epc-core.c              |  68 +++++-
 include/linux/pci-epc.h                          |  15 +-
 include/linux/pci-epf.h                          |   1 +
 include/uapi/linux/pcitest.h                     |   3 +
 tools/pci/pcitest.c                              |  51 ++++-
 tools/pci/pcitest.sh                             |  15 ++
 16 files changed, 643 insertions(+), 132 deletions(-)

-- 
2.7.4
