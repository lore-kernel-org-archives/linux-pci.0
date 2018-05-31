Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 31 May 2018 08:12:02 -0500
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
Subject: Re: [PATCH v8 2/7] PCI: Introduce shpchp_is_native()
Message-ID: <20180531131202.GA76395@bhelgaas-glaptop.roam.corp.google.com>
References: <20180528124756.78512-1-mika.westerberg@linux.intel.com>
 <20180528124756.78512-3-mika.westerberg@linux.intel.com>
 <20180530202343.GO39853@bhelgaas-glaptop.roam.corp.google.com>
 <20180531065852.GV15419@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180531065852.GV15419@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 31, 2018 at 09:58:52AM +0300, Mika Westerberg wrote:
> On Wed, May 30, 2018 at 03:23:43PM -0500, Bjorn Helgaas wrote:
> > > +{
> > > +	const struct pci_host_bridge *host;
> > > +
> > > +	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
> > > +		return false;
> > > +
> > > +	if (!pci_find_capability(bridge, PCI_CAP_ID_SHPC))
> > > +		return false;
> > > +
> > > +	host = pci_find_host_bridge(bridge->bus);
> > > +	return host->native_shpc_hotplug;
> > > +}
> > 
> > This is sort-of-but-not-exactly the same as is_shpc_capable().
> > 
> > For PCI_DEVICE_ID_AMD_GOLAM_7450, is_shpc_capable() will return true
> > and shpchp will claim the device, but shpchp_is_native() will return
> > false because there's no SHPC capability.
> > 
> > At least that's my interpretation of the AMD GOLAM stuff.  I don't
> > have a spec for it, but if GOLAM did have an SHPC capability, I assume
> > is_shpc_capable() would look for it *before* testing for GOLAM.
> 
> Most probably it did not have SHPC capability because I find it hard to
> explain the check otherwise.
> 
> > So I think these two things need to be reconciled somehow.  I
> > mentioned this before, but it was buried at the bottom of a long
> > email, sorry about that.
> 
> No it wasn't. I read it and did exactly what you wanted. Now there is no
> duplication in these two functions. is_shpc_capable() calls
> acpi_get_hp_hw_control_from_firmware() which calls shpchp_is_native().
> In fact I don't think is_shpc_capable() warrants to exist at all and it
> should be removed (but in another separate cleanup patch).

Maybe I'm reading your patches wrong.  It looks to me like shpchp will
claim GOLAM_7450, which means shpchp will register slots, program the
SHPC, handle hotplug interrupts, etc.

But since shpchp_is_native() returns false, acpiphp thinks *it* should
handle hotplug.  For example, I think that given some ACPI
prerequisites (_EJ0/_RMV/etc), both will call pci_hp_register():

  shpc_probe
    is_shpc_capable             # true for GOLAM_7450
    init_slots
      pci_hp_register

  acpi_pci_add_slots
    acpiphp_enumerate_slots
      acpi_walk_namespace(..., acpiphp_add_context)
        acpiphp_add_context
          hotplug_is_native     # false for GOLAM_7450
          acpiphp_register_hotplug_slot
            pci_hp_register

It is true that the same situation occurred before your patches, since
acpiphp_add_context() only checked pciehp_is_native().  In fact, with
the existing code, shpchp and acpiphp could both try to manage *any*
SHPC, not just GOLAM_7450.

I think the current series fixes 99% of that problem and it seems like
we should try to do that last 1% at the same time so the SHPC code
makes more sense.

Bjorn
