Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 4 May 2018 19:04:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 4/9] ACPI / hotplug / PCI: Do not scan all bridges
 when native PCIe hotplug is used
Message-ID: <20180505000420.GB9529@bhelgaas-glaptop.roam.corp.google.com>
References: <20180416103453.46232-1-mika.westerberg@linux.intel.com>
 <20180416103453.46232-5-mika.westerberg@linux.intel.com>
 <20180502204932.GG11698@bhelgaas-glaptop.roam.corp.google.com>
 <20180503102241.GI2355@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180503102241.GI2355@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 03, 2018 at 01:22:41PM +0300, Mika Westerberg wrote:
> On Wed, May 02, 2018 at 03:49:32PM -0500, Bjorn Helgaas wrote:
> > On Mon, Apr 16, 2018 at 01:34:48PM +0300, Mika Westerberg wrote:
> > > When a system is using native PCIe hotplug for Thunderbolt and the
> > > controller is not enabled for full RTD3 (runtime D3) it will be only
> > > present in the system when there is a device connected. This pretty much
> > > follows the BIOS assisted hotplug behaviour.
> > 
> > This is a tangent, but what exactly does "controller is not enabled
> > for full RTD3 (runtime D3)" mean?  The way that's worded sounds like
> > it *could* be a setting in a PCI config register, but I suspect it's
> > really something in Linux, e.g., some bit in struct pci_dev or device?
> 
> It means that the controller can to into D3 runtime. With BIOS assisted
> mode and native PCIe mode, the controller is hot-removed when there is
> nothing connected. In RTD3 mode it is there always and the OS expected
> to put it into D3 when idle using standard PCI PM registers.

How do I tell if a controller is enabled for runtime D3?

I'm still struggling to figure out exactly how this runtime D3 part is
relevant to this patch.  It might be behavior that happens in this
particular scenario, but I'm not sure yet that it is a required part
of the picture.

I think you're trying to separate enumeration handled by pciehp from
enumeration handled by acpiphp, and runtime D3 sounds like an
orthogonal issue.

> > > Thunderbolt host router integrated PCIe switch has two additional PCIe
> > > downstream bridges that lead to NHI (Thunderbolt host controller) and xHCI
> > > (USB 3 host controller) respectively. These downstream bridges are not
> > > marked being hotplug capable. Reason for that is to preserve resources.
> > > Otherwise the OS would distribute remaining resources between all
> > > downstream bridges making these two bridges consume precious resources
> > > of the actual hotplug bridges.
> > > 
> > > Now, because these two bridges are not marked being hotplug capable the OS
> > > will not enable hotplug interrupt for them either and will not receive
> > > interrupt when devices behind them are hot-added. Solution to this is
> > > that the BIOS sends ACPI Notify() to the root port let the OS know it
> > > needs to rescan for added and/or removed devices.
> > 
> > We're building stuff based on "is_hotplug_bridge", but I'm not sure
> > that bit is really useful.
> > 
> > set_pcie_hotplug_bridge() sets it for downstream ports with
> > PCI_EXP_SLTCAP_HPC, which is easy enough to understand.
> > 
> > In acpiphp, check_hotplug_bridge() sets in some scenario that I can't
> > quite figure out.  I assume it's based on something in the namespace.
> > 
> > But it seems like the whole point of this patch is that even if a
> > bridge doesn't have "is_hotplug_bridge" set, ACPI hotplug can hot-add
> > devices below it.
> 
> Correct.
> 
> > So I'm not sure what "is_hotplug_bridge" is really telling us.  Is it
> > just a hint about how many resources we want to assign to the bridge,
> > i.e., we assign only a few when it's not set and more if it is set?
> 
> Good question. I did not invent the flag so hard to say. I've been using
> it because IIRC you prefer it.

It's not a question of whether I prefer it.  It's only useful if it
means something specific and we agree on what that is.

So what do you think it means?

In this code:

