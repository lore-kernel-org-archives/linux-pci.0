Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751593AbcLFS5p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Dec 2016 13:57:45 -0500
Date: Tue, 6 Dec 2016 12:56:55 -0600
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
Message-ID: <20161206185655.GA554@bhelgaas-glaptop.roam.corp.google.com>
References: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <b59f12bb-fe22-e8ac-719c-d8fb12f31569@semihalf.com>
 <20161202215711.GE9903@bhelgaas-glaptop.roam.corp.google.com>
 <2bef38c3-be46-918e-8ab3-1eb39df23edc@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2bef38c3-be46-918e-8ab3-1eb39df23edc@semihalf.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 05, 2016 at 01:36:01PM +0100, Tomasz Nowicki wrote:
> On 02.12.2016 22:57, Bjorn Helgaas wrote:
> >On Fri, Dec 02, 2016 at 03:20:28PM +0100, Tomasz Nowicki wrote:
> >>dmesg from ThunderX pass2.0 (1 socket board) + small fix:

> I believe Robert meant:
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index d34d196..8ca8ca8 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -76,7 +76,7 @@ static struct mcfg_fixup mcfg_quirks[] = {
>         HISI_QUAD_DOM("HIP07   ", 12, &hisi_pcie_ops),
> 
>  #define THUNDER_PEM_RES(addr, node) \
> -       DEFINE_RES_MEM(addr + (node << 44), 0x39 * SZ_16M)
> +       DEFINE_RES_MEM(addr + ((u64)node << 44), 0x39 * SZ_16M)
> 
> Which means we can forget UL suffix for THUNDER_PEM_QUIRK macro:
> @@ -91,8 +91,8 @@ static struct mcfg_fixup mcfg_quirks[] = {
>         { "CAVIUM", "THUNDERX", rev, 9 + (10 * node), MCFG_BUS_ANY,
> \
>           &thunder_pem_ecam_ops, THUNDER_PEM_RES(0x89808f000000UL, node) }
>         /* SoC pass2.x */
> -       THUNDER_PEM_QUIRK(1, 0UL),
> -       THUNDER_PEM_QUIRK(1, 1UL),
> +       THUNDER_PEM_QUIRK(1, 0),
> +       THUNDER_PEM_QUIRK(1, 1),
> 
> Also, my apologies, I should have fixed parentheses in this macro
> from the very beginning. For you convenience below incremental patch
> where I fixed both issues:
> 
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index d34d196..cf6c321 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -76,23 +76,23 @@ static struct mcfg_fixup mcfg_quirks[] = {
>         HISI_QUAD_DOM("HIP07   ", 12, &hisi_pcie_ops),
> 
>  #define THUNDER_PEM_RES(addr, node) \
> -       DEFINE_RES_MEM(addr + (node << 44), 0x39 * SZ_16M)
> +       DEFINE_RES_MEM((addr) + ((u64)(node) << 44), 0x39 * SZ_16M)
>  #define THUNDER_PEM_QUIRK(rev, node) \
> -       { "CAVIUM", "THUNDERX", rev, 4 + (10 * node), MCFG_BUS_ANY,
> \
> -         &thunder_pem_ecam_ops, THUNDER_PEM_RES(0x88001f000000UL,
> node) }, \
> -       { "CAVIUM", "THUNDERX", rev, 5 + (10 * node), MCFG_BUS_ANY,
> \
> -         &thunder_pem_ecam_ops, THUNDER_PEM_RES(0x884057000000UL,
> node) }, \
> -       { "CAVIUM", "THUNDERX", rev, 6 + (10 * node), MCFG_BUS_ANY,
> \
> -         &thunder_pem_ecam_ops, THUNDER_PEM_RES(0x88808f000000UL,
> node) }, \
> -       { "CAVIUM", "THUNDERX", rev, 7 + (10 * node), MCFG_BUS_ANY,
> \
> -         &thunder_pem_ecam_ops, THUNDER_PEM_RES(0x89001f000000UL,
> node) }, \
> -       { "CAVIUM", "THUNDERX", rev, 8 + (10 * node), MCFG_BUS_ANY,
> \
> -         &thunder_pem_ecam_ops, THUNDER_PEM_RES(0x894057000000UL,
> node) }, \
> -       { "CAVIUM", "THUNDERX", rev, 9 + (10 * node), MCFG_BUS_ANY,
> \
> -         &thunder_pem_ecam_ops, THUNDER_PEM_RES(0x89808f000000UL, node) }
> +       { "CAVIUM", "THUNDERX", (rev), 4 + (10 * (node)),
> MCFG_BUS_ANY,      \
> +         &thunder_pem_ecam_ops, THUNDER_PEM_RES(0x88001f000000UL,
> (node)) }, \
> +       { "CAVIUM", "THUNDERX", (rev), 5 + (10 * (node)),
> MCFG_BUS_ANY,      \
> +         &thunder_pem_ecam_ops, THUNDER_PEM_RES(0x884057000000UL,
> (node)) }, \
> +       { "CAVIUM", "THUNDERX", (rev), 6 + (10 * (node)),
> MCFG_BUS_ANY,      \
> +         &thunder_pem_ecam_ops, THUNDER_PEM_RES(0x88808f000000UL,
> (node)) }, \
> +       { "CAVIUM", "THUNDERX", (rev), 7 + (10 * (node)),
> MCFG_BUS_ANY,      \
> +         &thunder_pem_ecam_ops, THUNDER_PEM_RES(0x89001f000000UL,
> (node)) }, \
> +       { "CAVIUM", "THUNDERX", (rev), 8 + (10 * (node)),
> MCFG_BUS_ANY,      \
> +         &thunder_pem_ecam_ops, THUNDER_PEM_RES(0x894057000000UL,
> (node)) }, \
> +       { "CAVIUM", "THUNDERX", (rev), 9 + (10 * (node)),
> MCFG_BUS_ANY,      \
> +         &thunder_pem_ecam_ops, THUNDER_PEM_RES(0x89808f000000UL, (node)) }
>         /* SoC pass2.x */
> -       THUNDER_PEM_QUIRK(1, 0UL),
> -       THUNDER_PEM_QUIRK(1, 1UL),
> +       THUNDER_PEM_QUIRK(1, 0),
> +       THUNDER_PEM_QUIRK(1, 1),
> 
>  #define THUNDER_ECAM_QUIRK(rev, seg)                                   \
>         { "CAVIUM", "THUNDERX", rev, seg, MCFG_BUS_ANY,                 \
> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> index 00eb8eb..643c9e7 100644
> --- a/include/linux/pci-ecam.h
> +++ b/include/linux/pci-ecam.h
> @@ -62,8 +62,9 @@ extern struct pci_ecam_ops pci_generic_ecam_ops;
>  #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
>  extern struct pci_ecam_ops pci_32b_ops;                /* 32-bit
> accesses only */
>  extern struct pci_ecam_ops hisi_pcie_ops;      /* HiSilicon */
> -extern struct pci_ecam_ops thunder_pem_ecam_ops; /* Cavium ThunderX
> 1.x & 2.x */
> -extern struct pci_ecam_ops pci_thunder_ecam_ops; /* Cavium ThunderX 1.x */
> +extern struct pci_ecam_ops thunder_pem_ecam_ops; /* Cavium ThunderX
> pass1.x &
> +                                                   pass2.x */
> +extern struct pci_ecam_ops pci_thunder_ecam_ops; /* Cavium ThunderX
> pass1.x */
>  #endif

I applied the above by hand, thanks!

> >>ACPI: MCFG table detected, 4 entries
> >>ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-1f])
> >>acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM
> >>Segments MSI]
> >>acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug PME AER]
> >>acpi PNP0A08:00: _OSC: OS now controls [PCIeCapability]
> >>acpi PNP0A08:00: ECAM area [mem 0x848000000000-0x848001ffffff]
> >>reserved by THRX0001:00
> >>acpi PNP0A08:00: ECAM at [mem 0x848000000000-0x848001ffffff] for [bus 00-1f]
> >
> >I guess we don't need MCFG quirks for these bridges, since I don't see
> >the "MCFG quirk" message?
> 
> Yes, this is ThunderX 1-socket pass2.x so quirks are needed for 4-9
> host bridges only. Below summary of where/how quirks should be
> applied:
> 
> ThunderX pass2.x
> NUMA node -> segments -> ECAM compliant note
> 0 -> 0-3 -> ECAM compliant
> 0 -> 4-9 -> ECAM quirks (thunder_pem_ecam_ops)
> 1 (optionally) -> 10-13 -> ECAM compliant
> 1 (optionally) -> 14-19 -> ECAM quirks (thunder_pem_ecam_ops)
> 
> ThunderX pass1.x
> NUMA node -> segments -> ECAM compliant note
> 0 -> 0-3 -> ECAM quirks (pci_thunder_ecam_ops)
> 0 -> 4-9 -> ECAM quirks (thunder_pem_ecam_ops)
> 1 (optionally) -> 10-13 -> ECAM quirks (pci_thunder_ecam_ops)
> 1 (optionally) -> 14-19 -> ECAM quirks (thunder_pem_ecam_ops)

