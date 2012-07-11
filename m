Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:65343 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932121Ab2GKSpG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 11 Jul 2012 14:45:06 -0400
Date: Wed, 11 Jul 2012 13:14:58 -0400
From: Jason Baron <jbaron@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/5] PCI, acpiphp: add is_hotplug_bridge detection
Message-ID: <20120711171458.GA14610@redhat.com>
References: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
 <1340437325-29282-5-git-send-email-yinghai@kernel.org>
 <CAErSpo7SS1N+h+VyGoCBq5HCMezvFAonRZR-pqsYezVHX2-_2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo7SS1N+h+VyGoCBq5HCMezvFAonRZR-pqsYezVHX2-_2w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 11, 2012 at 09:50:19AM -0600, Bjorn Helgaas wrote:
> On Sat, Jun 23, 2012 at 1:42 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> > When system support hotplug bridge with children hotplug slots, we need to make sure
> > that parent bridge get preallocated resource so later when device is plugged into
> > children slot, those children devices will get resource allocated.
> >
> > We do not meet this problem, because for pcie hotplug card, when acpiphp is used,
> > pci_scan_bridge will set that for us when detect hotplug bit in slot cap.
> >
> > Reported-and-tested-by: Jason Baron <jbaron@redhat.com>
> > Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> > Acked-by: Jason Baron <jbaron@redhat.com>
> > ---
> >  drivers/pci/hotplug/acpiphp_glue.c |   27 ++++++++++++++++++++++++++-
> >  1 files changed, 26 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> > index ad6fd66..0f2b72d 100644
> > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > @@ -783,6 +783,29 @@ static void acpiphp_set_acpi_region(struct acpiphp_slot *slot)
> >         }
> >  }
> >
> > +static void check_hotplug_bridge(struct acpiphp_slot *slot, struct pci_dev *dev)
> > +{
> > +       struct acpiphp_func *func;
> > +
> > +       if (!dev->subordinate)
> > +               return;
> > +
> > +       /* quirk, or pcie could set it already */
> > +       if (dev->is_hotplug_bridge)
> > +               return;
> > +
> > +       if (PCI_SLOT(dev->devfn) != slot->device)
> > +               return;
> > +
> > +       list_for_each_entry(func, &slot->funcs, sibling) {
> > +               if (PCI_FUNC(dev->devfn) == func->function) {
> > +                       /* check if this bridge has ejectable slots */
> > +                       if ((detect_ejectable_slots(func->handle) > 0))
> > +                               dev->is_hotplug_bridge = 1;
> > +                       break;
> > +               }
> > +       }
> > +}
> >  /**
> >   * enable_device - enable, configure a slot
> >   * @slot: slot to be enabled
> > @@ -817,8 +840,10 @@ static int __ref enable_device(struct acpiphp_slot *slot)
> >                         if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
> >                             dev->hdr_type == PCI_HEADER_TYPE_CARDBUS) {
> >                                 max = pci_scan_bridge(bus, dev, max, pass);
> > -                               if (pass && dev->subordinate)
> > +                               if (pass && dev->subordinate) {
> > +                                       check_hotplug_bridge(slot, dev);
> 
> I don't like this patch because it increases the differences between
> the hotplug drivers, rather than decreasing them.
> 
> For PCI Express devices, we set dev->is_hotplug_bridge in the
> pci_setup_device() path (in set_pcie_hotplug_bridge()).  I think it
> would make sense to try to expand that path to also handle SHPC and
> ACPI hotplug as well.  ACPI is harder because it's not PCI-specified,
> so we'd need some sort of pcibios or other optional hook.
> 
> I don't have a clear picture of how this works -- if I understand
> correctly, the situation is that we have a bridge managed by acpiphp.
> That part makes sense because the bridge is on the motherboard and can
> have a DSDT device.  Now we plug something into the slot below the
> bridge.  I *think* this patch handles the case where this new
> hot-added thing is also a bridge managed by acpiphp.  But where does
> the ACPI device for this hot-added bridge come from?  It's an
> arbitrary device the BIOS knows nothing about, so it can't be in the
> DSDT.
> 

So this came up while I was developing pci bridge hotplug for qemu.
Currently, there is a top level host bus (with ACPI device definitions), where
devices can be hot-plugged. What I've done is added a second level
of hotplug pci busses (again with ACPI device definitions). Thus, we can
now hotplug a bridge into the top-level bus and then devices behind it.
Effectively increasing the hot-plug space from n -> n^2.

Before the above pci patch, the devices behind the bridge would not
configure their PCI BARs properly, since there were no i/o, mem resources
assigned to the bridge. However, with the above patch in place things
work as expected.

Using the same code base I was able to do acpi hotplug on Windows 7,
which correctly configured the both the bridge window and devices behind
it on hot-plug. So currently, the above usage pattern works on Windows
7, but not on Linux.

Thanks,

-Jason


