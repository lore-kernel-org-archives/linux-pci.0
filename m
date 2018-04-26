Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56840 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754556AbeDZRFW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Apr 2018 13:05:22 -0400
Date: Thu, 26 Apr 2018 18:05:15 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 01/10] PCI: Rename directory from host to controller
Message-ID: <20180426170515.GA8928@e107981-ln.cambridge.arm.com>
References: <1522630865-151344-1-git-send-email-shawn.lin@rock-chips.com>
 <1522630910-151391-1-git-send-email-shawn.lin@rock-chips.com>
 <20180423143727.GA17979@e107981-ln.cambridge.arm.com>
 <20180425104917.GB15875@e107981-ln.cambridge.arm.com>
 <ac1b92e0-7cfc-6cad-4113-cfd863ede572@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ac1b92e0-7cfc-6cad-4113-cfd863ede572@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 26, 2018 at 08:48:37AM +0800, Shawn Lin wrote:
> Hi Lorenzo,
> 
> On 2018/4/25 18:49, Lorenzo Pieralisi wrote:
> >On Mon, Apr 23, 2018 at 03:37:27PM +0100, Lorenzo Pieralisi wrote:
> >>On Mon, Apr 02, 2018 at 09:01:50AM +0800, Shawn Lin wrote:
> >>>This patch is in preparation for moving back dwc and
> >>>cadence drivers.
> >>
> >>I know we have discussed this before but I would like to get Bjorn's
> >>opinion on this patch - it is quite intrusive and if we decide to do it
> >>I should ask people to rebase all their patches against it, which means
> >>that the sooner we decide what to do the better.
> >
> >Another option would consist in merging this as a second pull request
> >after the pci/host/endpoint changes are merged first, which would avoid
> >asking all outstanding patches author to rebase their series, if we
> >want to remove the per vendor specific directories we have to do something
> >one way or the other,
> 
> Yep, I'm perfact fine with a second pull request for that.The main goal
> of this series is to merge the rockchip ep driver, so this patch is
> quite trivial from this point. Put myself in the shoes, I would be
> reluctunt to do rebase if I was asked to rebase my ongoing
> host/endpoint patch(es) against this patch.
> 
> Anyway, I will rebase my series if needed, when you send PR to Bjorn for
> 4.18 in late -rc, or you could kindly remind me to rebase it. :)

I would start by re-sending this series without the host/controller
renaming, I know that was done before but at this stage I think that's
the better option, this will leave us time to decide on what to do
with the renaming patch later.

Thanks,
Lorenzo

