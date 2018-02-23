Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:33416 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754520AbeBWTHB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Feb 2018 14:07:01 -0500
From: <Mario.Limonciello@dell.com>
To: <helgaas@kernel.org>
CC: <bhelgaas@google.com>, <rjw@rjwysocki.net>,
        <andriy.shevchenko@linux.intel.com>, <lenb@kernel.org>,
        <michael.jamet@intel.com>, <yehezkel.bernat@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <mika.westerberg@linux.intel.com>
Subject: RE: [PATCH v2 1/5] PCI: Make sure all bridges reserve at least one
 bus number
Date: Fri, 23 Feb 2018 19:06:59 +0000
Message-ID: <5506aacec14e4696a6f306ebd7df6fd2@ausx13mpc120.AMER.DELL.COM>
References: <20180215144000.60456-1-mika.westerberg@linux.intel.com>
 <20180215144000.60456-2-mika.westerberg@linux.intel.com>
 <20180223002733.GH14632@bhelgaas-glaptop.roam.corp.google.com>
 <c00e7c7a-6ebd-41b6-a924-92a2070e3db3@Dell.com>
 <20180223172543.GK14632@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180223172543.GK14632@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Friday, February 23, 2018 11:26 AM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Cc: bhelgaas@google.com; rjw@rjwysocki.net;
> andriy.shevchenko@linux.intel.com; lenb@kernel.org; michael.jamet@intel.c=
om;
> yehezkel.bernat@intel.com; linux-acpi@vger.kernel.org; linux-
> pci@vger.kernel.org; mika.westerberg@linux.intel.com
> Subject: Re: [PATCH v2 1/5] PCI: Make sure all bridges reserve at least o=
ne bus
> number
>=20
> On Fri, Feb 23, 2018 at 12:52:18AM +0000, Mario.Limonciello@dell.com wrot=
e:
> > On Feb 22, 2018 18:27, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Thu, Feb 15, 2018 at 05:39:55PM +0300, Mika Westerberg wrote:
> > > > When distributing extra buses between hotplug bridges we need to ma=
ke
> > > > sure each bridge reserve at least one bus number, even if there is
> > > > currently nothing connected to it. For instance ACPI hotplug may br=
ing
> > > > in additional devices to non-hotplug bridges later on. To make sure=
 we
> > > > don't run out of bus numbers for non-hotplug bridges reserve one bu=
s
> > > > number for them upfront before distributing buses for hotplug bridg=
es.
> > > >
> > > > Fixes: 1c02ea810065 ("PCI: Distribute available buses to hotplug-ca=
pable
> bridges")
> > > > Reported-by: Mario Limonciello <mario.limonciello@dell.com>
> > >
> > > Is there a bugzilla or email URL we can include here?
> >
> > Sorry it was private communication that I believe Mika is referring to =
in Reported-
> By here.
> >
> > You can remove the tag if you think it's inappropriate for this commit.
>=20
> I like to give credit whenever possible, so I wouldn't necessarily
> remove the Reported-by.
>=20
> But it would be very useful to also have a URL to something with more
> details, e.g., what sort of failure the user would observe, dmesg
> logs, PCI topology, etc.
>=20
> This information can certainly be redacted to remove any proprietary
> things that can't be made public.  Usually that isn't of interest to
> structural issues like this anyway.

It was a result of a very long communication chain, but I think I pulled
out the relevant details here if you would like a URL to include:
https://gist.github.com/superm1/100a2ed20449f684ebb84c392e35dbed

Thank you.

>=20
> > > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > Cc: stable@vger.kernel.org
> > > > ---
> > > >  drivers/pci/probe.c | 11 ++++++++---
> > > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > > index ef5377438a1e..6cefd47556e3 100644
> > > > --- a/drivers/pci/probe.c
> > > > +++ b/drivers/pci/probe.c
> > > > @@ -2561,7 +2561,10 @@ static unsigned int
> pci_scan_child_bus_extend(struct pci_bus *bus,
> > > >  for_each_pci_bridge(dev, bus) {
> > > >  cmax =3D max;
> > > >  max =3D pci_scan_bridge_extend(bus, dev, max, 0, 0);
> > > > - used_buses +=3D cmax - max;
> > > > + /* Reserve one bus for each bridge */
> > > > + used_buses++;
> > > > + if (cmax - max > 1)
> > > > + used_buses +=3D cmax - max - 1;
> > > >  }
> > > >
> > > >  /* Scan bridges that need to be reconfigured */
> > > > @@ -2584,12 +2587,14 @@ static unsigned int
> pci_scan_child_bus_extend(struct pci_bus *bus,
> > > >  * bridges if any.
> > > >  */
> > > >  buses =3D available_buses / hotplug_bridges;
> > > > - buses =3D min(buses, available_buses - used_buses);
> > > > + buses =3D min(buses, available_buses - used_buses + 1);
> > > >  }
> > > >
> > > >  cmax =3D max;
> > > >  max =3D pci_scan_bridge_extend(bus, dev, cmax, buses, 1);
> > > > - used_buses +=3D max - cmax;
> > > > + /* One bus is already accounted so don't add it again */
> > > > + if (max - cmax > 1)
> > > > + used_buses +=3D max - cmax - 1;
> > > >  }
> > > >
> > > >  /*
> > > > --
> > > > 2.15.1
> > > >
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe linux-acp=
i" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
