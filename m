Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:53669 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbcGMN3L (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2016 09:29:11 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	nofooter <nofooter@xilinx.com>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>
Subject: Re: Purpose of pci_remap_iospace
Date: Wed, 13 Jul 2016 15:28:21 +0200
Message-ID: <4264647.cRxqIJ3z77@wuerfel>
In-Reply-To: <8520D5D51A55D047800579B094147198258B8B06@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <8520D5D51A55D047800579B094147198258B85DC@XAP-PVEXMBX01.xlnx.xilinx.com> <4235946.u1vYRsOpTR@wuerfel> <8520D5D51A55D047800579B094147198258B8B06@XAP-PVEXMBX01.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, July 13, 2016 12:30:44 PM CEST Bharat Kumar Gogada wrote:
>  > On Wednesday, July 13, 2016 8:11:56 AM CEST Bharat Kumar Gogada wrote:
> > > > Subject: Re: Purpose of pci_remap_iospace
> >
> > I notice you have 1MB of I/O space here
> >
> > > Kernel Boot log:
> > > [    2.345294] nwl-pcie fd0e0000.pcie: Link is UP
> > > [    2.345339] PCI host bridge /amba/pcie@fd0e0000 ranges:
> > > [    2.345356]   No bus range found for /amba/pcie@fd0e0000, using [bus
> > 00-ff]
> > > [    2.345382]    IO 0xe0000000..0xe00fffff -> 0x00000000
> > > [    2.345401]   MEM 0xe0100000..0xeeffffff -> 0xe0100000
> > > [    2.345498] nwl-pcie fd0e0000.pcie: PCI host bridge to bus 0000:00
> > > [    2.345517] pci_bus 0000:00: root bus resource [bus 00-ff]
> > > [    2.345533] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
> >
> > and all of it gets mapped by the PCI core. Usually you only have 64K of I/O
> > space per host bridge, and the PCI core should perhaps not try to map
> > all of it, though I don't think this is actually your problem here.
> >
> > > [    2.345550] pci_bus 0000:00: root bus resource [mem 0xe0100000-
> > 0xeeffffff]
> > > [    2.345770] pci 0000:00:00.0: cannot attach to SMMU, is it on the same
> > bus?
> > > [    2.345786] iommu: Adding device 0000:00:00.0 to group 1
> > > [    2.346142] pci 0000:01:00.0: cannot attach to SMMU, is it on the same
> > bus?
> > > [    2.346158] iommu: Adding device 0000:01:00.0 to group 1
> > > [    2.346213] pci 0000:00:00.0: BAR 8: assigned [mem 0xe0100000-
> > 0xe02fffff]
> > > [    2.346234] pci 0000:01:00.0: BAR 0: assigned [mem 0xe0100000-0xe01fffff
> > 64bit]
> > > [    2.346268] pci 0000:01:00.0: BAR 2: assigned [mem 0xe0200000-0xe02fffff
> > 64bit]
> > > [    2.346300] pci 0000:01:00.0: BAR 4: no space for [io  size 0x0040]
> > > [    2.346316] pci 0000:01:00.0: BAR 4: failed to assign [io  size 0x0040]
> > > [    2.346333] pci 0000:00:00.0: PCI bridge to [bus 01-0c]
> > > [    2.346350] pci 0000:00:00.0:   bridge window [mem 0xe0100000-
> > 0xe02fffff]
> > >
> > > IO assignment fails.
> >
> > I would guess that the I/O space is not registered correctly. Is this
> > drivers/pci/host/pcie-xilinx.c ? We have had problems with this in the
> > past, since almost nobody uses I/O space and it requires several
> > steps to all be done correctly.
> >
> Thanks Arnd.
> 
> we are testing using drivers/pci/host/pcie-xilinx-nwl.c.

According to Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt,
this hardware does not support I/O space.

Is this on ARM or microblaze?

> Here is the code I added to driver in probe:
> ..
> err = of_pci_get_host_bridge_resources(node, 0, 0xff, &res, &iobase);
>         if (err) {
>                 pr_err("Getting bridge resources failed\n");
>                 return err;
>         }
> resource_list_for_each_entry(window, &res) {            //code for io resource
>                 struct resource *res = window->res;
>                 u64 restype = resource_type(res);
> 
>                 switch (restype) {
>                 case IORESOURCE_IO:
>                         err = pci_remap_iospace(res, iobase);
>                         if(err)
>                                 pr_info("FAILED TO IPREMAP RESOURCE\n");
>                         break;
>                 default:
>                         dev_err(pcie->dev, "invalid resource %pR\n", res);
> 
>                 }
>         }
> 
> Other than above code I haven't done any change in driver.
> 
> Here is the printk added boot log:
> [    2.308680] nwl-pcie fd0e0000.pcie: Link is UP
> [    2.308724] PCI host bridge /amba/pcie@fd0e0000 ranges:
> [    2.308741]   No bus range found for /amba/pcie@fd0e0000, using [bus 00-ff]
> [    2.308755] in pci_add_resource_offset res->start 0   offset 0
> [    2.308774]    IO 0xe0000000..0xe00fffff -> 0x00000000
> [    2.308795] in pci_add_resource_offset res->start 0   offset 0
> [    2.308805]   MEM 0xe0100000..0xeeffffff -> 0xe0100000
> [    2.308824] in pci_add_resource_offset res->start e0100000    offset 0
> [    2.308834] nwl-pcie fd0e0000.pcie: invalid resource [bus 00-ff]
> [    2.308870] nwl-pcie fd0e0000.pcie: invalid resource [mem 0xe0100000-0xeeffffff]
> [    2.308979] nwl-pcie fd0e0000.pcie: PCI host bridge to bus 0000:00
> [    2.308998] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    2.309014] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
> [    2.309030] pci_bus 0000:00: root bus resource [mem 0xe0100000-0xeeffffff]
> [    2.309253] pci 0000:00:00.0: cannot attach to SMMU, is it on the same bus?
> [    2.309269] iommu: Adding device 0000:00:00.0 to group 1
> [    2.309625] pci 0000:01:00.0: cannot attach to SMMU, is it on the same bus?
> [    2.309641] iommu: Adding device 0000:01:00.0 to group 1
> [    2.309697] pci 0000:00:00.0: BAR 8: assigned [mem 0xe0100000-0xe02fffff]
> [    2.309718] pci 0000:01:00.0: BAR 0: assigned [mem 0xe0100000-0xe01fffff 64bit]
> [    2.309752] pci 0000:01:00.0: BAR 2: assigned [mem 0xe0200000-0xe02fffff 64bit]
> [    2.309784] pci 0000:01:00.0: BAR 4: no space for [io  size 0x0040]
> [    2.309800] pci 0000:01:00.0: BAR 4: failed to assign [io  size 0x0040]
> [    2.309816] pci 0000:00:00.0: PCI bridge to [bus 01-0c]
> [    2.309833] pci 0000:00:00.0:   bridge window [mem 0xe0100000-0xe02fffff]
> 
> Here is the output of ioports and iomem:
> 
> root@:~# cat /proc/iomem
> 00000000-7fffffff : System RAM
>   00080000-00a76fff : Kernel code
>   01c72000-01d4bfff : Kernel data
> fd0c0000-fd0c1fff : /amba/ahci@fd0c0000
> fd0e0000-fd0e0fff : breg
> fd480000-fd480fff : pcireg
> ff000000-ff000fff : xuartps
> ff010000-ff010fff : xuartps
> ff020000-ff020fff : /amba/i2c@ff020000
> ff030000-ff030fff : /amba/i2c@ff030000
> ff070000-ff070fff : /amba/can@ff070000
> ff0a0000-ff0a0fff : /amba/gpio@ff0a0000
> ff0f0000-ff0f0fff : /amba/spi@ff0f0000
> ff170000-ff170fff : mmc0
> ffa60000-ffa600ff : /amba/rtc@ffa60000
> 8000000000-8000ffffff : cfg
> root@:~# cat /proc/ioports
> root@:~#
> 
> /proc/ioports is empty.
> 

This has neither the PCI memory nor the I/O resource, it looks like you never
call pci_add_resource_offset() to start with, or maybe it fails for some reason.

	Arnd
