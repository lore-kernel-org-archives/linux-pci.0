Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0075.outbound.protection.outlook.com ([104.47.37.75]:20736
	"EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750739AbcGNNcX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2016 09:32:23 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Arnd Bergmann <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	nofooter <nofooter@xilinx.com>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>
Subject: RE: Purpose of pci_remap_iospace
Date: Thu, 14 Jul 2016 13:32:13 +0000
Message-ID: <8520D5D51A55D047800579B094147198258B8F73@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <8520D5D51A55D047800579B094147198258B85DC@XAP-PVEXMBX01.xlnx.xilinx.com>
 <3927657.6zNCtCntSU@wuerfel>
 <8520D5D51A55D047800579B094147198258B8952@XAP-PVEXMBX01.xlnx.xilinx.com>
 <4235946.u1vYRsOpTR@wuerfel>
 <8520D5D51A55D047800579B094147198258B8B06@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160713134642.GA29309@red-moon>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> > Subject: Re: Purpose of pci_remap_iospace
> >
> > On Wed, Jul 13, 2016 at 12:30:44PM +0000, Bharat Kumar Gogada wrote:
> >
> > [...]
> >
> > > err = of_pci_get_host_bridge_resources(node, 0, 0xff, &res, &iobase);
> > >         if (err) {
> > >                 pr_err("Getting bridge resources failed\n");
> > >                 return err;
> > >         }
> > > resource_list_for_each_entry(window, &res) {            //code for io
> resource
> > >                 struct resource *res = window->res;
> > >                 u64 restype = resource_type(res);
> > >
> > >                 switch (restype) {
> > >                 case IORESOURCE_IO:
> > >                         err = pci_remap_iospace(res, iobase);
> > >                         if(err)
> > >                                 pr_info("FAILED TO IPREMAP RESOURCE\n");
> > >                         break;
> > >                 default:
> > >                         dev_err(pcie->dev, "invalid resource %pR\n",
> > > res);
> > >
> > >                 }
> > >         }
> > >
> > > Other than above code I haven't done any change in driver.
> > >
> > Here is your PCI bridge mem space window assignment. I do not see an
> > IO window assignment which makes me think that IO cycles and relative
> > IO window is not enabled through the bridge, that's the reason you
> > can't assign IO space to the endpoint, because it has no parent IO window
> enabled IIUC.
> >
>
> We sorted this out, enabled the IO base limit / upper 16bit registers in the
> bridge for 32 bit decode.
> However my IO address being assigned to EP is different than what I provide
> in device tree.
>

Hi Lorenzo,

I missed something in my device tree now I corrected it.

ranges = <0x01000000 0x00000000 0xe0000000 0x00000000 0xe0000000 0 0x00010000   //io
                     0x02000000 0x00000000 0xe0100000 0x00000000 0xe0100000 0 0x0ef00000>; //non prefetchabe memory

[    2.389498] nwl-pcie fd0e0000.pcie: Link is UP
[    2.389541] PCI host bridge /amba/pcie@fd0e0000 ranges:
[    2.389558]   No bus range found for /amba/pcie@fd0e0000, using [bus 00-ff]
[    2.389583]    IO 0xe0000000..0xe000ffff -> 0xe0000000
[    2.389624]   MEM 0xe0100000..0xeeffffff -> 0xe0100000
[    2.389803] nwl-pcie fd0e0000.pcie: PCI host bridge to bus 0000:00
[    2.389822] pci_bus 0000:00: root bus resource [bus 00-ff]
[    2.389839] pci_bus 0000:00: root bus resource [io  0x0000-0xffff] (bus address [0xe0000000-0xe000ffff])
[    2.389863] pci_bus 0000:00: root bus resource [mem 0xe0100000-0xeeffffff]
[    2.390094] pci 0000:00:00.0: cannot attach to SMMU, is it on the same bus?
[    2.390110] iommu: Adding device 0000:00:00.0 to group 1
[    2.390274] pci 0000:01:00.0: reg 0x20: initial BAR value 0x00000000 invalid
[    2.390481] pci 0000:01:00.0: cannot attach to SMMU, is it on the same bus?
[    2.390496] iommu: Adding device 0000:01:00.0 to group 1
[    2.390533] in pci_bridge_check_ranges io 101
[    2.390545] in pci_bridge_check_ranges io 2 101
[    2.390575] pci 0000:00:00.0: BAR 8: assigned [mem 0xe0100000-0xe02fffff]
[    2.390592] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
[    2.390609] pci 0000:00:00.0: BAR 6: assigned [mem 0xe0300000-0xe03007ff pref]
[    2.390636] pci 0000:01:00.0: BAR 0: assigned [mem 0xe0100000-0xe01fffff 64bit]
[    2.390669] pci 0000:01:00.0: BAR 2: assigned [mem 0xe0200000-0xe02fffff 64bit]
[    2.390702] pci 0000:01:00.0: BAR 4: assigned [io  0x1000-0x103f]
[    2.390721] pci 0000:00:00.0: PCI bridge to [bus 01-0c]
[    2.390785] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
[    2.390823] pci 0000:00:00.0:   bridge window [mem 0xe0100000-0xe02fffff]

Lspci on bridge:
00:00.0 PCI bridge: Xilinx Corporation Device a024 (prog-if 00 [Normal decode])
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 224
        Bus: primary=00, secondary=01, subordinate=0c, sec-latency=0
        I/O behind bridge: e0001000-e0001fff
        Memory behind bridge: e0100000-e02fffff

Here my IO space is showing 4k, but what I'm providing is 4k ?(In above boot log also IO space length 4k)

Lspci on EP:
01:00.0 Memory controller: Xilinx Corporation Device d024
        Subsystem: Xilinx Corporation Device 0007
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 224
        Region 0: Memory at e0100000 (64-bit, non-prefetchable) [disabled] [size=1M]
        Region 2: Memory at e0200000 (64-bit, non-prefetchable) [disabled] [size=1M]
        Region 4: I/O ports at 1000 [disabled] [size=64]

On EP from where it is getting this 1000 address, it should be within I/O behind bridge range know ?


Thanks & Regards,
Bharat



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

