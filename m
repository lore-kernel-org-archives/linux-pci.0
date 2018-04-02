Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:43193 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753980AbeDBBJe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 Apr 2018 21:09:34 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v5 03/10] PCI: dwc: Move dwc drivers back to controller directory
Date: Mon,  2 Apr 2018 09:02:35 +0800
Message-Id: <1522630955-151485-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1522630865-151344-1-git-send-email-shawn.lin@rock-chips.com>
References: <1522630865-151344-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No functional change intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 MAINTAINERS                                        | 27 +++++++++++-----------
 drivers/pci/Kconfig                                |  1 -
 drivers/pci/Makefile                               |  3 ---
 drivers/pci/controller/Kconfig                     |  1 +
 drivers/pci/controller/Makefile                    |  2 ++
 drivers/pci/{ => controller}/dwc/Kconfig           |  0
 drivers/pci/{ => controller}/dwc/Makefile          |  0
 drivers/pci/{ => controller}/dwc/pci-dra7xx.c      |  0
 drivers/pci/{ => controller}/dwc/pci-exynos.c      |  0
 drivers/pci/{ => controller}/dwc/pci-imx6.c        |  0
 drivers/pci/{ => controller}/dwc/pci-keystone-dw.c |  0
 drivers/pci/{ => controller}/dwc/pci-keystone.c    |  0
 drivers/pci/{ => controller}/dwc/pci-keystone.h    |  0
 drivers/pci/{ => controller}/dwc/pci-layerscape.c  |  0
 drivers/pci/{ => controller}/dwc/pcie-armada8k.c   |  0
 drivers/pci/{ => controller}/dwc/pcie-artpec6.c    |  0
 .../pci/{ => controller}/dwc/pcie-designware-ep.c  |  0
 .../{ => controller}/dwc/pcie-designware-host.c    |  0
 .../{ => controller}/dwc/pcie-designware-plat.c    |  0
 drivers/pci/{ => controller}/dwc/pcie-designware.c |  0
 drivers/pci/{ => controller}/dwc/pcie-designware.h |  0
 drivers/pci/{ => controller}/dwc/pcie-hisi.c       |  2 +-
 drivers/pci/{ => controller}/dwc/pcie-histb.c      |  0
 drivers/pci/{ => controller}/dwc/pcie-kirin.c      |  0
 drivers/pci/{ => controller}/dwc/pcie-qcom.c       |  0
 drivers/pci/{ => controller}/dwc/pcie-spear13xx.c  |  0
 26 files changed, 17 insertions(+), 19 deletions(-)
 rename drivers/pci/{ => controller}/dwc/Kconfig (100%)
 rename drivers/pci/{ => controller}/dwc/Makefile (100%)
 rename drivers/pci/{ => controller}/dwc/pci-dra7xx.c (100%)
 rename drivers/pci/{ => controller}/dwc/pci-exynos.c (100%)
 rename drivers/pci/{ => controller}/dwc/pci-imx6.c (100%)
 rename drivers/pci/{ => controller}/dwc/pci-keystone-dw.c (100%)
 rename drivers/pci/{ => controller}/dwc/pci-keystone.c (100%)
 rename drivers/pci/{ => controller}/dwc/pci-keystone.h (100%)
 rename drivers/pci/{ => controller}/dwc/pci-layerscape.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-armada8k.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-artpec6.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-designware-ep.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-designware-host.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-designware-plat.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-designware.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-designware.h (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-hisi.c (99%)
 rename drivers/pci/{ => controller}/dwc/pcie-histb.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-kirin.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-qcom.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-spear13xx.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42c02e1..f2dbbc9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10660,7 +10660,7 @@ L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/pci-armada8k.txt
-F:	drivers/pci/dwc/pcie-armada8k.c
+F:	drivers/pci/controller/pcie-armada8k.c
 
 PCI DRIVER FOR CADENCE PCIE IP
 M:	Alan Douglas <adouglas@cadence.com>
@@ -10677,7 +10677,7 @@ L:	linuxppc-dev@lists.ozlabs.org
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
-F:	drivers/pci/dwc/*layerscape*
+F:	drivers/pci/controller/*layerscape*
 
 PCI DRIVER FOR GENERIC OF HOSTS
 M:	Will Deacon <will.deacon@arm.com>
@@ -10695,7 +10695,7 @@ L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
-F:	drivers/pci/dwc/*imx6*
+F:	drivers/pci/controller/*imx6*
 
 PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (VMD)
 M:	Keith Busch <keith.busch@intel.com>
@@ -10745,7 +10745,7 @@ L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-samsung-soc@vger.kernel.org (moderated for non-subscribers)
 S:	Maintained
-F:	drivers/pci/dwc/pci-exynos.c
+F:	drivers/pci/controller/pci-exynos.c
 
 PCI DRIVER FOR SYNOPSYS DESIGNWARE
 M:	Jingoo Han <jingoohan1@gmail.com>
@@ -10753,7 +10753,7 @@ M:	Joao Pinto <Joao.Pinto@synopsys.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/designware-pcie.txt
-F:	drivers/pci/dwc/*designware*
+F:	drivers/pci/controller/*designware*
 
 PCI DRIVER FOR TI DRA7XX
 M:	Kishon Vijay Abraham I <kishon@ti.com>
@@ -10761,14 +10761,14 @@ L:	linux-omap@vger.kernel.org
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/ti-pci.txt
-F:	drivers/pci/dwc/pci-dra7xx.c
+F:	drivers/pci/controller/pci-dra7xx.c
 
 PCI DRIVER FOR TI KEYSTONE
 M:	Murali Karicheri <m-karicheri2@ti.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	drivers/pci/dwc/*keystone*
+F:	drivers/pci/controller/*keystone*
 
 PCI ENDPOINT SUBSYSTEM
 M:	Kishon Vijay Abraham I <kishon@ti.com>
@@ -10836,7 +10836,6 @@ Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/
 S:	Supported
 F:	drivers/pci/controller/
-F:	drivers/pci/dwc/
 
 PCIE DRIVER FOR AXIS ARTPEC
 M:	Niklas Cassel <niklas.cassel@axis.com>
@@ -10845,7 +10844,7 @@ L:	linux-arm-kernel@axis.com
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/axis,artpec*
-F:	drivers/pci/dwc/*artpec*
+F:	drivers/pci/controller/*artpec*
 
 PCIE DRIVER FOR CAVIUM THUNDERX
 M:	David Daney <david.daney@cavium.com>
@@ -10860,7 +10859,7 @@ M:	Zhou Wang <wangzhou1@hisilicon.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
-F:	drivers/pci/dwc/pcie-hisi.c
+F:	drivers/pci/controller/pcie-hisi.c
 
 PCIE DRIVER FOR HISILICON KIRIN
 M:	Xiaowei Song <songxiaowei@hisilicon.com>
@@ -10868,7 +10867,7 @@ M:	Binghui Wang <wangbinghui@hisilicon.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/pcie-kirin.txt
-F:	drivers/pci/dwc/pcie-kirin.c
+F:	drivers/pci/controller/pcie-kirin.c
 
 PCIE DRIVER FOR HISILICON STB
 M:	Jianguo Sun <sunjianguo1@huawei.com>
@@ -10876,7 +10875,7 @@ M:	Shawn Guo <shawn.guo@linaro.org>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
-F:	drivers/pci/dwc/pcie-histb.c
+F:	drivers/pci/controller/pcie-histb.c
 
 PCIE DRIVER FOR MEDIATEK
 M:	Ryder Lee <ryder.lee@mediatek.com>
@@ -10891,7 +10890,7 @@ M:	Stanimir Varbanov <svarbanov@mm-sol.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
-F:	drivers/pci/dwc/*qcom*
+F:	drivers/pci/controller/*qcom*
 
 PCIE DRIVER FOR ROCKCHIP
 M:	Shawn Lin <shawn.lin@rock-chips.com>
@@ -10912,7 +10911,7 @@ PCIE DRIVER FOR ST SPEAR13XX
 M:	Pratyush Anand <pratyush.anand@gmail.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-F:	drivers/pci/dwc/*spear*
+F:	drivers/pci/controller/*spear*
 
 PCMCIA SUBSYSTEM
 M:	Dominik Brodowski <linux@dominikbrodowski.net>
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 49e4d18..477131d 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -138,6 +138,5 @@ config PCI_HYPERV
 
 source "drivers/pci/hotplug/Kconfig"
 source "drivers/pci/controller/Kconfig"
-source "drivers/pci/dwc/Kconfig"
 source "drivers/pci/endpoint/Kconfig"
 source "drivers/pci/switch/Kconfig"
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 5a8a015..922ada6 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -33,7 +33,4 @@ obj-y				+= switch/
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
 
-# pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
-obj-y				+= dwc/
-
 ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 6a569a1..d3dae70 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -256,4 +256,5 @@ config VMD
 	  To compile this driver as a module, choose M here: the
 	  module will be called vmd.
 
+source "drivers/pci/controller/dwc/Kconfig"
 endmenu
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index 6474638..039ee9e 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -2,6 +2,8 @@
 obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
 obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
 obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
+# pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
+obj-y += dwc/
 obj-$(CONFIG_PCI_FTPCI100) += pci-ftpci100.o
 obj-$(CONFIG_PCI_HYPERV) += pci-hyperv.o
 obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
similarity index 100%
rename from drivers/pci/dwc/Kconfig
rename to drivers/pci/controller/dwc/Kconfig
diff --git a/drivers/pci/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
similarity index 100%
rename from drivers/pci/dwc/Makefile
rename to drivers/pci/controller/dwc/Makefile
diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
similarity index 100%
rename from drivers/pci/dwc/pci-dra7xx.c
rename to drivers/pci/controller/dwc/pci-dra7xx.c
diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
similarity index 100%
rename from drivers/pci/dwc/pci-exynos.c
rename to drivers/pci/controller/dwc/pci-exynos.c
diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
similarity index 100%
rename from drivers/pci/dwc/pci-imx6.c
rename to drivers/pci/controller/dwc/pci-imx6.c
diff --git a/drivers/pci/dwc/pci-keystone-dw.c b/drivers/pci/controller/dwc/pci-keystone-dw.c
similarity index 100%
rename from drivers/pci/dwc/pci-keystone-dw.c
rename to drivers/pci/controller/dwc/pci-keystone-dw.c
diff --git a/drivers/pci/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
similarity index 100%
rename from drivers/pci/dwc/pci-keystone.c
rename to drivers/pci/controller/dwc/pci-keystone.c
diff --git a/drivers/pci/dwc/pci-keystone.h b/drivers/pci/controller/dwc/pci-keystone.h
similarity index 100%
rename from drivers/pci/dwc/pci-keystone.h
rename to drivers/pci/controller/dwc/pci-keystone.h
diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
similarity index 100%
rename from drivers/pci/dwc/pci-layerscape.c
rename to drivers/pci/controller/dwc/pci-layerscape.c
diff --git a/drivers/pci/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
similarity index 100%
rename from drivers/pci/dwc/pcie-armada8k.c
rename to drivers/pci/controller/dwc/pcie-armada8k.c
diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
similarity index 100%
rename from drivers/pci/dwc/pcie-artpec6.c
rename to drivers/pci/controller/dwc/pcie-artpec6.c
diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
similarity index 100%
rename from drivers/pci/dwc/pcie-designware-ep.c
rename to drivers/pci/controller/dwc/pcie-designware-ep.c
diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
similarity index 100%
rename from drivers/pci/dwc/pcie-designware-host.c
rename to drivers/pci/controller/dwc/pcie-designware-host.c
diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
similarity index 100%
rename from drivers/pci/dwc/pcie-designware-plat.c
rename to drivers/pci/controller/dwc/pcie-designware-plat.c
diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
similarity index 100%
rename from drivers/pci/dwc/pcie-designware.c
rename to drivers/pci/controller/dwc/pcie-designware.c
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
similarity index 100%
rename from drivers/pci/dwc/pcie-designware.h
rename to drivers/pci/controller/dwc/pcie-designware.h
diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/controller/dwc/pcie-hisi.c
similarity index 99%
rename from drivers/pci/dwc/pcie-hisi.c
rename to drivers/pci/controller/dwc/pcie-hisi.c
index 2658aae..6d9e1b2 100644
--- a/drivers/pci/dwc/pcie-hisi.c
+++ b/drivers/pci/controller/dwc/pcie-hisi.c
@@ -19,7 +19,7 @@
 #include <linux/pci-acpi.h>
 #include <linux/pci-ecam.h>
 #include <linux/regmap.h>
-#include "../pci.h"
+#include "../../pci.h"
 
 #if defined(CONFIG_PCI_HISI) || (defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS))
 
diff --git a/drivers/pci/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
similarity index 100%
rename from drivers/pci/dwc/pcie-histb.c
rename to drivers/pci/controller/dwc/pcie-histb.c
diff --git a/drivers/pci/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
similarity index 100%
rename from drivers/pci/dwc/pcie-kirin.c
rename to drivers/pci/controller/dwc/pcie-kirin.c
diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
similarity index 100%
rename from drivers/pci/dwc/pcie-qcom.c
rename to drivers/pci/controller/dwc/pcie-qcom.c
diff --git a/drivers/pci/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
similarity index 100%
rename from drivers/pci/dwc/pcie-spear13xx.c
rename to drivers/pci/controller/dwc/pcie-spear13xx.c
-- 
1.9.1
