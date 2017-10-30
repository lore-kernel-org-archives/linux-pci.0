Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@axis.com>
To: linux-arm-kernel@axis.com, linux-pci@vger.kernel.org,
        linux-omap@vger.kernel.org
Cc: Niklas Cassel <niklass@axis.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/17] dwc MSI fixes, ARTPEC-6 EP mode support, ARTPEC-7 SoC support
Date: Mon, 30 Oct 2017 13:42:03 +0100
Message-Id: <20171030124221.20690-1-niklas.cassel@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a series that adds:
- PCI endpoint mode support in the ARTPEC-6 driver.
- ARTPEC-7 SoC support in the ARTPEC-6 driver (the SoCs are very similar).
- Small fixes for MSI in designware-ep and designware-host,
  needed to get endpoint mode support working for ARTPEC-6.

New in V2:
Capitalized first letter in summary for all patches.
Moved DT binding changes to self contained patches.
Fixed all review comments, for detailed changes, see the note for in patch.

Niklas Cassel (17):
  PCI: dwc: Use DMA-API for allocating MSI data
  PCI: designware-ep: dw_pcie_ep_set_msi() should only set MMC bits
  PCI: designware-ep: Read-only registers need DBI_RO_WR_EN to be
    writable
  PCI: designware-ep: Pre-allocate memory for MSI in dw_pcie_ep_init
  PCI: designware-ep: Remove static keyword from dw_pcie_ep_reset_bar()
  PCI: designware-ep: Add generic function for raising MSI irq
  PCI: dwc: dra7xx: Refactor Kconfig and Makefile handling for host/ep
    mode
  PCI: dwc: dra7xx: Assign pp->ops in dra7xx_add_pcie_port() rather than
    in probe
  PCI: dwc: dra7xx: Add ifdefs for host/ep specific code
  PCI: dwc: artpec6: Remove unused defines
  PCI: dwc: artpec6: Use BIT and GENMASK macros
  PCI: dwc: artpec6: Split artpec6_pcie_establish_link to smaller
    functions
  bindings: PCI: artpec: Add support for endpoint mode
  PCI: dwc: artpec6: Add support for endpoint mode
  PCI: dwc: Make cpu_addr_fixup take struct dw_pcie as argument
  bindings: PCI: artpec: Add support for the ARTPEC-7 SoC
  PCI: dwc: artpec6: Add support for the ARTPEC-7 SoC

 .../devicetree/bindings/pci/axis,artpec6-pcie.txt  |   5 +-
 drivers/pci/dwc/Kconfig                            |  68 ++--
 drivers/pci/dwc/Makefile                           |   4 +-
 drivers/pci/dwc/pci-dra7xx.c                       |  53 +--
 drivers/pci/dwc/pcie-artpec6.c                     | 416 ++++++++++++++++++---
 drivers/pci/dwc/pcie-designware-ep.c               |  56 ++-
 drivers/pci/dwc/pcie-designware-host.c             |  15 +-
 drivers/pci/dwc/pcie-designware.c                  |   2 +-
 drivers/pci/dwc/pcie-designware.h                  |  22 +-
 9 files changed, 530 insertions(+), 111 deletions(-)

-- 
2.14.2
