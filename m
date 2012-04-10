Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:6464 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753457Ab2DJUYY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Apr 2012 16:24:24 -0400
From: Steven Newbury <steve@snewbury.org.uk>
Reply-To: Steven Newbury <steve@snewbury.org.uk>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
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
In-Reply-To: <CAE9FiQXvwYrJhLi91VDVtD4+OOfbGQ1U20-Cap+8tBZUt7QCkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Tue, 10 Apr 2012 21:26:08 +0100
Message-Id: <1334089568.4083.2.camel@Nokia-N900>
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 10 Apr 2012, 21:07:02 BST, Yinghai Lu <yinghai@kernel.org> wrote:

> On Tue, Apr 10, 2012 at 12:46 PM, Steven Newbury <steve@snewbury.org.uk>
> wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > > the suitable range for that is 0xe0000000-0xefffffff. that is not
> > > bigger enough, because need to preallocate 64M optional for 03:01.0
> > > the cardbus. but that is optional.
> > 
> > Maybe this is a stupid question, but is there any way of enlarging the
> > PCI hole?
> 
> Sane BIOS should have one option to increase that.
> 
> or it should probe MMIO range it need to allocate for pci devices and
> hotplug. then set TOP_OF_LOW_MEM.
> 
So far I'm concluding the BIOS isn't sane.  Is it possible to define a custom memory map from the linux boot cmdline to set TOP_OF_LOW_MEM?  

Obviously, I'd prefer getting everything allocated into the address space available, and working, but if it comes down to it I'd accept a hack like the above if there's no other way.


