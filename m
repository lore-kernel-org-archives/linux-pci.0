Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:57406 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965366AbdAKMHO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2017 07:07:14 -0500
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH 1/5] PCI: dwc: Add COMPILE_TEST to all designware based drivers
Date: Wed, 11 Jan 2017 17:36:51 +0530
Message-ID: <1484136415-20798-2-git-send-email-kishon@ti.com>
In-Reply-To: <1484136415-20798-1-git-send-email-kishon@ti.com>
References: <1484136415-20798-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add COMPILE_TEST to all designware based drivers so that it is possible
to perform compile test even when a particular architecture specific
config symbol is not set.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/Kconfig |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
index deae261..8b08519 100644
--- a/drivers/pci/dwc/Kconfig
+++ b/drivers/pci/dwc/Kconfig
@@ -29,21 +29,21 @@ config PCIE_DW_PLAT
 
 config PCI_EXYNOS
 	bool "Samsung Exynos PCIe controller"
-	depends on SOC_EXYNOS5440
+	depends on SOC_EXYNOS5440 || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	select PCIE_DW
 
 config PCI_IMX6
 	bool "Freescale i.MX6 PCIe controller"
-	depends on SOC_IMX6Q
+	depends on SOC_IMX6Q || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	select PCIE_DW
 
 config PCIE_SPEAR13XX
 	bool "STMicroelectronics SPEAr PCIe controller"
-	depends on ARCH_SPEAR13XX
+	depends on ARCH_SPEAR13XX || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	select PCIE_DW
@@ -52,7 +52,7 @@ config PCIE_SPEAR13XX
 
 config PCI_KEYSTONE
 	bool "TI Keystone PCIe controller"
-	depends on ARCH_KEYSTONE
+	depends on ARCH_KEYSTONE || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	select PCIE_DW
@@ -64,7 +64,7 @@ config PCI_KEYSTONE
 
 config PCI_LAYERSCAPE
 	bool "Freescale Layerscape PCIe controller"
-	depends on OF && (ARM || ARCH_LAYERSCAPE)
+	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
 	select MFD_SYSCON
 	select PCIE_DW
@@ -83,7 +83,7 @@ config PCI_HISI
 
 config PCIE_QCOM
 	bool "Qualcomm PCIe controller"
-	depends on ARCH_QCOM && OF
+	depends on (ARCH_QCOM || COMPILE_TEST) && OF
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	select PCIE_DW
@@ -94,7 +94,7 @@ config PCIE_QCOM
 
 config PCIE_ARMADA_8K
 	bool "Marvell Armada-8K PCIe controller"
-	depends on ARCH_MVEBU
+	depends on ARCH_MVEBU || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	select PCIE_DW
@@ -106,7 +106,7 @@ config PCIE_ARMADA_8K
 
 config PCIE_ARTPEC6
 	bool "Axis ARTPEC-6 PCIe controller"
-	depends on MACH_ARTPEC6
+	depends on MACH_ARTPEC6 || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	select PCIE_DW
-- 
1.7.9.5

