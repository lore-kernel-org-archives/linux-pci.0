Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@axis.com>
To: linux-arm-kernel@axis.com, linux-pci@vger.kernel.org,
        linux-omap@vger.kernel.org
Cc: Niklas Cassel <niklass@axis.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/18] dwc MSI fixes, ARTPEC-6 EP mode support, ARTPEC-7 SoC support
Date: Mon, 20 Nov 2017 14:32:03 +0100
Message-Id: <20171120133222.27771-1-niklas.cassel@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a series that adds:
- PCI endpoint mode support in the ARTPEC-6 driver.
- ARTPEC-7 SoC support in the ARTPEC-6 driver (the SoCs are very similar).
- Small fixes for MSI in designware-ep and designware-host,
  needed to get endpoint mode support working for ARTPEC-6.
- Cleanups in pci-dra7xx to better prepare for endpoint mode in other
  DWC based PCIe drivers.

New in V5:
-Replaced ep->page_size with epc->mem->page_size in patch
 ("PCI: designware-ep: Pre-allocate memory for MSI in dw_pcie_ep_init") and
 in patch ("PCI: designware-ep: Add generic function for raising MSI irq").
-Included a new patch in this patch series:
 ("PCI: dwc: artpec6: Deassert the core before waiting for PHY").

Niklas Cassel (18):
  PCI: dwc: Use the DMA-API to get the MSI address
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
  PCI: dwc: dra7xx: Help compiler to remove unused code
  PCI: dwc: artpec6: Remove unused defines
  PCI: dwc: artpec6: Use BIT and GENMASK macros
  PCI: dwc: artpec6: Split artpec6_pcie_establish_link() into smaller
    functions
  bindings: PCI: artpec: Add support for endpoint mode
  PCI: dwc: artpec6: Add support for endpoint mode
  PCI: dwc: Make cpu_addr_fixup take struct dw_pcie as argument
  PCI: dwc: artpec6: Deassert the core before waiting for PHY
  bindings: PCI: artpec: Add support for the ARTPEC-7 SoC
  PCI: dwc: artpec6: Add support for the ARTPEC-7 SoC

 .../devicetree/bindings/pci/axis,artpec6-pcie.txt  |   5 +-
 drivers/pci/dwc/Kconfig                            |  68 +--
 drivers/pci/dwc/Makefile                           |   4 +-
 drivers/pci/dwc/pci-dra7xx.c                       |  27 +-
 drivers/pci/dwc/pcie-artpec6.c                     | 470 ++++++++++++++++++---
 drivers/pci/dwc/pcie-designware-ep.c               |  59 ++-
 drivers/pci/dwc/pcie-designware-host.c             |  15 +-
 drivers/pci/dwc/pcie-designware.c                  |   2 +-
 drivers/pci/dwc/pcie-designware.h                  |  22 +-
 9 files changed, 554 insertions(+), 118 deletions(-)

-- 
2.14.2
