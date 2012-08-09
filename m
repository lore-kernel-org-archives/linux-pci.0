Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:45402 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757847Ab2HIKz4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Aug 2012 06:55:56 -0400
MIME-Version: 1.0
In-Reply-To: <201208091246.25874.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1208081432090.1701-100000@iolanthe.rowland.org>
	<201208082216.48863.rjw@sisk.pl>
	<CACVXFVPxjcawVVQwZGeHZ+g9Gh5twc2EqRH_BLbx9kzY3eMekQ@mail.gmail.com>
	<201208091246.25874.rjw@sisk.pl>
Date: Thu, 9 Aug 2012 18:55:54 +0800
Message-ID: <CACVXFVM9rQWvOrwR9ENrTx4m8iVK=EFbcjioWiCdgbyBRov3eQ@mail.gmail.com>
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

On Thu, Aug 9, 2012 at 6:46 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday, August 09, 2012, Ming Lei wrote:

>> driver->runtime_resume should be allowed to do I/O things after
>> the device has been woken up inside driver callback, shouldn't it? If it
>> isn't allowed, something wrong should have be reported before.
>
> Well, the lack of reports doesn't mean there are no bugs. :-)
>
> People may actually see those bugs, but they don't report them or they
> report them as system suspend/resume bugs, for example.

Also, I am still wondering why subsystem PM callback need to do
something after driver->runtime_resume completes, could you explain
it?

>> Firstly, introduce one extra pointer in device may increase memory
>> consume for device allocation,
>
> Yes, it does, which may or may not matter depending on the actual size of
> struct device and the CPU cache line size on the given machine, right?

It may double memory allocation size in some cases. And it is very possible
since there are so many device objects in system.

>
>> also it reflects one design drawback in the patch, see below.
>>
>> More importantly, the implementation violates some software design
>> principle in object oriented design.
>
> It doesn't violate anything and you're just ignoring what you've been told.
> That makes discussing with you rather difficult, but I'll try again
> nevertheless.
>
> If you look at the actual patch I've just posted:
>
> https://patchwork.kernel.org/patch/1299781/
>
> you can see that power.func is never run directly.  Moreover, the pointer it
> contains is only used to run a function in pm_runtime_work() and note that
> pm_runtime_work() reads that pointer _twice_, because it may be changed in the
> meantime by a concurrent thread.

I have explained it before, it is enough to keep the pointer read only
since driver can maintain its internal state in its specific device instance
(for example, usb_interface objects) and decide what to do in 'func'
for situations, right?



Thanks,
-- 
Ming Lei