I included the above in the appropriate changelogs.

> >>system 00:00: [mem 0x848000000000-0x848001ffffff] could not be reserved
> >>system 00:01: [mem 0x849000000000-0x849001ffffff] could not be reserved
> >>system 00:02: [mem 0x84a000000000-0x84a001ffffff] could not be reserved
> >>system 00:03: [mem 0x84b000000000-0x84b001ffffff] could not be reserved
> >>system 00:04: [mem 0x87e0c0000000-0x87e0c0ffffff] could not be reserved
> >>system 00:04: [mem 0x88001f000000-0x880057ffffff] could not be reserved
> >>system 00:05: [mem 0x87e0c2000000-0x87e0c2ffffff] could not be reserved
> >>system 00:05: [mem 0x88808f000000-0x8880c7ffffff] could not be reserved
> >
> >Most of these match ECAM spaces, which is good.  00:04 and 00:05 each
> >have one ECAM space and one "other" space, which might be PEMx host
> >bridge registers?  That all seems good.
> 
> Yes, "other" space is PEMx host bridge registers.
> 
> >But I assume the other bridges (PCIx) also have register space in
> >addition to ECAM, and that should be reported also.
> 
> 00:00, 00:01, 00:02, 00:03 are ECAM compliant so for those we need
> ECAM region only.

