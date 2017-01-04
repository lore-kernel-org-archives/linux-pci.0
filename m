Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:54882 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934604AbdADMIt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2017 07:08:49 -0500
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH v2] PCI: add a new directory for designware core
Date: Wed, 4 Jan 2017 17:38:15 +0530
Message-ID: <1483531695-9377-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Group all the PCI drivers that use designware core in dwc directory.
dwc IP is capable of operating in both host mode and device mode and
keeping it inside the *host* directory is misleading.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Changes from v1:
*) instead of renaming *host* directory to *controller* directory,
   move all the dwc drivers to dwc/ directory.
Next Steps:
Split pcie-designware.c to core, host-only and endpoint-only files.

 drivers/pci/Kconfig                              |    1 +
 drivers/pci/Makefile                             |    3 +
 drivers/pci/dwc/Kconfig                          |  108 +++++++++++++++++++++
 drivers/pci/dwc/Makefile                         |   23 +++++
 drivers/pci/{host => dwc}/pci-dra7xx.c           |    0
 drivers/pci/{host => dwc}/pci-exynos.c           |    0
 drivers/pci/{host => dwc}/pci-imx6.c             |    0
 drivers/pci/{host => dwc}/pci-keystone-dw.c      |    0
 drivers/pci/{host => dwc}/pci-keystone.c         |    0
 drivers/pci/{host => dwc}/pci-layerscape.c       |    0
 drivers/pci/{host => dwc}/pcie-armada8k.c        |    0
 drivers/pci/{host => dwc}/pcie-artpec6.c         |    0
 drivers/pci/{host => dwc}/pcie-designware-plat.c |    0
 drivers/pci/{host => dwc}/pcie-designware.c      |    0
 drivers/pci/{host => dwc}/pcie-designware.h      |    0
 drivers/pci/{host => dwc}/pcie-hisi.c            |    0
 drivers/pci/{host => dwc}/pcie-qcom.c            |    0
 drivers/pci/{host => dwc}/pcie-spear13xx.c       |    0
 drivers/pci/host/Kconfig                         |  113 ----------------------
 drivers/pci/host/Makefile                        |   12 ---
 20 files changed, 135 insertions(+), 125 deletions(-)
 create mode 100644 drivers/pci/dwc/Kconfig
 create mode 100644 drivers/pci/dwc/Makefile
 rename drivers/pci/{host => dwc}/pci-dra7xx.c (100%)
 rename drivers/pci/{host => dwc}/pci-exynos.c (100%)
 rename drivers/pci/{host => dwc}/pci-imx6.c (100%)
 rename drivers/pci/{host => dwc}/pci-keystone-dw.c (100%)
 rename drivers/pci/{host => dwc}/pci-keystone.c (100%)
 rename drivers/pci/{host => dwc}/pci-layerscape.c (100%)
 rename drivers/pci/{host => dwc}/pcie-armada8k.c (100%)
 rename drivers/pci/{host => dwc}/pcie-artpec6.c (100%)
 rename drivers/pci/{host => dwc}/pcie-designware-plat.c (100%)
 rename drivers/pci/{host => dwc}/pcie-designware.c (100%)
 rename drivers/pci/{host => dwc}/pcie-designware.h (100%)
 rename drivers/pci/{host => dwc}/pcie-hisi.c (100%)
 rename drivers/pci/{host => dwc}/pcie-qcom.c (100%)
 rename drivers/pci/{host => dwc}/pcie-spear13xx.c (100%)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 6555eb7..df14142 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -132,4 +132,5 @@ config PCI_HYPERV
           PCI devices from a PCI backend to support PCI driver domains.
 
 source "drivers/pci/hotplug/Kconfig"
+source "drivers/pci/dwc/Kconfig"
 source "drivers/pci/host/Kconfig"
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 8db5079..b7e9751 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -66,5 +66,8 @@ obj-$(CONFIG_OF) += of.o
 
 ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
 
+# PCI dwc controller drivers
+obj-y += dwc/
+
 # PCI host controller drivers
 obj-y += host/
diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
new file mode 100644
index 0000000..3144a06
--- /dev/null
+++ b/drivers/pci/dwc/Kconfig
@@ -0,0 +1,108 @@
+menuconfig PCIE_DW
+	bool "DesignWare PCI Core Support"
+	depends on PCI
+	depends on PCI_MSI_IRQ_DOMAIN
+        help
+	 Say Y if your system has Designware PCI core
+
+if PCIE_DW
+
+config PCI_DRA7XX
+	bool "TI DRA7xx PCIe controller"
+	depends on OF && HAS_IOMEM && TI_PIPE3
+	depends on PCI_MSI_IRQ_DOMAIN
+	help
+	 Enables support for the PCIe controller in the DRA7xx SoC.  There
+	 are two instances of PCIe controller in DRA7xx.  This controller can
+	 act both as EP and RC.  This reuses the Designware core.
+
+config PCIE_DW_PLAT
+	bool "Platform bus based DesignWare PCIe Controller"
+	depends on PCI_MSI_IRQ_DOMAIN
+	---help---
+	 This selects the DesignWare PCIe controller support. Select this if
+	 you have a PCIe controller on Platform bus.
+
+	 If you have a controller with this interface, say Y or M here.
+
+	 If unsure, say N.
+
+config PCI_EXYNOS
+	bool "Samsung Exynos PCIe controller"
+	depends on SOC_EXYNOS5440
+	depends on PCI_MSI_IRQ_DOMAIN
+	select PCIEPORTBUS
+
+config PCI_IMX6
+	bool "Freescale i.MX6 PCIe controller"
+	depends on SOC_IMX6Q
+	depends on PCI_MSI_IRQ_DOMAIN
+	select PCIEPORTBUS
+
+config PCIE_SPEAR13XX
+	bool "STMicroelectronics SPEAr PCIe controller"
+	depends on ARCH_SPEAR13XX
+	depends on PCI_MSI_IRQ_DOMAIN
+	select PCIEPORTBUS
+	help
+	  Say Y here if you want PCIe support on SPEAr13XX SoCs.
+
+config PCI_KEYSTONE
+	bool "TI Keystone PCIe controller"
+	depends on ARCH_KEYSTONE
+	depends on PCI_MSI_IRQ_DOMAIN
+	select PCIEPORTBUS
+	help
+	  Say Y here if you want to enable PCI controller support on Keystone
+	  SoCs. The PCI controller on Keystone is based on Designware hardware
+	  and therefore the driver re-uses the Designware core functions to
+	  implement the driver.
+
+config PCI_LAYERSCAPE
+	bool "Freescale Layerscape PCIe controller"
+	depends on OF && (ARM || ARCH_LAYERSCAPE)
+	depends on PCI_MSI_IRQ_DOMAIN
+	select MFD_SYSCON
+	help
+	  Say Y here if you want PCIe controller support on Layerscape SoCs.
+
+config PCI_HISI
+	depends on OF && ARM64
+	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
+	depends on PCI_MSI_IRQ_DOMAIN
+	select PCIEPORTBUS
+	help
+	  Say Y here if you want PCIe controller support on HiSilicon
+	  Hip05 and Hip06 SoCs
+
+config PCIE_QCOM
+	bool "Qualcomm PCIe controller"
+	depends on ARCH_QCOM && OF
+	depends on PCI_MSI_IRQ_DOMAIN
+	select PCIEPORTBUS
+	help
+	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
+	  PCIe controller uses the Designware core plus Qualcomm-specific
+	  hardware wrappers.
+
+config PCIE_ARMADA_8K
+	bool "Marvell Armada-8K PCIe controller"
+	depends on ARCH_MVEBU
+	depends on PCI_MSI_IRQ_DOMAIN
+	select PCIEPORTBUS
+	help
+	  Say Y here if you want to enable PCIe controller support on
+	  Armada-8K SoCs. The PCIe controller on Armada-8K is based on
+	  Designware hardware and therefore the driver re-uses the
+	  Designware core functions to implement the driver.
+
+config PCIE_ARTPEC6
+	bool "Axis ARTPEC-6 PCIe controller"
+	depends on MACH_ARTPEC6
+	depends on PCI_MSI_IRQ_DOMAIN
+	select PCIEPORTBUS
+	help
+	  Say Y here to enable PCIe controller support on Axis ARTPEC-6
+	  SoCs.  This PCIe controller uses the DesignWare core.
+
+endif
diff --git a/drivers/pci/dwc/Makefile b/drivers/pci/dwc/Makefile
new file mode 100644
index 0000000..7d27c14
--- /dev/null
+++ b/drivers/pci/dwc/Makefile
@@ -0,0 +1,23 @@
+obj-$(CONFIG_PCIE_DW) += pcie-designware.o
+obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
+obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
+obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
+obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
+obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
+obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o pci-keystone.o
+obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
+obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
+obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
+obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
+
+# The following drivers are for devices that use the generic ACPI
+# pci_root.c driver but don't support standard ECAM config access.
+# They contain MCFG quirks to replace the generic ECAM accessors with
+# device-specific ones that are shared with the DT driver.
+
+# The ACPI driver is generic and should not require driver-specific
+# config options to be enabled, so we always build these drivers on
+# ARM64 and use internal ifdefs to only build the pieces we need
+# depending on whether ACPI, the DT driver, or both are enabled.
+
+obj-$(CONFIG_ARM64) += pcie-hisi.o
diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
similarity index 100%
rename from drivers/pci/host/pci-dra7xx.c
rename to drivers/pci/dwc/pci-dra7xx.c
diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
similarity index 100%
rename from drivers/pci/host/pci-exynos.c
rename to drivers/pci/dwc/pci-exynos.c
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
similarity index 100%
rename from drivers/pci/host/pci-imx6.c
rename to drivers/pci/dwc/pci-imx6.c
diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/dwc/pci-keystone-dw.c
similarity index 100%
rename from drivers/pci/host/pci-keystone-dw.c
rename to drivers/pci/dwc/pci-keystone-dw.c
diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/dwc/pci-keystone.c
similarity index 100%
rename from drivers/pci/host/pci-keystone.c
rename to drivers/pci/dwc/pci-keystone.c
diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
similarity index 100%
rename from drivers/pci/host/pci-layerscape.c
rename to drivers/pci/dwc/pci-layerscape.c
diff --git a/drivers/pci/host/pcie-armada8k.c b/drivers/pci/dwc/pcie-armada8k.c
similarity index 100%
rename from drivers/pci/host/pcie-armada8k.c
rename to drivers/pci/dwc/pcie-armada8k.c
diff --git a/drivers/pci/host/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
similarity index 100%
rename from drivers/pci/host/pcie-artpec6.c
rename to drivers/pci/dwc/pcie-artpec6.c
diff --git a/drivers/pci/host/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
similarity index 100%
rename from drivers/pci/host/pcie-designware-plat.c
rename to drivers/pci/dwc/pcie-designware-plat.c
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
similarity index 100%
rename from drivers/pci/host/pcie-designware.c
rename to drivers/pci/dwc/pcie-designware.c
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
similarity index 100%
rename from drivers/pci/host/pcie-designware.h
rename to drivers/pci/dwc/pcie-designware.h
diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
similarity index 100%
rename from drivers/pci/host/pcie-hisi.c
rename to drivers/pci/dwc/pcie-hisi.c
diff --git a/drivers/pci/host/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
similarity index 100%
rename from drivers/pci/host/pcie-qcom.c
rename to drivers/pci/dwc/pcie-qcom.c
diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/dwc/pcie-spear13xx.c
similarity index 100%
rename from drivers/pci/host/pcie-spear13xx.c
rename to drivers/pci/dwc/pcie-spear13xx.c
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 898d2c4..f7c1d4d 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -1,16 +1,6 @@
 menu "PCI host controller drivers"
 	depends on PCI
 
