Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.37.59]:52400 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932176AbeFTQ2o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jun 2018 12:28:44 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com, sboyd@codeaurora.org
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v5 00/11] Add MSI-X support on pcitest tool
Date: Wed, 20 Jun 2018 17:28:22 +0100
Message-Id: <cover.1529507416.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Patch series made against Lorenzo's master branch.

Add MSI-X support on pcitest tool.

Add new callbacks methods and handlers to trigger the MSI-X interrupts
on the EP DesignWare IP driver.

Allow to set/get MSI-X EP maximum capability number.

Rework on set/get and triggering MSI methods on EP DesignWare IP driver.

Add a new input parameter (msix) to pcitest tool to test MSI-X feature.

Update the pcitest.sh script to support MSI-X feature tests.

Gustavo Pimentel (11):
  PCI: endpoint: Add MSI-X interfaces
  PCI: Update xxx_pcie_ep_raise_irq() and pci_epc_raise_irq() signatures
  PCI: dwc: Add MSI-X callbacks handler
  PCI: dwc: Rework MSI callbacks handler
  PCI: dwc: Add legacy interrupt callback handler
  pci-epf-test/pci_endpoint_test: Cleanup PCI_ENDPOINT_TEST memspace
  pci-epf-test/pci_endpoint_test: Use irq_type module parameter
  pci-epf-test/pci_endpoint_test: Add MSI-X support
  pci_endpoint_test: Add 2 ioctl commands
  tools: PCI: Add MSI-X support
  PCI: endpoint: Add MSI set maximum restriction.

 Documentation/misc-devices/pci-endpoint-test.txt  |   6 +
 drivers/misc/pci_endpoint_test.c                  | 259 ++++++++++++++++------
 drivers/pci/controller/dwc/pci-dra7xx.c           |   2 +-
 drivers/pci/controller/dwc/pcie-artpec6.c         |   2 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c   | 205 +++++++++++++++--
 drivers/pci/controller/dwc/pcie-designware-plat.c |   7 +-
 drivers/pci/controller/dwc/pcie-designware.h      |  31 ++-
 drivers/pci/controller/pcie-cadence-ep.c          |   3 +-
 drivers/pci/controller/pcie-rockchip-ep.c         |   2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c     |  81 +++++--
 drivers/pci/endpoint/pci-ep-cfs.c                 |  24 ++
 drivers/pci/endpoint/pci-epc-core.c               |  68 +++++-
 include/linux/pci-epc.h                           |  15 +-
 include/linux/pci-epf.h                           |   1 +
 include/uapi/linux/pcitest.h                      |   3 +
 tools/pci/pcitest.c                               |  51 ++++-
 tools/pci/pcitest.sh                              |  15 ++
 17 files changed, 643 insertions(+), 132 deletions(-)

-- 
2.7.4
