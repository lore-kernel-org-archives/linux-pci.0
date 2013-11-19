Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qe0-f53.google.com ([209.85.128.53]:36012 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906Ab3KSMWA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Nov 2013 07:22:00 -0500
Received: by mail-qe0-f53.google.com with SMTP id cy11so4959456qeb.26
        for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2013 04:21:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1311181010080.1421-100000@iolanthe.rowland.org>
References: <CAPDyKFrushEwW7x_VguPjOnP8BuSO=+tD=DxS9J0JQVfYTgOYA@mail.gmail.com>
	<Pine.LNX.4.44L0.1311181010080.1421-100000@iolanthe.rowland.org>
Date: Tue, 19 Nov 2013 13:21:57 +0100
Message-ID: <CAPDyKFpypLVKiOZEweWMig9LrNHcOpNQnm+J3KJ3KzCDBgkv9A@mail.gmail.com>
Subject: Re: [RFC PATCH] PM / Runtime: Allow to inactivate devices during
 system suspend
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	linux-usb@vger.kernel.org, Kevin Hilman <khilman@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 18 November 2013 16:17, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 18 Nov 2013, Ulf Hansson wrote:
>
>> I favour the pm_runtime_no_prevent_suspend API approach, since it
>> would mean a change in behaviour of the PM core.
>
> That's exactly why I don't favor it!  :-)

I will try my best to convince you then. :-)

>
>>  I also think that in
>> some cases it could make runtime PM better understandable, for those
>> who are deploying it.
>
> I don't see how it would make runtime PM either more or less
> understandable, since the proposed change affects system PM, not
> runtime PM.  On the other hand, it would make the Runtime PM
> documentation more complicated.

At the moment, system PM is already affecting behaviour of runtime PM
since it is preventing runtime suspend during system suspend.

To me and and those driver authors, that don't see the direct need for
why the PM core behaves like this (because we are not working with PCI
drivers for example), I would guess this is probably the piece in the
documentation we have more difficult to understand and adapt to.

I can point at some examples, were I believe drivers that use runtime
PM, tries to adapt to the PM core behaviour, but I fear they for too
many times have got it wrong. Here are some various examples I have
found, which made me think like this.

1.
Not many are using the .suspend_late callback at all, which should be
the most proper solution to use.

2.
Drivers are using the synchronise pm_runtime_put_sync in their
.suspend callbacks.

3.
Drivers do "pm_runtime_get_sync" from their .suspend callbacks, but
don't put the device into inactive state from anywhere as a part of
the system suspend.

4.
Drivers only handles system suspend tasks from it's .suspend callbacks
and don't implement .suspend_late, thus the device will not be fully
inactivated.

5.
Drivers relies on pm_runtime_suspended or worse
pm_runtime_status_suspend, to check if they shall put their device
into inactive state from their .suspend callbacks or leave it as is.
While they put the device into inactive state, the runtime state is
not properly updated to reflect this. Most important, at this point
runtime PM has not yet been disabled from the PM core.

>
> (Also, I think the name "pm_runtime_no_prevent_suspend" is a very bad
> choice.  It should be something more like
> "allow_runtime_suspend_during_system_sleep".)

I am not so happy with the naming myself, we should work out a better one then.

>
>> Another advantage of "pm_runtime_no_prevent_suspend" is that driver's
>> can still easily prevent runtime suspend, during system suspend, by an
>> extra call to "pm_runtime_get*". Typically this could be used when the
>> device is configured for wakeup.
>
> How is this an advantage?  Drivers can accomplish the same thing right
> now by not doing anything at all.
>
>>  In this case the generic suspend_late
>> approach would not work, since the driver would need to implement it's
>> own .suspend_late callback to handle this.
>
> Actually, drivers would simply need to _avoid_ setting the
> .suspend_late callback.

I should have stated, that I means those scenarios were the wakeup
configuration is decided in runtime and depending on the current
situation. For example depending on what kind of peripheral that is
connected. In this scenario, I think the advantage still stands.

Kind regards
Ulf Hansson

>
> Alan Stern
>
