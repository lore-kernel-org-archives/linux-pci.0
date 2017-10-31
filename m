Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:52307 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753619AbdJaWkU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2017 18:40:20 -0400
From: Niklas Cassel <niklas.cassel@axis.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Niklas Cassel <niklass@axis.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Dongdong Liu <liudongdong3@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/17] PCI: dwc: dra7xx: Refactor Kconfig and Makefile handling for host/ep mode
Date: Tue, 31 Oct 2017 23:39:25 +0100
Message-Id: <20171031223936.27549-8-niklas.cassel@axis.com>
In-Reply-To: <20171031223936.27549-1-niklas.cassel@axis.com>
References: <20171031223936.27549-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The previous handling was a bit unorthodox and would have been a bit
bloated once more DWC based controllers added support for ep mode.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
V3:
* Added Kishon's ack.

 drivers/pci/dwc/Kconfig  | 45 ++++++++++++++++++++++-----------------------
 drivers/pci/dwc/Makefile |  4 +---
 2 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
index 113e09440f85..3954353e3e2e 100644
--- a/drivers/pci/dwc/Kconfig
+++ b/drivers/pci/dwc/Kconfig
@@ -15,39 +15,38 @@ config PCIE_DW_EP
 	select PCIE_DW
 
 config PCI_DRA7XX
-	bool "TI DRA7xx PCIe controller"
-	depends on SOC_DRA7XX || COMPILE_TEST
-	depends on (PCI && PCI_MSI_IRQ_DOMAIN) || PCI_ENDPOINT
-	depends on OF && HAS_IOMEM && TI_PIPE3
-	help
-	 Enables support for the PCIe controller in the DRA7xx SoC. There
-	 are two instances of PCIe controller in DRA7xx. This controller can
-	 work either as EP or RC. In order to enable host-specific features
-	 PCI_DRA7XX_HOST must be selected and in order to enable device-
-	 specific features PCI_DRA7XX_EP must be selected. This uses
-	 the DesignWare core.
-
-if PCI_DRA7XX
+	bool
 
 config PCI_DRA7XX_HOST
-	bool "PCI DRA7xx Host Mode"
-	depends on PCI
-	depends on PCI_MSI_IRQ_DOMAIN
+	bool "TI DRA7xx PCIe controller Host Mode"
+	depends on SOC_DRA7XX || COMPILE_TEST
+	depends on PCI && PCI_MSI_IRQ_DOMAIN
+	depends on OF && HAS_IOMEM && TI_PIPE3
 	select PCIE_DW_HOST
+	select PCI_DRA7XX
 	default y
 	help
-	 Enables support for the PCIe controller in the DRA7xx SoC to work in
-	 host mode.
+	  Enables support for the PCIe controller in the DRA7xx SoC to work in
+	  host mode. There are two instances of PCIe controller in DRA7xx.
+	  This controller can work either as EP or RC. In order to enable
+	  host-specific features PCI_DRA7XX_HOST must be selected and in order
+	  to enable device-specific features PCI_DRA7XX_EP must be selected.
+	  This uses the DesignWare core.
 
 config PCI_DRA7XX_EP
-	bool "PCI DRA7xx Endpoint Mode"
+	bool "TI DRA7xx PCIe controller Endpoint Mode"
+	depends on SOC_DRA7XX || COMPILE_TEST
 	depends on PCI_ENDPOINT
+	depends on OF && HAS_IOMEM && TI_PIPE3
 	select PCIE_DW_EP
+	select PCI_DRA7XX
 	help
-	 Enables support for the PCIe controller in the DRA7xx SoC to work in
-	 endpoint mode.
-
-endif
+	  Enables support for the PCIe controller in the DRA7xx SoC to work in
+	  endpoint mode. There are two instances of PCIe controller in DRA7xx.
+	  This controller can work either as EP or RC. In order to enable
+	  host-specific features PCI_DRA7XX_HOST must be selected and in order
+	  to enable device-specific features PCI_DRA7XX_EP must be selected.
+	  This uses the DesignWare core.
 
 config PCIE_DW_PLAT
 	bool "Platform bus based DesignWare PCIe Controller"
diff --git a/drivers/pci/dwc/Makefile b/drivers/pci/dwc/Makefile
index 54f56f6e9236..260589bd4e1d 100644
--- a/drivers/pci/dwc/Makefile
+++ b/drivers/pci/dwc/Makefile
@@ -2,9 +2,7 @@ obj-$(CONFIG_PCIE_DW) += pcie-designware.o
 obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
 obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
 obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
-ifneq ($(filter y,$(CONFIG_PCI_DRA7XX_HOST) $(CONFIG_PCI_DRA7XX_EP)),)
-        obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
-endif
+obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
 obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
 obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
 obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
-- 
2.14.2
