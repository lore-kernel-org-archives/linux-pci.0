Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43792 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757762Ab2IDU4E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 4 Sep 2012 16:56:04 -0400
Date: Tue, 4 Sep 2012 16:55:59 -0400
From: Jason Baron <jbaron@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
	mst@redhat.com
Subject: Re: [PATCH 4/5] PCI, acpiphp: add is_hotplug_bridge detection
Message-ID: <20120904205559.GE22890@redhat.com>
References: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
 <1340437325-29282-5-git-send-email-yinghai@kernel.org>
 <CAErSpo7SS1N+h+VyGoCBq5HCMezvFAonRZR-pqsYezVHX2-_2w@mail.gmail.com>
 <20120711171458.GA14610@redhat.com>
 <CAErSpo6Xdc-rDvvipJFzXbbF3V75zSBq4skMtZ2PDVsz1kxtdw@mail.gmail.com>
 <20120717141459.GD2463@redhat.com>
 <CAErSpo4vUqNDqGOxEhzsJbGRAiX6JN+hm5KowsCiZDgcTopehw@mail.gmail.com>
 <20120820143548.GA2546@redhat.com>
 <CAErSpo5=3o9xE_LhKmZCFeg25HwGO-ZBuTrgbi+Aczjz9L4Q6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo5=3o9xE_LhKmZCFeg25HwGO-ZBuTrgbi+Aczjz9L4Q6w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 22, 2012 at 05:19:35PM -0600, Bjorn Helgaas wrote:
