Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qe0-f52.google.com ([209.85.128.52]:56628 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629Ab3KUJLw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Nov 2013 04:11:52 -0500
Received: by mail-qe0-f52.google.com with SMTP id ne12so923893qeb.39
        for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2013 01:11:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1311141053060.1439-100000@iolanthe.rowland.org>
References: <CAPDyKFozCfPj-gW124cyFSu=ckiL-zVEmEx5tspY-1maO=+6fA@mail.gmail.com>
	<Pine.LNX.4.44L0.1311141053060.1439-100000@iolanthe.rowland.org>
Date: Thu, 21 Nov 2013 10:11:50 +0100
Message-ID: <CAPDyKFpfdjMRVWnkiGTy2D=J1ghxbFgiDXROrpX1-mDMihhgdw@mail.gmail.com>
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

On 14 November 2013 16:55, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 14 Nov 2013, Ulf Hansson wrote:
>
>> > If you want a driver to do the same thing for runtime PM and system
>> > suspend/resume, point its .suspend_late() and .runtime_suspend() to the
>> > same routine and analogously for .runtime_resume() and .resume_early()
>> > (that may not work for PCI, though, because of the _noirq stuff, but that's
>> > the PCI bus type issue).
>>
>> When your .suspend_late callback gets called, your device may be
>> either active or inactive from runtime PM point of view. Just pointing
>> the .suspend_late callback to the .runtime_suspend callback, simply
>> wont work.
>>
>> That would mean we might end up in trying to inactivate an already
>> inactivated device, which I doubt is a good thing.:-) Some additional
>> code will be needed to track the "runtime state" and to act
>> accordingly. This is what drivers already tries to handle as of today,
>> though so far mostly from their .suspend callbacks I believe.
>
> You could write a "generic" suspend_late routine that would invoke the
> driver's runtime_suspend routine if the device's runtime PM status was
> RPM_ACTIVE.
>

I started drafting a new RFC according to your suggestion. Soon I
realized that using such a callback for .suspend_late will make
drivers/buses system suspend to depend on runtime suspend, (which my
RFC also has problem with). So I guess this is not a recommended set
up from the PM maintainers. Wandering in circles... :-)

Kind regards
Ulf Hansson