Even if they're ECAM compliant, I'm surprised that the bridges have no
other register space, e.g., for programming the range of bus numbers
below the bridge, root complex error reporting, etc.  This would all
be device-specific, of course, so in the ACPI model it would be used
by firmware only (either firmware init or by ASL).

> >>root@ubuntu:~# cat /proc/iomem
> >>...
> >>838000000000-841fffffffff : PCI Bus 0000:00
> >>  838000000000-8380003fffff : 0000:03:00.0
> >
> >Something's missing here: we should have a clue about how we got from
> >bus 00 to bus 03.  From your dmesg, 0000:00:15.0 is a bridge from bus
> >00 to bus 03, and its windows should appear here.  I'd expect
> >something like:
> >
> >  838000000000-841fffffffff : PCI Bus 0000:00
> >    838000000000-838fffffffff : PCI Bus 0000:03  <- 00:15.0 window
> >      838000000000-8380003fffff : 0000:03:00.0
> >
> >This window should be inserted by generic code, so I don't know how
> >this could be broken.  Your dmesg should also have something like
> >this:
> >
> >  pci 0000:00:15.0: PCI bridge to [bus 03]
> >  pci 0000:00:15.0:   bridge window [mem 0x838000000000-0x838fffffffff]
> >
> >I don't see that, maybe because this is actually a console log
> >collected without "ignore_loglevel"?  But that obviously doesn't
> >affect /proc/iomem, so I'm still puzzled about that.
> 
> Enhanced Allocation is used for devices but not for bridges which
> have invalid BARs in standard configuration header. Thus devices
> request resources from first valid parent bridge (host bridge in
> this case).

Hmm, OK.  I can tell EA is going to be a pain.  We might need to
improve our logging somehow to make this more visible.

For my own edification, does this mean the bridge itself has magic EA
functionality?  I was assuming EA would be used for non-configurable
endpoints.  If the bridges leading to those endpoints have extra
apertures not described by the standard bridge window registers, that
makes it much more complicated to understand the topology.

> >>87e024000000-87e024000fff : ARMH0011:00
> >>  87e024000000-87e024000fff : ARMH0011:00
> >
> >This is interesting.  This must be a driver reserving these areas?
> >Normally a driver would use the driver name, not the device name.
> >
> >Ideally, I think the core should reserve the region with the device
> >name, and the driver would request it using the driver name, like
> >this:
> >
> >  843000000000-84303fffffff : 0002:01:00.0    <-- PCI core reservation
> >    843000000000-84303fffffff : thunder-nic   <-- driver request
> >
> >The ACPI core doesn't actually do the reservation, so I assume the
> >ARMH0011:00 stuff is from the driver, and it's curious that it has the
> >same region twice.
> >
> >>87e026000000-87e0bfffffff : PCI Bus 0000:00
> >>  87e027000000-87e0277fffff : CAVA02A:00
> >
> >This is interesting, too.  CAVA02A:00 looks like an ACPI device, but
> >apparently it consumes some of the space that we think is routed to
> >PCI bus 0000:00.  I think this happens on some x86 boxes, too, but it
> >is somewhat confusing.
> 
> I will take a look.
> 
> >
> >Based on this, I don't see any problems with the ThunderX quirks.
> >I'd like to understand what's going on with the PCI-to-PCI bridge
> >windows in /proc/iomem, but I doubt that's related to your quirks.
> 
> Yes it is not related to quirks.
> 
> However, CAVA02A:00 and ARMH0011 things should be investigated.

Thanks!  This piece is more a curiosity thing on my part.

ARMH0011 looks like it's claimed by arm_sbsa_uart_platform_driver.
This path:

  sbsa_uart_probe
    pl011_setup_port
      devm_ioremap_resource
        devm_request_mem_region

explains one of the lines, still curious about the other.

Bjorn
