Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qe0-f47.google.com ([209.85.128.47]:57078 "EHLO
	mail-qe0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628Ab3KNOc5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Nov 2013 09:32:57 -0500
Received: by mail-qe0-f47.google.com with SMTP id b4so1305498qen.34
        for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2013 06:32:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2003753.HAeVh74cdL@vostro.rjw.lan>
References: <1384360178-333-1-git-send-email-ulf.hansson@linaro.org>
	<2003753.HAeVh74cdL@vostro.rjw.lan>
Date: Thu, 14 Nov 2013 15:32:56 +0100
Message-ID: <CAPDyKFozCfPj-gW124cyFSu=ckiL-zVEmEx5tspY-1maO=+6fA@mail.gmail.com>
Subject: Re: [RFC PATCH] PM / Runtime: Allow to inactivate devices during
 system suspend
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	linux-usb@vger.kernel.org, Kevin Hilman <khilman@linaro.org>,
	Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>
> That's not even correct.  It prevents the runtime PM framework from being
> used to suspend devices during system suspend and that's on purpose.  The
> reason why is that we don't want asynchronous runtime suspends to happen
> during system suspend and race with the suspend process.
>
>> Remove this constraint and moreover try to inactivate devices
>> by invoking pm_runtime_idle() before proceeding with device's
>> suspend_late callbacks.
>>
>> A great amount of drivers that uses runtime PM will benefit from this.
>
> If the idea is to be able to do pm_runtime_suspend() from the system suspend
> code path, this is not the way to go and it kind of indicates the lack of
> understanding why things have been arranged this way.

I guess there are several reasons, but the one that think stands the
best is the race condition you are referring to above. I were more or
less looking at the below commits to try to get a summary of the
history, I guess there are more. :-)

cf579dfb82550e34de7ccf3ef090d8b834ccd3a9
and
1e2ef05bb8cf851a694d38e9170c89e7ff052741

>
> If you want a driver to do the same thing for runtime PM and system
> suspend/resume, point its .suspend_late() and .runtime_suspend() to the
> same routine and analogously for .runtime_resume() and .resume_early()
> (that may not work for PCI, though, because of the _noirq stuff, but that's
> the PCI bus type issue).

When your .suspend_late callback gets called, your device may be
either active or inactive from runtime PM point of view. Just pointing
the .suspend_late callback to the .runtime_suspend callback, simply
wont work.

That would mean we might end up in trying to inactivate an already
inactivated device, which I doubt is a good thing.:-) Some additional
code will be needed to track the "runtime state" and to act
accordingly. This is what drivers already tries to handle as of today,
though so far mostly from their .suspend callbacks I believe.

>
> Of course, the assumption behind .runtime_suspend() and .runtime_resume() is
> that they will be run when the device is not in use, while system suspend
> may actually happen when the device *is* in use and .suspend() should take
> care of that if necessary.  So you may need .suspend() anyway.
>
> One important property of system suspend is that it can happen at any time
> and that's why the .suspend() and .resume() callbacks are needed (and this
> also means that they can't be the same as .runtime_suspend() and
> .runtime_resume() in general).

I see your point and in most cases you are right. But, I am also sure
that quite many drivers should be able to cope with only runtime PM
callbacks. I have collected a bunch of examples that I can share, if
you are interested?

Kind regards
Ulf Hansson

>
> Thanks!
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
