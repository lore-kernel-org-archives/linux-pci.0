Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pci: dwc: hisi needs PCI_HOST_COMMON
Date: Tue, 21 Mar 2017 15:32:11 +0100
Message-Id: <20170321143229.3372903-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Without PCI_HOST_COMMON support enabled, we get a link error:

drivers/pci/dwc/built-in.o: In function `hisi_pcie_map_bus':
pcie-hisi.c:(.text+0x8860): undefined reference to `pci_ecam_map_bus'
drivers/pci/dwc/built-in.o: In function `hisi_pcie_almost_ecam_probe':
pcie-hisi.c:(.text+0x88b4): undefined reference to `pci_host_common_probe'

This adds an explicit 'select', as the other users have.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/dwc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
index dfb8a69afc28..d2d2ba5b8a68 100644
--- a/drivers/pci/dwc/Kconfig
+++ b/drivers/pci/dwc/Kconfig
@@ -89,6 +89,7 @@ config PCI_HISI
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	select PCIE_DW_HOST
+	select PCI_HOST_COMMON
 	help
 	  Say Y here if you want PCIe controller support on HiSilicon
 	  Hip05 and Hip06 SoCs
-- 
2.9.0
