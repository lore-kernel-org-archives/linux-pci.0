Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751627AbcLEVUS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Dec 2016 16:20:18 -0500
Date: Mon, 5 Dec 2016 15:20:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Duc Dang <dhdang@apm.com>
Cc: Jon Masters <jcm@redhat.com>, Mark Salter <msalter@redhat.com>,
        Rafael Wysocki <rafael@kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, patches <patches@apm.com>
Subject: Re: [PATCH v3] PCI/ACPI: xgene: Add ECAM quirk for X-Gene PCIe
 controller
Message-ID: <20161205212012.GA22455@bhelgaas-glaptop.roam.corp.google.com>
References: <1480549373-2123-1-git-send-email-dhdang@apm.com>
 <20161201183350.GF30746@bhelgaas-glaptop.roam.corp.google.com>
 <1480620053.4751.30.camel@redhat.com>
 <20161201194114.GA8263@bhelgaas-glaptop.roam.corp.google.com>
 <CADaLNDkVPRPSg0aU-sxHsiJbVvEn=LxcekDt6gfXBBhc+fzhjw@mail.gmail.com>
 <20161201230736.GA17948@bhelgaas-glaptop.roam.corp.google.com>
 <CADaLND=Ss8d-jv7wffbrtytrjj=SUnjDn9bognKUszhKguRV1A@mail.gmail.com>
 <d77e403c-81e9-114e-6ec6-bbffaa4ac36f@redhat.com>
 <20161202233943.GF9903@bhelgaas-glaptop.roam.corp.google.com>
 <CADaLNDk-cMW8k+bXqH3+yYCye_kHf6RXUYQ=eCCZ4FF2ZTjgkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CADaLNDk-cMW8k+bXqH3+yYCye_kHf6RXUYQ=eCCZ4FF2ZTjgkQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 02, 2016 at 11:06:30PM -0800, Duc Dang wrote:
> On Fri, Dec 2, 2016 at 3:39 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:

> > diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> > index 8a177a1..a16fc8e 100644
> > --- a/arch/arm64/kernel/pci.c
> > +++ b/arch/arm64/kernel/pci.c
> > @@ -114,6 +114,19 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
> >         return 0;
> >  }
> >
> > +static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
> > +{
> > +       struct resource_entry *entry, *tmp;
> > +       int status;
> > +
> > +       status = acpi_pci_probe_root_resources(ci);
> > +       resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
> > +               if (!(entry->res->flags & IORESOURCE_WINDOW))
> > +                       resource_list_destroy_entry(entry);
> > +       }
> > +       return status;
> > +}
> > +
> >  /*
> >   * Lookup the bus range for the domain in MCFG, and set up config space
> >   * mapping.
> > @@ -190,6 +203,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> >         }
> >
> >         root_ops->release_info = pci_acpi_generic_release_info;
> > +       root_ops->prepare_resources = pci_acpi_root_prepare_resources;
> >         root_ops->pci_ops = &ri->cfg->ops->pci_ops;
> >         bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
> >         if (!bus)
> 
> I tried your patch above with my X-Gene ECAM v4 patch on Mustang, here
> is the kernel boot log and output of 'cat /proc/iomem'. The PCIe core
> does not print the MMIO space as a window (which is expected per your
> patch above).

Thanks!

> ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
> acpi PNP0A08:00: MCFG quirk: ECAM at [mem 0xe0d0000000-0xe0dfffffff] for [bus 00-ff] with xgene_v1_pcie_ecam_ops
> acpi PNP0A08:00: [Firmware Bug]: ECAM area [mem 0xe0d0000000-0xe0dfffffff] not reserved in ACPI namespace
> acpi PNP0A08:00: ECAM at [mem 0xe0d0000000-0xe0dfffffff] for [bus 00-ff]
> Remapped I/O 0x000000e010000000 to [io  0x0000-0xffff window]
> PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x0000-0xffff window] (bus address [0x10000000-0x1000ffff])
> pci_bus 0000:00: root bus resource [mem 0xe040000000-0xe07fffffff window] (bus address [0x40000000-0x7fffffff])
> pci_bus 0000:00: root bus resource [mem 0xf000000000-0xffffffffff window]
> pci_bus 0000:00: root bus resource [bus 00-ff]

Yup, no bridge register space here; that's good.  I assume the bridge
registers are at [mem 0x1f2b0000-0x1f2bffff] as shown in /proc/iomem
below.

> [root@(none) ~]# cat /proc/io mem
> ...
> 19000000-19007fff : 808622B7:00
> 1900c100-190fffff : 808622B7:00
>   1900c100-190fffff : 808622B7:00
> 19800000-19807fff : 808622B7:01
> 1980c100-198fffff : 808622B7:01
>   1980c100-198fffff : 808622B7:01
> ...
> 1f280000-1f28ffff : 808622B7:00
> 1f290000-1f29ffff : 808622B7:01

I'm curious what these "808622B7" devices are.  Per ACPI 6.0, sec
6.1.5, that looks like a PCI vendor ID, which I guess is a valid ACPI
ID.  But these resources don't seem to have any connection with PCI
(they're not in any of the host bridge apertures).

> 1f2b0000-1f2bffff : PNP0A08:00

Looks like the bridge register space; good.

> e040000000-e07fffffff : PCI Bus 0000:00
>   e040000000-e0401fffff : PCI Bus 0000:01
>     e040000000-e0400fffff : 0000:01:00.0
>       e040000000-e0400fffff : mlx4_core
>     e040100000-e0401fffff : 0000:01:00.0

> e0d0000000-e0dfffffff : PCI ECAM

This region should be described in either a PNP0C02 device or (if we
decide we can allow "consumer" descriptors) the PNP0A08 device.  I
assume you'll fix that in a future firmware release.

But I think this reservation from pci_ecam_create() is good enough for
now.

> f000000000-ffffffffff : PCI Bus 0000:00
>   f000000000-f001ffffff : PCI Bus 0000:01
>     f000000000-f001ffffff : 0000:01:00.0
>       f000000000-f001ffffff : mlx4_core
