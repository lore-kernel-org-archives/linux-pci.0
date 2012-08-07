Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44531 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184Ab2HGPOZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Aug 2012 11:14:25 -0400
MIME-Version: 1.0
In-Reply-To: <201208071323.51275.rjw@sisk.pl>
References: <CACVXFVPNO2yQXJjwPGm8oLeNHsj72wtHnJ5YKLg65hR2X7BWDg@mail.gmail.com>
	<Pine.LNX.4.44L0.1208061045020.1649-100000@iolanthe.rowland.org>
	<CACVXFVP=RJ=Zcj4NDpr7zD1+X=oVPg40v6yR7_osOxN8mPowEA@mail.gmail.com>
	<201208071323.51275.rjw@sisk.pl>
Date: Tue, 7 Aug 2012 23:14:23 +0800
Message-ID: <CACVXFVO957+ORC4dLh5=5Ck=xeFw9cCSDXMNzx7jDPogyMfE_w@mail.gmail.com>
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

On Tue, Aug 7, 2012 at 7:23 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> Yes, I agree, but I don't think it may make .runtime_post_resume
>> not doable, do I?
>
> No more device PM callbacks, please.

IMO, what the patch is doing is to introduce one callback which
is just called after .runtime_resume is completed, and you want
to move something out of previous .runtime_resume and do it
in another new callback to speedup resume, so it should be
reasonable to introduce the .runtime_post_resume callback in logic.

Also, the 'func' should be per driver, not per device since only one
'func' is enough for all same kind of devices driven by one same
driver.

> Besides, callbacks in struct dev_pm_ops are not only for drivers.

All the current 3 runtime callbacks are for devices. If you mean
they can be defined in bus/power_domain/device_type, .runtime_post_resume
still can be defined there too.

>
>> > Also, "func" should not be stored in dev_pm_ops because it won't be a
>> > read-only value.
>>
>> Sorry, could you explain it in detail that why the 'func'
>> has to switch to multiple functions dynamically? I understand
>> one function is enough and sometimes it can be bypassed with
>> one flag(such as, ignore_post_resume is introduced in dev_pm_info)
>> set.  Also, the driver can store the device specific states
>> in its own device instance to deal with different situations in the callback.
>>
>> If the idea is doable, we can save one pointer in 'struct device',
>> since the 'func' may not be used by more than 90% devices, also
>> have document benefit, even may simplify implementation of the
>> mechanism.
>
> And how many struct device objects there are for the one extra pointer to
> matter, let alone the fact that you want to replace it by one extra pointer
> somewhere else?

For example, in the pandaboard(one omap4 based small system), follows
the count of device instances:

         [root@root]#dmesg | grep device_add | wc -l
        471

The above is just a simple configuration(no graphics, no video/video, only
console enabled) on Pandaboard.

If the callback may be defined in dev_pm_info, not only memory can be saved,
also there are other advantages described before.


Thanks,
-- 
Ming Lei
