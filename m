Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:42240 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750814AbcL1N6M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Dec 2016 08:58:12 -0500
Subject: Re: [PATCH] pci: rename *host* directory to *controller*
To: Christoph Hellwig <hch@infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <1482912577-31356-1-git-send-email-kishon@ti.com>
 <20161228092228.GA14025@infradead.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <nsekhar@ti.com>, Linus Torvalds <torvalds@linux-foundation.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <fa775e80-68cc-0d76-855d-c7e64f8bf1fc@synopsys.com>
Date: Wed, 28 Dec 2016 13:57:13 +0000
MIME-Version: 1.0
In-Reply-To: <20161228092228.GA14025@infradead.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hello,

Às 9:22 AM de 12/28/2016, Christoph Hellwig escreveu:
> On Wed, Dec 28, 2016 at 01:39:37PM +0530, Kishon Vijay Abraham I wrote:
>> Hi Bjorn,
>>
>> As discussed during our LPC discussions, I'm posting the rename patch
>> here. I'll post the rest of EP series before the next merge window.
>>
>> There might be hiccups because of this renaming but feel this is
>> necessary for long-term maintenance.
> 
> if we do this rename it would be great to get it to Linus NOW after
> -rc1 as that minimizes the impact on the 4.11 merge window.

Rename it to controller is a bit vague I thing since we have the PCI Endpoint IP
also. Wouldn't be better to name it rc_controller?

