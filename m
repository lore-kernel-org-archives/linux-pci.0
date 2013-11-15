Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:48712 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494Ab3KOKeg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Nov 2013 05:34:36 -0500
Received: by mail-qa0-f49.google.com with SMTP id cm18so423976qab.8
        for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2013 02:34:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87li0q9fna.fsf@nemi.mork.no>
References: <CAPDyKFqYOnfWKH7BFRem5T5yGmJrOWBTDhZwoExuemMf0HQ7Ag@mail.gmail.com>
	<Pine.LNX.4.44L0.1311141249580.1439-100000@iolanthe.rowland.org>
	<CAPDyKFrQfwOQsOCB1QFo4GWeX303AEWnanE61svy9UUJpNBUiw@mail.gmail.com>
	<87li0q9fna.fsf@nemi.mork.no>
Date: Fri, 15 Nov 2013 11:34:35 +0100
Message-ID: <CAPDyKFqJMbsF30PtFicXQ17fA+62YX7a9smsLrUUK7Fxn2SWpA@mail.gmail.com>
Subject: Re: [RFC PATCH] PM / Runtime: Allow to inactivate devices during
 system suspend
From: Ulf Hansson <ulf.hansson@linaro.org>
To: =?ISO-8859-1?Q?Bj=F8rn_Mork?= <bjorn@mork.no>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	linux-usb@vger.kernel.org, Kevin Hilman <khilman@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 15 November 2013 10:29, Bjørn Mork <bjorn@mork.no> wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>> I think it is kind of strange to give provision to userspace to
>> control a "request based" power management feature in the kernel. Me
>> personally can't think of any good use case, but I comes from the
>> embedded/ARM world so I might not have the full picture.
>
> Because resuming a device inevitably adds latency, and that only
> userspace can decide the latency vs power policy for any given device,
> system and user?

That is a valid point. Though we have pm_qos, should not that be the
input for these kind of requirement for a driver?

In other words, if the latency requirement can't be met for a device
while re-activating it, it should not enter runtime suspend state.

>
> There are also other reasons, mostly related to device bugs.  But the
> above is the most important in my view.  Without that control knob I
> don't think I would have enabled runtime PM in any network driver while
> the netif is running.  The additional latency is noticable.
>
> Anyway, this is a pointless discussion.  The power/control ABI is in use
> so many places that it cannot be changed.  I'd suggest googling "break
> userspace" before even suggesting anything like that again.
>

I agree, and has never been a suggestion from my side either, more
like a statement that I don't like the sysfs for runtime PM. :-)

Kind regards
Ulf Hansson

>
> Bjørn