-config PCI_DRA7XX
-	bool "TI DRA7xx PCIe controller"
-	depends on OF && HAS_IOMEM && TI_PIPE3
-	depends on PCI_MSI_IRQ_DOMAIN
-	select PCIE_DW
-	help
-	 Enables support for the PCIe controller in the DRA7xx SoC.  There
-	 are two instances of PCIe controller in DRA7xx.  This controller can
-	 act both as EP and RC.  This reuses the Designware core.
-
 config PCI_MVEBU
 	bool "Marvell EBU PCIe controller"
 	depends on ARCH_MVEBU || ARCH_DOVE
@@ -37,36 +27,6 @@ config PCIE_XILINX_NWL
 	 or End Point. The current option selection will only
 	 support root port enabling.
 
-config PCIE_DW_PLAT
-	bool "Platform bus based DesignWare PCIe Controller"
-	depends on PCI_MSI_IRQ_DOMAIN
-	select PCIE_DW
-	---help---
-	 This selects the DesignWare PCIe controller support. Select this if
-	 you have a PCIe controller on Platform bus.
-
-	 If you have a controller with this interface, say Y or M here.
-
-	 If unsure, say N.
-
-config PCIE_DW
-	bool
-	depends on PCI_MSI_IRQ_DOMAIN
-
-config PCI_EXYNOS
-	bool "Samsung Exynos PCIe controller"
-	depends on SOC_EXYNOS5440
-	depends on PCI_MSI_IRQ_DOMAIN
-	select PCIEPORTBUS
-	select PCIE_DW
-
-config PCI_IMX6
-	bool "Freescale i.MX6 PCIe controller"
-	depends on SOC_IMX6Q
-	depends on PCI_MSI_IRQ_DOMAIN
-	select PCIEPORTBUS
-	select PCIE_DW
-
 config PCI_TEGRA
 	bool "NVIDIA Tegra PCIe controller"
 	depends on ARCH_TEGRA
