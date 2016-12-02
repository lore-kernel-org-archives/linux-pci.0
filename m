Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751534AbcLBV5P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Dec 2016 16:57:15 -0500
Date: Fri, 2 Dec 2016 15:57:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Duc Dang <dhdang@apm.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>,
        Dongdong Liu <liudongdong3@huawei.com>
Subject: Re: [PATCH v10 00/12] PCI: ARM64 ECAM quirks
Message-ID: <20161202215711.GE9903@bhelgaas-glaptop.roam.corp.google.com>
References: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <b59f12bb-fe22-e8ac-719c-d8fb12f31569@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b59f12bb-fe22-e8ac-719c-d8fb12f31569@semihalf.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 02, 2016 at 03:20:28PM +0100, Tomasz Nowicki wrote:
> dmesg from ThunderX pass2.0 (1 socket board) + small fix:
> 
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> -       THUNDER_PEM_QUIRK(2,  0),       /* off-chip devices */
> -       THUNDER_PEM_QUIRK(2,  1),       /* off-chip devices */
> +       THUNDER_PEM_QUIRK(2,  0UL),     /* off-chip devices */
> +       THUNDER_PEM_QUIRK(2,  1UL),     /* off-chip devices */

Thanks!  I folded this change into my branch (possibly to be updated
if Robert sends something better).

> ACPI: MCFG table detected, 4 entries
> ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-1f])
> acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM
> Segments MSI]
> acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug PME AER]
> acpi PNP0A08:00: _OSC: OS now controls [PCIeCapability]
> acpi PNP0A08:00: ECAM area [mem 0x848000000000-0x848001ffffff]
> reserved by THRX0001:00
> acpi PNP0A08:00: ECAM at [mem 0x848000000000-0x848001ffffff] for [bus 00-1f]

I guess we don't need MCFG quirks for these bridges, since I don't see
the "MCFG quirk" message?

> system 00:00: [mem 0x848000000000-0x848001ffffff] could not be reserved
> system 00:01: [mem 0x849000000000-0x849001ffffff] could not be reserved
> system 00:02: [mem 0x84a000000000-0x84a001ffffff] could not be reserved
> system 00:03: [mem 0x84b000000000-0x84b001ffffff] could not be reserved
> system 00:04: [mem 0x87e0c0000000-0x87e0c0ffffff] could not be reserved
> system 00:04: [mem 0x88001f000000-0x880057ffffff] could not be reserved
> system 00:05: [mem 0x87e0c2000000-0x87e0c2ffffff] could not be reserved
> system 00:05: [mem 0x88808f000000-0x8880c7ffffff] could not be reserved

Most of these match ECAM spaces, which is good.  00:04 and 00:05 each
have one ECAM space and one "other" space, which might be PEMx host
bridge registers?  That all seems good.

But I assume the other bridges (PCIx) also have register space in
addition to ECAM, and that should be reported also.

> root@ubuntu:~# cat /proc/iomem
> ...
> 838000000000-841fffffffff : PCI Bus 0000:00
>   838000000000-8380003fffff : 0000:03:00.0

Something's missing here: we should have a clue about how we got from
bus 00 to bus 03.  From your dmesg, 0000:00:15.0 is a bridge from bus
00 to bus 03, and its windows should appear here.  I'd expect
something like:

  838000000000-841fffffffff : PCI Bus 0000:00
    838000000000-838fffffffff : PCI Bus 0000:03  <- 00:15.0 window
      838000000000-8380003fffff : 0000:03:00.0

This window should be inserted by generic code, so I don't know how
this could be broken.  Your dmesg should also have something like
this:

  pci 0000:00:15.0: PCI bridge to [bus 03]
  pci 0000:00:15.0:   bridge window [mem 0x838000000000-0x838fffffffff]

I don't see that, maybe because this is actually a console log
collected without "ignore_loglevel"?  But that obviously doesn't
affect /proc/iomem, so I'm still puzzled about that.

> 87e024000000-87e024000fff : ARMH0011:00
>   87e024000000-87e024000fff : ARMH0011:00

This is interesting.  This must be a driver reserving these areas?
Normally a driver would use the driver name, not the device name.

Ideally, I think the core should reserve the region with the device
name, and the driver would request it using the driver name, like
this:

  843000000000-84303fffffff : 0002:01:00.0    <-- PCI core reservation
    843000000000-84303fffffff : thunder-nic   <-- driver request

The ACPI core doesn't actually do the reservation, so I assume the
ARMH0011:00 stuff is from the driver, and it's curious that it has the
same region twice.

> 87e026000000-87e0bfffffff : PCI Bus 0000:00
>   87e027000000-87e0277fffff : CAVA02A:00

This is interesting, too.  CAVA02A:00 looks like an ACPI device, but
apparently it consumes some of the space that we think is routed to
PCI bus 0000:00.  I think this happens on some x86 boxes, too, but it
is somewhat confusing.

Based on this, I don't see any problems with the ThunderX quirks.
I'd like to understand what's going on with the PCI-to-PCI bridge
windows in /proc/iomem, but I doubt that's related to your quirks.

Bjorn
