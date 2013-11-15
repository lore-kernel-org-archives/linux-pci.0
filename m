Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:37264 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752575Ab3KOJa1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Nov 2013 04:30:27 -0500
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	"linux-pm\@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	linux-usb@vger.kernel.org, Kevin Hilman <khilman@linaro.org>
Subject: Re: [RFC PATCH] PM / Runtime: Allow to inactivate devices during system suspend
References: <CAPDyKFqYOnfWKH7BFRem5T5yGmJrOWBTDhZwoExuemMf0HQ7Ag@mail.gmail.com>
	<Pine.LNX.4.44L0.1311141249580.1439-100000@iolanthe.rowland.org>
	<CAPDyKFrQfwOQsOCB1QFo4GWeX303AEWnanE61svy9UUJpNBUiw@mail.gmail.com>
Date: Fri, 15 Nov 2013 10:29:45 +0100
In-Reply-To: <CAPDyKFrQfwOQsOCB1QFo4GWeX303AEWnanE61svy9UUJpNBUiw@mail.gmail.com>
	(Ulf Hansson's message of "Fri, 15 Nov 2013 09:44:48 +0100")
Message-ID: <87li0q9fna.fsf@nemi.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> I think it is kind of strange to give provision to userspace to
> control a "request based" power management feature in the kernel. Me
> personally can't think of any good use case, but I comes from the
> embedded/ARM world so I might not have the full picture.

Because resuming a device inevitably adds latency, and that only
userspace can decide the latency vs power policy for any given device,
system and user?

There are also other reasons, mostly related to device bugs.  But the
above is the most important in my view.  Without that control knob I
don't think I would have enabled runtime PM in any network driver while
the netif is running.  The additional latency is noticable.

Anyway, this is a pointless discussion.  The power/control ABI is in use
so many places that it cannot be changed.  I'd suggest googling "break
userspace" before even suggesting anything like that again.


Bjørn
