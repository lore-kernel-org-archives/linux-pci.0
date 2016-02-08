Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:51098 "EHLO mail5.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754041AbcBHABc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 7 Feb 2016 19:01:32 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ley Foon Tan <lftan@altera.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, <linux-pci@vger.kernel.org>,
	<linux-arm-msm@vger.kernel.org>
Subject: [PATCH 5/5] drivers/pci: make most of the PCI_DW drivers modular
Date: Sun, 7 Feb 2016 19:00:44 -0500
Message-ID: <1454889644-27830-6-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1454889644-27830-1-git-send-email-paul.gortmaker@windriver.com>
References: <1454889644-27830-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We've exported the symbols that we know these specific drivers
will need as tristate, so now we can make the conversion from
bool to tristate w/o concern for build regressions.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ley Foon Tan <lftan@altera.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/host/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index b040ad7ba44d..f3020389ddaa 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -2,7 +2,7 @@ menu "PCI host controller drivers"
 	depends on PCI
 
 config PCI_DRA7XX
-	bool "TI DRA7xx PCIe controller"
+	tristate "TI DRA7xx PCIe controller"
 	select PCIE_DW
 	depends on OF && HAS_IOMEM && TI_PIPE3
 	depends on BROKEN
@@ -20,13 +20,13 @@ config PCIE_DW
 	bool
 
 config PCI_EXYNOS
-	bool "Samsung Exynos PCIe controller"
+	tristate "Samsung Exynos PCIe controller"
 	depends on SOC_EXYNOS5440
 	select PCIEPORTBUS
 	select PCIE_DW
 
 config PCI_IMX6
-	bool "Freescale i.MX6 PCIe controller"
+	tristate "Freescale i.MX6 PCIe controller"
 	depends on SOC_IMX6Q
 	select PCIEPORTBUS
 	select PCIE_DW
@@ -61,7 +61,7 @@ config PCI_HOST_GENERIC
 	  controller, such as the one emulated by kvmtool.
 
 config PCIE_SPEAR13XX
-	bool "STMicroelectronics SPEAr PCIe controller"
+	tristate "STMicroelectronics SPEAr PCIe controller"
 	depends on ARCH_SPEAR13XX
 	select PCIEPORTBUS
 	select PCIE_DW
@@ -106,7 +106,7 @@ config PCI_XGENE_MSI
 	  This MSI driver supports 5 PCIe ports on the APM X-Gene v1 SoC.
 
 config PCI_LAYERSCAPE
-	bool "Freescale Layerscape PCIe controller"
+	tristate "Freescale Layerscape PCIe controller"
 	depends on OF && (ARM || ARCH_LAYERSCAPE)
 	select PCIE_DW
 	select MFD_SYSCON
@@ -174,7 +174,7 @@ config PCIE_ALTERA_MSI
 
 config PCI_HISI
 	depends on OF && ARM64
-	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
+	tristate "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
 	select PCIEPORTBUS
 	select PCIE_DW
 	help
@@ -182,7 +182,7 @@ config PCI_HISI
 	  Hip05 and Hip06 SoCs
 
 config PCIE_QCOM
-	bool "Qualcomm PCIe controller"
+	tristate "Qualcomm PCIe controller"
 	depends on ARCH_QCOM && OF
 	select PCIE_DW
 	select PCIEPORTBUS
-- 
2.6.1

