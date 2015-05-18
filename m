Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jarod Wilson <jarod@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci/hotplug: work-around for missing _RMV on HP ZBook G2
Date: Tue, 19 May 2015 01:06:16 +0200
Message-ID: <1948383.UKjRPomMUp@vostro.rjw.lan>
In-Reply-To: <555A4F68.1020208@redhat.com>
References: <1431632038-39917-1-git-send-email-jarod@redhat.com> <555A1093.40303@redhat.com> <555A4F68.1020208@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, May 18, 2015 04:45:28 PM Jarod Wilson wrote:
> On 5/18/2015 12:17 PM, Jarod Wilson wrote:
> > On 5/18/2015 10:33 AM, Jarod Wilson wrote:
> >> On 5/17/2015 8:26 PM, Rafael J. Wysocki wrote:
> >>> On Saturday, May 16, 2015 09:41:55 AM Bjorn Helgaas wrote:
> >>>> On Sat, May 16, 2015 at 09:37:50AM -0500, Bjorn Helgaas wrote:
> >>>>> Hi Jarod,
> >>>>>
> >>>>> On Thu, May 14, 2015 at 03:33:58PM -0400, Jarod Wilson wrote:
> >>>>>> The HP ZBook 15 and 17 Mobile Workstations, generation 2, up to and
> >>>>>> including at least BIOS revision 01.07, do not have an ACPI _RMV
> >>>>>> object
> >>>>>> associated with their expresscard slots, so acpi-based
> >>>>>> hotplug-capable
> >>>>>> slot detection fails. If we fall back to pcie-based detection, the
> >>>>>> systems
> >>>>>> work just fine, so this uses dmi matching to do that. With luck, a
> >>>>>> future
> >>>>>> BIOS will remedy this (I've let someone at HP know about the
> >>>>>> problem),
> >>>>>> but for now, just use this for all existing versions.
> >> ...
> >>>>> Oh, my goodness.  I forgot how terrible this path is.  Can anyone
> >>>>> write a
> >>>>> simple explanation of how we choose to use acpiphp or pciehp?
> >>>
> >>> In theory, that should depend on the _OSC handshake in
> >>> acpi_pci_root_add().
> >>>
> >>> If the firmware doesn't give us control of the PCIe features, we'll
> >>> not use
> >>> pciehp (or at least that's the idea).
> >>>
> >>> acpiphp is used if pciehp doesn't claim the device, AFAICS.
> >>
> >> [    4.013326] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
> >> ClockPM Segments MSI]
> >> [    4.015860] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME
> >> AER PCIeCapability]
> >>
> >> So at a glance, it would appear that pciehp *should* be claiming it,
> >> right? Something I noted in the bug I filed is that the device ID
> >> reported there is PNP0A08, and the root_device_id table that associates
> >> with acpi_pci_root_add() only includes PNP0A03 in it. Is that correct,
> >> or should 08 also be in there, which might remedy this? (I can test this
> >> out easily enough).
> >
> > Nope, makes no difference, seems those are just two different references
> > to the same bus, based on a peek at the extracted dsdt:
> >
> > Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
> > Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
> 
> Ah, I forgot some additional details. pciehp_probe() in 
> drivers/pci/hotplug/pciehp_core.c fails on the 
> pciehp_acpi_slot_detection_check() call for the expresscard slot, which 
> is why the base pciehp doesn't bind. DEVICE_ACPI_HANDLE(&dev->dev) in 
> the slot detection check is winding up with a NULL acpi device.

So IMO the bug is that select_detection_mode() assumes that ACPI should be
used as the PCIe hotplug detection method if it has found at least one
device that looks like an "ACPI hotplug slot" (Thuderbolt breaks that "logic").

To be honest, I'm not sure why we need the pciehp_acpi_slot_detection_check()
in pciehp_probe() at all.  It doesn't add any value as far as I can say.

If pciehp_probe() is called at all, we have registered a PCIe port service
and if this is a "hotplug" service, we wouldn't have registered it if the
_OSC handshake had not given us contol over native hotplug.

So I wonder if the patch below makes any difference.

---
 drivers/pci/hotplug/pciehp_core.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/pci/hotplug/pciehp_core.c
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/pciehp_core.c
+++ linux-pm/drivers/pci/hotplug/pciehp_core.c
@@ -248,12 +248,9 @@ static int pciehp_probe(struct pcie_devi
 	struct slot *slot;
 	u8 occupied, poweron;
 
-	if (pciehp_force)
-		dev_info(&dev->device,
-			 "Bypassing BIOS check for pciehp use on %s\n",
-			 pci_name(dev->port));
-	else if (pciehp_acpi_slot_detection_check(dev->port))
-		goto err_out_none;
+	/* If this is not a "hotplug" service, we have no business here. */
+	if (dev->service != PCIE_PORT_SERVICE_HP)
+		return -ENODEV;
 
 	if (!dev->port->subordinate) {
 		/* Can happen if we run out of bus numbers during probe */

