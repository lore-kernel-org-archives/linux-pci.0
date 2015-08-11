Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:25218 "EHLO
	lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261AbbHKHkP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Aug 2015 03:40:15 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: "Wangzhou (B)" <wangzhou1@hisilicon.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	James Morse <james.morse@arm.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	"Jason Cooper" <jason@lakedaemon.net>,
	"robh@kernel.org" <robh@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Yuanzhichang <yuanzhichang@hisilicon.com>,
	Zhudacai <zhudacai@hisilicon.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	qiuzhenfa <qiuzhenfa@hisilicon.com>,
	"liudongdong (C)" <liudongdong3@huawei.com>,
	qiujiang <qiujiang@huawei.com>,
	Kangfenglong <kangfenglong@huawei.com>,
	"xuwei (O)" <xuwei5@hisilicon.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: RE: [PATCH v6 0/6] PCI: hisi: Add PCIe host support for HiSilicon
 SoC Hip05
Date: Tue, 11 Aug 2015 07:39:16 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E01D79B34@lhreml503-mbs>
References: <1438848559-232109-1-git-send-email-wangzhou1@hisilicon.com>
 <55C449AF.3030303@hisilicon.com>
In-Reply-To: <55C449AF.3030303@hisilicon.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn and all

Any comment on this patchset?

Thanks

Gab

> -----Original Message-----
> From: Wangzhou (B)
> Sent: Friday, August 07, 2015 7:01 AM
> To: Wangzhou (B)
> Cc: Bjorn Helgaas; Jingoo Han; Pratyush Anand; Arnd Bergmann;
> linux@arm.linux.org.uk; thomas.petazzoni@free-electrons.com; Gabriele
> Paoloni; lorenzo.pieralisi@arm.com; James Morse; Liviu.Dudau@arm.com;
> Jason Cooper; robh@kernel.org; linux-pci@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; devicetree@vger.kernel.org; Yuanzhichang;
> Zhudacai; zhangjukuo; qiuzhenfa; liudongdong (C); qiujiang;
> Kangfenglong; xuwei (O); Liguozhu (Kenneth)
> Subject: Re: [PATCH v6 0/6] PCI: hisi: Add PCIe host support for
> HiSilicon SoC Hip05
> 
> [+cc jingoohan1@gmail.com]
> 
> On 2015/8/6 16:09, Zhou Wang wrote:
> > This patchset adds PCIe host support for HiSilicon SoC Hip05. The
> PCIe hosts
> > use PCIe IP core from Synopsys, So this driver is base on designware
> PCIe driver.
> >
> > Hip05 is an ARMv8 architecture SoC. It should be able to use ARM64
> PCIe API in
> > designeware PCIe driver. So this patch also adds ARM64 support for
> designware
> > pcie.
> >
> > This patchset is based on v4.2-rc1.
> >
> > Change from v5:
> > - Merge 1/6 in this series, discussion about this can be found in [1]
> >
> > Change from v4:
> > - Change the author of 1/5 to Gabriele.
> > - Modify problems in 3/5 pointed by Bjorn.
> > - Modify spelling problems in 4/5.
> >
> > Change from v3:
> > - Change 1/5 to what Gabriele suggested.
> > - Use win->__res.start to get *_mod_base in 2/5, this fix a bug in v3
> series.
> >
> > Change from v2:
> > - Move struct pci_dev *dev and struct pci_sys_data *sys in
> >   pcibios_align_resource in 1/5.
> > - Add Gabriele's codes in 2/5 which delete unnecessary information
> parse and
> >   use of_pci_get_host_bridge_resources for both ARM32 and ARM64.
> > - Add maintainer patch 5/5.
> >
> > Change from RFC v1:
> > - Add 1/4 patch by Arnd which removes align_resource callback in ARM
> >   pcibios_align_resource.
> > - Change head file in pcie-designware from asm/hardirq.h to
> linux/hardirq.h.
> > - Set pp->root_bus_nr = 0 in dra7xx, exynos, imx6, keystone,
> layerscape,
> >   spear13xx.
> > - Remove unnecessary parentheses of some macros in pcie-hisi.
> > - Use macro to replace some magic values.
> > - Merge two loops together and add some comments about it in
> context_config
> >   function in pcie-hisi.
> > - Modify some value of items in pcie node example in binding document.
> >
> > Change from RFC:
> > - delete dw_pcie_setup, dw_pcie_scan_bus, dw_pcie_map_irq and struct
> hw_pci,
> >   merge related operations into dw_pcie_host_init.
> >
> > Link of v5:
> > - http://www.spinics.net/lists/devicetree/msg87959.html
> > Link of v4:
> > - http://www.spinics.net/lists/arm-kernel/msg433050.html
> > Link of v3:
> > - http://www.spinics.net/lists/linux-pci/msg42539.html
> > Link of v2:
> > - http://www.spinics.net/lists/linux-pci/msg41844.html
> > Link of RFC v1:
> > - http://www.spinics.net/lists/linux-pci/msg41305.html
> > Link of RFC:
> > - http://www.spinics.net/lists/linux-pci/msg40434.html
> >
> > [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-
> July/359741.html
> >
> > Zhou Wang (4):
> >   PCI: designware: Add ARM64 support
> >   PCI: hisi: Add PCIe host support for HiSilicon SoC Hip05
> >   Documentation: DT: Add HiSilicon PCIe host binding
> >   MAINTAINERS: Add pcie-hisi maintainer
> >
> > gabriele paoloni (2):
> >   PCI: designware: move calculation of bus addresses to DRA7xx
> >   ARM/PCI: remove align_resource in pci_sys_data
> >
> >  .../devicetree/bindings/pci/hisilicon-pcie.txt     |  46 ++++
> >  MAINTAINERS                                        |   7 +
> >  arch/arm/include/asm/mach/pci.h                    |   5 -
> >  arch/arm/kernel/bios32.c                           |  12 +-
> >  drivers/pci/host/Kconfig                           |   8 +
> >  drivers/pci/host/Makefile                          |   1 +
> >  drivers/pci/host/pci-dra7xx.c                      |  14 ++
> >  drivers/pci/host/pci-exynos.c                      |   2 +-
> >  drivers/pci/host/pci-imx6.c                        |   2 +-
> >  drivers/pci/host/pci-keystone-dw.c                 |   2 +-
> >  drivers/pci/host/pci-keystone.c                    |   2 +-
> >  drivers/pci/host/pci-layerscape.c                  |   2 +-
> >  drivers/pci/host/pcie-designware.c                 | 236 ++++++-----
> --------
> >  drivers/pci/host/pcie-designware.h                 |  14 +-
> >  drivers/pci/host/pcie-hisi.c                       | 254
> +++++++++++++++++++++
> >  drivers/pci/host/pcie-spear13xx.c                  |   2 +-
> >  16 files changed, 425 insertions(+), 184 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pci/hisilicon-
> pcie.txt
> >  create mode 100644 drivers/pci/host/pcie-hisi.c
> >
> 

