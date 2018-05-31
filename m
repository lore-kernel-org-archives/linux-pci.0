Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:33943 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932563AbeEaBMz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 May 2018 21:12:55 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] PCI: Rename directory from host to controller and move back drivers
Date: Thu, 31 May 2018 09:12:37 +0800
Message-Id: <1527729157-201428-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In early discussion, the PCI drivers were scattered across three
different places, including host, cadence and dwc directories.
The reason behind that is we thought the name, host, was confusing
since it seems contain the driver for RC. And dwc drivers set a
precedent for supporting both of RC and EP mode, so that they were
moved to a separate directory called dwc which is parallel to the host
directory. Then cadence drivers follow this convention, and so on.
But this confuses more and potentially make the drivers/pci/ look
fragmented if more and more drivers follow this way.

So this patch rename directory from host to controller and make it
obvious that this is for controller drivers which applies to both
of RC and EP drivers. Then it moves back cadence and dwc drivers.

Hope all are settled down and all the following patches submitting
new drivers could benefit from it.

No functional change intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 MAINTAINERS                                        | 70 +++++++++++-----------
 drivers/pci/Kconfig                                |  4 +-
 drivers/pci/Makefile                               |  6 +-
 drivers/pci/cadence/Kconfig                        | 27 ---------
 drivers/pci/cadence/Makefile                       |  4 --
 drivers/pci/{host => controller}/Kconfig           | 31 +++++++++-
 drivers/pci/{host => controller}/Makefile          |  6 ++
 drivers/pci/{ => controller}/dwc/Kconfig           |  0
 drivers/pci/{ => controller}/dwc/Makefile          |  0
 drivers/pci/{ => controller}/dwc/pci-dra7xx.c      |  2 +-
 drivers/pci/{ => controller}/dwc/pci-exynos.c      |  0
 drivers/pci/{ => controller}/dwc/pci-imx6.c        |  0
 drivers/pci/{ => controller}/dwc/pci-keystone-dw.c |  0
 drivers/pci/{ => controller}/dwc/pci-keystone.c    |  0
 drivers/pci/{ => controller}/dwc/pci-keystone.h    |  0
 drivers/pci/{ => controller}/dwc/pci-layerscape.c  |  0
 drivers/pci/{ => controller}/dwc/pcie-armada8k.c   |  0
 drivers/pci/{ => controller}/dwc/pcie-artpec6.c    |  0
 .../pci/{ => controller}/dwc/pcie-designware-ep.c  |  0
 .../{ => controller}/dwc/pcie-designware-host.c    |  2 +-
 .../{ => controller}/dwc/pcie-designware-plat.c    |  0
 drivers/pci/{ => controller}/dwc/pcie-designware.c |  0
 drivers/pci/{ => controller}/dwc/pcie-designware.h |  0
 drivers/pci/{ => controller}/dwc/pcie-hisi.c       |  2 +-
 drivers/pci/{ => controller}/dwc/pcie-histb.c      |  0
 drivers/pci/{ => controller}/dwc/pcie-kirin.c      |  0
 drivers/pci/{ => controller}/dwc/pcie-qcom.c       |  0
 drivers/pci/{ => controller}/dwc/pcie-spear13xx.c  |  0
 drivers/pci/{host => controller}/pci-aardvark.c    |  0
 drivers/pci/{host => controller}/pci-ftpci100.c    |  0
 drivers/pci/{host => controller}/pci-host-common.c |  0
 .../pci/{host => controller}/pci-host-generic.c    |  0
 drivers/pci/{host => controller}/pci-hyperv.c      |  0
 drivers/pci/{host => controller}/pci-mvebu.c       |  0
 drivers/pci/{host => controller}/pci-rcar-gen2.c   |  0
 drivers/pci/{host => controller}/pci-tegra.c       |  0
 .../pci/{host => controller}/pci-thunder-ecam.c    |  0
 drivers/pci/{host => controller}/pci-thunder-pem.c |  0
 drivers/pci/{host => controller}/pci-v3-semi.c     |  0
 drivers/pci/{host => controller}/pci-versatile.c   |  0
 drivers/pci/{host => controller}/pci-xgene-msi.c   |  0
 drivers/pci/{host => controller}/pci-xgene.c       |  0
 drivers/pci/{host => controller}/pcie-altera-msi.c |  0
 drivers/pci/{host => controller}/pcie-altera.c     |  0
 .../pci/{cadence => controller}/pcie-cadence-ep.c  |  0
 .../{cadence => controller}/pcie-cadence-host.c    |  0
 drivers/pci/{cadence => controller}/pcie-cadence.c |  0
 drivers/pci/{cadence => controller}/pcie-cadence.h |  0
 drivers/pci/{host => controller}/pcie-iproc-bcma.c |  0
 drivers/pci/{host => controller}/pcie-iproc-msi.c  |  0
 .../pci/{host => controller}/pcie-iproc-platform.c |  0
 drivers/pci/{host => controller}/pcie-iproc.c      |  0
 drivers/pci/{host => controller}/pcie-iproc.h      |  0
 drivers/pci/{host => controller}/pcie-mediatek.c   |  0
 drivers/pci/{host => controller}/pcie-mobiveil.c   |  0
 drivers/pci/{host => controller}/pcie-rcar.c       |  0
 .../pci/{host => controller}/pcie-rockchip-ep.c    |  0
 .../pci/{host => controller}/pcie-rockchip-host.c  |  0
 drivers/pci/{host => controller}/pcie-rockchip.c   |  0
 drivers/pci/{host => controller}/pcie-rockchip.h   |  0
 drivers/pci/{host => controller}/pcie-tango.c      |  0
 drivers/pci/{host => controller}/pcie-xilinx-nwl.c |  0
 drivers/pci/{host => controller}/pcie-xilinx.c     |  0
 drivers/pci/{host => controller}/vmd.c             |  0
 64 files changed, 75 insertions(+), 79 deletions(-)
 delete mode 100644 drivers/pci/cadence/Kconfig
 delete mode 100644 drivers/pci/cadence/Makefile
 rename drivers/pci/{host => controller}/Kconfig (90%)
 rename drivers/pci/{host => controller}/Makefile (89%)
 rename drivers/pci/{ => controller}/dwc/Kconfig (100%)
 rename drivers/pci/{ => controller}/dwc/Makefile (100%)
 rename drivers/pci/{ => controller}/dwc/pci-dra7xx.c (99%)
 rename drivers/pci/{ => controller}/dwc/pci-exynos.c (100%)
 rename drivers/pci/{ => controller}/dwc/pci-imx6.c (100%)
 rename drivers/pci/{ => controller}/dwc/pci-keystone-dw.c (100%)
 rename drivers/pci/{ => controller}/dwc/pci-keystone.c (100%)
 rename drivers/pci/{ => controller}/dwc/pci-keystone.h (100%)
 rename drivers/pci/{ => controller}/dwc/pci-layerscape.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-armada8k.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-artpec6.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-designware-ep.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-designware-host.c (99%)
 rename drivers/pci/{ => controller}/dwc/pcie-designware-plat.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-designware.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-designware.h (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-hisi.c (99%)
 rename drivers/pci/{ => controller}/dwc/pcie-histb.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-kirin.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-qcom.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-spear13xx.c (100%)
 rename drivers/pci/{host => controller}/pci-aardvark.c (100%)
 rename drivers/pci/{host => controller}/pci-ftpci100.c (100%)
 rename drivers/pci/{host => controller}/pci-host-common.c (100%)
 rename drivers/pci/{host => controller}/pci-host-generic.c (100%)
 rename drivers/pci/{host => controller}/pci-hyperv.c (100%)
 rename drivers/pci/{host => controller}/pci-mvebu.c (100%)
 rename drivers/pci/{host => controller}/pci-rcar-gen2.c (100%)
 rename drivers/pci/{host => controller}/pci-tegra.c (100%)
 rename drivers/pci/{host => controller}/pci-thunder-ecam.c (100%)
 rename drivers/pci/{host => controller}/pci-thunder-pem.c (100%)
 rename drivers/pci/{host => controller}/pci-v3-semi.c (100%)
 rename drivers/pci/{host => controller}/pci-versatile.c (100%)
 rename drivers/pci/{host => controller}/pci-xgene-msi.c (100%)
 rename drivers/pci/{host => controller}/pci-xgene.c (100%)
 rename drivers/pci/{host => controller}/pcie-altera-msi.c (100%)
 rename drivers/pci/{host => controller}/pcie-altera.c (100%)
 rename drivers/pci/{cadence => controller}/pcie-cadence-ep.c (100%)
 rename drivers/pci/{cadence => controller}/pcie-cadence-host.c (100%)
 rename drivers/pci/{cadence => controller}/pcie-cadence.c (100%)
 rename drivers/pci/{cadence => controller}/pcie-cadence.h (100%)
 rename drivers/pci/{host => controller}/pcie-iproc-bcma.c (100%)
 rename drivers/pci/{host => controller}/pcie-iproc-msi.c (100%)
 rename drivers/pci/{host => controller}/pcie-iproc-platform.c (100%)
 rename drivers/pci/{host => controller}/pcie-iproc.c (100%)
 rename drivers/pci/{host => controller}/pcie-iproc.h (100%)
 rename drivers/pci/{host => controller}/pcie-mediatek.c (100%)
 rename drivers/pci/{host => controller}/pcie-mobiveil.c (100%)
 rename drivers/pci/{host => controller}/pcie-rcar.c (100%)
 rename drivers/pci/{host => controller}/pcie-rockchip-ep.c (100%)
 rename drivers/pci/{host => controller}/pcie-rockchip-host.c (100%)
 rename drivers/pci/{host => controller}/pcie-rockchip.c (100%)
 rename drivers/pci/{host => controller}/pcie-rockchip.h (100%)
 rename drivers/pci/{host => controller}/pcie-tango.c (100%)
 rename drivers/pci/{host => controller}/pcie-xilinx-nwl.c (100%)
 rename drivers/pci/{host => controller}/pcie-xilinx.c (100%)
 rename drivers/pci/{host => controller}/vmd.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4863175..32fbfb3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6611,7 +6611,7 @@ F:	arch/x86/hyperv
 F:	drivers/hid/hid-hyperv.c
 F:	drivers/hv/
 F:	drivers/input/serio/hyperv-keyboard.c
-F:	drivers/pci/host/pci-hyperv.c
+F:	drivers/pci/controller/pci-hyperv.c
 F:	drivers/net/hyperv/
 F:	drivers/scsi/storvsc_drv.c
 F:	drivers/uio/uio_hv_generic.c
@@ -9507,7 +9507,7 @@ M:	Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
-F:	drivers/pci/host/pcie-mobiveil.c
+F:	drivers/pci/controller/pcie-mobiveil.c
 
 MODULE SUPPORT
 M:	Jessica Yu <jeyu@kernel.org>
@@ -10799,7 +10799,7 @@ L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/aardvark-pci.txt
-F:	drivers/pci/host/pci-aardvark.c
+F:	drivers/pci/controller/pci-aardvark.c
 
 PCI DRIVER FOR ALTERA PCIE IP
 M:	Ley Foon Tan <lftan@altera.com>
@@ -10807,7 +10807,7 @@ L:	rfi@lists.rocketboards.org (moderated for non-subscribers)
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/altera-pcie.txt
-F:	drivers/pci/host/pcie-altera.c
+F:	drivers/pci/controller/pcie-altera.c
 
 PCI DRIVER FOR APPLIEDMICRO XGENE
 M:	Tanmay Inamdar <tinamdar@apm.com>
@@ -10815,7 +10815,7 @@ L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/xgene-pci.txt
-F:	drivers/pci/host/pci-xgene.c
+F:	drivers/pci/controller/pci-xgene.c
 
 PCI DRIVER FOR ARM VERSATILE PLATFORM
 M:	Rob Herring <robh@kernel.org>
@@ -10823,7 +10823,7 @@ L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/versatile.txt
-F:	drivers/pci/host/pci-versatile.c
+F:	drivers/pci/controller/pci-versatile.c
 
 PCI DRIVER FOR ARMADA 8K
 M:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
@@ -10831,14 +10831,14 @@ L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/pci-armada8k.txt
-F:	drivers/pci/dwc/pcie-armada8k.c
+F:	drivers/pci/controller/dwc/pcie-armada8k.c
 
 PCI DRIVER FOR CADENCE PCIE IP
 M:	Alan Douglas <adouglas@cadence.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/cdns,*.txt
-F:	drivers/pci/cadence/pcie-cadence*
+F:	drivers/pci/controller/pcie-cadence*
 
 PCI DRIVER FOR FREESCALE LAYERSCAPE
 M:	Minghuan Lian <minghuan.Lian@nxp.com>
@@ -10848,16 +10848,16 @@ L:	linuxppc-dev@lists.ozlabs.org
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
-F:	drivers/pci/dwc/*layerscape*
+F:	drivers/pci/controller/dwc/*layerscape*
 
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
 
 PCI DRIVER FOR IMX6
 M:	Richard Zhu <hongxing.zhu@nxp.com>
@@ -10866,14 +10866,14 @@ L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
-F:	drivers/pci/dwc/*imx6*
+F:	drivers/pci/controller/dwc/*imx6*
 
 PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (VMD)
 M:	Keith Busch <keith.busch@intel.com>
 M:	Jonathan Derrick <jonathan.derrick@intel.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
-F:	drivers/pci/host/vmd.c
+F:	drivers/pci/controller/vmd.c
 
 PCI DRIVER FOR MICROSEMI SWITCHTEC
 M:	Kurt Schwemmer <kurt.schwemmer@microsemi.com>
@@ -10893,7 +10893,7 @@ M:	Jason Cooper <jason@lakedaemon.net>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	drivers/pci/host/*mvebu*
+F:	drivers/pci/controller/*mvebu*
 
 PCI DRIVER FOR NVIDIA TEGRA
 M:	Thierry Reding <thierry.reding@gmail.com>
@@ -10901,14 +10901,14 @@ L:	linux-tegra@vger.kernel.org
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
-F:	drivers/pci/host/pci-tegra.c
+F:	drivers/pci/controller/pci-tegra.c
 
 PCI DRIVER FOR RENESAS R-CAR
 M:	Simon Horman <horms@verge.net.au>
 L:	linux-pci@vger.kernel.org
 L:	linux-renesas-soc@vger.kernel.org
 S:	Maintained
-F:	drivers/pci/host/*rcar*
+F:	drivers/pci/controller/*rcar*
 
 PCI DRIVER FOR SAMSUNG EXYNOS
 M:	Jingoo Han <jingoohan1@gmail.com>
@@ -10916,7 +10916,7 @@ L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-samsung-soc@vger.kernel.org (moderated for non-subscribers)
 S:	Maintained
-F:	drivers/pci/dwc/pci-exynos.c
+F:	drivers/pci/controller/dwc/pci-exynos.c
 
 PCI DRIVER FOR SYNOPSYS DESIGNWARE
 M:	Jingoo Han <jingoohan1@gmail.com>
@@ -10924,7 +10924,7 @@ M:	Joao Pinto <Joao.Pinto@synopsys.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/designware-pcie.txt
-F:	drivers/pci/dwc/*designware*
+F:	drivers/pci/controller/dwc/*designware*
 
 PCI DRIVER FOR TI DRA7XX
 M:	Kishon Vijay Abraham I <kishon@ti.com>
@@ -10932,14 +10932,14 @@ L:	linux-omap@vger.kernel.org
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/ti-pci.txt
-F:	drivers/pci/dwc/pci-dra7xx.c
+F:	drivers/pci/controller/dwc/pci-dra7xx.c
 
 PCI DRIVER FOR TI KEYSTONE
 M:	Murali Karicheri <m-karicheri2@ti.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	drivers/pci/dwc/*keystone*
+F:	drivers/pci/controller/dwc/*keystone*
 
 PCI ENDPOINT SUBSYSTEM
 M:	Kishon Vijay Abraham I <kishon@ti.com>
@@ -10972,7 +10972,7 @@ L:	rfi@lists.rocketboards.org (moderated for non-subscribers)
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
-F:	drivers/pci/host/pcie-altera-msi.c
+F:	drivers/pci/controller/pcie-altera-msi.c
 
 PCI MSI DRIVER FOR APPLIEDMICRO XGENE
 M:	Duc Dang <dhdang@apm.com>
@@ -10980,7 +10980,7 @@ L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
-F:	drivers/pci/host/pci-xgene-msi.c
+F:	drivers/pci/controller/pci-xgene-msi.c
 
 PCI SUBSYSTEM
 M:	Bjorn Helgaas <bhelgaas@google.com>
@@ -11006,9 +11006,7 @@ L:	linux-pci@vger.kernel.org
 Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/
 S:	Supported
-F:	drivers/pci/cadence/
-F:	drivers/pci/host/
-F:	drivers/pci/dwc/
+F:	drivers/pci/controller/
 
 PCIE DRIVER FOR AXIS ARTPEC
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
@@ -11016,7 +11014,7 @@ L:	linux-arm-kernel@axis.com
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/axis,artpec*
-F:	drivers/pci/dwc/*artpec*
+F:	drivers/pci/controller/dwc/*artpec*
 
 PCIE DRIVER FOR CAVIUM THUNDERX
 M:	David Daney <david.daney@cavium.com>
@@ -11024,14 +11022,14 @@ L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/pci-thunder-*
-F:	drivers/pci/host/pci-thunder-*
+F:	drivers/pci/controller/pci-thunder-*
 
 PCIE DRIVER FOR HISILICON
 M:	Zhou Wang <wangzhou1@hisilicon.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
-F:	drivers/pci/dwc/pcie-hisi.c
+F:	drivers/pci/controller/dwc/pcie-hisi.c
 
 PCIE DRIVER FOR HISILICON KIRIN
 M:	Xiaowei Song <songxiaowei@hisilicon.com>
@@ -11039,7 +11037,7 @@ M:	Binghui Wang <wangbinghui@hisilicon.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/pcie-kirin.txt
-F:	drivers/pci/dwc/pcie-kirin.c
+F:	drivers/pci/controller/dwc/pcie-kirin.c
 
 PCIE DRIVER FOR HISILICON STB
 M:	Jianguo Sun <sunjianguo1@huawei.com>
@@ -11047,7 +11045,7 @@ M:	Shawn Guo <shawn.guo@linaro.org>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
-F:	drivers/pci/dwc/pcie-histb.c
+F:	drivers/pci/controller/dwc/pcie-histb.c
 
 PCIE DRIVER FOR MEDIATEK
 M:	Ryder Lee <ryder.lee@mediatek.com>
@@ -11055,14 +11053,14 @@ L:	linux-pci@vger.kernel.org
 L:	linux-mediatek@lists.infradead.org
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/mediatek*
-F:	drivers/pci/host/*mediatek*
+F:	drivers/pci/controller/*mediatek*
 
 PCIE DRIVER FOR QUALCOMM MSM
 M:	Stanimir Varbanov <svarbanov@mm-sol.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
-F:	drivers/pci/dwc/*qcom*
+F:	drivers/pci/controller/dwc/*qcom*
 
 PCIE DRIVER FOR ROCKCHIP
 M:	Shawn Lin <shawn.lin@rock-chips.com>
@@ -11070,20 +11068,20 @@ L:	linux-pci@vger.kernel.org
 L:	linux-rockchip@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/rockchip-pcie*
-F:	drivers/pci/host/pcie-rockchip*
+F:	drivers/pci/controller/pcie-rockchip*
 
 PCI DRIVER FOR V3 SEMICONDUCTOR V360EPC
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
-F:	drivers/pci/host/pci-v3-semi.c
+F:	drivers/pci/controller/pci-v3-semi.c
 
 PCIE DRIVER FOR ST SPEAR13XX
 M:	Pratyush Anand <pratyush.anand@gmail.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-F:	drivers/pci/dwc/*spear*
+F:	drivers/pci/controller/dwc/*spear*
 
 PCMCIA SUBSYSTEM
 M:	Dominik Brodowski <linux@dominikbrodowski.net>
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index b2f0763..56ff8f6 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -145,8 +145,6 @@ config PCI_HYPERV
           PCI devices from a PCI backend to support PCI driver domains.
 
 source "drivers/pci/hotplug/Kconfig"
-source "drivers/pci/cadence/Kconfig"
-source "drivers/pci/dwc/Kconfig"
-source "drivers/pci/host/Kconfig"
+source "drivers/pci/controller/Kconfig"
 source "drivers/pci/endpoint/Kconfig"
 source "drivers/pci/switch/Kconfig"
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 84c9eef..5352019 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -28,14 +28,10 @@ obj-$(CONFIG_PCI_PF_STUB)	+= pci-pf-stub.o
 obj-$(CONFIG_PCI_ECAM)		+= ecam.o
 obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 
-obj-y				+= host/
+obj-y				+= controller/
 obj-y				+= switch/
 
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
 
-obj-$(CONFIG_PCIE_CADENCE)	+= cadence/
-# pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
-obj-y				+= dwc/
-
 ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
diff --git a/drivers/pci/cadence/Kconfig b/drivers/pci/cadence/Kconfig
deleted file mode 100644
index e6824cb..0000000
--- a/drivers/pci/cadence/Kconfig
+++ /dev/null
@@ -1,27 +0,0 @@
-menu "Cadence PCIe controllers support"
-
-config PCIE_CADENCE
-	bool
-
-config PCIE_CADENCE_HOST
-	bool "Cadence PCIe host controller"
-	depends on OF
-	depends on PCI
-	select IRQ_DOMAIN
-	select PCIE_CADENCE
-	help
-	  Say Y here if you want to support the Cadence PCIe controller in host
-	  mode. This PCIe controller may be embedded into many different vendors
-	  SoCs.
-
-config PCIE_CADENCE_EP
-	bool "Cadence PCIe endpoint controller"
-	depends on OF
-	depends on PCI_ENDPOINT
-	select PCIE_CADENCE
-	help
-	  Say Y here if you want to support the Cadence PCIe  controller in
-	  endpoint mode. This PCIe controller may be embedded into many
-	  different vendors SoCs.
-
-endmenu
diff --git a/drivers/pci/cadence/Makefile b/drivers/pci/cadence/Makefile
deleted file mode 100644
index 719392b..0000000
--- a/drivers/pci/cadence/Makefile
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
-obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
-obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/controller/Kconfig
similarity index 90%
rename from drivers/pci/host/Kconfig
rename to drivers/pci/controller/Kconfig
index 09a9ace..511e486 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-menu "PCI host controller drivers"
+menu "PCI controller drivers"
 	depends on PCI
 
 config PCI_MVEBU
@@ -19,6 +19,34 @@ config PCI_AARDVARK
 	 controller is part of the South Bridge of the Marvel Armada
 	 3700 SoC.
 
+menu "Cadence PCIe controllers support"
+
+config PCIE_CADENCE
+	bool
+
+config PCIE_CADENCE_HOST
+	bool "Cadence PCIe host controller"
+	depends on OF
+	depends on PCI
+	select IRQ_DOMAIN
+	select PCIE_CADENCE
+	help
+	  Say Y here if you want to support the Cadence PCIe controller in host
+	  mode. This PCIe controller may be embedded into many different vendors
+	  SoCs.
+
+config PCIE_CADENCE_EP
+	bool "Cadence PCIe endpoint controller"
+	depends on OF
+	depends on PCI_ENDPOINT
+	select PCIE_CADENCE
+	help
+	  Say Y here if you want to support the Cadence PCIe  controller in
+	  endpoint mode. This PCIe controller may be embedded into many
+	  different vendors SoCs.
+
+endmenu
+
 config PCIE_XILINX_NWL
 	bool "NWL PCIe Core"
 	depends on ARCH_ZYNQMP || COMPILE_TEST
@@ -242,4 +270,5 @@ config VMD
 	  To compile this driver as a module, choose M here: the
 	  module will be called vmd.
 
+source "drivers/pci/controller/dwc/Kconfig"
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/controller/Makefile
similarity index 89%
rename from drivers/pci/host/Makefile
rename to drivers/pci/controller/Makefile
index 11d21b0..24322b9 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
+obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
+obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
 obj-$(CONFIG_PCI_FTPCI100) += pci-ftpci100.o
 obj-$(CONFIG_PCI_HYPERV) += pci-hyperv.o
 obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
@@ -25,6 +28,9 @@ obj-$(CONFIG_PCIE_ROCKCHIP_HOST) += pcie-rockchip-host.o
 obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
 obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
 obj-$(CONFIG_VMD) += vmd.o
+# pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
+obj-y				+= dwc/
+
 
 # The following drivers are for devices that use the generic ACPI
 # pci_root.c driver but don't support standard ECAM config access.
diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
similarity index 100%
rename from drivers/pci/dwc/Kconfig
rename to drivers/pci/controller/dwc/Kconfig
diff --git a/drivers/pci/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
similarity index 100%
rename from drivers/pci/dwc/Makefile
rename to drivers/pci/controller/dwc/Makefile
diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
similarity index 99%
rename from drivers/pci/dwc/pci-dra7xx.c
rename to drivers/pci/controller/dwc/pci-dra7xx.c
index f688204..cfaeef8 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -27,7 +27,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 
-#include "../pci.h"
+#include "../../pci.h"
 #include "pcie-designware.h"
 
 /* PCIe controller wrapper DRA7XX configuration registers */
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
similarity index 99%
rename from drivers/pci/dwc/pcie-designware-host.c
rename to drivers/pci/controller/dwc/pcie-designware-host.c
index cba1432..781aa03 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -15,7 +15,7 @@
 #include <linux/pci_regs.h>
 #include <linux/platform_device.h>
 
-#include "../pci.h"
+#include "../../pci.h"
 #include "pcie-designware.h"
 
 static struct pci_ops dw_pcie_ops;
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
diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
similarity index 100%
rename from drivers/pci/host/pci-aardvark.c
rename to drivers/pci/controller/pci-aardvark.c
diff --git a/drivers/pci/host/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
similarity index 100%
rename from drivers/pci/host/pci-ftpci100.c
rename to drivers/pci/controller/pci-ftpci100.c
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
diff --git a/drivers/pci/host/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
similarity index 100%
rename from drivers/pci/host/pci-v3-semi.c
rename to drivers/pci/controller/pci-v3-semi.c
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
diff --git a/drivers/pci/cadence/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
similarity index 100%
rename from drivers/pci/cadence/pcie-cadence-ep.c
rename to drivers/pci/controller/pcie-cadence-ep.c
diff --git a/drivers/pci/cadence/pcie-cadence-host.c b/drivers/pci/controller/pcie-cadence-host.c
similarity index 100%
rename from drivers/pci/cadence/pcie-cadence-host.c
rename to drivers/pci/controller/pcie-cadence-host.c
diff --git a/drivers/pci/cadence/pcie-cadence.c b/drivers/pci/controller/pcie-cadence.c
similarity index 100%
rename from drivers/pci/cadence/pcie-cadence.c
rename to drivers/pci/controller/pcie-cadence.c
diff --git a/drivers/pci/cadence/pcie-cadence.h b/drivers/pci/controller/pcie-cadence.h
similarity index 100%
rename from drivers/pci/cadence/pcie-cadence.h
rename to drivers/pci/controller/pcie-cadence.h
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
diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
similarity index 100%
rename from drivers/pci/host/pcie-mediatek.c
rename to drivers/pci/controller/pcie-mediatek.c
diff --git a/drivers/pci/host/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
similarity index 100%
rename from drivers/pci/host/pcie-mobiveil.c
rename to drivers/pci/controller/pcie-mobiveil.c
diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
similarity index 100%
rename from drivers/pci/host/pcie-rcar.c
rename to drivers/pci/controller/pcie-rcar.c
diff --git a/drivers/pci/host/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
similarity index 100%
rename from drivers/pci/host/pcie-rockchip-ep.c
rename to drivers/pci/controller/pcie-rockchip-ep.c
diff --git a/drivers/pci/host/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
similarity index 100%
rename from drivers/pci/host/pcie-rockchip-host.c
rename to drivers/pci/controller/pcie-rockchip-host.c
diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
similarity index 100%
rename from drivers/pci/host/pcie-rockchip.c
rename to drivers/pci/controller/pcie-rockchip.c
diff --git a/drivers/pci/host/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
similarity index 100%
rename from drivers/pci/host/pcie-rockchip.h
rename to drivers/pci/controller/pcie-rockchip.h
diff --git a/drivers/pci/host/pcie-tango.c b/drivers/pci/controller/pcie-tango.c
similarity index 100%
rename from drivers/pci/host/pcie-tango.c
rename to drivers/pci/controller/pcie-tango.c
diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
similarity index 100%
rename from drivers/pci/host/pcie-xilinx-nwl.c
rename to drivers/pci/controller/pcie-xilinx-nwl.c
diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
similarity index 100%
rename from drivers/pci/host/pcie-xilinx.c
rename to drivers/pci/controller/pcie-xilinx.c
diff --git a/drivers/pci/host/vmd.c b/drivers/pci/controller/vmd.c
similarity index 100%
rename from drivers/pci/host/vmd.c
rename to drivers/pci/controller/vmd.c
-- 
1.9.1
