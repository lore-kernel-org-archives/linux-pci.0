Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49524 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751416AbaAPTKs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 16 Jan 2014 14:10:48 -0500
Message-ID: <1389899441.8705.60.camel@bling.home>
Subject: Re: [PATCHv2 0/2] PCI: driver function reset notification
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Keith Busch <keith.busch@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Thu, 16 Jan 2014 12:10:41 -0700
In-Reply-To: <CAErSpo6W9-Gg55T_dO_F6KJ+RK9mWhDtZUHdW-Ke4NP-da7-uA@mail.gmail.com>
References: <1389651988-27392-1-git-send-email-keith.busch@intel.com>
	 <CAErSpo6W9-Gg55T_dO_F6KJ+RK9mWhDtZUHdW-Ke4NP-da7-uA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2014-01-16 at 11:49 -0700, Bjorn Helgaas wrote:
> On Mon, Jan 13, 2014 at 3:26 PM, Keith Busch <keith.busch@intel.com> wrote:
> > Here's version 2 of this patch with a driver implementing the intended
> > use as an example.
> >
> > The NVMe stuff requires using the maintainer's tree to get the newly
> > added nvme reset handling code. Willy's repo is located here:
> >
> > git.infradead.org/users/willy/linux-nvme.git
> >
> > v1->v2:
> >
> > As suggested, I'm reusing the slot_reset error handler instead of defining
> > a new one for function_reset.
> >
> > I moved invoking the callback further up the this call stack. The test
> > case I use resets the device via sysfs, and the pci device's command
> > register is cleared at the previous point, so the callback couldn't
> > actually do anything useful other than schedule something to handle
> > it after pci_dev_restore is called. The previous location would break
> > other driver slot_reset implementations and make my nvme implementation
> > a little more complicated.
> 
> There's now a pci_try_reset_function(), and something like this
> callback would have to be done in that path, too.
> 
> > Actually ... I'm a little concered to be using slot_reset instead of
> > defining a new callback for FLR. From looking at other device drivers,
> > I'm not sure they would expect to have their slot_reset invoked in
> > this situation.
> 
> I haven't looked at other slot_reset callbacks.  Do you have an
> example we can look at and talk about?
> 
> The existing model (even without your changes) allows a user to start
> a reset via sysfs while the driver is still active.  What happens when
> the reset occurs while the driver is programming the device?  For
> example, if the driver sets up a DMA transfer address, the reset
> occurs (destroying the address), and the driver initiates the DMA, the
> DMA will go to the wrong place.
> 
> I'm not sure how to fix this model of resets happening asynchronous to
> the driver.  Maybe we need to tell the driver *before* the reset.
> Maybe we need to ask the driver to do the reset itself, and only do it
> in the core if no driver is attached.  Maybe we need to make the reset
> look like a hotplug remove/add to the driver, so we detach the driver,
> do the reset, and reattach a driver.
> 
> In the general case, we don't know what the device *is* after a reset
> because it could have loaded new firmware.  It could require more
> resources or even a different driver.
> 
> I know it would cause Alex heartburn to make reset look like hotplug.

Yes it would.  I agree that it's theoretically possible for a device to
undergo a metamorphosis to something new at reset, but in practice it
just doesn't happen.  Perhaps a reset with no driver attached could
completely remove, reset, and rescan the device, but that might still
cause problems with legacy KVM device assignment if pci-stub is not used
to hold the device.  For a device exposed to userspace through vfio, we
want to be able to reset the device, but releasing the device and trying
to reacquire it would be challenging to say the least.  Thanks,

Alex

> What sort of NVMe problems would that cause?  I assume most drivers
> will have to treat a device coming out of reset basically the same way
> as a brand new hot-added device.
> 
> Bjorn



