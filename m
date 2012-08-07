Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38885 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753513Ab2HGQa7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Aug 2012 12:30:59 -0400
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1208071138430.2400-100000@iolanthe.rowland.org>
References: <CACVXFVO957+ORC4dLh5=5Ck=xeFw9cCSDXMNzx7jDPogyMfE_w@mail.gmail.com>
	<Pine.LNX.4.44L0.1208071138430.2400-100000@iolanthe.rowland.org>
Date: Wed, 8 Aug 2012 00:30:58 +0800
Message-ID: <CACVXFVM6id=oB5x80fin-k8-=sj=fLYu=0YDRZX-Uhqk4Cp8QQ@mail.gmail.com>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected
 regression ...)
From: Ming Lei <tom.leiming@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pci@vger.kernel.org,
	USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 7, 2012 at 11:42 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> No, that's really not what the patch is doing.
>
> The idea behind the new API is that "func" will be called as soon as we
> know the device is at full power.  That could be after the next runtime
> resume or it could be right away.  This is a one-time call; it should

IMO, in the both two cases, the 'func' should be very similar with
.runtime_post_resume from view of the caller because the caller
don't know what the power state of the device is now, so they may
always think the 'func' should do something similar done in
.runtime_post_resume.

Also .runtime_post_resume always knows the device's power state
is active, which is same with 'func'. In fact, it doesn't matter if the active
state is the 1st time or other times, does it?

> not be made _every_ time the device resumes.

Suppose the device is always resumed in the path(such as irq context),
the callback is still called every time.

If the .runtime_post_resume is to be a one-time call, that is easy to do it.
Also I am wondering why the callback shouldn't be called after resume
in sync context, and it may simplify implementation if the two contexts
(sync vs. async) are kept consistent.

>
>> Also, the 'func' should be per driver, not per device since only one
>> 'func' is enough for all same kind of devices driven by one same
>> driver.
>
> But what if the subsystem defines its own dev_pm_info structure?  Then
> the driver's dev_pm_info will be ignored by the runtime PM core.  All
> the subsystems would have to be changed.

Suppose .runtime_post_resume is introduced, the priority of
dev_pm_info for .runtime_post_resume callback can be changed to
adapt to the situation.


Thanks,
-- 
Ming Lei