@@ -103,27 +63,6 @@ config PCI_HOST_GENERIC
 	  Say Y here if you want to support a simple generic PCI host
 	  controller, such as the one emulated by kvmtool.
 
-config PCIE_SPEAR13XX
-	bool "STMicroelectronics SPEAr PCIe controller"
-	depends on ARCH_SPEAR13XX
-	depends on PCI_MSI_IRQ_DOMAIN
-	select PCIEPORTBUS
-	select PCIE_DW
-	help
-	  Say Y here if you want PCIe support on SPEAr13XX SoCs.
-
-config PCI_KEYSTONE
-	bool "TI Keystone PCIe controller"
-	depends on ARCH_KEYSTONE
-	depends on PCI_MSI_IRQ_DOMAIN
-	select PCIE_DW
-	select PCIEPORTBUS
-	help
-	  Say Y here if you want to enable PCI controller support on Keystone
-	  SoCs. The PCI controller on Keystone is based on Designware hardware
-	  and therefore the driver re-uses the Designware core functions to
-	  implement the driver.
-
 config PCIE_XILINX
 	bool "Xilinx AXI PCIe host bridge support"
 	depends on ARCH_ZYNQ || MICROBLAZE
@@ -150,15 +89,6 @@ config PCI_XGENE_MSI
 	  Say Y here if you want PCIe MSI support for the APM X-Gene v1 SoC.
 	  This MSI driver supports 5 PCIe ports on the APM X-Gene v1 SoC.
 
-config PCI_LAYERSCAPE
-	bool "Freescale Layerscape PCIe controller"
-	depends on OF && (ARM || ARCH_LAYERSCAPE)
-	depends on PCI_MSI_IRQ_DOMAIN
-	select PCIE_DW
-	select MFD_SYSCON
-	help
-	  Say Y here if you want PCIe controller support on Layerscape SoCs.
-
 config PCI_VERSATILE
 	bool "ARM Versatile PB PCI controller"
 	depends on ARCH_VERSATILE
@@ -217,27 +147,6 @@ config PCIE_ALTERA_MSI
 	  Say Y here if you want PCIe MSI support for the Altera FPGA.
 	  This MSI driver supports Altera MSI to GIC controller IP.
 
