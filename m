Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jarod Wilson <jarod@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci/hotplug: work-around for missing _RMV on HP ZBook G2
Date: Mon, 18 May 2015 23:57:47 +0200
Message-ID: <5429970.RX0mzgSQ5s@vostro.rjw.lan>
In-Reply-To: <5559F824.1020703@redhat.com>
References: <1431632038-39917-1-git-send-email-jarod@redhat.com> <1481007.OlNlbgiUPd@vostro.rjw.lan> <5559F824.1020703@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, May 18, 2015 10:33:08 AM Jarod Wilson wrote:
> On 5/17/2015 8:26 PM, Rafael J. Wysocki wrote:
> > On Saturday, May 16, 2015 09:41:55 AM Bjorn Helgaas wrote:
> >> On Sat, May 16, 2015 at 09:37:50AM -0500, Bjorn Helgaas wrote:
> >>> Hi Jarod,
> >>>
> >>> On Thu, May 14, 2015 at 03:33:58PM -0400, Jarod Wilson wrote:
> >>>> The HP ZBook 15 and 17 Mobile Workstations, generation 2, up to and
> >>>> including at least BIOS revision 01.07, do not have an ACPI _RMV object
> >>>> associated with their expresscard slots, so acpi-based hotplug-capable
> >>>> slot detection fails. If we fall back to pcie-based detection, the systems
> >>>> work just fine, so this uses dmi matching to do that. With luck, a future
> >>>> BIOS will remedy this (I've let someone at HP know about the problem),
> >>>> but for now, just use this for all existing versions.
> ...
> >>> Oh, my goodness.  I forgot how terrible this path is.  Can anyone write a
> >>> simple explanation of how we choose to use acpiphp or pciehp?
> >
> > In theory, that should depend on the _OSC handshake in acpi_pci_root_add().
> >
> > If the firmware doesn't give us control of the PCIe features, we'll not use
> > pciehp (or at least that's the idea).
> >
> > acpiphp is used if pciehp doesn't claim the device, AFAICS.

That wasn't precise enough, sorry.  ACPIPHP will handle device check and bus
check notifications from ACPI even for devices that have been claimed by
pciehp.  It won't call pci_hp_register() for them, though.

> [    4.013326] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM 
> ClockPM Segments MSI]
> [    4.015860] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME 
> AER PCIeCapability]
> 
> So at a glance, it would appear that pciehp *should* be claiming it, 
> right?

Yes, it should.

> Something I noted in the bug I filed is that the device ID 
> reported there is PNP0A08, and the root_device_id table that associates 
> with acpi_pci_root_add() only includes PNP0A03 in it. Is that correct, 
> or should 08 also be in there, which might remedy this? (I can test this 
> out easily enough).

It is correct (or at least not obviously incorrect).  The _OSC is for the host
bridge and determines the behavior for all devices below root ports.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
