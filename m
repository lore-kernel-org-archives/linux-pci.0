Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:46335 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936459AbcKKHWY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2016 02:22:24 -0500
Date: Fri, 11 Nov 2016 08:23:31 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Rajat Jain <rajatja@google.com>
Cc: Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-pci@vger.kernel.org, Todd Broch <tbroch@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        paul.gortmaker@windriver.com
Subject: Re: [PATCH] pciehp_resume: don't add existing device
Message-ID: <20161111072331.GA8246@wunner.de>
References: <1478714735-134347-1-git-send-email-ravisadineni@chromium.org>
 <20161109195812.GA7528@wunner.de>
 <CACK8Z6EJ45m+_fSNPQGpoTq52vWHwRyDguO6Syau3XFUt-HdkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACK8Z6EJ45m+_fSNPQGpoTq52vWHwRyDguO6Syau3XFUt-HdkA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 09, 2016 at 12:59:01PM -0800, Rajat Jain wrote:
> On Wed, Nov 9, 2016 at 11:58 AM, Lukas Wunner <lukas@wunner.de> wrote:
> > On Wed, Nov 09, 2016 at 10:05:35AM -0800, Ravi Chandra Sadineni wrote:
> >> If a slot was occupied before supend, and nothing has changed after
> >> resume, we call pciehp_enable_slot() although it fails a little
> >> later with the message:
> >>    Device XXXX:XX:XX.X already exists at XXXX:XX:XX, cannot hot-add
> >>    Cannot add device at XXXX:XX:XX
> >>
> >> This was partly discussed here: https://lkml.org/lkml/2013/7/9/452
> >> and I'm pulling only the part4 of that patch, since it does not change
> >> anything functionally (or atleast does not seem to make it worse), but
> >> prevents uncomfortable messages pointed above.
> 
> Missing "Signed-off-by" :-)
> 
> >> ---
> >>  drivers/pci/hotplug/pciehp_core.c | 10 +++++++---
> >>  1 file changed, 7 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> >> index 612b21a..873cff8 100644
> >> --- a/drivers/pci/hotplug/pciehp_core.c
> >> +++ b/drivers/pci/hotplug/pciehp_core.c
> >> @@ -290,6 +290,7 @@ static int pciehp_resume(struct pcie_device *dev)
> >>  {
> >>       struct controller *ctrl;
> >>       struct slot *slot;
> >> +     struct pci_bus *pbus = dev->port->subordinate;
> >>       u8 status;
> >>
> >>       ctrl = get_service_data(dev);
> >> @@ -302,10 +303,13 @@ static int pciehp_resume(struct pcie_device *dev)
> >>       /* Check if slot is occupied */
> >>       pciehp_get_adapter_status(slot, &status);
> >>       mutex_lock(&slot->hotplug_lock);
> >> -     if (status)
> >> -             pciehp_enable_slot(slot);
> >> -     else
> >> +     if (status) {
> 
> should be "} else {" (on the same line)
> 
> 
> >> +             if (list_empty(&pbus->devices))
> >> +                     pciehp_enable_slot(slot);
> >> +     }
> >> +     else {
> >>               pciehp_disable_slot(slot);
> >> +     }
> >
> > What if the device plugged in after suspend is a different one
> > and requires e.g. an entirely different driver or different resource
> > allocations?
> 
> I may be missing it completely, but this situation does not seem be
> handled well today (even without this patch).

Yes, what we currently have is not correct.

First of all we should call pci_rescan_bus() in pciehp_configure_device().

Second, pci_rescan_bus() is broken in that it only adds new devices,
it doesn't remove devices.

It should perform a first pass where it walks the bus, checks for each
device whether the immediate parent is a hotplug bridge, and if so,
compares the vendor and device ID to what we have cached.  If it's
the same, chances are it's the same device (could have been replaced
by an identical device, but that shouldn't be a problem at least after
waking from system sleep).

If it's not the same, pci_stop_and_remove_bus_device() needs to be called
on it. That way we remove all replaced or no longer present devices.  In a
subsequent pass, pci_rescan_bus() would discover any newly added devices,
as it does now.

Third, we're not allowed to remove devices during the ->resume phase,
actually we're not even allowed to add devices until after the
->complete phase. Perhaps this can be accomplished with a PM notifier.

Fourth, we're also not allowed to add new devices after the ->prepare
phase, so we should disable the interrupt there.


> I wasn't able to figure out that if the device was replaced, how the
> old driver would be notified or the new driver's probe routine get
> called.

pci_stop_and_remove_bus_device() will unbind the old driver.
pci_bus_add_devices() causes the new driver to probe.  This is called
both from pci_rescan_bus() as well as pciehp_configure_device().


Thanks,

Lukas
