Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-out4.electric.net ([192.162.216.187]:62822 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752325AbdLHMSL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Dec 2017 07:18:11 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: 'Bjorn Helgaas' <helgaas@kernel.org>
CC: "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
        Dongdong Liu <liudongdong3@huawei.com>
Subject: RE: PCIe link not recovering
Date: Fri, 8 Dec 2017 12:18:29 +0000
Message-ID: <ba011f7daeee41afbf6c5afa5408959a@AcuMS.aculab.com>
References: <3d3c69b6dcc44963b1ad80120c69767b@AcuMS.aculab.com>
 <20171206224727.GQ23510@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171206224727.GQ23510@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas
> Sent: 06 December 2017 22:47
>
> On Wed, Dec 06, 2017 at 02:03:55PM +0000, David Laight wrote:
> > If I perform the following:
> > 1) echo 1 >/sys/devices/pcixxxx/xxx/remove
> > 2) completely reset the PCIe endpoint
> > 3) echo 1 >/sys/devices/pcixxxx/rescan
> > I expect the endpoint to be reprobed (provided the BARs are compatible).
> 
> I expect that, too.  Even if the BARs are wrong (they should be
> cleared by the reset), we should at least discover the device.

That matches what I've seen every other system do.

If I reset the fpga during boot (well held in bios setup) it still isn't found.
On other boards I've done that to load a different set of BARs and had the
BIOS allocate resources based on the later image.

> > However on a new motherboard (SkyLake) it looks as though the root bridge isn't
> > trying to bring the PCIe link back up.
> > (The same system disk works fine in a slighty older system.)
...
> > I believe that the endpoint is flipping between the 'Detect Active' and 'Detect Quiet'
> > states. Which would imply that the root port isn't trying to establish the link.
> 
> I guess this refers to PCIe r3.1, sec 4.2.6.1.2, and Figure 4-23, the
> "Detect Substate Machine".  I'm not a hardware person, so still
> doesn't help me much :)  Out of curiosity, do you have an analyzer or
> other visibility into what the Endpoint is doing?

We don't have an analyser (cost too much) so I can't see what is actually
happening on the link itself.
The target is a fpga and we log all the low level state transitions to a
memory block (and some transitions to a serial EEPROM).
I'll set things up so I can read the trace while the PCIe link is still down.
(I think the trace I looked at last time went back to the reset - but it
is hard to tell.)

...
> > The full output (link_down) is:
> >
> > 00:01.0 PCI bridge: Intel Corporation Skylake PCIe Controller (x16) (rev 05) (prog-if 00 [Normal decode])
...
> 
> I'm surprised there's no AER capability.  The Root Ports in my Sky Lake
> system advertise AER, Access Control Services, and L1 PM Substates
> capabilities, none of which are shown here.  Must be configurable via
> the BIOS or something.

Nothing I've seen in the BIOS setup (just rechecked).

The PCIe lanes behind the 'Sunrise Point-H PCI Express Root Port'
at 00:1c.0 do support AER.
On this motherboard that is one of the ethernet chips, the m-PCIe
and the M.2 connectors. I don't have the required adapters for those.

But the big x16 connector (which we think we can split into two gen1 x1)
doesn't report AER.
I think it is directly connected to the cpu (i7-7700).

We might be able to ask SuperMicro (well we can ask...)

...
> You could try clearing that corrected error in DevSta, e.g.,
> 
>   # setpci -s00:01.0 0xaa.w=0x0001
> 
> to see if the Link comes up.  I doubt that would make a difference,
> but maybe.

Made no difference.

Nothing ever appears in the kernel log either.
FWIW I'm normally running a 4.13.0-16 Ubuntu 17.10 kernel,
but can run a 'bleeding edge' one.

	David
