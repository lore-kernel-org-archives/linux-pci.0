Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:23018 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756449Ab3BVJzr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 22 Feb 2013 04:55:47 -0500
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Gu Zheng <guz.fnst@cn.fujitsu.com>,
	Cole Mickens <cole.mickens@gmail.com>
CC: linux-pci@vger.kernel.org, kirill.shutemov@linux.intel.com,
	Mika Westerberg <mika.westerberg@linux.intel.com>
In-Reply-To: <5127203F.1040007@cn.fujitsu.com>
References: <CAJ9Gbf1o0JHTWRvx=5x51q-wpZctkjFQuufR4fdNja_kV56dqw@mail.gmail.com>
 <5127203F.1040007@cn.fujitsu.com>
Subject: Re: Hot (un)plugging a Thunderbolt Ethernet adapter causes kernel
 panic
Message-Id: <20130222095713.A7520E0085@blue.fi.intel.com>
Date: Fri, 22 Feb 2013 11:57:13 +0200 (EET)
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Gu Zheng wrote:
> On 02/22/2013 07:45 AM, Cole Mickens wrote:
> 
> > Hello, I was instructed to send this issue to this mailing list:
> > https://bugzilla.kernel.org/show_bug.cgi?id=54131
> > 
> > --
> > 
> > I have a Macbook Air 2012 running Ubuntu 13.04 with the 3.8.0 kernel
> > (not an RC).
> > 
> > My Thunderbolt Ethernet adapter is usable but only if it is inserted at boot.

It's expected behaviour.

Apple has different Thunderbolt implementation. On PC it's just a ACPI
Hotplug, on Apple kernel have to deal with Thunderbolt controller
directly. We don't have a driver for that yet. It's on todo list, but not
any time soon.

> > If it is removed after being available, the kernel will panic. Generally it
> > takes a minute or two or I have to fire up Chrome or something to stir it.

Hm. We will try to trigger it. Will see if we can do anything about that.

> > I assume the crash isn't written out on a Mac EFI system but I can easily
> > reproduce it and retype whatever bits are important. I did take a
> > snapshot with my camera: http://i.imgur.com/q2iuHWZ.jpg
> > 
> > Apologies if this is the wrong format or place for this; I'm reporting my first
> > kernel bug. Cheers.
> 
> Hi Cole,
> It seems not a new issue, see these: 
> https://lkml.org/lkml/2012/12/13/589
> http://help.lockergnome.com/linux/Linux-Support-Thunderbolt-Apple-Monitor--ftopict553657.html
> Maybe Thunderbolt hotplug is not well supported now.
> If this issue does disturb you, you can try Kirill's patch <https://lkml.org/lkml/2012/12/13/589>,
> maybe it can help you.:)

It will not help. :(

-- 
 Kirill A. Shutemov
