Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:56976 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933268AbcA0PRq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jan 2016 10:17:46 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
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
Subject: Re: [PATCH V2 3/5] PCI: xilinx: Modifying AXI PCIe Host Bridge driver to  work on both  Zynq and Microblaze
Date: Wed, 27 Jan 2016 16:14:32 +0100
Message-ID: <5255218.OREPu5Af3W@wuerfel>
In-Reply-To: <8520D5D51A55D047800579B09414719825873DA8@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1452620173-4905-1-git-send-email-bharatku@xilinx.com> <4734542.KZZp0TeeeM@wuerfel> <8520D5D51A55D047800579B09414719825873DA8@XAP-PVEXMBX01.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 27 January 2016 14:33:45 Bharat Kumar Gogada wrote:
> > > @@ -705,7 +715,9 @@ static int xilinx_pcie_probe(struct
> > > platform_device *pdev)  #endif
> > >     pci_scan_child_bus(bus);
> > >     pci_assign_unassigned_bus_resources(bus);
> > > +#ifdef CONFIG_ARM
> > >     pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> > > +#endif
> > >     pci_bus_add_devices(bus);
> > >     platform_set_drvdata(pdev, port);
> > 
> > Here it looks like microblaze gets it right. I'm not sure why we still need the
> > pci_fixup_irqs() on ARM, but my feeling is that this should be fixed in
> > common code.
> In arm pci_fixup_irqs is called by pci_common_init_dev (arch/arm/kernel/bios32.c), since this API is removed now, I was calling it separately.

But who calls it in microblaze? If it works without the extra call there,
can we make it work the same way for ARM?

	Arnd
