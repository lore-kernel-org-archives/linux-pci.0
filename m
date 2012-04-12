Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:60590 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761832Ab2DLLiM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Apr 2012 07:38:12 -0400
From: Steven Newbury <steve@snewbury.org.uk>
Reply-To: Steven Newbury <steve@snewbury.org.uk>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: PCI resources above 4GB
References: <1333968563.5678.19.camel@infinity>
	 <CAErSpo7hGvJSmq4U37XN9T7ZaYn55fyy9t3ER5BBCDdQ3XZxqw@mail.gmail.com>
	 <4F84110E.3000400@snewbury.org.uk>
	 <CAE9FiQVHf_pcXUspOtLXx4XminmzdWja3Ra2Wh5jQRbfNOQ1eQ@mail.gmail.com>
	 <4F8467AA.90305@snewbury.org.uk>
	 <CAE9FiQWaop0NE7ZJu6jVW3SnxLkOJ9hRKh4xMNk64XjCAMRMMw@mail.gmail.com>
	 <4F848357.3060007@snewbury.org.uk>
	 <CAE9FiQXTgh3X4x+xD1T0ipsEbhbPtctYucfGeuWK=cq7kHeZ1Q@mail.gmail.com>
	 <4F848E10.1090703@snewbury.org.uk>
	 <CAE9FiQXvwYrJhLi91VDVtD4+OOfbGQ1U20-Cap+8tBZUt7QCkA@mail.gmail.com>
	 <1334089568.4083.2.camel@Nokia-N900>
	 <CAE9FiQWnvB2VbBQQaEnDE0nf+Zwy6nyoGrEuVrUesQEzgYfbvA@mail.gmail.com>
	 <4F84A3EC.6030903@snewbury.org.uk>
	 <CAErSpo6GTarMUySce+n6x=TtqgfryzA5-88aKwL7L4snDp4MTA@mail.gmail.com>
	 <4F859646.7030109@snewbury.org.uk>
	  <CAErSpo4CQowZic0HR-_hnUqMZUrLKk34QfDikH9LykfRAYKt4Q@mail.gmail.com>
In-Reply-To: <CAErSpo4CQowZic0HR-_hnUqMZUrLKk34QfDikH9LykfRAYKt4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Thu, 12 Apr 2012 12:39:59 +0100
Message-Id: <1334230799.30606.10.camel@Nokia-N900>
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 12 Apr 2012, 00:59:24 BST, Bjorn Helgaas <bhelgaas@google.com> wrote:
> I don't doubt that Windows tries to put PCI resources above 4GB, but I
> suspect it does so only when it can place them inside a host bridge
> aperture reported via _CRS.   I'd be very surprised if 64-bit Windows
> assigned >4GB PCI resources on this machine.
> 
I don't know.  I'd try it if I had a copy.  As I understand Windows PCI/PnP is one of its better capablities.

> Here's the basic problem: when we hot-add a PCI device, we have to
> know what resources can possibly be assigned to it.   When we have more
> than one host bridge,   we have to know the apertures of each host
> bridge so we can allocate from the correct ones.   That's what _CRS
> tells us.
> 
> So the short answer is that by default Linux uses _CRS, and it won't
> work any better than Windows in this case.
> 
Given 32-bit Vista BSODs on me, I'd say it's already doing better! :)

> If you want to make some tweaks and just live with the fact of always
> having to use "pci=nocrs", that's fine.   I don't personally have time
> to mess with that, and I don't know whether it would make sense to
> push those tweaks upstream, but you can likely make it work somehow.

Okay, fair enough, although I feel most of this is pretty generic PCI resource management (if an extreme example), it would be nice if BIOSes were better and provided the needed information, but sadly that's not the case, certainly not on older machines, probably laptops especially.

I'm pleased to have got as far as getting it to boot with both video devices now working when docked.  I'm going to keep going and try to get hot-plug working too, but that means some more agressive tweaking as mentioned in my other email.

Hopefully something generally useful comes out of this.  At the least there must be a few people out there with similar hardware.
