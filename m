Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42727 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933648AbcDMGbS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 Apr 2016 02:31:18 -0400
Date: Wed, 13 Apr 2016 01:31:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jordan Hargrave <jharg93@gmail.com>
Cc: Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v3] Create pci slot files for SMBIOS Type 9 entries
Message-ID: <20160413063114.GA8252@localhost>
References: <1455827823254.98505@Dell.com>
 <20160410221743.GC5852@localhost>
 <CAC1AzdcBH7wLz+tAE4R00q6YQ7KRRzBDyP5w8wJQueJgT2agnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAC1AzdcBH7wLz+tAE4R00q6YQ7KRRzBDyP5w8wJQueJgT2agnQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 12, 2016 at 06:36:14PM -0500, Jordan Hargrave wrote:
> On Sun, Apr 10, 2016 at 5:17 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > Hi Jordan,
> >
> > On Thu, Feb 18, 2016 at 08:40:32PM +0000, Jordan_Hargrave@Dell.com wrote:
> >> The following diff builds on the "[PATCHv3] Save SMBIOS Type 9 System Slots"
> >>
> >> This will create a /sys/bus/pci/slots/XXX file for each Type 9 entry.  This will be \
> >> used for systemd enumeration of NICs.
> >>
> >> Only build if CONFIG_DMI is set
> >>
> >> Signed-off-by: Jordan Hargrave <Jordan_Hargrave@dell.com>
> >> ---
> >>  arch/x86/pci/common.c | 21 +++++++++++++++++++++
> >>  1 file changed, 21 insertions(+)
> >>
> >> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> >> index eccd4d9..bfa3c85 100644
> >> --- a/arch/x86/pci/common.c
> >> +++ b/arch/x86/pci/common.c
> >> @@ -173,6 +173,27 @@ void pcibios_fixup_bus(struct pci_bus *b)
> >>
> >>  void pcibios_add_bus(struct pci_bus *bus)
> >>  {
> >> +#ifdef CONFIG_DMI
> >> +     const struct dmi_device *dmi;
> >> +     struct dmi_dev_onboard *dslot;
> >> +     char sname[128];
> >> +
> >> +     dmi = NULL;
> >> +     while ((dmi = dmi_find_device(DMI_DEV_TYPE_DEV_SLOT,
> >> +                                   NULL, dmi)) != NULL) {
> >> +             dslot = dmi->device_data;
> >> +             if (dslot->segment == pci_domain_nr(bus) &&
> >> +                 dslot->bus == bus->number) {
> >> +                     dev_info(&bus->dev, "Found SMBIOS Slot %s\n",
> >> +                              dslot->dev.name);
> >> +                     snprintf(sname, sizeof(sname), "%s-%d",
> >> +                              dslot->dev.name,
> >> +                              dslot->instance);
> >> +                     pci_create_slot(bus, dslot->devfn,
> >> +                                     sname, NULL);
> >> +             }
> >> +     }
> >> +#endif
> >
> > arm64, ia64, and x86 all support CONFIG_DMI, so this would have to be
> > a bit more generic.
> 
> The SMBIOS tables for DMI_DEV_TYPE_DEV_SLOT are scanned in
> firmware/dmi_scan.c which requires CONFIG_DMI

Right.  My point is that arm64, ia64, and x86 can all have SMBIOS
tables, but the code you're adding to parse them and add sysfs info is
only for x86.  If we're going to do this, we should do it for all
arches that support SMBIOS, not just x86.

> > Is there a spec that describes this SMBIOS entry?  It seems to have
> > segment/bus/devfn, so maybe this should be done on a per-device basis,
> > not a per-bus basis?
> >
> 
> Yes, the SMBIOS specification for Type 9 System Slots.  The fields for
> PCI mapping were added in SMBIOS 2.6
> 
> https://www.dmtf.org/sites/default/files/standards/documents/DSP0134_3.0.0.pdf

Thanks.  Let's include that link in the changelog of the next
iteration.

> > Does this do the same thing ctrl_slot_setup() does with
> > get_SMBIOS_entry()?  (This is in the cpqphp hotplug driver; I have no
> > idea if anybody still uses that.)
> 
> Looks like cpqphp driver is looking for SMBIOS Type 9, but < 2.5 table
> structure. It's looking for the slot ID number (this number is
> equivalent to dslot->instance).
> 
> 
> >
> > There's quite a collection of pci_create_slot() callers, and I'd like
> > to know how this new addition would coexist with the others.  In
> > particular, what about the one in pciehp?  I think we only expose a
> > slot name in sysfs if pciehp claims a downstream port, but I'm not
> > sure that's the right thing.  The slot number might be useful even if
> > the slot doesn't support hotplug or if hotplug is disabled for some
> > reason.
> >
> 
> pciehp requires the BIOS has setup the slot number in PCI properly....
> I've seen systems with two PCIE 'slots' which had the same slot
> number.  Of course the SMBIOS table requires the BIOS got it right
> too....

I don't know what the answer is; I'm just trying to make the point
that we have several sources of slot information, the process of
exposing that via sysfs is already a bit messy, and adding more from
SMBIOS will only make it messier.  So I'd like to have a better
understanding of how it all works.

The slot info from the PCIe capability is not necessarily unique, even
if the BIOS gets everything right.  If you hot-add a PCIe expansion
chassis, BIOS isn't involved in setting up those new slots, so the
PCIe slot capability probably contains slot numbers hardwired into the
chassis.

Bjorn