> > > @@ -291,7 +294,7 @@ static acpi_status acpiphp_add_context(acpi_handle handle, u32 lvl, void *data,
> > >          * expose slots to user space in those cases.
> > >          */
> > >         if ((acpi_pci_check_ejectable(pbus, handle) || is_dock_device(adev))
> > > -           && !(pdev && pdev->is_hotplug_bridge && pciehp_is_native(pdev))) {
> > > +           && !(slot->flags & SLOT_IS_NATIVE && pdev->is_hotplug_bridge)) {

I *think* this part:

  slot->flags & SLOT_IS_NATIVE && pdev->is_hotplug_bridge

means "this bridge supports hotplug but it is handled by pciehp, and
acpiphp should not expose the slot to user space".

If that's the case, maybe we should rework pciehp_is_native(bridge) so
instead of answering the question "does the OS have permission to
control PCIe hotplug in the hierarchy containing <bridge>?", it could
answer the specific question "does pciehp handle hotplug for
<bridge>?", e.g., something along these lines:

  bool pciehp_is_native(struct pci_dev *bridge)
  {
  #ifdef CONFIG_HOTPLUG_PCI_PCIE
    u32 slot_cap;
    struct pci_host_bridge *host;

    if (!pci_is_pcie(bridge))
      return false;

    pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
    if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
      return false;

    if (pcie_ports_native)
      return true;

    host = pci_find_host_bridge(bridge->bus);
    return host->native_hotplug;
  #else
    return false;
  #endif
  }

Then your test for whether acpiphp should expose the slot to user
space could be:

  -   && !(pdev && pdev->is_hotplug_bridge && pciehp_is_native(pdev))) {
  +   && !pciehp_is_native(pdev)) {
 
We could also use pciehp_is_native() directly in
get_port_device_capability(), which is essentially the condition that
allows pciehp to claim the device.

> > > Here is how the mechanism is supposed to work when a Thunderbolt
> > > endpoint is connected to one of the ports. In case of a standard USB-C
> > > device only the xHCI is hot-added otherwise steps are the same.
> > > 
> > > 1. Initially there is only the PCIe root port that is controlled by
> > >    the pciehp driver
> > > 
> > >   00:1b.0 (Hotplug+) --
> > > 
> > > 2. Then we get native PCIe hotplug interrupt and once it is handled the
> > >    topology looks as following
> > > 
> > >   00:1b.0 (Hotplug+) -- 01:00.0 --+- 02:00.0 --
> > >                                   +- 02:01.0 (HotPlug+)
> > >                                   \- 02:02.0 --
> > > 
> > > 3. Bridges 02:00.0 and 02:02.0 are not marked as hotplug capable and
> > 
> > By "not marked as hotplug capable", I guess you mean
> > PCI_EXP_SLTCAP_HPC is not set, right?
> 
> Right.
> 
> > >    they don't have anything behind them currently. Bridge 02:01.0 is
> > >    hotplug capable and used for extending the topology. At this point
> > >    the required PCIe devices are enabled and ACPI Notify() is sent to
> > >    the root port. The resulting topology is expected to look like
> > > 
> > >   00:1b.0 (Hotplug+) -- 01:00.0 --+- 02:00.0 -- Thunderbolt host controller
> > >                                   +- 02:01.0 (HotPlug+)
> > >                                   \- 02:02.0 -- xHCI host controller
> > > 
> > > However, the current ACPI hotplug implementation scans the whole 00:1b.0
> > > hotplug slot and everything behind it regardless whether native PCIe is
> > > used or not, and it expects that the BIOS has configured bridge
> > > resources upfront. If that's not the case it assigns resources using
> > > minimal allocation (everything currently found just barely fit)
> > > preventing future extension. In addition to that, if there is another
> > > native PCIe hotplug going on we may find the new PCIe switch only
> > > partially ready (all links are not fully trained yet) confusing pciehp
> > > when it finally starts to enumerate for new devices.
> > > 
> > > To make this work better with the native PCIe hotplug driver (pciehp),
> > > we let it handle all slot management and resource allocation for hotplug
> > > bridges and restrict ACPI hotplug to non-hotplug bridges.

I *think* the point of this patch is that:

  If X is a bridge, and pciehp manages hotplug on X, i.e., X has
  PCI_EXP_SLTCAP_HPC set and the OS owns PCIe hotplug in this
  hierarchy per _OSC, acpiphp should not enumerate devices on X's
  secondary bus.

  Furthermore, acpiphp should avoid this enumeration no matter where X
  is in the hierarchy.  So if the Notify() goes to a bridge Y far
  above X, acpiphp should look at every existing bridge in the
  hierarchy below Y.  If the bridge is managed by pciehp, acpiphp
  should ignore it.  Otherwise, acpiphp should scan for new devices
  below it.

This enumeration by acpiphp is recursive, and it has to avoid the
pciehp-managed bridges at every level.  Your changes to enable_slot()
check for SLOT_IS_NATIVE at the top level, but I don't see how they
avoid pciehp-managed bridges at lower levels that may be scanned by
pci_scan_bridge().

Bjorn
