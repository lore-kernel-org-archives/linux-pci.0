Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Sat, 2 Jun 2018 00:46:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v8 4/7] ACPI/hotplug/PCI: Do not scan all bridges when
 native PCIe hotplug is used
Message-ID: <20180602054659.GB187972@bhelgaas-glaptop.roam.corp.google.com>
References: <20180528124756.78512-1-mika.westerberg@linux.intel.com>
 <20180529160155.1738-1-mika.westerberg@linux.intel.com>
 <20180601213505.GA199634@bhelgaas-glaptop.roam.corp.google.com>
 <20180601214818.GK15419@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180601214818.GK15419@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 02, 2018 at 12:48:18AM +0300, Mika Westerberg wrote:
> On Fri, Jun 01, 2018 at 04:35:05PM -0500, Bjorn Helgaas wrote:
> > On Tue, May 29, 2018 at 07:01:55PM +0300, Mika Westerberg wrote:
> > > When a system is using native PCIe hotplug for Thunderbolt it will be
> > > only present in the system when there is a device connected. This pretty
> > > much follows the BIOS assisted hotplug behaviour.
> > > ...
> > 
> > > +static void acpiphp_native_scan_bridge(struct pci_dev *bridge)
> > > +{
> > > +	struct pci_bus *bus = bridge->subordinate;
> > > +	struct pci_dev *dev;
> > > +	int max;
> > > +
> > > +	if (!bus)
> > > +		return;
> > > +
> > > +	max = bus->busn_res.start;
> > > +	/* Scan already configured non-hotplug bridges */
> > > +	for_each_pci_bridge(dev, bus) {
> > > +		if (!dev->is_hotplug_bridge)
> > 
> > Here we test "dev->is_hotplug_bridge" and below we use
> > "hotplug_is_native(bus->self)".  Is the difference significant, or
> > should we use hotplug_is_native() here as well?
> > 
> > If we do need to use is_hotplug_bridge here, maybe a comment about the
> > difference would be helpful.
> 
> I think here hotplug_is_native() would work as well. The idea is
> that we need to avoid scanning bridges that are handled by pciehp
> (or shpchp).

I made that change on my branch.  That way we won't have to worry
about the cases where we set is_hotplug_bridge based on some ACPI
methods.  I think those would be bugs because I think we *do* want
acpiphp to scan them, and if we tested "!dev->is_hotplug_bridge", we
would not scan them.

Here's what's on my branch:

commit eb4c82c49180cf46dd7f9ed15ea96d1da190fea6
Author: Mika Westerberg <mika.westerberg@linux.intel.com>
Date:   Tue May 29 19:01:55 2018 +0300

    ACPI / hotplug / PCI: Don't scan bridges managed by native hotplug
    
    When acpiphp re-enumerates a PCI hierarchy because of an ACPI Notify()
    event, we should skip bridges managed by native hotplug (pciehp or shpchp).
    We don't want to scan below a native hotplug bridge until the hotplug
    controller generates a hot-add event.
    
    A typical scenario is a Root Port leading to a Thunderbolt host router that
    remains powered off until something is connected to it.  See [1] for the
    lspci details.
    
      1. Before something is connected, only the Root Port exists.  It has
         PCI_EXP_SLTCAP_HPC set and pciehp is responsible for hotplug:
    
           00:1b.0 Root Port (HotPlug+)
    
      2. When a USB-C or Thunderbolt device is connected, the Switch in the
         Thunderbolt host router is powered up, the Root Port signals a hotplug
         add event and pciehp enumerates the Switch:
    
           01:00.0 Switch Upstream Port   to [bus 02-39]
           02:00.0 Switch Downstream Port to [bus 03]    (HotPlug-, to NHI)
           02:01.0 Switch Downstream Port to [bus 04-38] (HotPlug+, to Thunderbolt connector)
           02:02.0 Switch Downstream Port to [bus 39]    (HotPlug-, to xHCI)
    
         The 02:00.0 and 02:02.0 Ports lead to Endpoints that are not powered
         up yet.  The Ports have PCI_EXP_SLTCAP_HPC cleared, so pciehp doesn't
         handle hotplug for them and we assign minimal resources to them.
    
         The 02:01.0 Port has PCI_EXP_SLTCAP_HPC set, so pciehp handles native
         hotplug events for it.
    
      3. The BIOS powers up the xHCI controller.  If a Thunderbolt device was
         connected (not just a USB-C device), it also powers up the NHI.  Then
         it sends an ACPI Notify() to the Root Port, and acpiphp enumerates the
         new device(s):
    
           03:00.0 Thunderbolt Host Controller (NHI) Endpoint
           39:00.0 xHCI Endpoint
    
      4. If a Thunderbolt device was connected, the host router firmware uses
         the NHI to set up Thunderbolt tunnels and triggers a native hotplug
         event (via 02:01.0 in this example).  Then pciehp enumerates the new
         Thunderbolt devices:
    
           04:00.0 Switch Upstream Port   to [bus 05-38]
           05:01.0 Switch Downstream Port to [bus 06-09] (HotPlug-)
           05:04.0 Switch Downstream Port to [bus 0a-38] (HotPlug+)
    
         In this example, 05:01.0 leads to another Switch and some NICs.  This
         subtree is static, so 05:01.0 doesn't support hotplug and has
         PCI_EXP_SLTCAP_HPC cleared.
    
    In step 3, acpiphp previously enumerated everything below the Root Port,
    including things below the 02:01.0 Port.  We don't want that because pciehp
    expects to manage hotplug below that Port, and firmware on the host router
    may be in the middle of configuring its Link so it may not be ready yet.
    
    To make this work better with the native PCIe (pciehp) and standard PCI
    (shpchp) hotplug drivers, we let them handle all slot management and
    resource allocation for hotplug bridges and restrict ACPI hotplug to
    non-hotplug bridges.
    
    [1] https://bugzilla.kernel.org/show_bug.cgi?id=199581#c5
    Link: https://lkml.kernel.org/r/20180529160155.1738-1-mika.westerberg@linux.intel.com
    Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
    [bhelgaas: changelog, use hotplug_is_native() instead of
    dev->is_hotplug_bridge]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index b45b375c0e6c..bc9e19642567 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -287,11 +287,12 @@ static acpi_status acpiphp_add_context(acpi_handle handle, u32 lvl, void *data,
 	/*
 	 * Expose slots to user space for functions that have _EJ0 or _RMV or
 	 * are located in dock stations.  Do not expose them for devices handled
-	 * by the native PCIe hotplug (PCIeHP), becuase that code is supposed to
-	 * expose slots to user space in those cases.
+	 * by the native PCIe hotplug (PCIeHP) or standard PCI hotplug
+	 * (SHPCHP), because that code is supposed to expose slots to user
+	 * space in those cases.
 	 */
 	if ((acpi_pci_check_ejectable(pbus, handle) || is_dock_device(adev))
-	    && !(pdev && pdev->is_hotplug_bridge && pciehp_is_native(pdev))) {
+	    && !(pdev && hotplug_is_native(pdev))) {
 		unsigned long long sun;
 		int retval;
 
@@ -430,6 +431,29 @@ static int acpiphp_rescan_slot(struct acpiphp_slot *slot)
 	return pci_scan_slot(slot->bus, PCI_DEVFN(slot->device, 0));
 }
 
+static void acpiphp_native_scan_bridge(struct pci_dev *bridge)
+{
+	struct pci_bus *bus = bridge->subordinate;
+	struct pci_dev *dev;
+	int max;
+
+	if (!bus)
+		return;
+
+	max = bus->busn_res.start;
+	/* Scan already configured non-hotplug bridges */
+	for_each_pci_bridge(dev, bus) {
+		if (!hotplug_is_native(dev))
+			max = pci_scan_bridge(bus, dev, max, 0);
+	}
+
+	/* Scan non-hotplug bridges that need to be reconfigured */
+	for_each_pci_bridge(dev, bus) {
+		if (!hotplug_is_native(dev))
+			max = pci_scan_bridge(bus, dev, max, 1);
+	}
+}
+
 /**
  * enable_slot - enable, configure a slot
  * @slot: slot to be enabled
@@ -442,25 +466,42 @@ static void enable_slot(struct acpiphp_slot *slot)
 	struct pci_dev *dev;
 	struct pci_bus *bus = slot->bus;
 	struct acpiphp_func *func;
-	int max, pass;
-	LIST_HEAD(add_list);
 
-	acpiphp_rescan_slot(slot);
-	max = acpiphp_max_busnr(bus);
-	for (pass = 0; pass < 2; pass++) {
+	if (bus->self && hotplug_is_native(bus->self)) {
+		/*
+		 * If native hotplug is used, it will take care of hotplug
+		 * slot management and resource allocation for hotplug
+		 * bridges. However, ACPI hotplug may still be used for
+		 * non-hotplug bridges to bring in additional devices such
+		 * as a Thunderbolt host controller.
+		 */
 		for_each_pci_bridge(dev, bus) {
-			if (PCI_SLOT(dev->devfn) != slot->device)
-				continue;
-
-			max = pci_scan_bridge(bus, dev, max, pass);
-			if (pass && dev->subordinate) {
-				check_hotplug_bridge(slot, dev);
-				pcibios_resource_survey_bus(dev->subordinate);
-				__pci_bus_size_bridges(dev->subordinate, &add_list);
+			if (PCI_SLOT(dev->devfn) == slot->device)
+				acpiphp_native_scan_bridge(dev);
+		}
+		pci_assign_unassigned_bridge_resources(bus->self);
+	} else {
+		LIST_HEAD(add_list);
+		int max, pass;
+
+		acpiphp_rescan_slot(slot);
+		max = acpiphp_max_busnr(bus);
+		for (pass = 0; pass < 2; pass++) {
+			for_each_pci_bridge(dev, bus) {
+				if (PCI_SLOT(dev->devfn) != slot->device)
+					continue;
+
+				max = pci_scan_bridge(bus, dev, max, pass);
+				if (pass && dev->subordinate) {
+					check_hotplug_bridge(slot, dev);
+					pcibios_resource_survey_bus(dev->subordinate);
+					__pci_bus_size_bridges(dev->subordinate,
+							       &add_list);
+				}
 			}
 		}
+		__pci_bus_assign_resources(bus, &add_list, NULL);
 	}
-	__pci_bus_assign_resources(bus, &add_list, NULL);
 
 	acpiphp_sanitize_bus(bus);
 	pcie_bus_configure_settings(bus);
