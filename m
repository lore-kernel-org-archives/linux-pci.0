Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50190 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753767AbaAaAuh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jan 2014 19:50:37 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: Commit ef83b0781a73f (PCI: Remove from bus_list and release resources in pci_release_dev()) broke TBT hotplug
Date: Fri, 31 Jan 2014 02:04:58 +0100
Message-ID: <6710733.Fy4CsjXWaz@vostro.rjw.lan>
In-Reply-To: <7120202.A2h3LvJsyn@vostro.rjw.lan>
References: <20140130131236.GW18029@intel.com> <CAE9FiQUmuaarJEhOQogusyv3EpBPDjRTtRvbh4U4QCJqfs0Vvw@mail.gmail.com> <7120202.A2h3LvJsyn@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, January 31, 2014 01:39:38 AM Rafael J. Wysocki wrote:
> On Thursday, January 30, 2014 03:39:02 PM Yinghai Lu wrote:
> > On Thu, Jan 30, 2014 at 3:39 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > On Thursday, January 30, 2014 08:56:05 AM Yinghai Lu wrote:
> > >>
> > >> --047d7b5d2ea4eb937804f132eedf
> > >> Content-Type: text/plain; charset=ISO-8859-1
> > >>
> > >> >> The latest mainline kernel "hangs" when Thunderbolt devices are
> > >> >> hot-unplugged to the system. I can't see any oops but after hot-unplug I'm
> > >> >> getting huge amounts of messages like:
> > >> >>
> > >> >> [  352.717001] pci 0000:02:00.0: PME# disabled
> > >> >> [  352.717011] pci 0000:02:00.0: PME# disabled
> > >> >> [  352.717021] pci 0000:02:00.0: PME# disabled
> > >> >> [  352.717032] pci 0000:02:00.0: PME# disabled
> > >> >> [  352.717041] pci 0000:02:00.0: PME# disabled
> > >> >> [  352.717051] pci 0000:02:00.0: PME# disabled
> > >> >> [  352.717061] pci 0000:02:00.0: PME# disabled
> > >> >> [  352.717070] pci 0000:02:00.0: PME# disabled
> > >> >> [  352.717083] pci 0000:02:00.0: PME# disabled
> > >> >> [  352.717094] pci 0000:02:00.0: PME# disabled
> > >> >> [  352.717104] pci 0000:02:00.0: PME# disabled
> > >> >> [  352.717113] pci 0000:02:00.0: PME# disabled
> > >> >> [  352.717124] pci 0000:02:00.0: PME# disabled
> > >> >> [  352.717133] pci 0000:02:00.0: PME# disabled
> > >> >> [  352.717143] pci 0000:02:00.0: PME# disabled
> > >> >> [  352.717153] pci 0000:02:00.0: PME# disabled
> > >> >> [  352.717162] pci 0000:02:00.0: PME# disabled
> > >> >
> > >> > that mean pci_stop_dev() get called again and again ?
> > >>
> > >> please check if attached patch could help.
> > >
> > > Well, it looks like what happens is an endless loop in
> > > acpiphp_glue.c:disable_slot().
> > >
> > > dev_in_slot() returns the first device in the list, so
> > > pci_stop_and_remove_bus_device() is called for it, but it
> > > doesn't remove the device from bus->devices any more, so
> > > dev_in_slot() will return the same device next time and
> > > so on forever.
> > >
> > ...
> > >
> > > So the above won't help in my opinion.
> > >
> > > I wonder, however, if this patch helps instead:
> > >
> > > https://patchwork.kernel.org/patch/3540701/
> > >
> > > I thought it would be 3.15 material, but it very well can go in earlier if
> > > it happens to address this particular problem.
> > 
> > Agree, that should fix the problem.
> > 
> > but please use list_for_each_entry_safe_reverse
> > instead.
> > 
> > please refer to pciehp changelog in
> > 
> > commit 29ed1f29b68a8395d5679b3c4e38352b617b3236
> > Author: Yinghai Lu <yinghai@kernel.org>
> > Date:   Fri Jul 19 12:14:16 2013 -0700
> > 
> >     PCI: pciehp: Fix null pointer deref when hot-removing SR-IOV device
> > 
> >     Hot-removing a device with SR-IOV enabled causes a null pointer dereference
> >     in v3.9 and v3.10.
> > 
> >     This is a regression caused by ba518e3c17 ("PCI: pciehp: Iterate over all
> >     devices in slot, not functions 0-7").  When we iterate over the
> >     bus->devices list, we first remove the PF, which also removes all the VFs
> >     from the list.  Then the list iterator blows up because more than just the
> >     current entry was removed from the list.
> > 
> >     ac205b7bb7 ("PCI: make sriov work with hotplug remove") works around a
> >     similar problem in pci_stop_bus_devices() by iterating over the list in
> >     reverse, so the VFs are stopped and removed from the list first, before the
> >     PF.
> > 
> >     This patch changes pciehp_unconfigure_device() to iterate over the list in
> >     reverse, too.
> > 
> >     [bhelgaas: bugzilla, changelog]
> >     Reference: https://bugzilla.kernel.org/show_bug.cgi?id=60604
> 
> So I gather all of bus->devices list walks during which devices may be removed
> should be done in the reverse order, right?

So it looks like we need the patch below (on top of https://patchwork.kernel.org/patch/3559831/),
right?

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: ACPI / hotplug / PCI: Remove entries from bus->devices in reverse order

According to the changelog of commit 29ed1f29b68a (PCI: pciehp: Fix null
pointer deref when hot-removing SR-IOV device) it is unsafe to walk the
bus->devices list of a PCI bus and remove devices from it in direct order,
because that may lead to NULL pointer dereferences related to virtual
functions.

For this reason, change all of the bus->devices list walks in
acpiphp_glue.c during which devices may be removed to be carried out in
reverse order.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/pci/hotplug/acpiphp_glue.c
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-pm/drivers/pci/hotplug/acpiphp_glue.c
@@ -724,7 +724,7 @@ static void trim_stale_devices(struct pc
 
 		/* The device is a bridge. so check the bus below it. */
 		pm_runtime_get_sync(&dev->dev);
-		list_for_each_entry_safe(child, tmp, &bus->devices, bus_list)
+		list_for_each_entry_safe_reverse(child, tmp, &bus->devices, bus_list)
 			trim_stale_devices(child);
 
 		pm_runtime_put(&dev->dev);
@@ -755,8 +755,8 @@ static void acpiphp_check_bridge(struct
 			; /* do nothing */
 		} else if (get_slot_status(slot) == ACPI_STA_ALL) {
 			/* remove stale devices if any */
-			list_for_each_entry_safe(dev, tmp, &bus->devices,
-						 bus_list)
+			list_for_each_entry_safe_reverse(dev, tmp,
+							 &bus->devices, bus_list)
 				if (PCI_SLOT(dev->devfn) == slot->device)
 					trim_stale_devices(dev);
 
@@ -787,7 +787,7 @@ static void acpiphp_sanitize_bus(struct
 	int i;
 	unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM;
 
-	list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list) {
+	list_for_each_entry_safe_reverse(dev, tmp, &bus->devices, bus_list) {
 		for (i=0; i<PCI_BRIDGE_RESOURCES; i++) {
 			struct resource *res = &dev->resource[i];
 			if ((res->flags & type_mask) && !res->start &&

