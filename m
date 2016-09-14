Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([198.47.19.12]:39427 "EHLO arroyo.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759121AbcINFOI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Sep 2016 01:14:08 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Jingoo Han <jingoohan1@gmail.com>, <hch@infradead.org>,
        <Joao.Pinto@synopsys.com>, <mingkai.hu@nxp.com>,
        <m-karicheri2@ti.com>, Pratyush Anand <pratyush.anand@gmail.com>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Joao Pinto <jpinto@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>, <kishon@ti.com>,
        <nsekhar@ti.com>
Subject: [RFC PATCH 05/11] pci: rename *host* directory to *controller*
Date: Wed, 14 Sep 2016 10:42:01 +0530
Message-ID: <1473829927-20466-6-git-send-email-kishon@ti.com>
In-Reply-To: <1473829927-20466-1-git-send-email-kishon@ti.com>
References: <1473829927-20466-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No functional change. Renamed the *host* directory present inside
drivers/pci to *controller*. Some of the controllers present in
drivers/pci/host is capable of operating in endpoint mode.
So having these drivers in *host* directory might not be appropriate.
This is in preparation for adding endpoint mode support for some of
controller drivers present here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 MAINTAINERS                                        |   50 ++++++++++----------
 drivers/Makefile                                   |    3 ++
 drivers/pci/Kconfig                                |    2 +-
 drivers/pci/Makefile                               |    3 --
 drivers/pci/{host => controller}/Kconfig           |   35 +++++++++++++-
 drivers/pci/{host => controller}/Makefile          |    0
 drivers/pci/{host => controller}/pci-aardvark.c    |    0
 drivers/pci/{host => controller}/pci-dra7xx.c      |    0
 drivers/pci/{host => controller}/pci-exynos.c      |    0
 drivers/pci/{host => controller}/pci-host-common.c |    0
 .../pci/{host => controller}/pci-host-generic.c    |    0
 drivers/pci/{host => controller}/pci-hyperv.c      |    0
 drivers/pci/{host => controller}/pci-imx6.c        |    0
 drivers/pci/{host => controller}/pci-keystone-dw.c |    0
 drivers/pci/{host => controller}/pci-keystone.c    |    0
 drivers/pci/{host => controller}/pci-keystone.h    |    0
 drivers/pci/{host => controller}/pci-layerscape.c  |    0
 drivers/pci/{host => controller}/pci-mvebu.c       |    0
 drivers/pci/{host => controller}/pci-rcar-gen2.c   |    0
 drivers/pci/{host => controller}/pci-tegra.c       |    0
 .../pci/{host => controller}/pci-thunder-ecam.c    |    0
 drivers/pci/{host => controller}/pci-thunder-pem.c |    0
 drivers/pci/{host => controller}/pci-versatile.c   |    0
 drivers/pci/{host => controller}/pci-xgene-msi.c   |    0
 drivers/pci/{host => controller}/pci-xgene.c       |    0
 drivers/pci/{host => controller}/pcie-altera-msi.c |    0
 drivers/pci/{host => controller}/pcie-altera.c     |    0
 drivers/pci/{host => controller}/pcie-armada8k.c   |    0
 drivers/pci/{host => controller}/pcie-artpec6.c    |    0
 .../{host => controller}/pcie-designware-plat.c    |    0
 drivers/pci/{host => controller}/pcie-designware.c |    0
 drivers/pci/{host => controller}/pcie-designware.h |    0
 drivers/pci/{host => controller}/pcie-hisi.c       |    0
 drivers/pci/{host => controller}/pcie-iproc-bcma.c |    0
 drivers/pci/{host => controller}/pcie-iproc-msi.c  |    0
 .../pci/{host => controller}/pcie-iproc-platform.c |    0
 drivers/pci/{host => controller}/pcie-iproc.c      |    0
 drivers/pci/{host => controller}/pcie-iproc.h      |    0
 drivers/pci/{host => controller}/pcie-qcom.c       |    0
 drivers/pci/{host => controller}/pcie-rcar.c       |    0
 drivers/pci/{host => controller}/pcie-spear13xx.c  |    0
 drivers/pci/{host => controller}/pcie-xilinx-nwl.c |    0
 drivers/pci/{host => controller}/pcie-xilinx.c     |    0
 43 files changed, 62 insertions(+), 31 deletions(-)
 rename drivers/pci/{host => controller}/Kconfig (93%)
 rename drivers/pci/{host => controller}/Makefile (100%)
 rename drivers/pci/{host => controller}/pci-aardvark.c (100%)
 rename drivers/pci/{host => controller}/pci-dra7xx.c (100%)
 rename drivers/pci/{host => controller}/pci-exynos.c (100%)
 rename drivers/pci/{host => controller}/pci-host-common.c (100%)
 rename drivers/pci/{host => controller}/pci-host-generic.c (100%)
 rename drivers/pci/{host => controller}/pci-hyperv.c (100%)
 rename drivers/pci/{host => controller}/pci-imx6.c (100%)
 rename drivers/pci/{host => controller}/pci-keystone-dw.c (100%)
 rename drivers/pci/{host => controller}/pci-keystone.c (100%)
 rename drivers/pci/{host => controller}/pci-keystone.h (100%)
 rename drivers/pci/{host => controller}/pci-layerscape.c (100%)
 rename drivers/pci/{host => controller}/pci-mvebu.c (100%)
 rename drivers/pci/{host => controller}/pci-rcar-gen2.c (100%)
 rename drivers/pci/{host => controller}/pci-tegra.c (100%)
 rename drivers/pci/{host => controller}/pci-thunder-ecam.c (100%)
 rename drivers/pci/{host => controller}/pci-thunder-pem.c (100%)
 rename drivers/pci/{host => controller}/pci-versatile.c (100%)
 rename drivers/pci/{host => controller}/pci-xgene-msi.c (100%)
 rename drivers/pci/{host => controller}/pci-xgene.c (100%)
 rename drivers/pci/{host => controller}/pcie-altera-msi.c (100%)
 rename drivers/pci/{host => controller}/pcie-altera.c (100%)
 rename drivers/pci/{host => controller}/pcie-armada8k.c (100%)
 rename drivers/pci/{host => controller}/pcie-artpec6.c (100%)
 rename drivers/pci/{host => controller}/pcie-designware-plat.c (100%)
 rename drivers/pci/{host => controller}/pcie-designware.c (100%)
 rename drivers/pci/{host => controller}/pcie-designware.h (100%)
 rename drivers/pci/{host => controller}/pcie-hisi.c (100%)
 rename drivers/pci/{host => controller}/pcie-iproc-bcma.c (100%)
 rename drivers/pci/{host => controller}/pcie-iproc-msi.c (100%)
 rename drivers/pci/{host => controller}/pcie-iproc-platform.c (100%)
 rename drivers/pci/{host => controller}/pcie-iproc.c (100%)
 rename drivers/pci/{host => controller}/pcie-iproc.h (100%)
 rename drivers/pci/{host => controller}/pcie-qcom.c (100%)
 rename drivers/pci/{host => controller}/pcie-rcar.c (100%)
 rename drivers/pci/{host => controller}/pcie-spear13xx.c (100%)
 rename drivers/pci/{host => controller}/pcie-xilinx-nwl.c (100%)
 rename drivers/pci/{host => controller}/pcie-xilinx.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index a5e1270..3db2531 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5662,7 +5662,7 @@ F:	arch/x86/kernel/cpu/mshyperv.c
 F:	drivers/hid/hid-hyperv.c
 F:	drivers/hv/
 F:	drivers/input/serio/hyperv-keyboard.c
-F:	drivers/pci/host/pci-hyperv.c
+F:	drivers/pci/controller/pci-hyperv.c
 F:	drivers/net/hyperv/
 F:	drivers/scsi/storvsc_drv.c
 F:	drivers/video/fbdev/hyperv_fb.c
@@ -8945,7 +8945,7 @@ L:	rfi@lists.rocketboards.org (moderated for non-subscribers)
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/altera-pcie.txt
-F:	drivers/pci/host/pcie-altera.c
+F:	drivers/pci/controller/pcie-altera.c
 
 PCI DRIVER FOR ARM VERSATILE PLATFORM
 M:	Rob Herring <robh@kernel.org>
@@ -8953,7 +8953,7 @@ L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/versatile.txt
-F:	drivers/pci/host/pci-versatile.c
+F:	drivers/pci/controller/pci-versatile.c
 
 PCI DRIVER FOR APPLIEDMICRO XGENE
 M:	Tanmay Inamdar <tinamdar@apm.com>
@@ -8961,7 +8961,7 @@ L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/xgene-pci.txt
-F:	drivers/pci/host/pci-xgene.c
+F:	drivers/pci/controller/pci-xgene.c
 
 PCI DRIVER FOR FREESCALE LAYERSCAPE
 M:	Minghuan Lian <minghuan.Lian@freescale.com>
@@ -8971,7 +8971,7 @@ L:	linuxppc-dev@lists.ozlabs.org
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
-F:	drivers/pci/host/*layerscape*
+F:	drivers/pci/controller/*layerscape*
 
 PCI DRIVER FOR IMX6
 M:	Richard Zhu <Richard.Zhu@freescale.com>
@@ -8979,14 +8979,14 @@ M:	Lucas Stach <l.stach@pengutronix.de>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	drivers/pci/host/*imx6*
+F:	drivers/pci/controller/*imx6*
 
 PCI DRIVER FOR TI KEYSTONE
 M:	Murali Karicheri <m-karicheri2@ti.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	drivers/pci/host/*keystone*
+F:	drivers/pci/controller/*keystone*
 
 PCI DRIVER FOR MVEBU (Marvell Armada 370 and Armada XP SOC support)
 M:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
@@ -8994,14 +8994,14 @@ M:	Jason Cooper <jason@lakedaemon.net>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	drivers/pci/host/*mvebu*
+F:	drivers/pci/controller/*mvebu*
 
 PCI DRIVER FOR AARDVARK (Marvell Armada 3700)
 M:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	drivers/pci/host/pci-aardvark.c
+F:	drivers/pci/controller/pci-aardvark.c
 
 PCI DRIVER FOR NVIDIA TEGRA
 M:	Thierry Reding <thierry.reding@gmail.com>
@@ -9009,7 +9009,7 @@ L:	linux-tegra@vger.kernel.org
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
-F:	drivers/pci/host/pci-tegra.c
+F:	drivers/pci/controller/pci-tegra.c
 
 PCI DRIVER FOR TI DRA7XX
 M:	Kishon Vijay Abraham I <kishon@ti.com>
@@ -9017,14 +9017,14 @@ L:	linux-omap@vger.kernel.org
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/ti-pci.txt
-F:	drivers/pci/host/pci-dra7xx.c
+F:	drivers/pci/controller/pci-dra7xx.c
 
 PCI DRIVER FOR RENESAS R-CAR
 M:	Simon Horman <horms@verge.net.au>
 L:	linux-pci@vger.kernel.org
 L:	linux-renesas-soc@vger.kernel.org
 S:	Maintained
-F:	drivers/pci/host/*rcar*
+F:	drivers/pci/controller/*rcar*
 
 PCI DRIVER FOR SAMSUNG EXYNOS
 M:	Jingoo Han <jingoohan1@gmail.com>
@@ -9032,30 +9032,30 @@ L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-samsung-soc@vger.kernel.org (moderated for non-subscribers)
 S:	Maintained
-F:	drivers/pci/host/pci-exynos.c
+F:	drivers/pci/controller/pci-exynos.c
 
 PCI DRIVER FOR SYNOPSIS DESIGNWARE
 M:	Jingoo Han <jingoohan1@gmail.com>
 M:	Pratyush Anand <pratyush.anand@gmail.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-F:	drivers/pci/host/*designware*
+F:	drivers/pci/controller/*designware*
 
 PCI DRIVER FOR SYNOPSYS PROTOTYPING DEVICE
 M:	Joao Pinto <jpinto@synopsys.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/designware-pcie.txt
-F:	drivers/pci/host/pcie-designware-plat.c
+F:	drivers/pci/controller/pcie-designware-plat.c
 
 PCI DRIVER FOR GENERIC OF HOSTS
 M:	Will Deacon <will.deacon@arm.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/host-generic-pci.txt
-F:	drivers/pci/host/pci-host-common.c
-F:	drivers/pci/host/pci-host-generic.c
+F:	Documentation/devicetree/bindings/pci/controller-generic-pci.txt
+F:	drivers/pci/controller/pci-host-common.c
+F:	drivers/pci/controller/pci-host-generic.c
 
 PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (VMD)
 M:	Keith Busch <keith.busch@intel.com>
@@ -9067,7 +9067,7 @@ PCIE DRIVER FOR ST SPEAR13XX
 M:	Pratyush Anand <pratyush.anand@gmail.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-F:	drivers/pci/host/*spear*
+F:	drivers/pci/controller/*spear*
 
 PCI MSI DRIVER FOR ALTERA MSI IP
 M:	Ley Foon Tan <lftan@altera.com>
@@ -9075,7 +9075,7 @@ L:	rfi@lists.rocketboards.org (moderated for non-subscribers)
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
-F:	drivers/pci/host/pcie-altera-msi.c
+F:	drivers/pci/controller/pcie-altera-msi.c
 
 PCI MSI DRIVER FOR APPLIEDMICRO XGENE
 M:	Duc Dang <dhdang@apm.com>
@@ -9083,7 +9083,7 @@ L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
-F:	drivers/pci/host/pci-xgene-msi.c
+F:	drivers/pci/controller/pci-xgene-msi.c
 
 PCIE DRIVER FOR AXIS ARTPEC
 M:	Niklas Cassel <niklas.cassel@axis.com>
@@ -9092,7 +9092,7 @@ L:	linux-arm-kernel@axis.com
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/axis,artpec*
-F:	drivers/pci/host/*artpec*
+F:	drivers/pci/controller/*artpec*
 
 PCIE DRIVER FOR HISILICON
 M:	Zhou Wang <wangzhou1@hisilicon.com>
@@ -9100,14 +9100,14 @@ M:	Gabriele Paoloni <gabriele.paoloni@huawei.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
-F:	drivers/pci/host/pcie-hisi.c
+F:	drivers/pci/controller/pcie-hisi.c
 
 PCIE DRIVER FOR QUALCOMM MSM
 M:     Stanimir Varbanov <svarbanov@mm-sol.com>
 L:     linux-pci@vger.kernel.org
 L:     linux-arm-msm@vger.kernel.org
 S:     Maintained
-F:     drivers/pci/host/*qcom*
+F:     drivers/pci/controller/*qcom*
 
 PCIE DRIVER FOR CAVIUM THUNDERX
 M:	David Daney <david.daney@cavium.com>
@@ -9115,7 +9115,7 @@ L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/pci-thunder-*
-F:	drivers/pci/host/pci-thunder-*
+F:	drivers/pci/controller/pci-thunder-*
 
 PCMCIA SUBSYSTEM
 P:	Linux PCMCIA Team
diff --git a/drivers/Makefile b/drivers/Makefile
index 8c070ad..10cb1ad 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -16,6 +16,9 @@ obj-$(CONFIG_GPIOLIB)		+= gpio/
 obj-y				+= pwm/
 obj-$(CONFIG_PCI_ENDPOINT)	+= pci/endpoint/
 obj-$(CONFIG_PCI)		+= pci/
+# PCI controller drivers
+obj-y				+= pci/controller/
+
 obj-$(CONFIG_PARISC)		+= parisc/
 obj-$(CONFIG_RAPIDIO)		+= rapidio/
 obj-y				+= video/
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 5f116a6..c603a8a 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -132,5 +132,5 @@ config PCI_HYPERV
           PCI devices from a PCI backend to support PCI driver domains.
 
 source "drivers/pci/hotplug/Kconfig"
-source "drivers/pci/host/Kconfig"
+source "drivers/pci/controller/Kconfig"
 source "drivers/pci/endpoint/Kconfig"
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 8db5079..b924cc9 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -65,6 +65,3 @@ obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 obj-$(CONFIG_OF) += of.o
 
 ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
-
-# PCI host controller drivers
-obj-y += host/
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/controller/Kconfig
similarity index 93%
rename from drivers/pci/host/Kconfig
rename to drivers/pci/controller/Kconfig
index 9b485d8..4c55c2d 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -1,10 +1,10 @@
-menu "PCI host controller drivers"
-	depends on PCI
+menu "PCI controller drivers"
 
 config PCI_DRA7XX
 	bool "TI DRA7xx PCIe controller"
 	depends on OF && HAS_IOMEM && TI_PIPE3
 	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI
 	select PCIE_DW
 	help
 	 Enables support for the PCIe controller in the DRA7xx SoC.  There
@@ -16,12 +16,14 @@ config PCI_MVEBU
 	depends on ARCH_MVEBU || ARCH_DOVE
 	depends on ARM
 	depends on OF
+	depends on PCI
 
 config PCI_AARDVARK
 	bool "Aardvark PCIe controller"
 	depends on ARCH_MVEBU && ARM64
 	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI
 	help
 	 Add support for Aardvark 64bit PCIe Host Controller. This
 	 controller is part of the South Bridge of the Marvel Armada
@@ -31,6 +33,7 @@ config PCIE_XILINX_NWL
 	bool "NWL PCIe Core"
 	depends on ARCH_ZYNQMP
 	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI
 	help
 	 Say 'Y' here if you want kernel support for Xilinx
 	 NWL PCIe controller. The controller can act as Root Port
@@ -40,6 +43,7 @@ config PCIE_XILINX_NWL
 config PCIE_DW_PLAT
 	bool "Platform bus based DesignWare PCIe Controller"
 	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI
 	select PCIE_DW
 	---help---
 	 This selects the DesignWare PCIe controller support. Select this if
@@ -52,6 +56,7 @@ config PCIE_DW_PLAT
 config PCIE_DW
 	bool
 	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI
 
 config PCI_EXYNOS
 	bool "Samsung Exynos PCIe controller"
@@ -59,17 +64,20 @@ config PCI_EXYNOS
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	select PCIE_DW
+	depends on PCI
 
 config PCI_IMX6
 	bool "Freescale i.MX6 PCIe controller"
 	depends on SOC_IMX6Q
 	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI
 	select PCIEPORTBUS
 	select PCIE_DW
 
 config PCI_TEGRA
 	bool "NVIDIA Tegra PCIe controller"
 	depends on ARCH_TEGRA && !ARM64
+	depends on PCI
 	help
 	  Say Y here if you want support for the PCIe host controller found
 	  on NVIDIA Tegra SoCs.
@@ -78,6 +86,7 @@ config PCI_RCAR_GEN2
 	bool "Renesas R-Car Gen2 Internal PCI controller"
 	depends on ARM
 	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on PCI
 	help
 	  Say Y here if you want internal PCI support on R-Car Gen2 SoC.
 	  There are 3 internal PCI controllers available with a single
@@ -87,16 +96,19 @@ config PCIE_RCAR
 	bool "Renesas R-Car PCIe controller"
 	depends on ARCH_RENESAS || (ARM && COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI
 	help
 	  Say Y here if you want PCIe controller support on R-Car SoCs.
 
 config PCI_HOST_COMMON
 	bool
+	depends on PCI
 	select PCI_ECAM
 
 config PCI_HOST_GENERIC
 	bool "Generic PCI host controller"
 	depends on (ARM || ARM64) && OF
+	depends on PCI
 	select PCI_HOST_COMMON
 	select IRQ_DOMAIN
 	help
@@ -107,6 +119,7 @@ config PCIE_SPEAR13XX
 	bool "STMicroelectronics SPEAr PCIe controller"
 	depends on ARCH_SPEAR13XX
 	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI
 	select PCIEPORTBUS
 	select PCIE_DW
 	help
@@ -116,6 +129,7 @@ config PCI_KEYSTONE
 	bool "TI Keystone PCIe controller"
 	depends on ARCH_KEYSTONE
 	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI
 	select PCIE_DW
 	select PCIEPORTBUS
 	help
@@ -127,6 +141,7 @@ config PCI_KEYSTONE
 config PCIE_XILINX
 	bool "Xilinx AXI PCIe host bridge support"
 	depends on ARCH_ZYNQ || MICROBLAZE
+	depends on PCI
 	help
 	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
 	  Host Bridge driver.
@@ -135,6 +150,7 @@ config PCI_XGENE
 	bool "X-Gene PCIe controller"
 	depends on ARCH_XGENE
 	depends on OF
+	depends on PCI
 	select PCIEPORTBUS
 	help
 	  Say Y here if you want internal PCI support on APM X-Gene SoC.
@@ -145,6 +161,7 @@ config PCI_XGENE_MSI
 	bool "X-Gene v1 PCIe MSI feature"
 	depends on PCI_XGENE
 	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI
 	default y
 	help
 	  Say Y here if you want PCIe MSI support for the APM X-Gene v1 SoC.
@@ -154,6 +171,7 @@ config PCI_LAYERSCAPE
 	bool "Freescale Layerscape PCIe controller"
 	depends on OF && (ARM || ARCH_LAYERSCAPE)
 	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI
 	select PCIE_DW
 	select MFD_SYSCON
 	help
@@ -162,9 +180,11 @@ config PCI_LAYERSCAPE
 config PCI_VERSATILE
 	bool "ARM Versatile PB PCI controller"
 	depends on ARCH_VERSATILE
+	depends on PCI
 
 config PCIE_IPROC
 	tristate
+	depends on PCI
 	help
 	  This enables the iProc PCIe core controller support for Broadcom's
 	  iProc family of SoCs. An appropriate bus interface driver needs
@@ -174,6 +194,7 @@ config PCIE_IPROC_PLATFORM
 	tristate "Broadcom iProc PCIe platform bus driver"
 	depends on ARCH_BCM_IPROC || (ARM && COMPILE_TEST)
 	depends on OF
+	depends on PCI
 	select PCIE_IPROC
 	default ARCH_BCM_IPROC
 	help
@@ -183,6 +204,7 @@ config PCIE_IPROC_PLATFORM
 config PCIE_IPROC_BCMA
 	tristate "Broadcom iProc PCIe BCMA bus driver"
 	depends on ARM && (ARCH_BCM_IPROC || COMPILE_TEST)
+	depends on PCI
 	select PCIE_IPROC
 	select BCMA
 	select PCI_DOMAINS
@@ -195,6 +217,7 @@ config PCIE_IPROC_MSI
 	bool "Broadcom iProc PCIe MSI support"
 	depends on PCIE_IPROC_PLATFORM || PCIE_IPROC_BCMA
 	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI
 	default ARCH_BCM_IPROC
 	help
 	  Say Y here if you want to enable MSI support for Broadcom's iProc
@@ -204,6 +227,7 @@ config PCIE_ALTERA
 	bool "Altera PCIe controller"
 	depends on ARM || NIOS2
 	depends on OF_PCI
+	depends on PCI
 	select PCI_DOMAINS
 	help
 	  Say Y here if you want to enable PCIe controller support on Altera
@@ -213,6 +237,7 @@ config PCIE_ALTERA_MSI
 	bool "Altera PCIe MSI feature"
 	depends on PCIE_ALTERA
 	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI
 	help
 	  Say Y here if you want PCIe MSI support for the Altera FPGA.
 	  This MSI driver supports Altera MSI to GIC controller IP.
@@ -221,6 +246,7 @@ config PCI_HISI
 	depends on OF && ARM64
 	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
 	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI
 	select PCIEPORTBUS
 	select PCIE_DW
 	help
@@ -231,6 +257,7 @@ config PCIE_QCOM
 	bool "Qualcomm PCIe controller"
 	depends on ARCH_QCOM && OF
 	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI
 	select PCIE_DW
 	select PCIEPORTBUS
 	help
@@ -241,6 +268,7 @@ config PCIE_QCOM
 config PCI_HOST_THUNDER_PEM
 	bool "Cavium Thunder PCIe controller to off-chip devices"
 	depends on OF && ARM64
+	depends on PCI
 	select PCI_HOST_COMMON
 	help
 	  Say Y here if you want PCIe support for CN88XX Cavium Thunder SoCs.
@@ -248,6 +276,7 @@ config PCI_HOST_THUNDER_PEM
 config PCI_HOST_THUNDER_ECAM
 	bool "Cavium Thunder ECAM controller to on-chip devices on pass-1.x silicon"
 	depends on OF && ARM64
+	depends on PCI
 	select PCI_HOST_COMMON
 	help
 	  Say Y here if you want ECAM support for CN88XX-Pass-1.x Cavium Thunder SoCs.
@@ -256,6 +285,7 @@ config PCIE_ARMADA_8K
 	bool "Marvell Armada-8K PCIe controller"
 	depends on ARCH_MVEBU
 	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI
 	select PCIE_DW
 	select PCIEPORTBUS
 	help
@@ -268,6 +298,7 @@ config PCIE_ARTPEC6
 	bool "Axis ARTPEC-6 PCIe controller"
 	depends on MACH_ARTPEC6
 	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI
 	select PCIE_DW
 	select PCIEPORTBUS
 	help
diff --git a/drivers/pci/host/Makefile b/drivers/pci/controller/Makefile
similarity index 100%
rename from drivers/pci/host/Makefile
rename to drivers/pci/controller/Makefile
diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
similarity index 100%
rename from drivers/pci/host/pci-aardvark.c
rename to drivers/pci/controller/pci-aardvark.c
diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/controller/pci-dra7xx.c
similarity index 100%
rename from drivers/pci/host/pci-dra7xx.c
rename to drivers/pci/controller/pci-dra7xx.c
diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/controller/pci-exynos.c
similarity index 100%
rename from drivers/pci/host/pci-exynos.c
rename to drivers/pci/controller/pci-exynos.c
diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
similarity index 100%
rename from drivers/pci/host/pci-host-common.c
rename to drivers/pci/controller/pci-host-common.c
diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/controller/pci-host-generic.c
similarity index 100%
rename from drivers/pci/host/pci-host-generic.c
rename to drivers/pci/controller/pci-host-generic.c
diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
similarity index 100%
rename from drivers/pci/host/pci-hyperv.c
rename to drivers/pci/controller/pci-hyperv.c
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/controller/pci-imx6.c
similarity index 100%
rename from drivers/pci/host/pci-imx6.c
rename to drivers/pci/controller/pci-imx6.c
diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/controller/pci-keystone-dw.c
similarity index 100%
rename from drivers/pci/host/pci-keystone-dw.c
rename to drivers/pci/controller/pci-keystone-dw.c
diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/controller/pci-keystone.c
similarity index 100%
rename from drivers/pci/host/pci-keystone.c
rename to drivers/pci/controller/pci-keystone.c
diff --git a/drivers/pci/host/pci-keystone.h b/drivers/pci/controller/pci-keystone.h
similarity index 100%
rename from drivers/pci/host/pci-keystone.h
rename to drivers/pci/controller/pci-keystone.h
diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/controller/pci-layerscape.c
similarity index 100%
rename from drivers/pci/host/pci-layerscape.c
rename to drivers/pci/controller/pci-layerscape.c
diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
similarity index 100%
rename from drivers/pci/host/pci-mvebu.c
rename to drivers/pci/controller/pci-mvebu.c
diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/controller/pci-rcar-gen2.c
similarity index 100%
rename from drivers/pci/host/pci-rcar-gen2.c
rename to drivers/pci/controller/pci-rcar-gen2.c
diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
similarity index 100%
rename from drivers/pci/host/pci-tegra.c
rename to drivers/pci/controller/pci-tegra.c
diff --git a/drivers/pci/host/pci-thunder-ecam.c b/drivers/pci/controller/pci-thunder-ecam.c
similarity index 100%
rename from drivers/pci/host/pci-thunder-ecam.c
rename to drivers/pci/controller/pci-thunder-ecam.c
diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/controller/pci-thunder-pem.c
similarity index 100%
rename from drivers/pci/host/pci-thunder-pem.c
rename to drivers/pci/controller/pci-thunder-pem.c
diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/controller/pci-versatile.c
similarity index 100%
rename from drivers/pci/host/pci-versatile.c
rename to drivers/pci/controller/pci-versatile.c
diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
similarity index 100%
rename from drivers/pci/host/pci-xgene-msi.c
rename to drivers/pci/controller/pci-xgene-msi.c
diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
similarity index 100%
rename from drivers/pci/host/pci-xgene.c
rename to drivers/pci/controller/pci-xgene.c
diff --git a/drivers/pci/host/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
similarity index 100%
rename from drivers/pci/host/pcie-altera-msi.c
rename to drivers/pci/controller/pcie-altera-msi.c
diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
similarity index 100%
rename from drivers/pci/host/pcie-altera.c
rename to drivers/pci/controller/pcie-altera.c
diff --git a/drivers/pci/host/pcie-armada8k.c b/drivers/pci/controller/pcie-armada8k.c
similarity index 100%
rename from drivers/pci/host/pcie-armada8k.c
rename to drivers/pci/controller/pcie-armada8k.c
diff --git a/drivers/pci/host/pcie-artpec6.c b/drivers/pci/controller/pcie-artpec6.c
similarity index 100%
rename from drivers/pci/host/pcie-artpec6.c
rename to drivers/pci/controller/pcie-artpec6.c
diff --git a/drivers/pci/host/pcie-designware-plat.c b/drivers/pci/controller/pcie-designware-plat.c
similarity index 100%
rename from drivers/pci/host/pcie-designware-plat.c
rename to drivers/pci/controller/pcie-designware-plat.c
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/controller/pcie-designware.c
similarity index 100%
rename from drivers/pci/host/pcie-designware.c
rename to drivers/pci/controller/pcie-designware.c
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/controller/pcie-designware.h
similarity index 100%
rename from drivers/pci/host/pcie-designware.h
rename to drivers/pci/controller/pcie-designware.h
diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/controller/pcie-hisi.c
similarity index 100%
rename from drivers/pci/host/pcie-hisi.c
rename to drivers/pci/controller/pcie-hisi.c
diff --git a/drivers/pci/host/pcie-iproc-bcma.c b/drivers/pci/controller/pcie-iproc-bcma.c
similarity index 100%
rename from drivers/pci/host/pcie-iproc-bcma.c
rename to drivers/pci/controller/pcie-iproc-bcma.c
diff --git a/drivers/pci/host/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
similarity index 100%
rename from drivers/pci/host/pcie-iproc-msi.c
rename to drivers/pci/controller/pcie-iproc-msi.c
diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
similarity index 100%
rename from drivers/pci/host/pcie-iproc-platform.c
rename to drivers/pci/controller/pcie-iproc-platform.c
diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
similarity index 100%
rename from drivers/pci/host/pcie-iproc.c
rename to drivers/pci/controller/pcie-iproc.c
diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/controller/pcie-iproc.h
similarity index 100%
rename from drivers/pci/host/pcie-iproc.h
rename to drivers/pci/controller/pcie-iproc.h
diff --git a/drivers/pci/host/pcie-qcom.c b/drivers/pci/controller/pcie-qcom.c
similarity index 100%
rename from drivers/pci/host/pcie-qcom.c
rename to drivers/pci/controller/pcie-qcom.c
diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
similarity index 100%
rename from drivers/pci/host/pcie-rcar.c
rename to drivers/pci/controller/pcie-rcar.c
diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/controller/pcie-spear13xx.c
similarity index 100%
rename from drivers/pci/host/pcie-spear13xx.c
rename to drivers/pci/controller/pcie-spear13xx.c
diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
similarity index 100%
rename from drivers/pci/host/pcie-xilinx-nwl.c
rename to drivers/pci/controller/pcie-xilinx-nwl.c
diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
similarity index 100%
rename from drivers/pci/host/pcie-xilinx.c
rename to drivers/pci/controller/pcie-xilinx.c
-- 
1.7.9.5

