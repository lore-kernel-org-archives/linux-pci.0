Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:2345 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964847Ab2EWCmA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 22 May 2012 22:42:00 -0400
Date: Tue, 22 May 2012 22:43:14 -0400
From: Jason Baron <jbaron@redhat.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, mst@redhat.com
Subject: Re: [PATCH] pci hotplug: rescan bridge after device hotplug
Message-ID: <20120523024313.GA2888@redhat.com>
References: <201205222011.q4MKBcMo024624@int-mx02.intmail.prod.int.phx2.redhat.com>
 <CAE9FiQVkOsCpxa2WzhYguX6CxM=HF+i7h9dM2XHiaCQXSmFU6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAE9FiQVkOsCpxa2WzhYguX6CxM=HF+i7h9dM2XHiaCQXSmFU6g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 22, 2012 at 02:21:13PM -0700, Yinghai Lu wrote:
> On Tue, May 22, 2012 at 1:11 PM, Jason Baron <jbaron@redhat.com> wrote:
> > I'm tyring to support bridge hotplug and devices below it in qemu via acpi
> > hotplug. Currently only 1 level or 32 slots are supported. By allowing for a
> > second level, we will be able to support 32^2 devices.
> >
> > If I first hotplug the bridge with no devices intially below it, the hotplug
> > code sets the bridge memory window to 0 and does not increase it when
> > subsequent devices are added below it.
> >
> > Fix this, by calling pci_rescan_bus_bridge_resize(), on the bridge directly
> > below the root to re-size all the birdge windows that may have changed.
> >
> > Signed-off-by: Jason Baron <jbaron@redhat.com>
> > ---
> >  drivers/pci/hotplug/acpiphp_glue.c |    8 ++++++++
> >  1 files changed, 8 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> > index 806c44f..8960c1e 100644
> > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > @@ -792,6 +792,7 @@ static int __ref enable_device(struct acpiphp_slot *slot)
> >  {
> >        struct pci_dev *dev;
> >        struct pci_bus *bus = slot->bridge->pci_bus;
> > +       struct pci_bus *rescan_bus;
> >        struct acpiphp_func *func;
> >        int retval = 0;
> >        int num, max, pass;
> > @@ -821,6 +822,13 @@ static int __ref enable_device(struct acpiphp_slot *slot)
> >                }
> >        }
> >
> > +       /* Ensure we rescan/setup a bridge for new devs hanging off of it */
> > +       rescan_bus = bus;
> > +       while (rescan_bus->parent && rescan_bus->parent->self)
> > +               rescan_bus = rescan_bus->parent;
> > +       if (rescan_bus->self)
> > +               pci_rescan_bus_bridge_resize(rescan_bus->self);
> > +
> 
> No, you can not do that.  some parents bus could have other devices
> and driver could be loaded for those devices.
> so can not release resources that are used by those devices to resize
> parent bridges.
> 

hmmm...this patch also does what I want:


diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 806c44f..be63c72 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -821,6 +821,10 @@ static int __ref enable_device(struct acpiphp_slot *slot)
 		}
 	}
 
+	/* Ensure we rescan/setup a bridge for new devs hanging off of it */
+	if (bus->self)
+		pci_assign_unassigned_bridge_resources(bus->self);
+
 	list_for_each_entry(func, &slot->funcs, sibling)
 		acpiphp_bus_add(func);
 

There appears to be a precedant for something very similar in:
drivers/pci/hotplug/pciehp_pci.c:pciehp_configure_device(), where there
is a call to 'pci_assign_unassigned_bridge_resources(), when a new
device is added...

Thanks,

-Jason
