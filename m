Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:46996 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753340Ab2HGUjy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 7 Aug 2012 16:39:54 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Ming Lei <tom.leiming@gmail.com>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected regression ...)
Date: Tue, 7 Aug 2012 22:45:46 +0200
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pci@vger.kernel.org,
	USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
References: <CACVXFVPNO2yQXJjwPGm8oLeNHsj72wtHnJ5YKLg65hR2X7BWDg@mail.gmail.com> <201208071323.51275.rjw@sisk.pl> <CACVXFVO957+ORC4dLh5=5Ck=xeFw9cCSDXMNzx7jDPogyMfE_w@mail.gmail.com>
In-Reply-To: <CACVXFVO957+ORC4dLh5=5Ck=xeFw9cCSDXMNzx7jDPogyMfE_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201208072245.46334.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, August 07, 2012, Ming Lei wrote:
> On Tue, Aug 7, 2012 at 7:23 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> Yes, I agree, but I don't think it may make .runtime_post_resume
> >> not doable, do I?
> >
> > No more device PM callbacks, please.
> 
> IMO, what the patch is doing is to introduce one callback which
> is just called after .runtime_resume is completed,

No, it is not a callback.  It is a function to be run _once_ when the device is
known to be active.  It is not a member of a data type or anything like this.

It's kind of disappointing that you don't see a difference between that and a
callback.

> and you want to move something out of previous .runtime_resume

No, I don't.  Where did you get that idea from?

> and do it in another new callback to speedup resume,

No, not to speed up resume.  The idea is to allow drivers to run something
when the resume is complete, so that they don't have to implement a "resume
detection" logic or use .runtime_resume() to run things that don't belong
there.

> so it should be reasonable to introduce the .runtime_post_resume callback in
> logic.

No.  This doesn't have anything to do with callbacks!

If you want a new callback, you should specify what the role of this callback
is, otherwise it is not well defined.  I this case, though, what the role of
func() is depends on the caller and most likely every driver would use it
for something different.  So no, I don't see how it can be a callback.

> Also, the 'func' should be per driver, not per device since only one
> 'func' is enough for all same kind of devices driven by one same
> driver.

It isn't per device!  It is per _caller_.  The fact that the pointer is
stored _temporarily_ in struct device doesn't mean that it is per device
and that it is a callback.  From the struct device point of view it is _data_,
not a member function.

> > Besides, callbacks in struct dev_pm_ops are not only for drivers.
> 
> All the current 3 runtime callbacks are for devices. If you mean
> they can be defined in bus/power_domain/device_type, .runtime_post_resume
> still can be defined there too.

No, it wouldn't make _any_ _sense_ there, because its role there cannot be
defined in any sane way.

> >> > Also, "func" should not be stored in dev_pm_ops because it won't be a
> >> > read-only value.
> >>
> >> Sorry, could you explain it in detail that why the 'func'
> >> has to switch to multiple functions dynamically? I understand
> >> one function is enough and sometimes it can be bypassed with
> >> one flag(such as, ignore_post_resume is introduced in dev_pm_info)
> >> set.  Also, the driver can store the device specific states
> >> in its own device instance to deal with different situations in the callback.
> >>
> >> If the idea is doable, we can save one pointer in 'struct device',
> >> since the 'func' may not be used by more than 90% devices, also
> >> have document benefit, even may simplify implementation of the
> >> mechanism.
> >
> > And how many struct device objects there are for the one extra pointer to
> > matter, let alone the fact that you want to replace it by one extra pointer
> > somewhere else?
> 
> For example, in the pandaboard(one omap4 based small system), follows
> the count of device instances:
> 
>          [root@root]#dmesg | grep device_add | wc -l
>         471
> 
> The above is just a simple configuration(no graphics, no video/video, only
> console enabled) on Pandaboard.
> 
> If the callback may be defined in dev_pm_info,

I guess you mean struct dev_pm_ops, right?

> not only memory can be saved, also there are other advantages described
> before.

So now please count how many struct dev_pm_ops objects there are on that system
and compute the differece.  And please note that drivers that don't use
struct dev_pm_ops for power management will do that in the future.

Also please note that the caller of pm_runtime_get_and_call() need not be
a driver, at least in theory.

Thanks,
Rafael
