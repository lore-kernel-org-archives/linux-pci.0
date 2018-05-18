Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH] PCI: Remove host driver Kconfig selection of
 CONFIG_PCIEPORTBUS
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-kernel@vger.kernel.org
Date: Fri, 18 May 2018 17:31:07 -0500
Message-ID: <152668266782.118010.15462515170612275250.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Host bridge drivers do not use the portdrv interfaces (struct pcie_device,
struct pcie_port_service_driver, pcie_port_service_register(), etc), and
they should not select CONFIG_PCIEPORTBUS.

If users need the portdrv services, they can select CONFIG_PCIEPORTBUS just
like all other PCI users.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/dwc/Kconfig  |   10 ----------
 drivers/pci/host/Kconfig |    2 --
 2 files changed, 12 deletions(-)

diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
index 2f3f5c50aa48..678390a77ba1 100644
--- a/drivers/pci/dwc/Kconfig
+++ b/drivers/pci/dwc/Kconfig
@@ -68,7 +68,6 @@ config PCI_EXYNOS
 	depends on PCI
 	depends on SOC_EXYNOS5440
 	depends on PCI_MSI_IRQ_DOMAIN
-	select PCIEPORTBUS
 	select PCIE_DW_HOST
 
 config PCI_IMX6
@@ -76,7 +75,6 @@ config PCI_IMX6
 	depends on PCI
 	depends on SOC_IMX6Q
 	depends on PCI_MSI_IRQ_DOMAIN
-	select PCIEPORTBUS
 	select PCIE_DW_HOST
 
 config PCIE_SPEAR13XX
@@ -84,7 +82,6 @@ config PCIE_SPEAR13XX
 	depends on PCI
 	depends on ARCH_SPEAR13XX
 	depends on PCI_MSI_IRQ_DOMAIN
-	select PCIEPORTBUS
 	select PCIE_DW_HOST
 	help
 	  Say Y here if you want PCIe support on SPEAr13XX SoCs.
@@ -94,7 +91,6 @@ config PCI_KEYSTONE
 	depends on PCI
 	depends on ARCH_KEYSTONE
 	depends on PCI_MSI_IRQ_DOMAIN
-	select PCIEPORTBUS
 	select PCIE_DW_HOST
 	help
 	  Say Y here if you want to enable PCI controller support on Keystone
@@ -117,7 +113,6 @@ config PCI_HISI
 	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
 	depends on PCI
 	depends on PCI_MSI_IRQ_DOMAIN
-	select PCIEPORTBUS
 	select PCIE_DW_HOST
 	select PCI_HOST_COMMON
 	help
@@ -129,7 +124,6 @@ config PCIE_QCOM
 	depends on PCI
 	depends on ARCH_QCOM && OF
 	depends on PCI_MSI_IRQ_DOMAIN
-	select PCIEPORTBUS
 	select PCIE_DW_HOST
 	help
 	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
@@ -141,7 +135,6 @@ config PCIE_ARMADA_8K
 	depends on PCI
 	depends on ARCH_MVEBU
 	depends on PCI_MSI_IRQ_DOMAIN
-	select PCIEPORTBUS
 	select PCIE_DW_HOST
 	help
 	  Say Y here if you want to enable PCIe controller support on
@@ -156,7 +149,6 @@ config PCIE_ARTPEC6_HOST
 	bool "Axis ARTPEC-6 PCIe controller Host Mode"
 	depends on MACH_ARTPEC6
 	depends on PCI && PCI_MSI_IRQ_DOMAIN
-	select PCIEPORTBUS
 	select PCIE_DW_HOST
 	select PCIE_ARTPEC6
 	help
@@ -178,7 +170,6 @@ config PCIE_KIRIN
 	bool "HiSilicon Kirin series SoCs PCIe controllers"
 	depends on PCI_MSI_IRQ_DOMAIN
 	depends on PCI
-	select PCIEPORTBUS
 	select PCIE_DW_HOST
 	help
 	  Say Y here if you want PCIe controller support
@@ -189,7 +180,6 @@ config PCIE_HISI_STB
 	depends on ARCH_HISI
 	depends on PCI
 	depends on PCI_MSI_IRQ_DOMAIN
-	select PCIEPORTBUS
 	select PCIE_DW_HOST
 	help
           Say Y here if you want PCIe controller support on HiSilicon STB SoCs
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 0d0177ce436c..90f0cc9dfd95 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -83,7 +83,6 @@ config PCI_XGENE
 	bool "X-Gene PCIe controller"
 	depends on ARM64
 	depends on OF || (ACPI && PCI_QUIRKS)
-	select PCIEPORTBUS
 	help
 	  Say Y here if you want internal PCI support on APM X-Gene SoC.
 	  There are 5 internal PCIe ports available. Each port is GEN3 capable
@@ -194,7 +193,6 @@ config PCIE_MEDIATEK
 	depends on (ARM || ARM64) && (ARCH_MEDIATEK || COMPILE_TEST)
 	depends on OF
 	depends on PCI
-	select PCIEPORTBUS
 	help
 	  Say Y here if you want to enable PCIe controller support on
 	  MediaTek SoCs.
