Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH v2 0/9] Designware EP support and code clean up
Date: Mon,  9 Apr 2018 10:41:09 +0100
Message-Id: <cover.1523266508.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch set was made against the Bjorn's next branch.

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
  bindings: PCI: designware: Add support for the EP in Designware driver
  PCI: Adds device ID for Synopsys Sample Endpoint.
  misc: pci_endpoint_test: Add designware EP entry
  PCI: dwc: Define maximum number of vectors
  PCI: dwc: Replace lower into upper case characters
  PCI: dwc: Small computation improvement
  PCI: dwc: Replace magic number by defines

 .../devicetree/bindings/pci/designware-pcie.txt    |  27 +++-
 drivers/misc/pci_endpoint_test.c                   |   1 +
 drivers/pci/dwc/Kconfig                            |  45 ++++--
 drivers/pci/dwc/pcie-designware-ep.c               |  20 +--
 drivers/pci/dwc/pcie-designware-host.c             |  77 +++++-----
 drivers/pci/dwc/pcie-designware-plat.c             | 159 +++++++++++++++++++--
 drivers/pci/dwc/pcie-designware.c                  |  22 +--
 drivers/pci/dwc/pcie-designware.h                  |   1 +
 drivers/pci/endpoint/functions/pci-epf-test.c      |   9 ++
 include/linux/pci_ids.h                            |   1 +
 10 files changed, 281 insertions(+), 81 deletions(-)

-- 
2.7.4