-config PCI_HISI
-	depends on OF && ARM64
-	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
-	depends on PCI_MSI_IRQ_DOMAIN
-	select PCIEPORTBUS
-	select PCIE_DW
-	help
-	  Say Y here if you want PCIe controller support on HiSilicon
-	  Hip05 and Hip06 SoCs
-
-config PCIE_QCOM
-	bool "Qualcomm PCIe controller"
-	depends on ARCH_QCOM && OF
-	depends on PCI_MSI_IRQ_DOMAIN
-	select PCIE_DW
-	select PCIEPORTBUS
-	help
-	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
-	  PCIe controller uses the Designware core plus Qualcomm-specific
-	  hardware wrappers.
-
 config PCI_HOST_THUNDER_PEM
 	bool "Cavium Thunder PCIe controller to off-chip devices"
 	depends on ARM64
@@ -254,28 +163,6 @@ config PCI_HOST_THUNDER_ECAM
 	help
 	  Say Y here if you want ECAM support for CN88XX-Pass-1.x Cavium Thunder SoCs.
 
-config PCIE_ARMADA_8K
-	bool "Marvell Armada-8K PCIe controller"
-	depends on ARCH_MVEBU
-	depends on PCI_MSI_IRQ_DOMAIN
-	select PCIE_DW
-	select PCIEPORTBUS
-	help
-	  Say Y here if you want to enable PCIe controller support on
-	  Armada-8K SoCs. The PCIe controller on Armada-8K is based on
-	  Designware hardware and therefore the driver re-uses the
-	  Designware core functions to implement the driver.
-
-config PCIE_ARTPEC6
-	bool "Axis ARTPEC-6 PCIe controller"
-	depends on MACH_ARTPEC6
-	depends on PCI_MSI_IRQ_DOMAIN
-	select PCIE_DW
-	select PCIEPORTBUS
-	help
-	  Say Y here to enable PCIe controller support on Axis ARTPEC-6
-	  SoCs.  This PCIe controller uses the DesignWare core.
-
 config PCIE_ROCKCHIP
 	bool "Rockchip PCIe controller"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index bfe3179..4d36866 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -1,8 +1,3 @@
-obj-$(CONFIG_PCIE_DW) += pcie-designware.o
-obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
-obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
-obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
-obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
 obj-$(CONFIG_PCI_HYPERV) += pci-hyperv.o
 obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
 obj-$(CONFIG_PCI_AARDVARK) += pci-aardvark.o
@@ -11,12 +6,9 @@ obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
 obj-$(CONFIG_PCIE_RCAR) += pcie-rcar.o
 obj-$(CONFIG_PCI_HOST_COMMON) += pci-host-common.o
 obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
-obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
-obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o pci-keystone.o
 obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
 obj-$(CONFIG_PCIE_XILINX_NWL) += pcie-xilinx-nwl.o
 obj-$(CONFIG_PCI_XGENE_MSI) += pci-xgene-msi.o
-obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
 obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
 obj-$(CONFIG_PCIE_IPROC) += pcie-iproc.o
 obj-$(CONFIG_PCIE_IPROC_MSI) += pcie-iproc-msi.o
@@ -24,9 +16,6 @@ obj-$(CONFIG_PCIE_IPROC_PLATFORM) += pcie-iproc-platform.o
 obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
 obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
 obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
-obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
-obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
-obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
 obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
 obj-$(CONFIG_VMD) += vmd.o
 
@@ -40,7 +29,6 @@ obj-$(CONFIG_VMD) += vmd.o
 # ARM64 and use internal ifdefs to only build the pieces we need
 # depending on whether ACPI, the DT driver, or both are enabled.
 
-obj-$(CONFIG_ARM64) += pcie-hisi.o
 obj-$(CONFIG_ARM64) += pci-thunder-ecam.o
 obj-$(CONFIG_ARM64) += pci-thunder-pem.o
 obj-$(CONFIG_ARM64) += pci-xgene.o
-- 
1.7.9.5

