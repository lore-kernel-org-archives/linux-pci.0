Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH v6 0/9] Designware EP support and code clean up
Date: Wed, 18 Apr 2018 15:46:35 +0100
Message-Id: <cover.1524062073.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch set was made against the Lorenzo's master branch.

Adds support Designware EP support.

Increases the maximum number of interrupts allowed for Designware IP
controller.

Does a code cleanup on Designware driver:
 - Replaces magic numbers without a easy meaning by a well known define
   that helps the human compreension.
 - Replaces a division by 2 by a simple right shift rotation of 1 bit.
 - Fixes all first letter characters on comments and debug messages to
   upper case to maintain coherency.

Gustavo Pimentel (9):
  bindings: PCI: designware: Example update
  PCI: dwc: Add support for endpoint mode
  PCI: endpoint: functions/pci-epf-test: Add second entry
  bindings: PCI: designware: Add support for the EP in Designware driver
  misc: pci_endpoint_test: Add designware EP entry
  PCI: dwc: Define maximum number of vectors
  PCI: dwc: Replace lower into upper case characters
  PCI: dwc: Small computation improvement
  PCI: dwc: Replace magic number by defines

 .../PCI/endpoint/function/binding/pci-test.txt     |   2 +
 .../devicetree/bindings/pci/designware-pcie.txt    |  24 +++-
 drivers/misc/pci_endpoint_test.c                   |   1 +
 drivers/pci/dwc/Kconfig                            |  41 ++++--
 drivers/pci/dwc/pcie-designware-ep.c               |  16 +--
 drivers/pci/dwc/pcie-designware-host.c             |  77 +++++-----
 drivers/pci/dwc/pcie-designware-plat.c             | 155 +++++++++++++++++++--
 drivers/pci/dwc/pcie-designware.c                  |  22 +--
 drivers/pci/dwc/pcie-designware.h                  |   1 +
 drivers/pci/endpoint/functions/pci-epf-test.c      |   8 ++
 10 files changed, 267 insertions(+), 80 deletions(-)

-- 
2.7.4
