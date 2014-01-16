Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37918 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbaAPUjI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 16 Jan 2014 15:39:08 -0500
Date: Thu, 16 Jan 2014 13:38:38 -0700 (MST)
From: Keith Busch <keith.busch@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
cc: Bjorn Helgaas <bhelgaas@google.com>,
	Keith Busch <keith.busch@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCHv2 0/2] PCI: driver function reset notification
In-Reply-To: <1389899441.8705.60.camel@bling.home>
Message-ID: <alpine.LRH.2.03.1401161257410.25844@AMR>
References: <1389651988-27392-1-git-send-email-keith.busch@intel.com>  <CAErSpo6W9-Gg55T_dO_F6KJ+RK9mWhDtZUHdW-Ke4NP-da7-uA@mail.gmail.com> <1389899441.8705.60.camel@bling.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 16 Jan 2014, Alex Williamson wrote:
> On Thu, 2014-01-16 at 11:49 -0700, Bjorn Helgaas wrote:
>> On Mon, Jan 13, 2014 at 3:26 PM, Keith Busch <keith.busch@intel.com> wrote:
...
>>> Actually ... I'm a little concered to be using slot_reset instead of
>>> defining a new callback for FLR. From looking at other device drivers,
>>> I'm not sure they would expect to have their slot_reset invoked in
>>> this situation.
>>
>> I haven't looked at other slot_reset callbacks.  Do you have an
>> example we can look at and talk about?

I'm comparing with mpt[2,3]sas_scsih.c. It looks like their slot_reset
requires pci_errhandlers' "err_detected" called prior to slot_reset,
otherwise they'll fail the device remapping.

>> The existing model (even without your changes) allows a user to start
>> a reset via sysfs while the driver is still active.  What happens when
>> the reset occurs while the driver is programming the device?  For
>> example, if the driver sets up a DMA transfer address, the reset
>> occurs (destroying the address), and the driver initiates the DMA, the
>> DMA will go to the wrong place.
>>
>> I'm not sure how to fix this model of resets happening asynchronous to
>> the driver.  Maybe we need to tell the driver *before* the reset.
>> Maybe we need to ask the driver to do the reset itself, and only do it
>> in the core if no driver is attached.  Maybe we need to make the reset
>> look like a hotplug remove/add to the driver, so we detach the driver,
>> do the reset, and reattach a driver.

Ha, Willy actually recommended I add two calls before I sent the first
patch! Something like pci_reset_prepare(), pci_reset_complete().

Now that I think about it for my driver, these calls would do be identical
to suspend()/resume(). Can we use those?!

>> In the general case, we don't know what the device *is* after a reset
>> because it could have loaded new firmware.  It could require more
>> resources or even a different driver.

Activating new firmware is the exact use I'm going for here. I've been
recommending users manually remove/reset/rescan the device with the
appriate sysfs writes. It sounds like your suggesting we make all that
automatically happen with only need to hit reset.

It turns out making this look like hotplug isn't desirable here because
the device's storage may be mounted partitions (sounds a little scary
to me), and a removal would take down opened disks.

>> I know it would cause Alex heartburn to make reset look like hotplug.
>
> Yes it would.  I agree that it's theoretically possible for a device to
> undergo a metamorphosis to something new at reset, but in practice it
> just doesn't happen.  Perhaps a reset with no driver attached could
> completely remove, reset, and rescan the device, but that might still
> cause problems with legacy KVM device assignment if pci-stub is not used
> to hold the device.  For a device exposed to userspace through vfio, we
> want to be able to reset the device, but releasing the device and trying
> to reacquire it would be challenging to say the least.  Thanks,
>
> Alex
>
>> What sort of NVMe problems would that cause?  I assume most drivers
>> will have to treat a device coming out of reset basically the same way
>>
>> Bjorn

Thanks for the feedback!
Keith