> 
>>
>> Thanks
>> Kishon
>>
>>  MAINTAINERS                                        |   52 ++++++++++----------
>>  drivers/pci/Kconfig                                |    2 +-
>>  drivers/pci/Makefile                               |    2 +-
>>  drivers/pci/{host => controller}/Kconfig           |    0
>>  drivers/pci/{host => controller}/Makefile          |    0
>>  drivers/pci/{host => controller}/pci-aardvark.c    |    0
>>  drivers/pci/{host => controller}/pci-dra7xx.c      |    0
>>  drivers/pci/{host => controller}/pci-exynos.c      |    0
>>  drivers/pci/{host => controller}/pci-host-common.c |    0
>>  .../pci/{host => controller}/pci-host-generic.c    |    0
>>  drivers/pci/{host => controller}/pci-hyperv.c      |    0
>>  drivers/pci/{host => controller}/pci-imx6.c        |    0
>>  drivers/pci/{host => controller}/pci-keystone-dw.c |    0
>>  drivers/pci/{host => controller}/pci-keystone.c    |    0
>>  drivers/pci/{host => controller}/pci-keystone.h    |    0
>>  drivers/pci/{host => controller}/pci-layerscape.c  |    0
>>  drivers/pci/{host => controller}/pci-mvebu.c       |    0
>>  drivers/pci/{host => controller}/pci-rcar-gen2.c   |    0
>>  drivers/pci/{host => controller}/pci-tegra.c       |    0
>>  .../pci/{host => controller}/pci-thunder-ecam.c    |    0
>>  drivers/pci/{host => controller}/pci-thunder-pem.c |    0
>>  drivers/pci/{host => controller}/pci-versatile.c   |    0
>>  drivers/pci/{host => controller}/pci-xgene-msi.c   |    0
>>  drivers/pci/{host => controller}/pci-xgene.c       |    0
>>  drivers/pci/{host => controller}/pcie-altera-msi.c |    0
>>  drivers/pci/{host => controller}/pcie-altera.c     |    0
>>  drivers/pci/{host => controller}/pcie-armada8k.c   |    0
>>  drivers/pci/{host => controller}/pcie-artpec6.c    |    0
>>  .../{host => controller}/pcie-designware-plat.c    |    0
>>  drivers/pci/{host => controller}/pcie-designware.c |    0
>>  drivers/pci/{host => controller}/pcie-designware.h |    0
>>  drivers/pci/{host => controller}/pcie-hisi.c       |    0
>>  drivers/pci/{host => controller}/pcie-iproc-bcma.c |    0
>>  drivers/pci/{host => controller}/pcie-iproc-msi.c  |    0
>>  .../pci/{host => controller}/pcie-iproc-platform.c |    0
>>  drivers/pci/{host => controller}/pcie-iproc.c      |    0
>>  drivers/pci/{host => controller}/pcie-iproc.h      |    0
>>  drivers/pci/{host => controller}/pcie-qcom.c       |    0
>>  drivers/pci/{host => controller}/pcie-rcar.c       |    0
>>  drivers/pci/{host => controller}/pcie-rockchip.c   |    0
>>  drivers/pci/{host => controller}/pcie-spear13xx.c  |    0
>>  drivers/pci/{host => controller}/pcie-xilinx-nwl.c |    0
>>  drivers/pci/{host => controller}/pcie-xilinx.c     |    0
>>  drivers/pci/{host => controller}/vmd.c             |    0
>>  44 files changed, 28 insertions(+), 28 deletions(-)
>>  rename drivers/pci/{host => controller}/Kconfig (100%)
>>  rename drivers/pci/{host => controller}/Makefile (100%)
>>  rename drivers/pci/{host => controller}/pci-aardvark.c (100%)
>>  rename drivers/pci/{host => controller}/pci-dra7xx.c (100%)
>>  rename drivers/pci/{host => controller}/pci-exynos.c (100%)
>>  rename drivers/pci/{host => controller}/pci-host-common.c (100%)
>>  rename drivers/pci/{host => controller}/pci-host-generic.c (100%)
>>  rename drivers/pci/{host => controller}/pci-hyperv.c (100%)
>>  rename drivers/pci/{host => controller}/pci-imx6.c (100%)
>>  rename drivers/pci/{host => controller}/pci-keystone-dw.c (100%)
>>  rename drivers/pci/{host => controller}/pci-keystone.c (100%)
>>  rename drivers/pci/{host => controller}/pci-keystone.h (100%)
>>  rename drivers/pci/{host => controller}/pci-layerscape.c (100%)
>>  rename drivers/pci/{host => controller}/pci-mvebu.c (100%)
>>  rename drivers/pci/{host => controller}/pci-rcar-gen2.c (100%)
>>  rename drivers/pci/{host => controller}/pci-tegra.c (100%)
>>  rename drivers/pci/{host => controller}/pci-thunder-ecam.c (100%)
>>  rename drivers/pci/{host => controller}/pci-thunder-pem.c (100%)
>>  rename drivers/pci/{host => controller}/pci-versatile.c (100%)
>>  rename drivers/pci/{host => controller}/pci-xgene-msi.c (100%)
>>  rename drivers/pci/{host => controller}/pci-xgene.c (100%)
>>  rename drivers/pci/{host => controller}/pcie-altera-msi.c (100%)
>>  rename drivers/pci/{host => controller}/pcie-altera.c (100%)
>>  rename drivers/pci/{host => controller}/pcie-armada8k.c (100%)
>>  rename drivers/pci/{host => controller}/pcie-artpec6.c (100%)
>>  rename drivers/pci/{host => controller}/pcie-designware-plat.c (100%)
>>  rename drivers/pci/{host => controller}/pcie-designware.c (100%)
>>  rename drivers/pci/{host => controller}/pcie-designware.h (100%)
>>  rename drivers/pci/{host => controller}/pcie-hisi.c (100%)
>>  rename drivers/pci/{host => controller}/pcie-iproc-bcma.c (100%)
>>  rename drivers/pci/{host => controller}/pcie-iproc-msi.c (100%)
>>  rename drivers/pci/{host => controller}/pcie-iproc-platform.c (100%)
>>  rename drivers/pci/{host => controller}/pcie-iproc.c (100%)
>>  rename drivers/pci/{host => controller}/pcie-iproc.h (100%)
>>  rename drivers/pci/{host => controller}/pcie-qcom.c (100%)
>>  rename drivers/pci/{host => controller}/pcie-rcar.c (100%)
>>  rename drivers/pci/{host => controller}/pcie-rockchip.c (100%)
>>  rename drivers/pci/{host => controller}/pcie-spear13xx.c (100%)
>>  rename drivers/pci/{host => controller}/pcie-xilinx-nwl.c (100%)
>>  rename drivers/pci/{host => controller}/pcie-xilinx.c (100%)
>>  rename drivers/pci/{host => controller}/vmd.c (100%)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index cfff2c9..2ac7a4b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -5969,7 +5969,7 @@ F:	arch/x86/kernel/cpu/mshyperv.c
>>  F:	drivers/hid/hid-hyperv.c
>>  F:	drivers/hv/
>>  F:	drivers/input/serio/hyperv-keyboard.c
>> -F:	drivers/pci/host/pci-hyperv.c
>> +F:	drivers/pci/controller/pci-hyperv.c
>>  F:	drivers/net/hyperv/
>>  F:	drivers/scsi/storvsc_drv.c
>>  F:	drivers/uio/uio_hv_generic.c
>> @@ -9413,7 +9413,7 @@ L:	rfi@lists.rocketboards.org (moderated for non-subscribers)
>>  L:	linux-pci@vger.kernel.org
>>  S:	Supported
>>  F:	Documentation/devicetree/bindings/pci/altera-pcie.txt
>> -F:	drivers/pci/host/pcie-altera.c
>> +F:	drivers/pci/controller/pcie-altera.c
>>  
>>  PCI DRIVER FOR ARM VERSATILE PLATFORM
>>  M:	Rob Herring <robh@kernel.org>
>> @@ -9421,7 +9421,7 @@ L:	linux-pci@vger.kernel.org
>>  L:	linux-arm-kernel@lists.infradead.org
>>  S:	Maintained
>>  F:	Documentation/devicetree/bindings/pci/versatile.txt
>> -F:	drivers/pci/host/pci-versatile.c
>> +F:	drivers/pci/controller/pci-versatile.c
>>  
>>  PCI DRIVER FOR ARMADA 8K
>>  M:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> @@ -9429,7 +9429,7 @@ L:	linux-pci@vger.kernel.org
>>  L:	linux-arm-kernel@lists.infradead.org
>>  S:	Maintained
>>  F:	Documentation/devicetree/bindings/pci/pci-armada8k.txt
>> -F:	drivers/pci/host/pcie-armada8k.c
>> +F:	drivers/pci/controller/pcie-armada8k.c
>>  
>>  PCI DRIVER FOR APPLIEDMICRO XGENE
>>  M:	Tanmay Inamdar <tinamdar@apm.com>
>> @@ -9437,7 +9437,7 @@ L:	linux-pci@vger.kernel.org
>>  L:	linux-arm-kernel@lists.infradead.org
>>  S:	Maintained
>>  F:	Documentation/devicetree/bindings/pci/xgene-pci.txt
>> -F:	drivers/pci/host/pci-xgene.c
>> +F:	drivers/pci/controller/pci-xgene.c
>>  
>>  PCI DRIVER FOR FREESCALE LAYERSCAPE
>>  M:	Minghuan Lian <minghuan.Lian@freescale.com>
>> @@ -9447,7 +9447,7 @@ L:	linuxppc-dev@lists.ozlabs.org
>>  L:	linux-pci@vger.kernel.org
>>  L:	linux-arm-kernel@lists.infradead.org
>>  S:	Maintained
>> -F:	drivers/pci/host/*layerscape*
>> +F:	drivers/pci/controller/*layerscape*
>>  
>>  PCI DRIVER FOR IMX6
>>  M:	Richard Zhu <hongxing.zhu@nxp.com>
>> @@ -9456,14 +9456,14 @@ L:	linux-pci@vger.kernel.org
>>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>  S:	Maintained
>>  F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
>> -F:	drivers/pci/host/*imx6*
>> +F:	drivers/pci/controller/*imx6*
>>  
>>  PCI DRIVER FOR TI KEYSTONE
>>  M:	Murali Karicheri <m-karicheri2@ti.com>
>>  L:	linux-pci@vger.kernel.org
>>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>  S:	Maintained
>> -F:	drivers/pci/host/*keystone*
>> +F:	drivers/pci/controller/*keystone*
>>  
>>  PCI DRIVER FOR MVEBU (Marvell Armada 370 and Armada XP SOC support)
>>  M:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> @@ -9471,7 +9471,7 @@ M:	Jason Cooper <jason@lakedaemon.net>
>>  L:	linux-pci@vger.kernel.org
>>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>  S:	Maintained
>> -F:	drivers/pci/host/*mvebu*
>> +F:	drivers/pci/controller/*mvebu*
>>  
>>  PCI DRIVER FOR AARDVARK (Marvell Armada 3700)
>>  M:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> @@ -9479,7 +9479,7 @@ L:	linux-pci@vger.kernel.org
>>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>  S:	Maintained
>>  F:	Documentation/devicetree/bindings/pci/aardvark-pci.txt
>> -F:	drivers/pci/host/pci-aardvark.c
>> +F:	drivers/pci/controller/pci-aardvark.c
>>  
>>  PCI DRIVER FOR NVIDIA TEGRA
>>  M:	Thierry Reding <thierry.reding@gmail.com>
>> @@ -9487,7 +9487,7 @@ L:	linux-tegra@vger.kernel.org
>>  L:	linux-pci@vger.kernel.org
>>  S:	Supported
>>  F:	Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
>> -F:	drivers/pci/host/pci-tegra.c
>> +F:	drivers/pci/controller/pci-tegra.c
>>  
>>  PCI DRIVER FOR TI DRA7XX
>>  M:	Kishon Vijay Abraham I <kishon@ti.com>
>> @@ -9495,14 +9495,14 @@ L:	linux-omap@vger.kernel.org
>>  L:	linux-pci@vger.kernel.org
>>  S:	Supported
>>  F:	Documentation/devicetree/bindings/pci/ti-pci.txt
>> -F:	drivers/pci/host/pci-dra7xx.c
>> +F:	drivers/pci/controller/pci-dra7xx.c
>>  
>>  PCI DRIVER FOR RENESAS R-CAR
>>  M:	Simon Horman <horms@verge.net.au>
>>  L:	linux-pci@vger.kernel.org
>>  L:	linux-renesas-soc@vger.kernel.org
>>  S:	Maintained
>> -F:	drivers/pci/host/*rcar*
>> +F:	drivers/pci/controller/*rcar*
>>  
>>  PCI DRIVER FOR SAMSUNG EXYNOS
>>  M:	Jingoo Han <jingoohan1@gmail.com>
>> @@ -9510,7 +9510,7 @@ L:	linux-pci@vger.kernel.org
>>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>  L:	linux-samsung-soc@vger.kernel.org (moderated for non-subscribers)
>>  S:	Maintained
>> -F:	drivers/pci/host/pci-exynos.c
>> +F:	drivers/pci/controller/pci-exynos.c
>>  
>>  PCI DRIVER FOR SYNOPSIS DESIGNWARE
>>  M:	Jingoo Han <jingoohan1@gmail.com>
>> @@ -9518,7 +9518,7 @@ M:	Joao Pinto <Joao.Pinto@synopsys.com>
>>  L:	linux-pci@vger.kernel.org
>>  S:	Maintained
>>  F:	Documentation/devicetree/bindings/pci/designware-pcie.txt
>> -F:	drivers/pci/host/*designware*
>> +F:	drivers/pci/controller/*designware*
>>  
>>  PCI DRIVER FOR GENERIC OF HOSTS
>>  M:	Will Deacon <will.deacon@arm.com>
>> @@ -9526,20 +9526,20 @@ L:	linux-pci@vger.kernel.org
>>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>  S:	Maintained
>>  F:	Documentation/devicetree/bindings/pci/host-generic-pci.txt
>> -F:	drivers/pci/host/pci-host-common.c
>> -F:	drivers/pci/host/pci-host-generic.c
>> +F:	drivers/pci/controller/pci-host-common.c
>> +F:	drivers/pci/controller/pci-host-generic.c
>>  
>>  PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (VMD)
>>  M:	Keith Busch <keith.busch@intel.com>
>>  L:	linux-pci@vger.kernel.org
>>  S:	Supported
>> -F:	drivers/pci/host/vmd.c
>> +F:	drivers/pci/controller/vmd.c
>>  
>>  PCIE DRIVER FOR ST SPEAR13XX
>>  M:	Pratyush Anand <pratyush.anand@gmail.com>
>>  L:	linux-pci@vger.kernel.org
>>  S:	Maintained
>> -F:	drivers/pci/host/*spear*
>> +F:	drivers/pci/controller/*spear*
>>  
>>  PCI MSI DRIVER FOR ALTERA MSI IP
>>  M:	Ley Foon Tan <lftan@altera.com>
>> @@ -9547,7 +9547,7 @@ L:	rfi@lists.rocketboards.org (moderated for non-subscribers)
>>  L:	linux-pci@vger.kernel.org
>>  S:	Supported
>>  F:	Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
>> -F:	drivers/pci/host/pcie-altera-msi.c
>> +F:	drivers/pci/controller/pcie-altera-msi.c
>>  
>>  PCI MSI DRIVER FOR APPLIEDMICRO XGENE
>>  M:	Duc Dang <dhdang@apm.com>
>> @@ -9555,7 +9555,7 @@ L:	linux-pci@vger.kernel.org
>>  L:	linux-arm-kernel@lists.infradead.org
>>  S:	Maintained
>>  F:	Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
>> -F:	drivers/pci/host/pci-xgene-msi.c
>> +F:	drivers/pci/controller/pci-xgene-msi.c
>>  
>>  PCIE DRIVER FOR AXIS ARTPEC
>>  M:	Niklas Cassel <niklas.cassel@axis.com>
>> @@ -9564,7 +9564,7 @@ L:	linux-arm-kernel@axis.com
>>  L:	linux-pci@vger.kernel.org
>>  S:	Maintained
>>  F:	Documentation/devicetree/bindings/pci/axis,artpec*
>> -F:	drivers/pci/host/*artpec*
>> +F:	drivers/pci/controller/*artpec*
>>  
>>  PCIE DRIVER FOR HISILICON
>>  M:	Zhou Wang <wangzhou1@hisilicon.com>
>> @@ -9572,7 +9572,7 @@ M:	Gabriele Paoloni <gabriele.paoloni@huawei.com>
>>  L:	linux-pci@vger.kernel.org
>>  S:	Maintained
>>  F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
>> -F:	drivers/pci/host/pcie-hisi.c
>> +F:	drivers/pci/controller/pcie-hisi.c
>>  
>>  PCIE DRIVER FOR ROCKCHIP
>>  M:	Shawn Lin <shawn.lin@rock-chips.com>
>> @@ -9581,14 +9581,14 @@ L:	linux-pci@vger.kernel.org
>>  L:	linux-rockchip@lists.infradead.org
>>  S:	Maintained
>>  F:	Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>> -F:	drivers/pci/host/pcie-rockchip.c
>> +F:	drivers/pci/controller/pcie-rockchip.c
>>  
>>  PCIE DRIVER FOR QUALCOMM MSM
>>  M:     Stanimir Varbanov <svarbanov@mm-sol.com>
>>  L:     linux-pci@vger.kernel.org
>>  L:     linux-arm-msm@vger.kernel.org
>>  S:     Maintained
>> -F:     drivers/pci/host/*qcom*
>> +F:     drivers/pci/controller/*qcom*
>>  
>>  PCIE DRIVER FOR CAVIUM THUNDERX
>>  M:	David Daney <david.daney@cavium.com>
>> @@ -9596,7 +9596,7 @@ L:	linux-pci@vger.kernel.org
>>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>  S:	Supported
>>  F:	Documentation/devicetree/bindings/pci/pci-thunder-*
>> -F:	drivers/pci/host/pci-thunder-*
>> +F:	drivers/pci/controller/pci-thunder-*
>>  
>>  PCMCIA SUBSYSTEM
>>  P:	Linux PCMCIA Team
>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>> index 6555eb7..fa56abd 100644
>> --- a/drivers/pci/Kconfig
>> +++ b/drivers/pci/Kconfig
>> @@ -132,4 +132,4 @@ config PCI_HYPERV
>>            PCI devices from a PCI backend to support PCI driver domains.
>>  
>>  source "drivers/pci/hotplug/Kconfig"
>> -source "drivers/pci/host/Kconfig"
>> +source "drivers/pci/controller/Kconfig"
>> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
>> index 8db5079..94bf91d 100644
>> --- a/drivers/pci/Makefile
>> +++ b/drivers/pci/Makefile
>> @@ -67,4 +67,4 @@ obj-$(CONFIG_OF) += of.o
>>  ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
>>  
>>  # PCI host controller drivers
>> -obj-y += host/
>> +obj-y += controller/
>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/controller/Kconfig
>> similarity index 100%
>> rename from drivers/pci/host/Kconfig
>> rename to drivers/pci/controller/Kconfig
>> diff --git a/drivers/pci/host/Makefile b/drivers/pci/controller/Makefile
>> similarity index 100%
>> rename from drivers/pci/host/Makefile
>> rename to drivers/pci/controller/Makefile
>> diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
>> similarity index 100%
>> rename from drivers/pci/host/pci-aardvark.c
>> rename to drivers/pci/controller/pci-aardvark.c
>> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/controller/pci-dra7xx.c
>> similarity index 100%
>> rename from drivers/pci/host/pci-dra7xx.c
>> rename to drivers/pci/controller/pci-dra7xx.c
>> diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/controller/pci-exynos.c
>> similarity index 100%
>> rename from drivers/pci/host/pci-exynos.c
>> rename to drivers/pci/controller/pci-exynos.c
>> diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
>> similarity index 100%
>> rename from drivers/pci/host/pci-host-common.c
>> rename to drivers/pci/controller/pci-host-common.c
>> diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/controller/pci-host-generic.c
>> similarity index 100%
>> rename from drivers/pci/host/pci-host-generic.c
>> rename to drivers/pci/controller/pci-host-generic.c
>> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
>> similarity index 100%
>> rename from drivers/pci/host/pci-hyperv.c
>> rename to drivers/pci/controller/pci-hyperv.c
>> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/controller/pci-imx6.c
>> similarity index 100%
>> rename from drivers/pci/host/pci-imx6.c
>> rename to drivers/pci/controller/pci-imx6.c
>> diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/controller/pci-keystone-dw.c
>> similarity index 100%
>> rename from drivers/pci/host/pci-keystone-dw.c
>> rename to drivers/pci/controller/pci-keystone-dw.c
>> diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/controller/pci-keystone.c
>> similarity index 100%
>> rename from drivers/pci/host/pci-keystone.c
>> rename to drivers/pci/controller/pci-keystone.c
>> diff --git a/drivers/pci/host/pci-keystone.h b/drivers/pci/controller/pci-keystone.h
>> similarity index 100%
>> rename from drivers/pci/host/pci-keystone.h
>> rename to drivers/pci/controller/pci-keystone.h
>> diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/controller/pci-layerscape.c
>> similarity index 100%
>> rename from drivers/pci/host/pci-layerscape.c
>> rename to drivers/pci/controller/pci-layerscape.c
>> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
>> similarity index 100%
>> rename from drivers/pci/host/pci-mvebu.c
>> rename to drivers/pci/controller/pci-mvebu.c
>> diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/controller/pci-rcar-gen2.c
>> similarity index 100%
>> rename from drivers/pci/host/pci-rcar-gen2.c
>> rename to drivers/pci/controller/pci-rcar-gen2.c
>> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>> similarity index 100%
>> rename from drivers/pci/host/pci-tegra.c
>> rename to drivers/pci/controller/pci-tegra.c
>> diff --git a/drivers/pci/host/pci-thunder-ecam.c b/drivers/pci/controller/pci-thunder-ecam.c
>> similarity index 100%
>> rename from drivers/pci/host/pci-thunder-ecam.c
>> rename to drivers/pci/controller/pci-thunder-ecam.c
>> diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/controller/pci-thunder-pem.c
>> similarity index 100%
>> rename from drivers/pci/host/pci-thunder-pem.c
>> rename to drivers/pci/controller/pci-thunder-pem.c
>> diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/controller/pci-versatile.c
>> similarity index 100%
>> rename from drivers/pci/host/pci-versatile.c
>> rename to drivers/pci/controller/pci-versatile.c
>> diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
>> similarity index 100%
>> rename from drivers/pci/host/pci-xgene-msi.c
>> rename to drivers/pci/controller/pci-xgene-msi.c
>> diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
>> similarity index 100%
>> rename from drivers/pci/host/pci-xgene.c
>> rename to drivers/pci/controller/pci-xgene.c
>> diff --git a/drivers/pci/host/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
>> similarity index 100%
>> rename from drivers/pci/host/pcie-altera-msi.c
>> rename to drivers/pci/controller/pcie-altera-msi.c
>> diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
>> similarity index 100%
>> rename from drivers/pci/host/pcie-altera.c
>> rename to drivers/pci/controller/pcie-altera.c
>> diff --git a/drivers/pci/host/pcie-armada8k.c b/drivers/pci/controller/pcie-armada8k.c
>> similarity index 100%
>> rename from drivers/pci/host/pcie-armada8k.c
>> rename to drivers/pci/controller/pcie-armada8k.c
>> diff --git a/drivers/pci/host/pcie-artpec6.c b/drivers/pci/controller/pcie-artpec6.c
>> similarity index 100%
>> rename from drivers/pci/host/pcie-artpec6.c
>> rename to drivers/pci/controller/pcie-artpec6.c
>> diff --git a/drivers/pci/host/pcie-designware-plat.c b/drivers/pci/controller/pcie-designware-plat.c
>> similarity index 100%
>> rename from drivers/pci/host/pcie-designware-plat.c
>> rename to drivers/pci/controller/pcie-designware-plat.c
>> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/controller/pcie-designware.c
>> similarity index 100%
>> rename from drivers/pci/host/pcie-designware.c
>> rename to drivers/pci/controller/pcie-designware.c
>> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/controller/pcie-designware.h
>> similarity index 100%
>> rename from drivers/pci/host/pcie-designware.h
>> rename to drivers/pci/controller/pcie-designware.h
>> diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/controller/pcie-hisi.c
>> similarity index 100%
>> rename from drivers/pci/host/pcie-hisi.c
>> rename to drivers/pci/controller/pcie-hisi.c
>> diff --git a/drivers/pci/host/pcie-iproc-bcma.c b/drivers/pci/controller/pcie-iproc-bcma.c
>> similarity index 100%
>> rename from drivers/pci/host/pcie-iproc-bcma.c
>> rename to drivers/pci/controller/pcie-iproc-bcma.c
>> diff --git a/drivers/pci/host/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
>> similarity index 100%
>> rename from drivers/pci/host/pcie-iproc-msi.c
>> rename to drivers/pci/controller/pcie-iproc-msi.c
>> diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
>> similarity index 100%
>> rename from drivers/pci/host/pcie-iproc-platform.c
>> rename to drivers/pci/controller/pcie-iproc-platform.c
>> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
>> similarity index 100%
>> rename from drivers/pci/host/pcie-iproc.c
>> rename to drivers/pci/controller/pcie-iproc.c
>> diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/controller/pcie-iproc.h
>> similarity index 100%
>> rename from drivers/pci/host/pcie-iproc.h
>> rename to drivers/pci/controller/pcie-iproc.h
>> diff --git a/drivers/pci/host/pcie-qcom.c b/drivers/pci/controller/pcie-qcom.c
>> similarity index 100%
>> rename from drivers/pci/host/pcie-qcom.c
>> rename to drivers/pci/controller/pcie-qcom.c
>> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
>> similarity index 100%
>> rename from drivers/pci/host/pcie-rcar.c
>> rename to drivers/pci/controller/pcie-rcar.c
>> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
>> similarity index 100%
>> rename from drivers/pci/host/pcie-rockchip.c
>> rename to drivers/pci/controller/pcie-rockchip.c
>> diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/controller/pcie-spear13xx.c
>> similarity index 100%
>> rename from drivers/pci/host/pcie-spear13xx.c
>> rename to drivers/pci/controller/pcie-spear13xx.c
>> diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
>> similarity index 100%
>> rename from drivers/pci/host/pcie-xilinx-nwl.c
>> rename to drivers/pci/controller/pcie-xilinx-nwl.c
>> diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
>> similarity index 100%
>> rename from drivers/pci/host/pcie-xilinx.c
>> rename to drivers/pci/controller/pcie-xilinx.c
>> diff --git a/drivers/pci/host/vmd.c b/drivers/pci/controller/vmd.c
>> similarity index 100%
>> rename from drivers/pci/host/vmd.c
>> rename to drivers/pci/controller/vmd.c
>> -- 
>> 1.7.9.5
>>
> ---end quoted text---
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=http-3A__vger.kernel.org_majordomo-2Dinfo.html&d=DgIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=s2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io_kx0&m=ua6BLpQf0eJgdbNFOVgzQdKFvJVUG6amaUtD6saWlr4&s=vOPPYZeKpsBLTIKOYV5jairmzLqfhhjjQrgQH_zfj6w&e= 
> 

