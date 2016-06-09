Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:51443 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbcFIOky convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2016 10:40:54 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Krzysztof =?utf-8?B?SGHFgmFzYQ==?= <khalasa@piap.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "ARM: cns3xxx: pci: avoid potential stack overflow"
Date: Thu, 09 Jun 2016 16:42:03 +0200
Message-ID: <7440319.e8dDgNlZLB@wuerfel>
In-Reply-To: <m37fdydikf.fsf@t19.piap.pl>
References: <20160531215802.30590.97398.stgit@bhelgaas-glaptop2.roam.corp.google.com> <11128570.JeBAgI5zQr@wuerfel> <m37fdydikf.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, June 9, 2016 7:42:24 AM CEST Krzysztof Hałasa wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > What exactly is the problem we are seeing, and is there a way to fix
> > it on top of my patch? Are we perhaps just missing a call to
> > pcie_bus_configure_settings()?
> 
> From: khalasa@piap.pl (Krzysztof Halasa)
> Subject: [PATCH] Extend PCIE_BUS_PEER2PEER to set MRSS=128 to fix CNS3xxx BM DMA.
> To: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
> Date: Mon, 21 Mar 2016 10:39:52 +0100 (11 weeks, 2 days, 19 hours ago)
> 
> The platform in question is Cavium CNS3xxx, ARMv6.
> 
> A recent patch by Arnd Bergmann (498a92d42596 "ARM: cns3xxx: pci: avoid
> potential stack overflow") converted an explicit setting of
> PCI_EXP_DEVCTL_READRQ = 0 (i.e., max 128 bytes for bus-mastering PCIe DMA
> read request) to:
> +    pcie_bus_config = PCIE_BUS_PEER2PEER;
> 
> with the following commentary:
>     "The second part is how the driver sets up the Max_Read_Request_Size
>     value for the first device/function on bus 1, i.e. the device
>     plugged directly into the PCIe root port.
>     For all I can tell, this is in fact incomplete, as it does not
>     perform the same setting on devices attached to a PCIe switch,
>     or multi-function devices.
>     The solution for this part fortunately is even easier: if we
>     just set the global pcie_bus_config variable to PCIE_BUS_PEER2PEER,
>     all PCIe devices in the system are limited to 128 byte MPS, which
>     in turn limits the MRRS to 128 bytes for all devices, and we
>     no longer even need to touch any devices."
> 
> The problem is the MRRS setting is never written to the hardware.
> I propose the following, though I'm not sure if we can do this safely,
> especially given the comments in probe.c. OTOH, this change may be
> required in other (all?) cases when the user requests
> PCIE_BUS_PEER2PEER.
> 
> On this Laguna GW-2388 the following patch fixes BM DMA with:
> 0000:00:00.0 PCI bridge: Cavium Networks Device 3400 (rev 01)
> 0000:01:00.0 PCI bridge: Texas Instruments XIO2001 PCI Express-to-PCI Bridge
> 0000:02:0e.0 (PCI devices behind the bridge, these are doing actual BM xfers)
> 0001:00:00.0 PCI bridge: Cavium Networks Device 3400 (rev 01 - this is
>              the second lane from the CPU)
> 
> pci 0000:00:00.0: Max Payload Size set to  128/ 128 (was  128), Max Read Rq  128
> pci 0000:01:00.0: Max Payload Size set to  128/ 512 (was  128), Max Read Rq  128
> pci 0001:00:00.0: Max Payload Size set to  128/ 128 (was  128), Max Read Rq  128
> 
> Signed-off-by: Krzysztof Hałasa <khalasa@piap.pl>
> Fixes: 498a92d42596 ("ARM: cns3xxx: pci: avoid potential stack overflow")

I see now, thanks for the quote. I guess I missed how PCIE_BUS_PEER2PEER is
documented as /* set MPS = 128 for all devices */ unlike PCIE_BUS_PERFORMANCE,
which is documented as setting both MPS and MRRS.

It seems the current behavior was introduced by
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=ed2888e90

Before that, we were always setting both mrrs and mps. As we don't know
who uses PCIE_BUS_PEER2PEER, maybe another option would be to add yet
another pcie_bus_config value for this particular quirk?

> > Note that cns3xxx is in a bit of an odd state, as only half of the
> > platform code is even present in the kernel, and there is no effort
> > to change that. As far as I know, the board that this was tested on
> > is not present in the mainline kernel, and the board we support
> > is a development system that few people even own at this point.
> 
> The boards I use (Gateworks Laguna) are basically equivalent to the
> devel board (from the platform code POV).
> The kernel lacks support for SMP and the Ethernet driver (and things
> like GPIO), though there are patches available and I plan to integrate
> them, when the existing issues are resolved.

Ok, good to know.

> Also, this is practically a non-DT arch but I guess a conversion to DT
> would be a good thing as it would eliminate a need for board-specific
> code. That's why there is no platform code for Laguna. Unfortunately
> there is no DT file for CNS3xxx, and I'm not an DT expert.

I started the DT conversion a long time ago (see the DT parsing in
arch/arm/mach-cns3xxx/core.c) but I never had any hardware to test
on, and it was at a time when we didn't even have DT support in all
the subsystems.

I'd definitely help you get the rest of the DT support in place if
you can test it. This is now the only SMP platform and one of
the last users of GIC and l2x0 that does not use DT, so I'd love
to see that converted just so we can remove the legacy probing from
those drivers.

Converting what we have in mainline should be fairly straightforward,
but there is more code in 
target/linux/cns3xxx/files/arch/arm/mach-cns3xxx/laguna.c that requires
more work, in particular we need to come up with a way to handle
the laguna_net_data and laguna_info structures, which have some of
the same data that is normall in DT. Also, the gpio driver doesn't
have a trivial conversion to DT and requires some work to define
a binding and implement that.

	Arnd
