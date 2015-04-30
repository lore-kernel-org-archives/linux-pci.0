Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <bhelgaas@google.com>, Ingo Molnar <mingo@redhat.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, Len Brown <lenb@kernel.org>,
	Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [Bugfix v6] x86/PCI/ACPI: Fix regression caused by commit 63f1789ec716
Date: Thu, 30 Apr 2015 22:16:50 +0200
Message-ID: <2420339.5qc3EhDri2@vostro.rjw.lan>
In-Reply-To: <CAErSpo4XrOx4DmR-xUzy45UxS6iErANJbojC_X1JVdjsAzL8WQ@mail.gmail.com>
References: <CAErSpo7D_CDM+1mzO0ADdzbAE9xwnwiyJ-dk0WFthr+ReKpidg@mail.gmail.com> <1430368888-21402-1-git-send-email-jiang.liu@linux.intel.com> <CAErSpo4XrOx4DmR-xUzy45UxS6iErANJbojC_X1JVdjsAzL8WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, April 30, 2015 08:28:17 AM Bjorn Helgaas wrote:
> On Wed, Apr 29, 2015 at 11:41 PM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
> > An IO port or MMIO resource assigned to a PCI host bridge may be
> > consumed by the host bridge itself or available to its child
> > bus/devices. The ACPI specification defines a bit (Producer/Consumer)
> > to tell whether the resource is consumed by the host bridge itself,
> > but firmware hasn't used that bit consistently, so we can't rely on it.
> >
> > Before commit 593669c2ac0f ("x86/PCI/ACPI: Use common ACPI resource
> > interfaces to simplify implementation"), arch/x86/pci/acpi.c ignored
> > all IO port resources defined by acpi_resource_io and
> > acpi_resource_fixed_io to filter out IO ports consumed by the host
> > bridge itself.
> >
> > Commit 593669c2ac0f ("x86/PCI/ACPI: Use common ACPI resource interfaces
> > to simplify implementation") started accepting all IO port and MMIO
> > resources, which caused a regression that IO port resources consumed
> > by the host bridge itself became available to its child devices.
> >
> > Then commit 63f1789ec716 ("x86/PCI/ACPI: Ignore resources consumed by
> > host bridge itself") ignored resources consumed by the host bridge
> > itself by checking the IORESOURCE_WINDOW flag, which accidently removed
> > MMIO resources defined by acpi_resource_memory24, acpi_resource_memory32
> > and acpi_resource_fixed_memory32.
> >
> > On x86 and IA64 platforms, all IO port and MMIO resources are assumed
> > to be available to child bus/devices except one special case:
> >     IO port [0xCF8-0xCFF] is consumed by the host bridge itself
> >     to access PCI configuration space.
> >
> > So explicitly filter out PCI CFG IO ports[0xCF8-0xCFF]. This solution
> > will also ease the way to consolidate ACPI PCI host bridge common code
> > from x86, ia64 and ARM64.
> >
> > Related ACPI table are archived at:
> > https://bugzilla.kernel.org/show_bug.cgi?id=94221
> >
> > Related discussions at:
> > http://patchwork.ozlabs.org/patch/461633/
> > https://lkml.org/lkml/2015/3/29/304
> >
> > Fixes: 63f1789ec716("Ignore resources consumed by host bridge itself")
> > Reported-by: Bernhard Thaler <bernhard.thaler@wvnet.at>
> > Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> > Cc: <stable@vger.kernel.org> # 4.0
> > ---
> >  arch/x86/pci/acpi.c     |   24 ++++++++++++++++++++++--
> >  drivers/acpi/resource.c |    2 +-
> >  2 files changed, 23 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> > index e4695985f9de..d93963340c3c 100644
> > --- a/arch/x86/pci/acpi.c
> > +++ b/arch/x86/pci/acpi.c
> > @@ -325,6 +325,26 @@ static void release_pci_root_info(struct pci_host_bridge *bridge)
> >         kfree(info);
> >  }
> >
> > +/*
> > + * An IO port or MMIO resource assigned to a PCI host bridge may be
> > + * consumed by the host bridge itself or available to its child
> > + * bus/devices. The ACPI specification defines a bit (Producer/Consumer)
> > + * to tell whether the resource is consumed by the host bridge itself,
> > + * but firmware hasn't used that bit consistently, so we can't rely on it.
> > + *
> > + * On x86 and IA64 platforms, all IO port and MMIO resources are assumed
> > + * to be available to child bus/devices except one special case:
> > + *     IO port [0xCF8-0xCFF] is consumed by the host bridge itself
> > + *     to access PCI configuration space.
> > + *
> > + * So explicitly filter out PCI CFG IO ports[0xCF8-0xCFF].
> > + */
> > +static bool resource_is_pcicfg_ioport(struct resource *res)
> > +{
> > +       return (res->flags & IORESOURCE_IO) &&
> > +               res->start == 0xCF8 && res->end == 0xCFF;
> > +}
> > +
> >  static void probe_pci_root_info(struct pci_root_info *info,
> >                                 struct acpi_device *device,
> >                                 int busnum, int domain,
> > @@ -346,8 +366,8 @@ static void probe_pci_root_info(struct pci_root_info *info,
> >                         "no IO and memory resources present in _CRS\n");
> >         else
> >                 resource_list_for_each_entry_safe(entry, tmp, list) {
> > -                       if ((entry->res->flags & IORESOURCE_WINDOW) == 0 ||
> > -                           (entry->res->flags & IORESOURCE_DISABLED))
> > +                       if ((entry->res->flags & IORESOURCE_DISABLED) ||
> > +                           resource_is_pcicfg_ioport(entry->res))
> 
> Hey, I can understand this code!  This is *way* better that what you
> had before.  Thanks for persevering.
> 
> My only remaining comment is that the subject line ("Fix regression
> caused by commit ...") doesn't really describe the code.  It should
> say something specific, like maybe "x86/PCI/ACPI: Make all resources
> except [io 0xcf8-0xcff] available on PCI bus".
> 
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

Awesome, thanks!

I'm sending my pull request for -rc2 shortly, so I'll queue this one up for
the next week.  I'll follow your subject suggestion.

Ingo, please let me know if there's any problem with that.

Rafael

