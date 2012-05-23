Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:19659 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758666Ab2EWUwm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 23 May 2012 16:52:42 -0400
Date: Wed, 23 May 2012 16:52:39 -0400
From: Jason Baron <jbaron@redhat.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, mst@redhat.com
Subject: Re: [PATCH] pci hotplug: rescan bridge after device hotplug
Message-ID: <20120523205238.GE23940@redhat.com>
References: <201205222011.q4MKBcMo024624@int-mx02.intmail.prod.int.phx2.redhat.com>
 <CAE9FiQVkOsCpxa2WzhYguX6CxM=HF+i7h9dM2XHiaCQXSmFU6g@mail.gmail.com>
 <20120523024313.GA2888@redhat.com>
 <CAE9FiQV4hgUGqAz3jhRrjJyEGrV-=K=LwRhr7zePncKirajoSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAE9FiQV4hgUGqAz3jhRrjJyEGrV-=K=LwRhr7zePncKirajoSw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 22, 2012 at 08:31:30PM -0700, Yinghai Lu wrote:
> On Tue, May 22, 2012 at 7:43 PM, Jason Baron <jbaron@redhat.com> wrote:
> > On Tue, May 22, 2012 at 02:21:13PM -0700, Yinghai Lu wrote:
> >> On Tue, May 22, 2012 at 1:11 PM, Jason Baron <jbaron@redhat.com> wrote:
> >> > I'm tyring to support bridge hotplug and devices below it in qemu via acpi
> >> > hotplug. Currently only 1 level or 32 slots are supported. By allowing for a
> >> > second level, we will be able to support 32^2 devices.
> >> >
> >> > If I first hotplug the bridge with no devices intially below it, the hotplug
> >> > code sets the bridge memory window to 0 and does not increase it when
> >> > subsequent devices are added below it.
> >> >
> >> > Fix this, by calling pci_rescan_bus_bridge_resize(), on the bridge directly
> >> > below the root to re-size all the birdge windows that may have changed.
> >> >
> >> > Signed-off-by: Jason Baron <jbaron@redhat.com>
> >> > ---
> >> >  drivers/pci/hotplug/acpiphp_glue.c |    8 ++++++++
> >> >  1 files changed, 8 insertions(+), 0 deletions(-)
> >> >
> >> > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> >> > index 806c44f..8960c1e 100644
> >> > --- a/drivers/pci/hotplug/acpiphp_glue.c
> >> > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> >> > @@ -792,6 +792,7 @@ static int __ref enable_device(struct acpiphp_slot *slot)
> >> >  {
> >> >        struct pci_dev *dev;
> >> >        struct pci_bus *bus = slot->bridge->pci_bus;
> >> > +       struct pci_bus *rescan_bus;
> >> >        struct acpiphp_func *func;
> >> >        int retval = 0;
> >> >        int num, max, pass;
> >> > @@ -821,6 +822,13 @@ static int __ref enable_device(struct acpiphp_slot *slot)
> >> >                }
> >> >        }
> >> >
> >> > +       /* Ensure we rescan/setup a bridge for new devs hanging off of it */
> >> > +       rescan_bus = bus;
> >> > +       while (rescan_bus->parent && rescan_bus->parent->self)
> >> > +               rescan_bus = rescan_bus->parent;
> >> > +       if (rescan_bus->self)
> >> > +               pci_rescan_bus_bridge_resize(rescan_bus->self);
> >> > +
> >>
> >> No, you can not do that.  some parents bus could have other devices
> >> and driver could be loaded for those devices.
> >> so can not release resources that are used by those devices to resize
> >> parent bridges.
> >>
> >
> > hmmm...this patch also does what I want:
> >
> >
> > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> > index 806c44f..be63c72 100644
> > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > @@ -821,6 +821,10 @@ static int __ref enable_device(struct acpiphp_slot *slot)
> >                }
> >        }
> >
> > +       /* Ensure we rescan/setup a bridge for new devs hanging off of it */
> > +       if (bus->self)
> > +               pci_assign_unassigned_bridge_resources(bus->self);
> > +
> >        list_for_each_entry(func, &slot->funcs, sibling)
> >                acpiphp_bus_add(func);
> >
> >
> > There appears to be a precedant for something very similar in:
> > drivers/pci/hotplug/pciehp_pci.c:pciehp_configure_device(), where there
> > is a call to 'pci_assign_unassigned_bridge_resources(), when a new
> > device is added...
> 
> the bus could have other devices under that bridge already.
> 
> so pci_assign_unassigned_bridge_resources() will still try to release
> the bridge resource and
> those devices resources.
> 
> but pciehp we could do that, because it will only have one device
> under that pcie root port or downstream port.
> 
> so you can make qemu to support pcie and pciehp.
> 
> for hot add one hotplug bridge support, we have
>      bus->self->is_hotplug_bridge to set, so it will have allocate
> minimum resource.
> 
> so you also could try to use quirk etc to get that bit set.
> please check
> drivers/pci/quirks.c::
> /* Allow manual resource allocation for PCI hotplug bridges
>  * via pci=hpmemsize=nnM and pci=hpiosize=nnM parameters. For
>  * some PCI-PCI hotplug bridges, like PLX 6254 (former HINT HB6),
>  * kernel fails to allocate resources when hotplug device is
>  * inserted and PCI bus is rescanned.
>  */
> static void __devinit quirk_hotplug_bridge(struct pci_dev *dev)
> {
>         dev->is_hotplug_bridge = 1;
> }
> 
> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HINT, 0x0020, quirk_hotplug_bridge);
> 
> but still would prefer you to make qemu to support pciehp.
> 

Hi,

Ok, I've also verified that quirk approach resolves the issue for me as
well. It might not be a bad solution, especially if we anticipate moving
to pciehp. We can also always change bridge vendor id to not hit the
quirk, if we choose to implement more complex guest, or acpi fixes. The
defaults for i/o and mem seem pretty sane too:


#define DEFAULT_HOTPLUG_IO_SIZE         (256)
#define DEFAULT_HOTPLUG_MEM_SIZE        (2*1024*1024)

And further can be set on the guest command line via:

/* pci=hpmemsize=nnM,hpiosize=nn can override this */

So I don't see any down-side really to the quirk approach (which is a
quite simple 1-line patch to the guest), even if it is not a long-term
solution.

Thanks,

-Jason
