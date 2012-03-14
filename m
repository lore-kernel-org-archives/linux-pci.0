Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6062 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030750Ab2CNKcU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 14 Mar 2012 06:32:20 -0400
Date: Wed, 14 Mar 2012 12:31:50 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Amos Kong <akong@redhat.com>, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, jasowang@redhat.com, scott@spiteful.org,
	mtosatti@redhat.com, Shaohua Li <shaohua.li@intel.com>,
	Prarit Bhargava <prarit@redhat.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PCI: Can continually add funcs after adding func0
Message-ID: <20120314103149.GA7714@redhat.com>
References: <1322204587-3636-1-git-send-email-akong@redhat.com>
 <20111205112124.2e7d2ff9@jbarnes-desktop>
 <20120127091721.1e7bb56d@jbarnes-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120127091721.1e7bb56d@jbarnes-desktop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 27, 2012 at 09:17:21AM -0800, Jesse Barnes wrote:
> On Mon, 5 Dec 2011 11:21:24 -0800
> Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
> 
> > On Fri, 25 Nov 2011 15:03:07 +0800
> > Amos Kong <akong@redhat.com> wrote:
> > 
> > > Boot up a KVM guest, and hotplug multifunction
> > > devices(func1,func2,func0,func3) to guest.
> > > 
> > > for i in 1 2 0 3;do
> > > qemu-img create /tmp/resize$i.qcow2 1G -f qcow2
> > > (qemu) drive_add 0x11.$i id=drv11$i,if=none,file=/tmp/resize$i.qcow2
> > > (qemu) device_add virtio-blk-pci,id=dev11$i,drive=drv11$i,addr=0x11.$i,multifunction=on
> > > done
> > > 
> > > In linux kernel, when func0 of the slot is hot-added, the whole
> > > slot will be marked as 'enabled', then driver will ignore other new
> > > hotadded funcs.
> > > But in Win7 & WinXP, we can continaully add other funcs after adding
> > > func0, all funcs will be added in guest.
> > > 
> > > drivers/pci/hotplug/acpiphp_glue.c:
> > > static int acpiphp_check_bridge(struct acpiphp_bridge *bridge)
> > > {
> > > ....
> > >         for (slot = bridge->slots; slot; slot = slot->next) {
> > >                 if (slot->flags & SLOT_ENABLED) {
> > >                         acpiphp_disable_slot()
> > >                 else
> > >                         acpiphp_enable_slot()
> > > ....                              |
> > > }                                 v
> > >                             enable_device()
> > >                                   |
> > >                                   v
> > >         //only don't enable slot if func0 is not added
> > > 	list_for_each_entry(func, &slot->funcs, sibling) {
> > >                ...
> > >         }
> > >        slot->flags |= SLOT_ENABLED; //mark slot to 'enabled'
> > > 
> > > This patch just make pci driver can continaully add funcs after adding
> > > func 0. Only mark slot to 'enabled' when all funcs are added.
> > > 
> > > For pci multifunction hotplug, we can add functions one by one(func 0 is
> > > necessary), and all functions will be removed in one time.
> > > 
> > > Signed-off-by: Amos Kong <akong@redhat.com>
> > > ---
> > 
> > Rafael, Prarit or Shaohua, any comments?  Would be good to get some
> > tested-bys too.
> 
> Missed the last merge window, but there have been no comments so I'm
> assuming people are ok with this and applying to -next.
> 
> Thanks,

I finally found this supporting statement in the acpi spec:

"For any device, the BIOS provides only information that is added to the
device in a non-hardware standard manner."
Since extra functions can be enumerated in a hardware-standard manner,
it seems clear that it's ok to skip their description in ACPI.

So, belatedly
Acked-by: Michael S. Tsirkin <mst@redhat.com>

> -- 
> Jesse Barnes, Intel Open Source Technology Center


