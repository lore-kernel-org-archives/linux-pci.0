Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36989 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883AbcGMNq2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 Jul 2016 09:46:28 -0400
Date: Wed, 13 Jul 2016 14:46:42 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	nofooter <nofooter@xilinx.com>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>
Subject: Re: Purpose of pci_remap_iospace
Message-ID: <20160713134642.GA29309@red-moon>
References: <8520D5D51A55D047800579B094147198258B85DC@XAP-PVEXMBX01.xlnx.xilinx.com>
 <3927657.6zNCtCntSU@wuerfel>
 <8520D5D51A55D047800579B094147198258B8952@XAP-PVEXMBX01.xlnx.xilinx.com>
 <4235946.u1vYRsOpTR@wuerfel>
 <8520D5D51A55D047800579B094147198258B8B06@XAP-PVEXMBX01.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8520D5D51A55D047800579B094147198258B8B06@XAP-PVEXMBX01.xlnx.xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 13, 2016 at 12:30:44PM +0000, Bharat Kumar Gogada wrote:

[...]

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

Here is your PCI bridge mem space window assignment. I do not see
an IO window assignment which makes me think that IO cycles and
relative IO window is not enabled through the bridge, that's the
reason you can't assign IO space to the endpoint, because it has
no parent IO window enabled IIUC.

You can add some debug info into pci_bridge_check_ranges() in
particular to the reading of PCI_IO_BASE resources to confirm
what I am saying above, thanks.

Lorenzo

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
> Thanks & Regards,
> Bharat
> 
> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
> 
