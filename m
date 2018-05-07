Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 7 May 2018 15:37:56 -0500
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
Message-ID: <20180507203756.GA131458@bhelgaas-glaptop.roam.corp.google.com>
References: <20180416103453.46232-1-mika.westerberg@linux.intel.com>
 <20180416103453.46232-5-mika.westerberg@linux.intel.com>
 <20180502204932.GG11698@bhelgaas-glaptop.roam.corp.google.com>
 <20180503102241.GI2355@lahna.fi.intel.com>
 <20180505000420.GB9529@bhelgaas-glaptop.roam.corp.google.com>
 <20180507113449.GR17277@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180507113449.GR17277@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 07, 2018 at 02:34:49PM +0300, Mika Westerberg wrote:
> On Fri, May 04, 2018 at 07:04:20PM -0500, Bjorn Helgaas wrote:
> ...

> > In this code:
> > 
> > > > > @@ -291,7 +294,7 @@ static acpi_status acpiphp_add_context(acpi_handle handle, u32 lvl, void *data,
> > > > >          * expose slots to user space in those cases.
> > > > >          */
> > > > >         if ((acpi_pci_check_ejectable(pbus, handle) || is_dock_device(adev))
> > > > > -           && !(pdev && pdev->is_hotplug_bridge && pciehp_is_native(pdev))) {
> > > > > +           && !(slot->flags & SLOT_IS_NATIVE && pdev->is_hotplug_bridge)) {
> > 
> > I *think* this part:
> > 
> >   slot->flags & SLOT_IS_NATIVE && pdev->is_hotplug_bridge
> > 
> > means "this bridge supports hotplug but it is handled by pciehp, and
> > acpiphp should not expose the slot to user space".
> 
> Yes, I specifically added SLOT_IS_NATIVE flag there so we can get rid of
> one condition. Note that:
> 
>   pdev && pdev->is_hotplug_bridge && pciehp_is_native(pdev)
> 
> and
> 
>   slot->flags & SLOT_IS_NATIVE && pdev->is_hotplug_bridge
> 
> are equivalent.
> 
> There are no functional changes in that hunk.
> 
> > If that's the case, maybe we should rework pciehp_is_native(bridge) so
> > instead of answering the question "does the OS have permission to
> > control PCIe hotplug in the hierarchy containing <bridge>?", it could
> > answer the specific question "does pciehp handle hotplug for
> > <bridge>?", e.g., something along these lines:
> > 
> >   bool pciehp_is_native(struct pci_dev *bridge)
> >   {
> >   #ifdef CONFIG_HOTPLUG_PCI_PCIE
> >     u32 slot_cap;
> >     struct pci_host_bridge *host;
> > 
> >     if (!pci_is_pcie(bridge))
> >       return false;
> > 
> >     pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
> >     if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
> >       return false;
> > 
> >     if (pcie_ports_native)
> >       return true;
> > 
> >     host = pci_find_host_bridge(bridge->bus);
> >     return host->native_hotplug;
> >   #else
> >     return false;
> >   #endif
> >   }
> > 
> > Then your test for whether acpiphp should expose the slot to user
> > space could be:
> 
> [That test was there already before this patch.]
> 
> >   -   && !(pdev && pdev->is_hotplug_bridge && pciehp_is_native(pdev))) {
> >   +   && !pciehp_is_native(pdev)) {
> >  
> > We could also use pciehp_is_native() directly in
> > get_port_device_capability(), which is essentially the condition that
> > allows pciehp to claim the device.
> 
> Fine, I agree it makes sense.
> 
> However, I intended *this* patch to be *fix* and thus did not want to
> start reworking things too much. Especially code that is not related to
> the issue at all (pciehp_is_native()).

I think this pciehp_is_native() issue is definitely related.  You're
using it to set SLOT_IS_NATIVE.  But it's more complicated than I
first thought and there are several things that look wrong here.

  - We request OSC_PCI_EXPRESS_NATIVE_HP_CONTROL unconditionally, even
    if CONFIG_HOTPLUG_PCI_PCIE isn't set, which seems wrong.  If we
    request control, we should be prepared to handle hotplug events.

  - I think we should make CONFIG_HOTPLUG_PCI_SHPC a bool instead of a
    tristate, like we did for pciehp.  acpiphp is a bool and I don't
    think it can coordinate correctly with pciehp and SHPC unless
    they're all bools.

  - We probably should split "host->native_hotplug" into
    "native_pcie_hotplug" and "native_shpc_hotplug".

  - We should request OSC_PCI_SHPC_NATIVE_HP_CONTROL similarly to how
    we request OSC_PCI_EXPRESS_NATIVE_HP_CONTROL and adapt the
    is_shpc_capable() / acpi_get_hp_hw_control_from_firmware() path to
    use "host->native_shpc_hotplug".

  - The acpiphp_add_context() path probably should treat SHPC and
    pciehp the same.

I know this probably sounds like a tangent to you, but to me it seems
like we're building on a poor foundation and we should make the
foundation solid before extending it.

Here's an example of what I mean about the foundation being poor: it
seems fairly clear that the *intent* is that pciehp_is_native() means
"pciehp manages hotplug events on this bridge", but I don't think
that's true.

Today pciehp_is_native() returns "true" for every PCI device in a
hierarchy where _OSC says we can use pciehp.  That's obviously wrong
because in such a hierarchy, bridges without PCI_EXP_SLTCAP_HPC should
be managed by acpiphp.

There's only one caller (acpiphp_add_context()), which *tries* to make
it sensible by restricting it to bridges with "is_hotplug_bridge" set.
But "is_hotplug_bridge" tells us nothing about whether pciehp manages
the bridge because acpiphp sets it in check_hotplug_bridge() (under
conditions that are very difficult to figure out).

So evidently "pdev->is_hotplug_bridge && pciehp_is_native(pdev)" is
true for some bridges that are actually managed by acpiphp, which
prevents acpiphp_add_context() from registering some slots that it
should register.

Bjorn
