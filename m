Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:34740 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbaAPStx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jan 2014 13:49:53 -0500
Received: by mail-ie0-f171.google.com with SMTP id to1so4336025ieb.2
        for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2014 10:49:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1389651988-27392-1-git-send-email-keith.busch@intel.com>
References: <1389651988-27392-1-git-send-email-keith.busch@intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 16 Jan 2014 11:49:32 -0700
Message-ID: <CAErSpo6W9-Gg55T_dO_F6KJ+RK9mWhDtZUHdW-Ke4NP-da7-uA@mail.gmail.com>
Subject: Re: [PATCHv2 0/2] PCI: driver function reset notification
To: Keith Busch <keith.busch@intel.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 13, 2014 at 3:26 PM, Keith Busch <keith.busch@intel.com> wrote:
> Here's version 2 of this patch with a driver implementing the intended
> use as an example.
>
> The NVMe stuff requires using the maintainer's tree to get the newly
> added nvme reset handling code. Willy's repo is located here:
>
> git.infradead.org/users/willy/linux-nvme.git
>
> v1->v2:
>
> As suggested, I'm reusing the slot_reset error handler instead of defining
> a new one for function_reset.
>
> I moved invoking the callback further up the this call stack. The test
> case I use resets the device via sysfs, and the pci device's command
> register is cleared at the previous point, so the callback couldn't
> actually do anything useful other than schedule something to handle
> it after pci_dev_restore is called. The previous location would break
> other driver slot_reset implementations and make my nvme implementation
> a little more complicated.

There's now a pci_try_reset_function(), and something like this
callback would have to be done in that path, too.

> Actually ... I'm a little concered to be using slot_reset instead of
> defining a new callback for FLR. From looking at other device drivers,
> I'm not sure they would expect to have their slot_reset invoked in
> this situation.

I haven't looked at other slot_reset callbacks.  Do you have an
example we can look at and talk about?

The existing model (even without your changes) allows a user to start
a reset via sysfs while the driver is still active.  What happens when
the reset occurs while the driver is programming the device?  For
example, if the driver sets up a DMA transfer address, the reset
occurs (destroying the address), and the driver initiates the DMA, the
DMA will go to the wrong place.

I'm not sure how to fix this model of resets happening asynchronous to
the driver.  Maybe we need to tell the driver *before* the reset.
Maybe we need to ask the driver to do the reset itself, and only do it
in the core if no driver is attached.  Maybe we need to make the reset
look like a hotplug remove/add to the driver, so we detach the driver,
do the reset, and reattach a driver.

In the general case, we don't know what the device *is* after a reset
because it could have loaded new firmware.  It could require more
resources or even a different driver.

I know it would cause Alex heartburn to make reset look like hotplug.
What sort of NVMe problems would that cause?  I assume most drivers
will have to treat a device coming out of reset basically the same way
as a brand new hot-added device.

Bjorn