> > On Wed, Aug 15, 2012 at 01:36:43PM -0600, Bjorn Helgaas wrote:
> >> On Tue, Jul 17, 2012 at 8:14 AM, Jason Baron <jbaron@redhat.com> wrote:
> >> > On Wed, Jul 11, 2012 at 01:42:15PM -0600, Bjorn Helgaas wrote:
> >> >> On Wed, Jul 11, 2012 at 11:14 AM, Jason Baron <jbaron@redhat.com> wrote:
> >> >> > On Wed, Jul 11, 2012 at 09:50:19AM -0600, Bjorn Helgaas wrote:
> >> >> >> On Sat, Jun 23, 2012 at 1:42 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> >> >> >> > When system support hotplug bridge with children hotplug slots, we need to make sure
> >> >> >> > that parent bridge get preallocated resource so later when device is plugged into
> >> >> >> > children slot, those children devices will get resource allocated.
> >> >> >> >
> >> >> >> > We do not meet this problem, because for pcie hotplug card, when acpiphp is used,
> >> >> >> > pci_scan_bridge will set that for us when detect hotplug bit in slot cap.
> >> >> >> >
> >> >> >> > Reported-and-tested-by: Jason Baron <jbaron@redhat.com>
> >> >> >> > Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> >> >> >> > Acked-by: Jason Baron <jbaron@redhat.com>
> >> >> >> > ---
> >> >> >> >  drivers/pci/hotplug/acpiphp_glue.c |   27 ++++++++++++++++++++++++++-
> >> >> >> >  1 files changed, 26 insertions(+), 1 deletions(-)
> >> >> >> >
> >> >> >> > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> >> >> >> > index ad6fd66..0f2b72d 100644
> >> >> >> > --- a/drivers/pci/hotplug/acpiphp_glue.c
> >> >> >> > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> >> >> >> > @@ -783,6 +783,29 @@ static void acpiphp_set_acpi_region(struct acpiphp_slot *slot)
> >> >> >> >         }
> >> >> >> >  }
> >> >> >> >
> >> >> >> > +static void check_hotplug_bridge(struct acpiphp_slot *slot, struct pci_dev *dev)
> >> >> >> > +{
> >> >> >> > +       struct acpiphp_func *func;
> >> >> >> > +
> >> >> >> > +       if (!dev->subordinate)
> >> >> >> > +               return;
> >> >> >> > +
> >> >> >> > +       /* quirk, or pcie could set it already */
> >> >> >> > +       if (dev->is_hotplug_bridge)
> >> >> >> > +               return;
> >> >> >> > +
> >> >> >> > +       if (PCI_SLOT(dev->devfn) != slot->device)
> >> >> >> > +               return;
> >> >> >> > +
> >> >> >> > +       list_for_each_entry(func, &slot->funcs, sibling) {
> >> >> >> > +               if (PCI_FUNC(dev->devfn) == func->function) {
> >> >> >> > +                       /* check if this bridge has ejectable slots */
> >> >> >> > +                       if ((detect_ejectable_slots(func->handle) > 0))
> >> >> >> > +                               dev->is_hotplug_bridge = 1;
> >> >> >> > +                       break;
> >> >> >> > +               }
> >> >> >> > +       }
> >> >> >> > +}
> >> >> >> >  /**
> >> >> >> >   * enable_device - enable, configure a slot
> >> >> >> >   * @slot: slot to be enabled
> >> >> >> > @@ -817,8 +840,10 @@ static int __ref enable_device(struct acpiphp_slot *slot)
> >> >> >> >                         if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
> >> >> >> >                             dev->hdr_type == PCI_HEADER_TYPE_CARDBUS) {
> >> >> >> >                                 max = pci_scan_bridge(bus, dev, max, pass);
> >> >> >> > -                               if (pass && dev->subordinate)
> >> >> >> > +                               if (pass && dev->subordinate) {
> >> >> >> > +                                       check_hotplug_bridge(slot, dev);
> >> >> >>
> >> >> >> I don't like this patch because it increases the differences between
> >> >> >> the hotplug drivers, rather than decreasing them.
> >> >> >>
> >> >> >> For PCI Express devices, we set dev->is_hotplug_bridge in the
> >> >> >> pci_setup_device() path (in set_pcie_hotplug_bridge()).  I think it
> >> >> >> would make sense to try to expand that path to also handle SHPC and
> >> >> >> ACPI hotplug as well.  ACPI is harder because it's not PCI-specified,
> >> >> >> so we'd need some sort of pcibios or other optional hook.
> >> >> >>
> >> >> >> I don't have a clear picture of how this works -- if I understand
> >> >> >> correctly, the situation is that we have a bridge managed by acpiphp.
> >> >> >> That part makes sense because the bridge is on the motherboard and can
> >> >> >> have a DSDT device.  Now we plug something into the slot below the
> >> >> >> bridge.  I *think* this patch handles the case where this new
> >> >> >> hot-added thing is also a bridge managed by acpiphp.  But where does
> >> >> >> the ACPI device for this hot-added bridge come from?  It's an
> >> >> >> arbitrary device the BIOS knows nothing about, so it can't be in the
> >> >> >> DSDT.
> >> >> >>
> >> >> >
> >> >> > So this came up while I was developing pci bridge hotplug for qemu.
> >> >> > Currently, there is a top level host bus (with ACPI device definitions), where
> >> >> > devices can be hot-plugged. What I've done is added a second level
> >> >> > of hotplug pci busses (again with ACPI device definitions). Thus, we can
> >> >> > now hotplug a bridge into the top-level bus and then devices behind it.
> >> >> > Effectively increasing the hot-plug space from n -> n^2.
> >> >> >
> >> >> > Before the above pci patch, the devices behind the bridge would not
> >> >> > configure their PCI BARs properly, since there were no i/o, mem resources
> >> >> > assigned to the bridge. However, with the above patch in place things
> >> >> > work as expected.
> >> >> >
> >> >> > Using the same code base I was able to do acpi hotplug on Windows 7,
> >> >> > which correctly configured the both the bridge window and devices behind
> >> >> > it on hot-plug. So currently, the above usage pattern works on Windows
> >> >> > 7, but not on Linux.
> >> >>
> >> >> Thanks, Jason.  Do you have "lspci -v" output and the DSDT AML handy?
> >> >> I'd like to look in more detail at what we're missing.
> >> >
> >> > Hi,
> >> >
> >> > Sorry for the delay...was on vacation.
> >> >
> >> > Anyways, below is the patch I have to the seabios acpi table. However,
> >> > there are other pieces for seabios and qemu required. I still need to
> >> > clean them up and send them out. But this pci patch (or something
> >> > similar) is a required dependency.
> >> >
> >> > What 'lspci -v' output are you looking for?
> >> >
> >> > Let me know what else I can provide.
> >>
> >> Now it's my turn to be sorry for dropping this for so long :)
> >>
> >> I was thinking of the "lspci -v" output from your system (qemu guest)
> >> and the disassembled DSDT extracted from the same system.  Then we
> >> could talk about concrete devices and point to the corresponding
> >> entries in lspci output and the ACPI namespace.
> >
> > Hi,
> >
> > posted to: http://people.redhat.com/~jbaron/bridge-hotplug/
> >
> > I've extracted the ssdt and dsdt tables.
> 
> Thanks, Jason.
> 
> I'd like to play with this on qemu myself so I don't have to ask so
> many stupid questions.  Earlier you mentioned some other qemu and
> seabios patches.  Are they usable yet?  I see the src/ssdt-pcihp.dsl
> patch you posted Jul 17, but I think you were referring to some other
> ones.
> 
> Bjorn


Hi Bjorn,

So you can try this out for yourself by cloning:

git://github.com/jibaron/q35-qemu.git
git://github.com/jibaron/q35-seabios.git

You will need to use the hotplug branches: 'bridge-hotplug'.

Then, you can start up a guest using something like:

/usr/local/bin/qemu-system-x86_64  -name "f16" -M pc -m 4G -smp 4
-drive file=/images/f16.img,index=0,media=disk,format=raw
-netdev tap,id=hostnet0,script=/home/scripts/qemu-ifup -vnc :5 --enable-kvm
-monitor stdio -bios /home/seabios/seabios/out/bios.bin 

Then, to test the hotplug from the qemu monitor command line you do:

(qemu) device_add pci-bridge,chassis_nr=10,id=br10,addr=0x1f [to add a
bridge at slot 0x1f]
(qemu) device_add e1000,netdev=hostnet0,id=net1,mac=52:54:00:05:11:10,bus=br10,addr=0x1
[to add an e1000 device off of the bridge in slot 0x1]

You'll notice that the resource for the e1000 wouldn't configure without
the patch in this thread in the guest kernel.

Please let me know if you need any more help re-producing this.

Thanks!

-Jason

