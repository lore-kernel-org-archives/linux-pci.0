Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:52183 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbdJMQJ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Oct 2017 12:09:27 -0400
From: Niklas Cassel <niklas.cassel@axis.com>
To: linux-arm-kernel@axis.com, linux-pci@vger.kernel.org,
        linux-omap@vger.kernel.org
Cc: Niklas Cassel <niklass@axis.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] dwc MSI fixes, ARTPEC-6 EP mode support, ARTPEC-7 SoC support
Date: Fri, 13 Oct 2017 18:09:03 +0200
Message-Id: <20171013160914.3220-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a series that adds:
- PCI endpoint mode support in the ARTPEC-6 driver.
- ARTPEC-7 SoC support in the ARTPEC-6 driver (the SoCs are very similar).
- Small fixes for MSI in designware-ep and designware-host,
  needed to get endpoint mode support working for ARTPEC-6.

Niklas Cassel (10):
  PCI: dwc: use DMA-API for allocating MSI data
  PCI: designware-ep: set_msi should only set MMC bits
  PCI: designware-ep: read-only registers need DBI_RO_WR_EN to be
    writable
  PCI: designware-ep: pre-allocate memory for MSI in dw_pcie_ep_init
  PCI: artpec6: remove unused defines
  PCI: dwc: artpec6: use BIT and GENMASK macros
  PCI: dwc: artpec6: split artpec6_pcie_establish_link to smaller
    functions
  PCI: dwc: artpec6: add support for endpoint mode
  PCI: dwc: make cpu_addr_fixup take struct dw_pcie as argument
  PCI: dwc: artpec6: add support for the ARTPEC-7 SoC

 .../devicetree/bindings/pci/axis,artpec6-pcie.txt  |   5 +-
 drivers/pci/dwc/Kconfig                            |  41 +-
 drivers/pci/dwc/Makefile                           |   4 +-
 drivers/pci/dwc/pci-dra7xx.c                       |   2 +-
 drivers/pci/dwc/pcie-artpec6.c                     | 482 +++++++++++++++++++--
 drivers/pci/dwc/pcie-designware-ep.c               |  20 +-
 drivers/pci/dwc/pcie-designware-host.c             |  23 +-
 drivers/pci/dwc/pcie-designware.c                  |   2 +-
 drivers/pci/dwc/pcie-designware.h                  |   8 +-
 9 files changed, 514 insertions(+), 73 deletions(-)

-- 
2.11.0
