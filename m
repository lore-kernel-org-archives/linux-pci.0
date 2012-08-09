Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:50396 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757768Ab2HIKkb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 9 Aug 2012 06:40:31 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Ming Lei <tom.leiming@gmail.com>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected regression ...)
Date: Thu, 9 Aug 2012 12:46:25 +0200
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pci@vger.kernel.org,
	USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
References: <Pine.LNX.4.44L0.1208081432090.1701-100000@iolanthe.rowland.org> <201208082216.48863.rjw@sisk.pl> <CACVXFVPxjcawVVQwZGeHZ+g9Gh5twc2EqRH_BLbx9kzY3eMekQ@mail.gmail.com>
In-Reply-To: <CACVXFVPxjcawVVQwZGeHZ+g9Gh5twc2EqRH_BLbx9kzY3eMekQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201208091246.25874.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, August 09, 2012, Ming Lei wrote:
> On Thu, Aug 9, 2012 at 4:16 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Wednesday, August 08, 2012, Alan Stern wrote:
> 
> To be honest, I agree on the idea:
> 
>        The runtime-resume method does nothing but bring the device
>         back to full power; it doesn't do any other processing, which
>         should be done in 'func' or some kind of callback.

Good. :-)

> I just think it is not good to introduce one extra field of 'func' in
> dev_pm_info which is embedded into struct device in the patch,
> see the reasons in the last part of the reply.
> 
> >> That was my original suggestion.  Rafael pointed out that having a
> >> single function call to do this would make it easier for driver writers
> >> to get it right.
> >
> > Not only would it be easier to get it right, in my opinion, but also in the
> > example above func() may be called in some places where the driver may not
> > want it to be called and which are very difficult to detect (like a resume
> > from __device_suspend() during system suspend).  Moreover, if the driver
> 
> IMO, func() does some driver specific things, which PM core shouldn't pay
> special attention to in theory.

But also it shouldn't execute that code, right?

> > callback is not executed directly by the PM core, but instead it is executed by
> > a subsystem or PM domain callback, there's no guarantee that the device _can_
> > be used for processing regular I/O before the driver callback returns (the
> > subsystem callback may still need to do something _after_ that happens).
> 
> driver->runtime_resume should be allowed to do I/O things after
> the device has been woken up inside driver callback, shouldn't it? If it
> isn't allowed, something wrong should have be reported before.

Well, the lack of reports doesn't mean there are no bugs. :-)

People may actually see those bugs, but they don't report them or they
report them as system suspend/resume bugs, for example.

> > So, this appears to be a matter of correctness too.
> 
> 
> >> If you've got a system with 10000 device instances, you can probably
> >> spare the memory needed to store these function pointers.  But you're
> >> right that this is a disadvantage.
> >
> > Yes, it is in grand general, but that also is a matter of alignment and of
> > the way the slab allocator works.  For example, if every struct device
> > object were stored at the beginning of a new memory page, then its size
> > wouldn't matter a lot as long as it were smaller than PAGE_SIZE.
> >
> > I haven't checked the details, but I'm pretty sure that focusing on the size
> > alone doesn't give us the whole picture here.
> 
> The allocation by kmalloc is not page aligned, and it is 2-power
> aligned, for example 16, 32, 64,..., also it is at least hardware
> L1 cache size aligned.

Sure, that's why I used the conditional above.  And it doesn't mean I didn't
have the point.

> Firstly, introduce one extra pointer in device may increase memory
> consume for device allocation,

Yes, it does, which may or may not matter depending on the actual size of
struct device and the CPU cache line size on the given machine, right?

> also it reflects one design drawback in the patch, see below.
> 
> More importantly, the implementation violates some software design
> principle in object oriented design.

It doesn't violate anything and you're just ignoring what you've been told.
That makes discussing with you rather difficult, but I'll try again
nevertheless.

If you look at the actual patch I've just posted:

https://patchwork.kernel.org/patch/1299781/

you can see that power.func is never run directly.  Moreover, the pointer it
contains is only used to run a function in pm_runtime_work() and note that
pm_runtime_work() reads that pointer _twice_, because it may be changed in the
meantime by a concurrent thread.

All of this means what I've told you already at least once: power.func is
_not_ _a_ _member_ _function_.

IOW, if it were C++, power.func would still be a function pointer, not a method,
because it is _data_, although its data type happens to be "void function
taking a struct device pointer argument".  It is a data field used to pass
information to a work function, pm_runtime_work(), from a piece of code that
schedules its execution, __pm_runtime_get_and_call().  See now?

> The driver core takes much
> object oriented idea in its design and implementation, and introduces
> device / driver / bus class. One class is an abstraction of one kind of
> objects or instances with same attributes, so one class may include
> many objects, for example, usb_device(class) is abstraction for all usb
> devices, and there may have many many usb devices in a system, but only
> one usb_device structure defined.
> 
> One specific driver class is a special class since it may only have one
> driver object , which is basically read only. In OO world, it might be called
> static class.
> 
> Generally, one driver object serves one specific device class, instead
> of one device object. For example, usb_storage_driver is a driver object,
> which serves all usb mass storage devices which all belongs to usb mass
> storage class).
> 
> The 'func' to be introduced is a function pointer, which should be
> driver related thing and should serve one specific device class in theory,
> and it shouldn't serve only one concrete device object, so it is not good
> to include it into 'struct device'.

No.  You're confusing function pointers with member functions.

Yes, we use function pointers to store the addresses of member functions,
because that's what we can do in C.  Again, in C++ member functions would be
methods, but we still might use function pointers for other purposes.

Whether or not it is "elegant" or "clean" (or whatever you call it) function
pointers for other purposes is a different matter and I think it is highly
subjective.

> The only function pointer in struct device:
> 
>               void    (*release)(struct device *dev)
> 
> should be removed.  All its users should convert to use device_type to
> define release handler for its 'device class', instead of device object.
> 
> So suggest to improve it.

What I want the callers to be able to do is "run this code right now if the
device is operational or schedule the resume of it and run this code when
it's been resumed".  So, the pointer is used to tell the workqueue code
which code to run (if any) when the device has been resumed.

I don't want a "run this code every time the device is resumed" kind of thing,
which I agree that a callback would be more suitable for.

Thanks,
Rafael
