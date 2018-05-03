Return-Path: <SRS0=NudY=HW=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=NudY=HW=linux.intel.com=mika.westerberg@kernel.org>
Date: Thu, 3 May 2018 13:22:41 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <20180503102241.GI2355@lahna.fi.intel.com>
References: <20180416103453.46232-1-mika.westerberg@linux.intel.com>
 <20180416103453.46232-5-mika.westerberg@linux.intel.com>
 <20180502204932.GG11698@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180502204932.GG11698@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 02, 2018 at 03:49:32PM -0500, Bjorn Helgaas wrote:
> On Mon, Apr 16, 2018 at 01:34:48PM +0300, Mika Westerberg wrote:
> > When a system is using native PCIe hotplug for Thunderbolt and the
> > controller is not enabled for full RTD3 (runtime D3) it will be only
> > present in the system when there is a device connected. This pretty much
> > follows the BIOS assisted hotplug behaviour.
> 
> This is a tangent, but what exactly does "controller is not enabled
> for full RTD3 (runtime D3)" mean?  The way that's worded sounds like
> it *could* be a setting in a PCI config register, but I suspect it's
> really something in Linux, e.g., some bit in struct pci_dev or device?

It means that the controller can to into D3 runtime. With BIOS assisted
mode and native PCIe mode, the controller is hot-removed when there is
nothing connected. In RTD3 mode it is there always and the OS expected
to put it into D3 when idle using standard PCI PM registers.

> > Thunderbolt host router integrated PCIe switch has two additional PCIe
> > downstream bridges that lead to NHI (Thunderbolt host controller) and xHCI
> > (USB 3 host controller) respectively. These downstream bridges are not
> > marked being hotplug capable. Reason for that is to preserve resources.
> > Otherwise the OS would distribute remaining resources between all
> > downstream bridges making these two bridges consume precious resources
> > of the actual hotplug bridges.
> > 
> > Now, because these two bridges are not marked being hotplug capable the OS
> > will not enable hotplug interrupt for them either and will not receive
> > interrupt when devices behind them are hot-added. Solution to this is
> > that the BIOS sends ACPI Notify() to the root port let the OS know it
> > needs to rescan for added and/or removed devices.
> 
> We're building stuff based on "is_hotplug_bridge", but I'm not sure
> that bit is really useful.
> 
> set_pcie_hotplug_bridge() sets it for downstream ports with
> PCI_EXP_SLTCAP_HPC, which is easy enough to understand.
> 
> In acpiphp, check_hotplug_bridge() sets in some scenario that I can't
> quite figure out.  I assume it's based on something in the namespace.
> 
> But it seems like the whole point of this patch is that even if a
> bridge doesn't have "is_hotplug_bridge" set, ACPI hotplug can hot-add
> devices below it.

Correct.

> So I'm not sure what "is_hotplug_bridge" is really telling us.  Is it
> just a hint about how many resources we want to assign to the bridge,
> i.e., we assign only a few when it's not set and more if it is set?

Good question. I did not invent the flag so hard to say. I've been using
it because IIRC you prefer it.

> > Here is how the mechanism is supposed to work when a Thunderbolt
> > endpoint is connected to one of the ports. In case of a standard USB-C
> > device only the xHCI is hot-added otherwise steps are the same.
> > 
> > 1. Initially there is only the PCIe root port that is controlled by
> >    the pciehp driver
> > 
> >   00:1b.0 (Hotplug+) --
> > 
> > 2. Then we get native PCIe hotplug interrupt and once it is handled the
> >    topology looks as following
> > 
> >   00:1b.0 (Hotplug+) -- 01:00.0 --+- 02:00.0 --
> >                                   +- 02:01.0 (HotPlug+)
> >                                   \- 02:02.0 --
> > 
> > 3. Bridges 02:00.0 and 02:02.0 are not marked as hotplug capable and
> 
> By "not marked as hotplug capable", I guess you mean
> PCI_EXP_SLTCAP_HPC is not set, right?