> >Lorenzo
> >
> >>Thanks,
> >>Lorenzo
> >>
> >>>No functional change intended.
> >>>
> >>>Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> >>>---
> >>>
> >>>  MAINTAINERS                                        | 36 +++++++++++-----------
> >>>  drivers/pci/Kconfig                                |  2 +-
> >>>  drivers/pci/Makefile                               |  2 +-
> >>>  drivers/pci/{host => controller}/Kconfig           |  2 +-
> >>>  drivers/pci/{host => controller}/Makefile          |  0
> >>>  drivers/pci/{host => controller}/pci-aardvark.c    |  0
> >>>  drivers/pci/{host => controller}/pci-ftpci100.c    |  0
> >>>  drivers/pci/{host => controller}/pci-host-common.c |  0
> >>>  .../pci/{host => controller}/pci-host-generic.c    |  0
> >>>  drivers/pci/{host => controller}/pci-hyperv.c      |  0
> >>>  drivers/pci/{host => controller}/pci-mvebu.c       |  0
> >>>  drivers/pci/{host => controller}/pci-rcar-gen2.c   |  0
> >>>  drivers/pci/{host => controller}/pci-tegra.c       |  0
> >>>  .../pci/{host => controller}/pci-thunder-ecam.c    |  0
> >>>  drivers/pci/{host => controller}/pci-thunder-pem.c |  0
> >>>  drivers/pci/{host => controller}/pci-v3-semi.c     |  0
> >>>  drivers/pci/{host => controller}/pci-versatile.c   |  0
> >>>  drivers/pci/{host => controller}/pci-xgene-msi.c   |  0
> >>>  drivers/pci/{host => controller}/pci-xgene.c       |  0
> >>>  drivers/pci/{host => controller}/pcie-altera-msi.c |  0
> >>>  drivers/pci/{host => controller}/pcie-altera.c     |  0
> >>>  drivers/pci/{host => controller}/pcie-iproc-bcma.c |  0
> >>>  drivers/pci/{host => controller}/pcie-iproc-msi.c  |  0
> >>>  .../pci/{host => controller}/pcie-iproc-platform.c |  0
> >>>  drivers/pci/{host => controller}/pcie-iproc.c      |  0
> >>>  drivers/pci/{host => controller}/pcie-iproc.h      |  0
> >>>  drivers/pci/{host => controller}/pcie-mediatek.c   |  0
> >>>  drivers/pci/{host => controller}/pcie-rcar.c       |  0
> >>>  drivers/pci/{host => controller}/pcie-rockchip.c   |  0
> >>>  drivers/pci/{host => controller}/pcie-tango.c      |  0
> >>>  drivers/pci/{host => controller}/pcie-xilinx-nwl.c |  0
> >>>  drivers/pci/{host => controller}/pcie-xilinx.c     |  0
> >>>  drivers/pci/{host => controller}/vmd.c             |  0
> >>>  33 files changed, 21 insertions(+), 21 deletions(-)
> >>>  rename drivers/pci/{host => controller}/Kconfig (99%)
> >>>  rename drivers/pci/{host => controller}/Makefile (100%)
> >>>  rename drivers/pci/{host => controller}/pci-aardvark.c (100%)
> >>>  rename drivers/pci/{host => controller}/pci-ftpci100.c (100%)
> >>>  rename drivers/pci/{host => controller}/pci-host-common.c (100%)
> >>>  rename drivers/pci/{host => controller}/pci-host-generic.c (100%)
> >>>  rename drivers/pci/{host => controller}/pci-hyperv.c (100%)
> >>>  rename drivers/pci/{host => controller}/pci-mvebu.c (100%)
> >>>  rename drivers/pci/{host => controller}/pci-rcar-gen2.c (100%)
> >>>  rename drivers/pci/{host => controller}/pci-tegra.c (100%)
> >>>  rename drivers/pci/{host => controller}/pci-thunder-ecam.c (100%)
> >>>  rename drivers/pci/{host => controller}/pci-thunder-pem.c (100%)
> >>>  rename drivers/pci/{host => controller}/pci-v3-semi.c (100%)
> >>>  rename drivers/pci/{host => controller}/pci-versatile.c (100%)
> >>>  rename drivers/pci/{host => controller}/pci-xgene-msi.c (100%)
> >>>  rename drivers/pci/{host => controller}/pci-xgene.c (100%)
> >>>  rename drivers/pci/{host => controller}/pcie-altera-msi.c (100%)
> >>>  rename drivers/pci/{host => controller}/pcie-altera.c (100%)
> >>>  rename drivers/pci/{host => controller}/pcie-iproc-bcma.c (100%)
> >>>  rename drivers/pci/{host => controller}/pcie-iproc-msi.c (100%)
> >>>  rename drivers/pci/{host => controller}/pcie-iproc-platform.c (100%)
> >>>  rename drivers/pci/{host => controller}/pcie-iproc.c (100%)
> >>>  rename drivers/pci/{host => controller}/pcie-iproc.h (100%)
> >>>  rename drivers/pci/{host => controller}/pcie-mediatek.c (100%)
> >>>  rename drivers/pci/{host => controller}/pcie-rcar.c (100%)
> >>>  rename drivers/pci/{host => controller}/pcie-rockchip.c (100%)
> >>>  rename drivers/pci/{host => controller}/pcie-tango.c (100%)
> >>>  rename drivers/pci/{host => controller}/pcie-xilinx-nwl.c (100%)
> >>>  rename drivers/pci/{host => controller}/pcie-xilinx.c (100%)
> >>>  rename drivers/pci/{host => controller}/vmd.c (100%)
> >>>
> >>>diff --git a/MAINTAINERS b/MAINTAINERS
> >>>index 4923621..a4e5971 100644
> >>>--- a/MAINTAINERS
> >>>+++ b/MAINTAINERS
> >>>@@ -6511,7 +6511,7 @@ F:	arch/x86/hyperv
> >>>  F:	drivers/hid/hid-hyperv.c
> >>>  F:	drivers/hv/
> >>>  F:	drivers/input/serio/hyperv-keyboard.c
> >>>-F:	drivers/pci/host/pci-hyperv.c
> >>>+F:	drivers/pci/controller/pci-hyperv.c
> >>>  F:	drivers/net/hyperv/
> >>>  F:	drivers/scsi/storvsc_drv.c
> >>>  F:	drivers/uio/uio_hv_generic.c
> >>>@@ -10628,7 +10628,7 @@ L:	linux-pci@vger.kernel.org
> >>>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> >>>  S:	Maintained
> >>>  F:	Documentation/devicetree/bindings/pci/aardvark-pci.txt
> >>>-F:	drivers/pci/host/pci-aardvark.c
> >>>+F:	drivers/pci/controller/pci-aardvark.c
> >>>  PCI DRIVER FOR ALTERA PCIE IP
> >>>  M:	Ley Foon Tan <lftan@altera.com>
> >>>@@ -10636,7 +10636,7 @@ L:	rfi@lists.rocketboards.org (moderated for non-subscribers)
> >>>  L:	linux-pci@vger.kernel.org
> >>>  S:	Supported
> >>>  F:	Documentation/devicetree/bindings/pci/altera-pcie.txt
> >>>-F:	drivers/pci/host/pcie-altera.c
> >>>+F:	drivers/pci/controller/pcie-altera.c
> >>>  PCI DRIVER FOR APPLIEDMICRO XGENE
> >>>  M:	Tanmay Inamdar <tinamdar@apm.com>
> >>>@@ -10644,7 +10644,7 @@ L:	linux-pci@vger.kernel.org
> >>>  L:	linux-arm-kernel@lists.infradead.org
> >>>  S:	Maintained
> >>>  F:	Documentation/devicetree/bindings/pci/xgene-pci.txt
> >>>-F:	drivers/pci/host/pci-xgene.c
> >>>+F:	drivers/pci/controller/pci-xgene.c
> >>>  PCI DRIVER FOR ARM VERSATILE PLATFORM
> >>>  M:	Rob Herring <robh@kernel.org>
> >>>@@ -10652,7 +10652,7 @@ L:	linux-pci@vger.kernel.org
> >>>  L:	linux-arm-kernel@lists.infradead.org
> >>>  S:	Maintained
> >>>  F:	Documentation/devicetree/bindings/pci/versatile.txt
> >>>-F:	drivers/pci/host/pci-versatile.c
> >>>+F:	drivers/pci/controller/pci-versatile.c
> >>>  PCI DRIVER FOR ARMADA 8K
> >>>  M:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> >>>@@ -10685,8 +10685,8 @@ L:	linux-pci@vger.kernel.org
> >>>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> >>>  S:	Maintained
> >>>  F:	Documentation/devicetree/bindings/pci/host-generic-pci.txt
> >>>-F:	drivers/pci/host/pci-host-common.c
> >>>-F:	drivers/pci/host/pci-host-generic.c
> >>>+F:	drivers/pci/controller/pci-host-common.c
> >>>+F:	drivers/pci/controller/pci-host-generic.c
> >>>  PCI DRIVER FOR IMX6
> >>>  M:	Richard Zhu <hongxing.zhu@nxp.com>
> >>>@@ -10702,7 +10702,7 @@ M:	Keith Busch <keith.busch@intel.com>
> >>>  M:	Jonathan Derrick <jonathan.derrick@intel.com>
> >>>  L:	linux-pci@vger.kernel.org
> >>>  S:	Supported
> >>>-F:	drivers/pci/host/vmd.c
> >>>+F:	drivers/pci/controller/vmd.c
> >>>  PCI DRIVER FOR MICROSEMI SWITCHTEC
> >>>  M:	Kurt Schwemmer <kurt.schwemmer@microsemi.com>
> >>>@@ -10722,7 +10722,7 @@ M:	Jason Cooper <jason@lakedaemon.net>
> >>>  L:	linux-pci@vger.kernel.org
> >>>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> >>>  S:	Maintained
> >>>-F:	drivers/pci/host/*mvebu*
> >>>+F:	drivers/pci/controller/*mvebu*
> >>>  PCI DRIVER FOR NVIDIA TEGRA
> >>>  M:	Thierry Reding <thierry.reding@gmail.com>
> >>>@@ -10730,14 +10730,14 @@ L:	linux-tegra@vger.kernel.org
> >>>  L:	linux-pci@vger.kernel.org
> >>>  S:	Supported
> >>>  F:	Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> >>>-F:	drivers/pci/host/pci-tegra.c
> >>>+F:	drivers/pci/controller/pci-tegra.c
> >>>  PCI DRIVER FOR RENESAS R-CAR
> >>>  M:	Simon Horman <horms@verge.net.au>
> >>>  L:	linux-pci@vger.kernel.org
> >>>  L:	linux-renesas-soc@vger.kernel.org
> >>>  S:	Maintained
> >>>-F:	drivers/pci/host/*rcar*
> >>>+F:	drivers/pci/controller/*rcar*
> >>>  PCI DRIVER FOR SAMSUNG EXYNOS
> >>>  M:	Jingoo Han <jingoohan1@gmail.com>
> >>>@@ -10801,7 +10801,7 @@ L:	rfi@lists.rocketboards.org (moderated for non-subscribers)
> >>>  L:	linux-pci@vger.kernel.org
> >>>  S:	Supported
> >>>  F:	Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
> >>>-F:	drivers/pci/host/pcie-altera-msi.c
> >>>+F:	drivers/pci/controller/pcie-altera-msi.c
> >>>  PCI MSI DRIVER FOR APPLIEDMICRO XGENE
> >>>  M:	Duc Dang <dhdang@apm.com>
> >>>@@ -10809,7 +10809,7 @@ L:	linux-pci@vger.kernel.org
> >>>  L:	linux-arm-kernel@lists.infradead.org
> >>>  S:	Maintained
> >>>  F:	Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
> >>>-F:	drivers/pci/host/pci-xgene-msi.c
> >>>+F:	drivers/pci/controller/pci-xgene-msi.c
> >>>  PCI SUBSYSTEM
> >>>  M:	Bjorn Helgaas <bhelgaas@google.com>
> >>>@@ -10835,7 +10835,7 @@ L:	linux-pci@vger.kernel.org
> >>>  Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
> >>>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/
> >>>  S:	Supported
> >>>-F:	drivers/pci/host/
> >>>+F:	drivers/pci/controller/
> >>>  F:	drivers/pci/dwc/
> >>>  PCIE DRIVER FOR AXIS ARTPEC
> >>>@@ -10853,7 +10853,7 @@ L:	linux-pci@vger.kernel.org
> >>>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> >>>  S:	Supported
> >>>  F:	Documentation/devicetree/bindings/pci/pci-thunder-*
> >>>-F:	drivers/pci/host/pci-thunder-*
> >>>+F:	drivers/pci/controller/pci-thunder-*
> >>>  PCIE DRIVER FOR HISILICON
> >>>  M:	Zhou Wang <wangzhou1@hisilicon.com>
> >>>@@ -10884,7 +10884,7 @@ L:	linux-pci@vger.kernel.org
> >>>  L:	linux-mediatek@lists.infradead.org
> >>>  S:	Supported
> >>>  F:	Documentation/devicetree/bindings/pci/mediatek*
> >>>-F:	drivers/pci/host/*mediatek*
> >>>+F:	drivers/pci/controller/*mediatek*
> >>>  PCIE DRIVER FOR QUALCOMM MSM
> >>>  M:	Stanimir Varbanov <svarbanov@mm-sol.com>
> >>>@@ -10899,14 +10899,14 @@ L:	linux-pci@vger.kernel.org
> >>>  L:	linux-rockchip@lists.infradead.org
> >>>  S:	Maintained
> >>>  F:	Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> >>>-F:	drivers/pci/host/pcie-rockchip.c
> >>>+F:	drivers/pci/controller/pcie-rockchip.c
> >>>  PCI DRIVER FOR V3 SEMICONDUCTOR V360EPC
> >>>  M:	Linus Walleij <linus.walleij@linaro.org>
> >>>  L:	linux-pci@vger.kernel.org
> >>>  S:	Maintained
> >>>  F:	Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
> >>>-F:	drivers/pci/host/pci-v3-semi.c
> >>>+F:	drivers/pci/controller/pci-v3-semi.c
> >>>  PCIE DRIVER FOR ST SPEAR13XX
> >>>  M:	Pratyush Anand <pratyush.anand@gmail.com>
> >>>diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> >>>index 34b56a8..b759b29 100644
> >>>--- a/drivers/pci/Kconfig
> >>>+++ b/drivers/pci/Kconfig
> >>>@@ -138,7 +138,7 @@ config PCI_HYPERV
> >>>  source "drivers/pci/hotplug/Kconfig"
> >>>  source "drivers/pci/cadence/Kconfig"
> >>>+source "drivers/pci/controller/Kconfig"
> >>>  source "drivers/pci/dwc/Kconfig"
> >>>-source "drivers/pci/host/Kconfig"
> >>>  source "drivers/pci/endpoint/Kconfig"
> >>>  source "drivers/pci/switch/Kconfig"
> >>>diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> >>>index 952addc..7769641 100644
> >>>--- a/drivers/pci/Makefile
> >>>+++ b/drivers/pci/Makefile
> >>>@@ -27,7 +27,7 @@ obj-$(CONFIG_PCI_STUB)		+= pci-stub.o
> >>>  obj-$(CONFIG_PCI_ECAM)		+= ecam.o
> >>>  obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
> >>>-obj-y				+= host/
> >>>+obj-y				+= controller/
> >>>  obj-y				+= switch/
> >>>  # Endpoint library must be initialized before its users
> >>>diff --git a/drivers/pci/host/Kconfig b/drivers/pci/controller/Kconfig
> >>>similarity index 99%
> >>>rename from drivers/pci/host/Kconfig
> >>>rename to drivers/pci/controller/Kconfig
> >>>index 0d0177ce..7af83af 100644
> >>>--- a/drivers/pci/host/Kconfig
> >>>+++ b/drivers/pci/controller/Kconfig
> >>>@@ -1,6 +1,6 @@
> >>>  # SPDX-License-Identifier: GPL-2.0
> >>>-menu "PCI host controller drivers"
> >>>+menu "PCI controller drivers"
> >>>  	depends on PCI
> >>>  config PCI_MVEBU
> >>>diff --git a/drivers/pci/host/Makefile b/drivers/pci/controller/Makefile
> >>>similarity index 100%
> >>>rename from drivers/pci/host/Makefile
> >>>rename to drivers/pci/controller/Makefile
> >>>diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> >>>similarity index 100%
> >>>rename from drivers/pci/host/pci-aardvark.c
> >>>rename to drivers/pci/controller/pci-aardvark.c
> >>>diff --git a/drivers/pci/host/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
> >>>similarity index 100%
> >>>rename from drivers/pci/host/pci-ftpci100.c
> >>>rename to drivers/pci/controller/pci-ftpci100.c
> >>>diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> >>>similarity index 100%
> >>>rename from drivers/pci/host/pci-host-common.c
> >>>rename to drivers/pci/controller/pci-host-common.c
> >>>diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/controller/pci-host-generic.c
> >>>similarity index 100%
> >>>rename from drivers/pci/host/pci-host-generic.c
> >>>rename to drivers/pci/controller/pci-host-generic.c
> >>>diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> >>>similarity index 100%
> >>>rename from drivers/pci/host/pci-hyperv.c
> >>>rename to drivers/pci/controller/pci-hyperv.c
> >>>diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> >>>similarity index 100%
> >>>rename from drivers/pci/host/pci-mvebu.c
> >>>rename to drivers/pci/controller/pci-mvebu.c
> >>>diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/controller/pci-rcar-gen2.c
> >>>similarity index 100%
> >>>rename from drivers/pci/host/pci-rcar-gen2.c
> >>>rename to drivers/pci/controller/pci-rcar-gen2.c
> >>>diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> >>>similarity index 100%
> >>>rename from drivers/pci/host/pci-tegra.c
> >>>rename to drivers/pci/controller/pci-tegra.c
> >>>diff --git a/drivers/pci/host/pci-thunder-ecam.c b/drivers/pci/controller/pci-thunder-ecam.c
> >>>similarity index 100%
> >>>rename from drivers/pci/host/pci-thunder-ecam.c
> >>>rename to drivers/pci/controller/pci-thunder-ecam.c
> >>>diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/controller/pci-thunder-pem.c
> >>>similarity index 100%
> >>>rename from drivers/pci/host/pci-thunder-pem.c
> >>>rename to drivers/pci/controller/pci-thunder-pem.c
> >>>diff --git a/drivers/pci/host/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
> >>>similarity index 100%
> >>>rename from drivers/pci/host/pci-v3-semi.c
> >>>rename to drivers/pci/controller/pci-v3-semi.c
> >>>diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/controller/pci-versatile.c
> >>>similarity index 100%
> >>>rename from drivers/pci/host/pci-versatile.c
> >>>rename to drivers/pci/controller/pci-versatile.c
> >>>diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
> >>>similarity index 100%
> >>>rename from drivers/pci/host/pci-xgene-msi.c
> >>>rename to drivers/pci/controller/pci-xgene-msi.c
> >>>diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
> >>>similarity index 100%
> >>>rename from drivers/pci/host/pci-xgene.c
> >>>rename to drivers/pci/controller/pci-xgene.c
> >>>diff --git a/drivers/pci/host/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
> >>>similarity index 100%
> >>>rename from drivers/pci/host/pcie-altera-msi.c
> >>>rename to drivers/pci/controller/pcie-altera-msi.c
> >>>diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
> >>>similarity index 100%
> >>>rename from drivers/pci/host/pcie-altera.c
> >>>rename to drivers/pci/controller/pcie-altera.c
> >>>diff --git a/drivers/pci/host/pcie-iproc-bcma.c b/drivers/pci/controller/pcie-iproc-bcma.c
> >>>similarity index 100%
> >>>rename from drivers/pci/host/pcie-iproc-bcma.c
> >>>rename to drivers/pci/controller/pcie-iproc-bcma.c
> >>>diff --git a/drivers/pci/host/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
> >>>similarity index 100%
> >>>rename from drivers/pci/host/pcie-iproc-msi.c
> >>>rename to drivers/pci/controller/pcie-iproc-msi.c
> >>>diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
> >>>similarity index 100%
> >>>rename from drivers/pci/host/pcie-iproc-platform.c
> >>>rename to drivers/pci/controller/pcie-iproc-platform.c
> >>>diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> >>>similarity index 100%
> >>>rename from drivers/pci/host/pcie-iproc.c
> >>>rename to drivers/pci/controller/pcie-iproc.c
> >>>diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/controller/pcie-iproc.h
> >>>similarity index 100%
> >>>rename from drivers/pci/host/pcie-iproc.h
> >>>rename to drivers/pci/controller/pcie-iproc.h
> >>>diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> >>>similarity index 100%
> >>>rename from drivers/pci/host/pcie-mediatek.c
> >>>rename to drivers/pci/controller/pcie-mediatek.c
> >>>diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> >>>similarity index 100%
> >>>rename from drivers/pci/host/pcie-rcar.c
> >>>rename to drivers/pci/controller/pcie-rcar.c
> >>>diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> >>>similarity index 100%
> >>>rename from drivers/pci/host/pcie-rockchip.c
> >>>rename to drivers/pci/controller/pcie-rockchip.c
> >>>diff --git a/drivers/pci/host/pcie-tango.c b/drivers/pci/controller/pcie-tango.c
> >>>similarity index 100%
> >>>rename from drivers/pci/host/pcie-tango.c
> >>>rename to drivers/pci/controller/pcie-tango.c
> >>>diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> >>>similarity index 100%
> >>>rename from drivers/pci/host/pcie-xilinx-nwl.c
> >>>rename to drivers/pci/controller/pcie-xilinx-nwl.c
> >>>diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
> >>>similarity index 100%
> >>>rename from drivers/pci/host/pcie-xilinx.c
> >>>rename to drivers/pci/controller/pcie-xilinx.c
> >>>diff --git a/drivers/pci/host/vmd.c b/drivers/pci/controller/vmd.c
> >>>similarity index 100%
> >>>rename from drivers/pci/host/vmd.c
> >>>rename to drivers/pci/controller/vmd.c
> >>>-- 
> >>>1.9.1
> >>>
> >>>
> >
> >
> >
> 
