Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:43080 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbeEKRPc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 May 2018 13:15:32 -0400
Received: by mail-ot0-f195.google.com with SMTP id y10-v6so7027792otg.10
        for <linux-pci@vger.kernel.org>; Fri, 11 May 2018 10:15:32 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Ley Foon Tan <lftan@altera.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 1/2] PCI: dwc: move CONFIG_PCI depends to menu
Date: Fri, 11 May 2018 12:15:29 -0500
Message-Id: <20180511171530.16068-1-robh@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There's no need for every config option to explicitly depend on
CONFIG_PCI, so move it out of individual option to the menu option.

Acked-by: Jingoo Han <jingoohan1@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Looks like these 2 patches slipped thru the cracks.

 drivers/pci/dwc/Kconfig | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
index 2f3f5c50aa48..8c1a5167fb5b 100644
--- a/drivers/pci/dwc/Kconfig
+++ b/drivers/pci/dwc/Kconfig
@@ -1,13 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
 
 menu "DesignWare PCI Core Support"
+	depends on PCI
 
 config PCIE_DW
 	bool
 
 config PCIE_DW_HOST
         bool
-	depends on PCI
 	depends on PCI_MSI_IRQ_DOMAIN
         select PCIE_DW
 
@@ -22,7 +22,7 @@ config PCI_DRA7XX
 config PCI_DRA7XX_HOST
 	bool "TI DRA7xx PCIe controller Host Mode"
 	depends on SOC_DRA7XX || COMPILE_TEST
-	depends on PCI && PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI_IRQ_DOMAIN
 	depends on OF && HAS_IOMEM && TI_PIPE3
 	select PCIE_DW_HOST
 	select PCI_DRA7XX
@@ -52,7 +52,6 @@ config PCI_DRA7XX_EP
 
 config PCIE_DW_PLAT
 	bool "Platform bus based DesignWare PCIe Controller"
-	depends on PCI
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	---help---
@@ -65,7 +64,6 @@ config PCIE_DW_PLAT
 
 config PCI_EXYNOS
 	bool "Samsung Exynos PCIe controller"
-	depends on PCI
 	depends on SOC_EXYNOS5440
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
@@ -73,7 +71,6 @@ config PCI_EXYNOS
 
 config PCI_IMX6
 	bool "Freescale i.MX6 PCIe controller"
-	depends on PCI
 	depends on SOC_IMX6Q
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
@@ -81,7 +78,6 @@ config PCI_IMX6
 
 config PCIE_SPEAR13XX
 	bool "STMicroelectronics SPEAr PCIe controller"
-	depends on PCI
 	depends on ARCH_SPEAR13XX
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
@@ -91,7 +87,6 @@ config PCIE_SPEAR13XX
 
 config PCI_KEYSTONE
 	bool "TI Keystone PCIe controller"
-	depends on PCI
 	depends on ARCH_KEYSTONE
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
@@ -104,7 +99,6 @@ config PCI_KEYSTONE
 
 config PCI_LAYERSCAPE
 	bool "Freescale Layerscape PCIe controller"
-	depends on PCI
 	depends on OF && (ARM || ARCH_LAYERSCAPE)
 	depends on PCI_MSI_IRQ_DOMAIN
 	select MFD_SYSCON
@@ -115,7 +109,6 @@ config PCI_LAYERSCAPE
 config PCI_HISI
 	depends on OF && ARM64
 	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
-	depends on PCI
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	select PCIE_DW_HOST
@@ -126,7 +119,6 @@ config PCI_HISI
 
 config PCIE_QCOM
 	bool "Qualcomm PCIe controller"
-	depends on PCI
 	depends on ARCH_QCOM && OF
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
@@ -138,7 +130,6 @@ config PCIE_QCOM
 
 config PCIE_ARMADA_8K
 	bool "Marvell Armada-8K PCIe controller"
-	depends on PCI
 	depends on ARCH_MVEBU
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
@@ -155,7 +146,7 @@ config PCIE_ARTPEC6
 config PCIE_ARTPEC6_HOST
 	bool "Axis ARTPEC-6 PCIe controller Host Mode"
 	depends on MACH_ARTPEC6
-	depends on PCI && PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	select PCIE_DW_HOST
 	select PCIE_ARTPEC6
@@ -177,7 +168,6 @@ config PCIE_KIRIN
 	depends on OF && ARM64
 	bool "HiSilicon Kirin series SoCs PCIe controllers"
 	depends on PCI_MSI_IRQ_DOMAIN
-	depends on PCI
 	select PCIEPORTBUS
 	select PCIE_DW_HOST
 	help
@@ -187,7 +177,6 @@ config PCIE_KIRIN
 config PCIE_HISI_STB
 	bool "HiSilicon STB SoCs PCIe controllers"
 	depends on ARCH_HISI
-	depends on PCI
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	select PCIE_DW_HOST
-- 
2.17.0