Right.

> >    they don't have anything behind them currently. Bridge 02:01.0 is
> >    hotplug capable and used for extending the topology. At this point
> >    the required PCIe devices are enabled and ACPI Notify() is sent to
> >    the root port. The resulting topology is expected to look like
> > 
> >   00:1b.0 (Hotplug+) -- 01:00.0 --+- 02:00.0 -- Thunderbolt host controller
> >                                   +- 02:01.0 (HotPlug+)
> >                                   \- 02:02.0 -- xHCI host controller
> > 
> > However, the current ACPI hotplug implementation scans the whole 00:1b.0
> > hotplug slot and everything behind it regardless whether native PCIe is
> > used or not, and it expects that the BIOS has configured bridge
> > resources upfront. If that's not the case it assigns resources using
> > minimal allocation (everything currently found just barely fit)
> > preventing future extension. In addition to that, if there is another
> > native PCIe hotplug going on we may find the new PCIe switch only
> > partially ready (all links are not fully trained yet) confusing pciehp
> > when it finally starts to enumerate for new devices.
> > 
> > To make this work better with the native PCIe hotplug driver (pciehp),
> > we let it handle all slot management and resource allocation for hotplug
> > bridges and restrict ACPI hotplug to non-hotplug bridges.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/pci/hotplug/acpiphp.h      |  1 +
> >  drivers/pci/hotplug/acpiphp_glue.c | 73 ++++++++++++++++++++++++++++++--------
> >  2 files changed, 59 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/pci/hotplug/acpiphp.h b/drivers/pci/hotplug/acpiphp.h
> > index e438a2d734f2..8dcfd623ef1d 100644
> > --- a/drivers/pci/hotplug/acpiphp.h
> > +++ b/drivers/pci/hotplug/acpiphp.h
> > @@ -158,6 +158,7 @@ struct acpiphp_attention_info
> >  
> >  #define SLOT_ENABLED		(0x00000001)
> >  #define SLOT_IS_GOING_AWAY	(0x00000002)
> > +#define SLOT_IS_NATIVE		(0x00000004)
> >  
> >  /* function flags */
> >  
> > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> > index b45b375c0e6c..5efa21cdddc9 100644
> > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > @@ -282,6 +282,9 @@ static acpi_status acpiphp_add_context(acpi_handle handle, u32 lvl, void *data,
> >  	slot->device = device;
> >  	INIT_LIST_HEAD(&slot->funcs);
> >  
> > +	if (pdev && pciehp_is_native(pdev))
> > +		slot->flags |= SLOT_IS_NATIVE;
> 
> If I understand correctly, pciehp_is_native() checks
> root->osc_control_set, so for everything under the same host bridge
> (PNP0A03 device), it gives the same answer.

Correct.

> If so, the name "SLOT_IS_NATIVE" seems a little misleading because
> there are very often several slots under the same host bridge, and
> they will be either all native or all non-native.

I used it because it works with pciehp_is_native(). I can rename it if
you have a better name.

> But I must be missing something because it seems like the whole point
> of this patch is to treat part of the Thunderbolt host router as
> native and another part as non-native.  Help, I'm confused :)

No, you are not confused. It is exactly what we are trying to fix with
this patch. These are systems (already out there in the wild) that are
in "native" mode. As I tried to explain in the changelog hotplugging
PCIe devices to hotplug PCIe downstream ports is done using native PCIe
hotplug. However, xHCI (USB 3) controller and NHI (Thunderbolt
controller) are hot-added using ACPI Notify(). Before you ask, no it is
not violating any spec because these two downstream ports are not under
control of pciehp (they don't have hotplug slot capability set):

  00:1b.0 (Hotplug+) -- 01:00.0 --+- 02:00.0 -- Thunderbolt host controller
                                  +- 02:01.0 (HotPlug+)
                                  \- 02:02.0 -- xHCI host controller

Hope this clarifies.
