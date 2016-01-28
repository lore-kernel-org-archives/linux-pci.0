Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0063.outbound.protection.outlook.com ([104.47.38.63]:29216
	"EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755331AbcA1OSX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2016 09:18:23 -0500
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	Michal Simek <michals@xilinx.com>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"paul.burton@imgtec.com" <paul.burton@imgtec.com>,
	"yinghai@kernel.org" <yinghai@kernel.org>,
	"wangyijing@huawei.com" <wangyijing@huawei.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"russell.joyce@york.ac.uk" <russell.joyce@york.ac.uk>,
	Soren Brinkmann <sorenb@xilinx.com>,
	"jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH V2 3/5] PCI: xilinx: Modifying AXI PCIe Host Bridge
 driver to  work on both  Zynq and Microblaze
Date: Thu, 28 Jan 2016 14:18:15 +0000
Message-ID: <8520D5D51A55D047800579B094147198258741F5@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1452620173-4905-1-git-send-email-bharatku@xilinx.com>
 <5255218.OREPu5Af3W@wuerfel>
 <8520D5D51A55D047800579B09414719825874148@XAP-PVEXMBX01.xlnx.xilinx.com>
 <1917083.LB4Ng3Y2yP@wuerfel>
In-Reply-To: <1917083.LB4Ng3Y2yP@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Subject: Re: [PATCH V2 3/5] PCI: xilinx: Modifying AXI PCIe Host Bridge driver
> to work on both Zynq and Microblaze
> 
> On Thursday 28 January 2016 13:20:56 Bharat Kumar Gogada wrote:
> > > Subject: Re: [PATCH V2 3/5] PCI: xilinx: Modifying AXI PCIe Host
> > > Bridge driver to work on both Zynq and Microblaze
> > >
> > > On Wednesday 27 January 2016 14:33:45 Bharat Kumar Gogada wrote:
> > > > > > @@ -705,7 +715,9 @@ static int xilinx_pcie_probe(struct
> > > > > > platform_device *pdev)  #endif
> > > > > >     pci_scan_child_bus(bus);
> > > > > >     pci_assign_unassigned_bus_resources(bus);
> > > > > > +#ifdef CONFIG_ARM
> > > > > >     pci_fixup_irqs(pci_common_swizzle,
> > > > > > of_irq_parse_and_map_pci);
> > > > > > +#endif
> > > > > >     pci_bus_add_devices(bus);
> > > > > >     platform_set_drvdata(pdev, port);
> > > > >
> > > > > Here it looks like microblaze gets it right. I'm not sure why we
> > > > > still need the
> > > > > pci_fixup_irqs() on ARM, but my feeling is that this should be
> > > > > fixed in common code.
> > > > In arm pci_fixup_irqs is called by pci_common_init_dev
> > > (arch/arm/kernel/bios32.c), since this API is removed now, I was
> > > calling it separately.
> > >
> > > But who calls it in microblaze? If it works without the extra call
> > > there, can we make it work the same way for ARM?
> > >
> > In microblaze I have added pcibios_add_device call (similar to call in
> > arch/arm64/kernel/pci.c ) in pci-common.c, which is being invoked by
> > kernel core itself.
> 
> I see. In the upstream code you seem to do it in
> pcibios_setup_bus_devices(), while arm64 and powerpc do it in
> pcibios_add_device().
> 
No that function is not getting called with generic API's, its getting called with pcibios_init flow which is tightly bound with struct pci_controller microblaze specific structure. So I added pcibios_add_device in pci-common.c.

> > May be we can add similar on arm and test out, but we might need some
> > cleanup in arch/arm/kernel/bios32.c
> 
> I think that would still just be a half-baked solution. This should really be fully
> automatic. We could do it in the __weak
> pcibios_add_device() for all architectures that don't override it when the bus
> was probed from DT, or we could do it in pci_read_irq().
When will pci_read_irq() call get invoked ?

Bharat

