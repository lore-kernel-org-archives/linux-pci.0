Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:49858 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755808Ab2DKX7r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Apr 2012 19:59:47 -0400
Received: by lbbgm6 with SMTP id gm6so1167202lbb.19
        for <linux-pci@vger.kernel.org>; Wed, 11 Apr 2012 16:59:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F859646.7030109@snewbury.org.uk>
References: <1333968563.5678.19.camel@infinity> <CAErSpo7hGvJSmq4U37XN9T7ZaYn55fyy9t3ER5BBCDdQ3XZxqw@mail.gmail.com>
 <4F84110E.3000400@snewbury.org.uk> <CAE9FiQVHf_pcXUspOtLXx4XminmzdWja3Ra2Wh5jQRbfNOQ1eQ@mail.gmail.com>
 <4F8467AA.90305@snewbury.org.uk> <CAE9FiQWaop0NE7ZJu6jVW3SnxLkOJ9hRKh4xMNk64XjCAMRMMw@mail.gmail.com>
 <4F848357.3060007@snewbury.org.uk> <CAE9FiQXTgh3X4x+xD1T0ipsEbhbPtctYucfGeuWK=cq7kHeZ1Q@mail.gmail.com>
 <4F848E10.1090703@snewbury.org.uk> <CAE9FiQXvwYrJhLi91VDVtD4+OOfbGQ1U20-Cap+8tBZUt7QCkA@mail.gmail.com>
 <1334089568.4083.2.camel@Nokia-N900> <CAE9FiQWnvB2VbBQQaEnDE0nf+Zwy6nyoGrEuVrUesQEzgYfbvA@mail.gmail.com>
 <4F84A3EC.6030903@snewbury.org.uk> <CAErSpo6GTarMUySce+n6x=TtqgfryzA5-88aKwL7L4snDp4MTA@mail.gmail.com>
 <4F859646.7030109@snewbury.org.uk>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 11 Apr 2012 17:59:24 -0600
Message-ID: <CAErSpo4CQowZic0HR-_hnUqMZUrLKk34QfDikH9LykfRAYKt4Q@mail.gmail.com>
Subject: Re: PCI resources above 4GB
To: Steven Newbury <steve@snewbury.org.uk>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 11, 2012 at 8:33 AM, Steven Newbury <steve@snewbury.org.uk> wrote:
> On 11/04/12 04:37, Bjorn Helgaas wrote:

>> If the host bridge has a _PRS with settings above 4G that we could
>> enable, that might be worthwhile.  I haven't seen _PRS on a host
>> bridge yet, and Linux would ignore it if it existed, but that would
>> be a plausible approach.  (Turn on CONFIG_PNP_DEBUG_MESSAGES and
>> boot with pnp.debug=1 to see if you have any _PRS.)
>
> Attached dmesg with pnp.debug=1, also includes working radeon with
> cardbus disabled in BIOS.

As expected, your host bridge doesn't have a _PRS method, so there's
no good way to change its apertures.

>> Do you happen to know what Windows does in that

> That's why I'm hoping to be able to reallocate the i915 aperture
> above 4GB, but this depends on what the chipset is capable of
> rather than what the BIOS exposes.

We don't have native drivers in Linux for every chipset.  For example,
to my knowledge, Linux doesn't know anything about the Intel 965 spec
ifics you mentioned.  Therefore, we do rely on the abstract
information the BIOS exposes.  Sometimes that we can't exploit every
hardware feature.  That's part of the tradeoff between having a
generic kernel vs. having to write new code for every new machine.

>> situation?   Does the radeon work and the i915 not, or does it somehow
>> make both work?   Is there any way you could collect the device info
>> under Windows, using AIDA64 (http://www.aida64.com/) or similar?

> From reading Microsoft documents, they always try putting PCI
> resources above 4GB on 64bit Windows since Vista, even
> using bounce buffers where necessary, and supported by the
> hardware, only falling back below 4GB when all else fails.

I don't doubt that Windows tries to put PCI resources above 4GB, but I
suspect it does so only when it can place them inside a host bridge
aperture reported via _CRS.  I'd be very surprised if 64-bit Windows
assigned >4GB PCI resources on this machine.

Here's the basic problem: when we hot-add a PCI device, we have to
know what resources can possibly be assigned to it.  When we have more
than one host bridge,  we have to know the apertures of each host
bridge so we can allocate from the correct ones.  That's what _CRS
tells us.

So the short answer is that by default Linux uses _CRS, and it won't
work any better than Windows in this case.

If you want to make some tweaks and just live with the fact of always
having to use "pci=nocrs", that's fine.  I don't personally have time
to mess with that, and I don't know whether it would make sense to
push those tweaks upstream, but you can likely make it work somehow.

Bjorn
