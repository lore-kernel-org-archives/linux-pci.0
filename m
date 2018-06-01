Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 1 Jun 2018 08:25:29 -0500
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
Message-ID: <20180601132529.GA119987@bhelgaas-glaptop.roam.corp.google.com>
References: <20180528124756.78512-1-mika.westerberg@linux.intel.com>
 <20180528124756.78512-3-mika.westerberg@linux.intel.com>
 <20180530202343.GO39853@bhelgaas-glaptop.roam.corp.google.com>
 <20180531065852.GV15419@lahna.fi.intel.com>
 <20180531131202.GA76395@bhelgaas-glaptop.roam.corp.google.com>
 <20180531135117.GX15419@lahna.fi.intel.com>
 <20180531165556.GA99633@bhelgaas-glaptop.roam.corp.google.com>
 <20180601092710.GA15419@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180601092710.GA15419@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 01, 2018 at 12:27:10PM +0300, Mika Westerberg wrote:
> On Thu, May 31, 2018 at 11:55:56AM -0500, Bjorn Helgaas wrote:
> > On Thu, May 31, 2018 at 04:51:17PM +0300, Mika Westerberg wrote:
> > > On Thu, May 31, 2018 at 08:12:02AM -0500, Bjorn Helgaas wrote:
> > > > Maybe I'm reading your patches wrong.  It looks to me like shpchp will
> > > > claim GOLAM_7450, which means shpchp will register slots, program the
> > > > SHPC, handle hotplug interrupts, etc.
> > > > 
> > > > But since shpchp_is_native() returns false, acpiphp thinks *it* should
> > > > handle hotplug.  For example, I think that given some ACPI
> > > > prerequisites (_EJ0/_RMV/etc), both will call pci_hp_register():
> > > > 
> > > >   shpc_probe
> > > >     is_shpc_capable             # true for GOLAM_7450
> > > >     init_slots
> > > >       pci_hp_register
> > > > 
> > > >   acpi_pci_add_slots
> > > >     acpiphp_enumerate_slots
> > > >       acpi_walk_namespace(..., acpiphp_add_context)
> > > >         acpiphp_add_context
> > > >           hotplug_is_native     # false for GOLAM_7450
> > > >           acpiphp_register_hotplug_slot
> > > >             pci_hp_register
> > > > 
> > > > It is true that the same situation occurred before your patches, since
> > > > acpiphp_add_context() only checked pciehp_is_native().  In fact, with
> > > > the existing code, shpchp and acpiphp could both try to manage *any*
> > > > SHPC, not just GOLAM_7450.
> > > > 
> > > > I think the current series fixes 99% of that problem and it seems like
> > > > we should try to do that last 1% at the same time so the SHPC code
> > > > makes more sense.
> > > 
> > > Would the following fix the last 1% for you? Applies on top of this
> > > patch.
> > 
> > Yes, that's exactly what I was looking for!  Thanks!
> 
> Great. Do you want me to update this patch accordingly or will you do
> that yourself?

No need, I squashed it in already.
