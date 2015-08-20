Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46141 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbbHTI2O (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2015 04:28:14 -0400
Message-ID: <1440059243.31432.59.camel@pengutronix.de>
Subject: Re: [PATCH v7 3/6] PCI: designware: Add ARM64 support
From: Lucas Stach <l.stach@pengutronix.de>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: "Wangzhou (B)" <wangzhou1@hisilicon.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	"jason@lakedaemon.net" <jason@lakedaemon.net>,
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
	"xuwei (O)" <xuwei5@hisilicon.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Date: Thu, 20 Aug 2015 10:27:23 +0200
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E01D8139B@lhreml503-mbs>
References: <1439812554-180426-1-git-send-email-wangzhou1@hisilicon.com>
	 <1439812554-180426-4-git-send-email-wangzhou1@hisilicon.com>
	 <1439988852.31432.15.camel@pengutronix.de>
	 <EE11001F9E5DDD47B7634E2F8A612F2E01D81315@lhreml503-mbs>
	 <1439998622.31432.44.camel@pengutronix.de>
	 <EE11001F9E5DDD47B7634E2F8A612F2E01D8139B@lhreml503-mbs>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gab,

Am Mittwoch, den 19.08.2015, 16:34 +0000 schrieb Gabriele Paoloni:
> Hi Lucas
> 
> First of all many thanks for the quick reply, really appreciated
> 
> > -----Original Message-----
> > From: Lucas Stach [mailto:l.stach@pengutronix.de]
> > Sent: Wednesday, August 19, 2015 4:37 PM
> > To: Gabriele Paoloni
> > Cc: Wangzhou (B); Bjorn Helgaas; jingoohan1@gmail.com; Pratyush Anand;
> > Arnd Bergmann; linux@arm.linux.org.uk; thomas.petazzoni@free-
> > electrons.com; lorenzo.pieralisi@arm.com; james.morse@arm.com;
> > Liviu.Dudau@arm.com; jason@lakedaemon.net; robh@kernel.org; linux-
> > pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > devicetree@vger.kernel.org; Yuanzhichang; Zhudacai; zhangjukuo;
> > qiuzhenfa; liudongdong (C); qiujiang; xuwei (O); Liguozhu (Kenneth)
> > Subject: Re: [PATCH v7 3/6] PCI: designware: Add ARM64 support
> > 
> > Hi Gab,
> > 
> > Am Mittwoch, den 19.08.2015, 15:16 +0000 schrieb Gabriele Paoloni:
> > > Hi Lucas
> > >
> > > I have rewritten the patch to take into account multiple controllers.
> > >
> > > As you can see now there is a static var in dw_pcie_host_init() that
> > tracks
> > > the bus numbers used.
> > 
> > This is wrong. The DT specifies the valid bus number range. You can not
> > just assign the next free bus number to the root bus.
> 
> I think this is what is being done in
> http://lxr.free-electrons.com/source/arch/arm/kernel/bios32.c#L495
> and currently designware assigns the root bus number in
> http://lxr.free-electrons.com/source/drivers/pci/host/pcie-designware.c#L730
> 
You found the right spot. It works a bit different than I remember, but
is less broken than your current code. :)

It actually assigns the next instance a root bus number behind the
current instances bus range. Please note the difference to your code
which assigns the next free bus number, which may still lay within the
current instances bus range.

> 
> In general I agree with you but if you look at all the current drivers 
> based on designware none of them define the "bus-range" dtb property.
> Therefore doing as you say would break the current driver when we have
> multiple controllers...am I right?
> 
The current _code_ works fine for multiple controllers. It's just that
you must define the bus range property in the DTB if you want to enable
multiple instances of one controller and support a kernel without PCI
domains support. As all current implementations have only a single
instance of the controller per SoC, or depend on PCI domain support,
it's totally fine for them to not define the bus ranges property, as
it's an optional property and it is well defined how things behave if it
is absent. We absolutely need to keep that specified behavior.

> If that is the case in order to fix this in the way you say I would need
> to assign "bus-range" for all the PCIe drivers with multiple controllers:
> in this case I would split the default range evenly (that is, if we have 
> two controllers I would define "bus-range"  0-127 and 128-255)
> 
> If you think this solution is ok I can go for it. My only doubt was about
> touching other vendors DTBs....
> 
You don't need to touch any of the current DTBs, as they are fine with
the default bus range behavior. You need to keep the specified behavior
of the bus range property with the new code.

Regards,
Lucas
> 
> > 
> > It is perfectly valid to have a bus range of 0x00-0x10 assigned to one
> > instance and 0x50-0xff to the next instance. Additional with PCIe
> > hotplug you may not use the full range of the bus numbers on one
> > instance at the first scan, but only later populate more buses when
> > more
> > bridges are added to the tree.
> > 
> > > Drivers that do not specify the bus range in the DTB set pp-
> > >root_bus_nr = DW_ROOT_NR_UNDEFINED.
> > > Designware will check if the flag is set and will use the automatic
> > bus range
> > > assignment.
> > 
> > No, please lets get rid of this assignment altogether. The glue drivers
> > have no business in assigning the bus range. Please remove the
> > pp->root_bus_nr assignment from all the glue drivers.
> > 
> > "bus range" is a generic DW PCIe property, so just parse the root bus
> > number from the DT, it is handled the same way for all the DW based
> > PCIe
> > drivers. The bindings specifies that if the bus range property is
> > missing the range is 0x00-0xff, so you can default to 0 as the root bus
> > number in that case.
> > 
> > Also I would think this conversion warrants a patch on its own and
> > should not be mixed in the ARM64 support patch.
> > 
> > Regards,
> > Lucas
> > 

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

