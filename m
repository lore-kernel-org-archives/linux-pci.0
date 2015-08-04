Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:34997 "EHLO
	lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755405AbbHDKYa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Aug 2015 06:24:30 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: James Morse <james.morse@arm.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
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
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: RE: [PATCH v5 2/5] PCI: designware: Add ARM64 support
Date: Tue, 4 Aug 2015 10:23:58 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E01D719E9@lhreml503-mbs>
References: <1437794486-21134-1-git-send-email-wangzhou1@hisilicon.com>
 <1437794486-21134-3-git-send-email-wangzhou1@hisilicon.com>
 <55B71F75.5030907@hisilicon.com> <55C0872E.9060507@arm.com>
In-Reply-To: <55C0872E.9060507@arm.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi James

Please see "[PATCH v6] PCI: Store PCIe bus address in struct of_pci_range"

I think if you apply this patch your problem should be solved...

If you follow the discussion you see that this patch is going to be part 
of the next designware patchset...

Wang Zhou said "You need apply Gabriele's patch before applying this patch."
but he didn't specify which one and obviously this patch should have been part
of the patch-set

Sorry for the confusion 

Gab

> -----Original Message-----
> From: James Morse [mailto:james.morse@arm.com]
> Sent: Tuesday, August 04, 2015 10:35 AM
> To: Wangzhou (B)
> Cc: Bjorn Helgaas; Jingoo Han; Pratyush Anand; Arnd Bergmann; Gabriele
> Paoloni; Lorenzo Pieralisi; Liviu Dudau; thomas.petazzoni@free-
> electrons.com; Jason Cooper; robh@kernel.org; linux-pci@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> Yuanzhichang; Zhudacai; zhangjukuo; qiuzhenfa; liudongdong (C);
> qiujiang; Kangfenglong; Liguozhu (Kenneth)
> Subject: Re: [PATCH v5 2/5] PCI: designware: Add ARM64 support
> 
> On 28/07/15 07:21, Zhou Wang wrote:
> > On 2015/7/25 11:21, Zhou Wang wrote:
> >> This patch tries to unify ARM32 and ARM64 PCIe in designware driver.
> Delete
> >> function dw_pcie_setup, dw_pcie_scan_bus, dw_pcie_map_irq and struct
> hw_pci,
> >> move related operations to dw_pcie_host_init. Also set pp-
> >root_bus_nr = 0 in
> >> each PCIe host driver which is based on pcie-designware. This patch
> also try
> >> to use of_pci_get_host_bridge_resources for ARM32 and ARM64
> according to the
> >> suggestion for Gabriele[1]
> >>
> >> This patch is based on Gabriele's patch about of_pci_range fix[2]
> >>
> >> I have compiled the driver with multi_v7_defconfig. However, I don't
> have
> >> ARM32 PCIe related board to do test. It will be appreciated if
> someone could
> >> help to test it.
> >>
> >
> > Hi James,
> >
> > If you have time, could you help to test this patch on i.MX 6Quad
> board?
> > You need apply Gabriele's patch before applying this patch.
> >
> > It will be very appreciate and helpful if we can get test result from
> you.
> 
> Applying patches 1 and 2, from v5, onto 4.2-rc5, I still get the same
> problem as before: config cycles to enumerate the second bus aren't
> working. (good news - I have a workaround)
> 
> Output from dmesg below, the lines 'dw_pcie_cfg_read(0xf0180000, 0x0,
> 0x4,
> =0x8878086)' were added by me, 0x8878086 is the intel wireless card
> attached to the board.
> 
> From v4.2-rc5:
> -----------------------------------------------------------------------
> -----------
> imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io 0x1000-0xffff]
> pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
> pci_bus 0000:00: root bus resource [bus 00-ff]
> pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
> pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
> pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
> pci 0000:00:00.0: IOMMU is currently not supported for PCI
> pci 0000:00:00.0: supports D1
> pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
> PCI: bus0: Fast back to back transfers disabled
> dw_pcie_cfg_read(0xf0180000, 0x0, 0x4, =0x8878086)
> pci 0000:01:00.0: [8086:0887] type 00 class 0x028000
> dw_pcie_cfg_read(0xf0180000, 0x0, 0x4, =0x8878086)
> pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
> pci 0000:01:00.0: IOMMU is currently not supported for PCI
> pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
> PCI: bus1: Fast back to back transfers disabled
> pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
> pci 0000:00:00.0: BAR 8: assigned [mem 0x01100000-0x011fffff]
> pci 0000:00:00.0: BAR 6: assigned [mem 0x01200000-0x0120ffff pref
> ]
> pci 0000:01:00.0: BAR 0: assigned [mem 0x01100000-0x01101fff 64bi
> t]
> pci 0000:00:00.0: PCI bridge to [bus 01]
> pci 0000:00:00.0:bridge window [mem 0x01100000-0x011fffff]
> pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
> pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
> pcie_pme 0000:00:00.0:pcie01: service driver pcie_pme loaded
> -----------------------------------------------------------------------
> -----------
> 
> And then with your two patches:
> -----------------------------------------------------------------------
> -----------
> PCI host bridge /soc/pcie@0x01000000 ranges:
> No bus range found for /soc/pcie@0x01000000, using [bus 00-ff]
> err 0x01f00000..0x01f7ffff -> 0x01f00000
> IO 0x01f80000..0x01f8ffff -> 0x00000000
> MEM 0x01000000..0x01efffff -> 0x01000000
> imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [bus 00-ff]
> pci_bus 0000:00: root bus resource [??? 0x01f00000-0x01f7ffff fla
> gs 0x0]
> pci_bus 0000:00: root bus resource [io 0x0000-0xffff]
> pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
> pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
> pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
> pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
> pci 0000:00:00.0: IOMMU is currently not supported for PCI
> pci 0000:00:00.0: supports D1
> pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
> PCI: bus0: Fast back to back transfers disabled
> dw_pcie_cfg_read(0xf0180000, 0x0, 0x4, =0x0)
> PCI: bus1: Fast back to back transfers enabled
> pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
> pci 0000:00:00.0: BAR 6: assigned [mem 0x01100000-0x0110ffff pref
> ]
> pci 0000:00:00.0: PCI bridge to [bus 01]
> pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
> pcie_pme 0000:00:00.0:pcie01: service driver pcie_pme loaded
> -----------------------------------------------------------------------
> -----------
> 
> Root-cause appears to be that the designware driver relies on ATU for
> config and IO accesses. dw_pcie_rd_other_conf() does the appropriate
> magic,
> but with your patches 'pp->cfg0_base' is NULL, despite being correctly
> initialised in dw_pcie_host_init().
> 
> dw_pcie_host_init() initialises the pp->cfg* values correctly after its
> call:
> >  platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
> 
> But the new code introduced by patch 2 then walks the whole
> resource_list
> and re-initialises the pp->cfg* values. The fault occurs at:
> > /* Find the untranslated configuration space address */
> > pp->cfg0_mod_base = win->__res.start
> 
> where win->__res is uninitialised. The comment in linux/resource_ext.h
> says
> this is the 'default storage for res', so its not valid to assume it
> contains different values to win->res. (in this case, it contains no
> useful
> values).
> 
> The workaround is to remove the re-initialisation of the pp->cfg*
> values,
> as they were already correctly initialised earlier. However, other
> resource
> types are accessing __res directly ... which is probably not correct.
> 
> I need to read-up on what these 'untranslated' addresses are for...
> 
> 
> 
> James
> 

