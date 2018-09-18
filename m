Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729782AbeISAVE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Sep 2018 20:21:04 -0400
Date: Tue, 18 Sep 2018 13:47:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Daniel Walker <danielwa@cisco.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: PCI: Enforce bus address limits in resource allocation
Message-ID: <20180918184706.GA13616@bhelgaas-glaptop.roam.corp.google.com>
References: <abb9aa39-3128-3a4d-01f7-d0614d63f37e@cisco.com>
 <20180918132056.GA254348@bhelgaas-glaptop.roam.corp.google.com>
 <b5883e58-861a-807e-f4c8-3745b006ce0d@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b5883e58-861a-807e-f4c8-3745b006ce0d@cisco.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 18, 2018 at 07:24:02AM -0700, Daniel Walker wrote:
> On 09/18/2018 06:20 AM, Bjorn Helgaas wrote:
> > On Fri, Sep 14, 2018 at 08:16:35AM -0700, Daniel Walker wrote:
> > > I have a powerpc system with PCI, and some devices attached to
> > > the PCI bus.  In 3.10 everything worked fine, then we moved to
> > > 4.9 and we had some issues.  I was able to bisect the issue down
> > > to the patch in the subject line.
> > > 
> > > f75b99d PCI: Enforce bus address limits in resource allocation
> > > 
> > >  From 3.10 here is part of the PCI initialization,
> > > 
> > > |pci 0001:0e:00.0: BAR 0: assigned [mem 0xfc0000000-0xfc00fffff pref]|
> > > |pci 0001:07:09.0: PCI bridge to [bus 0e]|
> > > |pci 0001:07:09.0: bridge window [mem 0xfc0000000-0xfc00fffff 64bit pref]|
> > >                  |||In this section the memory resource for the bridge is
> > > 64bit, and the device "BAR 0" gets a 64bit range. However, it seems the
> > > device is 32bit.|

> > > |Now fast forward to 4.9 we get this,|
> > 
> > > pci 0001:0e:00.0: BAR 0: no space for [mem size 0x00100000 pref]
> > > pci 0001:0e:00.0: BAR 0: failed to assign [mem size 0x00100000 pref]
> > > pci 0001:07:09.0: PCI bridge to [bus 0e]
> > > pci 0001:07:09.0: bridge window [mem 0xfc0000000-0xfc00fffff 64bit pref]
> > > 
> > > |Here it seems to have a larger size, I'm not sure where the size is coming
> > > from.
> > 
> > The size is 0x00100000 (1MB), which is the same size as
> > [mem 0xfc0000000-0xfc00fffff pref].
> > 
> > The size is normally discovered by probing the BAR (write all 1's to
> > the BAR then read it back to find which bits are writable and which
> > are read-only).  On powerpc we might learn it from DT instead.  But in
> > any case, we to get the same 1MB size, which is the same size as the
> > bridge window.  So this should still work unless there are other BARs
> > in that window.
> 
> As far as I know there is only one BAR connected to this window.
> 
> It kind of strikes me as an off-by-one problem because it says "no space"
> but the window is the same size as what's requested. With the patch removed
> you get the whole window assigned.
> 
> In the context of the patch if you change the pci_32_bit to pci_64_bit for
> the region when calling pci_bus_alloc_from_region() in the 32bit case this
> problem disappears. I do have CONFIG_ARCH_DMA_ADDR_T_64BIT enabled in my
> config.
> 
> > > I was able to work around the issue by setting IORESOURCE_MEM_64 on
> > > the resource for this device. I also was able to work around it by setting
> > > "max = avail.end" to "max = (-1);" inside pci_bus_alloc_resource(). |
> > > ||
> > > ||I don't know if the problem is the patch, or something else inside our
> > > system, but any thoughts are appreciated.
> > 
> > It seems like we think the bridge window contains only 64-bit space
> > and therefore contains nothing usable by the 32-bit BAR.
> > 
> > You said later that the same problem exists on v4.19-rc4.  Can you
> > collect the complete dmesg log with that kernel?  That should tell us
> > about any host bridge address translation.
> 
> Sure. I have attached the dmesg.

The relevant parts are below.  I think your DT is incorrect.  Either
it neglects to describe the host bridge address translation for the
ffb240000.pcie and ffb250000.pcie bridges, or it incorrectly describes
the BARs of devices below those bridges as 32-bit BARs when they are
really 64-bit BARs.

f75b99d5a77d ("PCI: Enforce bus address limits in resource allocation")
tightened up resource allocation and could expose DT defects like this
that previously were tolerated and worked by accident.

If you think the DT is correct and Linux is interpreting it wrong,
please include the DT so we can try to figure it out.

Bjorn


> Linux version 4.19.0-rc4 (danielwa@sjc-ads-2388) (gcc version 5.3.0 (GCC)) #205 Tue Sep 18 06:54:00 PDT 2018
> Using RSP3 machine description

> RSP3 board from Cisco Systems Inc.

> Found FSL PCI host bridge at 0x0000000ffb240000. Firmware bus number: 0->255
> PCI host bridge /pcie@ffb240000,0 (primary) ranges:
>  MEM 0x0000000fe0000000..0x0000000fe0ffffff -> 0x0000000fe0000000

DT says the bridge does not translate addresses, so there's no 32-bit PCI
address space available.  PCI bus addresses start at 0x0000000f_e000_0000.

> Found FSL PCI host bridge at 0x0000000ffb250000. Firmware bus number: 0->255
> PCI host bridge /pcie@ffb250000,0  ranges:
>  MEM 0x0000000400000000..0x0000000fffffffff -> 0x0000000400000000

DT says the bridge does not translate addresses, so there's no 32-bit PCI
address space.  PCI bus addresses start at 0x00000004_0000_0000.

> Found FSL PCI host bridge at 0x0000000ffb270000. Firmware bus number: 0->255
> PCI host bridge /pcie@ffb270000,0  ranges:
>  MEM 0x0000000fe2000000..0x0000000fe20fffff -> 0x00000000e2000000

Here DT tells us the bridge translates CPU address 0x0000000fe2000000 to
0x00000000_e200_0000, so there is 1MB of 32-bit PCI space available.

> fsl-pci ffb240000.pcie: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [mem 0xf_e000_0000-0xf_e0ff_ffff]

> fsl-pci ffb250000.pcie: PCI host bridge to bus 0001:05
> pci_bus 0001:05: root bus resource [mem 0x4_0000_0000-0xf_ffff_ffff]

This host bridge window is incorrect because it overlaps the
ffb240000.pcie window above.

> fsl-pci ffb270000.pcie: PCI host bridge to bus 0002:0f
> pci_bus 0002:0f: root bus resource [mem 0xf_e200_0000-0xf_e20f_ffff] (bus address [0xe2000000-0xe20fffff])

> pci 0000:00:00.0: BAR 0: no space for [mem size 0x01000000]
> pci 0000:01:00.0: BAR 0: no space for [mem size 0x00004000]

> pci 0001:05:00.0: BAR 0: no space for [mem size 0x01000000]
> pci 0001:06:00.0: BAR 0: no space for [mem size 0x00020000]
> pci 0001:06:00.1: BAR 0: no space for [mem size 0x00020000]
> pci 0001:0e:00.0: BAR 0: no space for [mem size 0x00100000]

> pci 0002:0f:00.0: BAR 0: no space for [mem size 0x01000000]

All these BAR 0 registers are only 32 bits wide.  Domains 0000 and
0001 have no 32-bit space at all.  Domain 0002 has 1MB of 32-bit space
available, but 0002:0f:00.0 requires 0x01000000 (16MB).
