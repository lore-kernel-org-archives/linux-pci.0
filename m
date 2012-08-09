Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:43767 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab2HIFzR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Aug 2012 01:55:17 -0400
MIME-Version: 1.0
In-Reply-To: <201208082216.48863.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1208081432090.1701-100000@iolanthe.rowland.org>
	<201208082216.48863.rjw@sisk.pl>
Date: Thu, 9 Aug 2012 13:55:15 +0800
Message-ID: <CACVXFVPxjcawVVQwZGeHZ+g9Gh5twc2EqRH_BLbx9kzY3eMekQ@mail.gmail.com>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected
 regression ...)
From: Ming Lei <tom.leiming@gmail.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pci@vger.kernel.org,
	USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 9, 2012 at 4:16 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Wednesday, August 08, 2012, Alan Stern wrote:

To be honest, I agree on the idea:

       The runtime-resume method does nothing but bring the device
        back to full power; it doesn't do any other processing, which
        should be done in 'func' or some kind of callback.

I just think it is not good to introduce one extra field of 'func' in
dev_pm_info which is embedded into struct device in the patch,
see the reasons in the last part of the reply.

>> That was my original suggestion.  Rafael pointed out that having a
>> single function call to do this would make it easier for driver writers
>> to get it right.
>
> Not only would it be easier to get it right, in my opinion, but also in the
> example above func() may be called in some places where the driver may not
> want it to be called and which are very difficult to detect (like a resume
> from __device_suspend() during system suspend).  Moreover, if the driver

IMO, func() does some driver specific things, which PM core shouldn't pay
special attention to in theory.

> callback is not executed directly by the PM core, but instead it is executed by
> a subsystem or PM domain callback, there's no guarantee that the device _can_
> be used for processing regular I/O before the driver callback returns (the
> subsystem callback may still need to do something _after_ that happens).

driver->runtime_resume should be allowed to do I/O things after
the device has been woken up inside driver callback, shouldn't it? If it
isn't allowed, something wrong should have be reported before.

> So, this appears to be a matter of correctness too.


>> If you've got a system with 10000 device instances, you can probably
>> spare the memory needed to store these function pointers.  But you're
>> right that this is a disadvantage.
>
> Yes, it is in grand general, but that also is a matter of alignment and of
> the way the slab allocator works.  For example, if every struct device
> object were stored at the beginning of a new memory page, then its size
> wouldn't matter a lot as long as it were smaller than PAGE_SIZE.
>
> I haven't checked the details, but I'm pretty sure that focusing on the size
> alone doesn't give us the whole picture here.

The allocation by kmalloc is not page aligned, and it is 2-power
aligned, for example 16, 32, 64,..., also it is at least hardware
L1 cache size aligned.

Firstly, introduce one extra pointer in device may increase memory
consume for device allocation, also it reflects one design drawback
in the patch, see below.

More importantly, the implementation violates some software design
principle in object oriented design. The driver core takes much
object oriented idea in its design and implementation, and introduces
device / driver / bus class. One class is an abstraction of one kind of
objects or instances with same attributes, so one class may include
many objects, for example, usb_device(class) is abstraction for all usb
devices, and there may have many many usb devices in a system, but only
one usb_device structure defined.

One specific driver class is a special class since it may only have one
driver object , which is basically read only. In OO world, it might be called
static class.

Generally, one driver object serves one specific device class, instead
of one device object. For example, usb_storage_driver is a driver object,
which serves all usb mass storage devices which all belongs to usb mass
storage class).

The 'func' to be introduced is a function pointer, which should be
driver related thing and should serve one specific device class in theory,
and it shouldn't serve only one concrete device object, so it is not good
to include it into 'struct device'.

The only function pointer in struct device:

              void    (*release)(struct device *dev)

should be removed.  All its users should convert to use device_type to
define release handler for its 'device class', instead of device object.

So suggest to improve it.


Thanks,
-- 
Ming Lei
