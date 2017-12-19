Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@axis.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 07/18] PCI: dwc: dra7xx: Refactor Kconfig and Makefile handling for host/ep mode
Date: Wed, 20 Dec 2017 00:29:28 +0100
Message-Id: <20171219232940.659-8-niklas.cassel@axis.com>
In-Reply-To: <20171219232940.659-1-niklas.cassel@axis.com>
References: <20171219232940.659-1-niklas.cassel@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Refactor the Kconfig and Makefile handling for host/ep mode, since
the previous handling was a bit unorthodox and would have been a bit
bloated once more DWC based controllers added support for ep mode.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
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
index 41ba499c96ee..a9d8a6fb48e3 100644
--- a/drivers/pci/dwc/Makefile
+++ b/drivers/pci/dwc/Makefile
@@ -3,9 +3,7 @@ obj-$(CONFIG_PCIE_DW) += pcie-designware.o
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
