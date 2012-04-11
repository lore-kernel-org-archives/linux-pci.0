Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:48446 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751508Ab2DKLmK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Apr 2012 07:42:10 -0400
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
	 <1334089568.4083.2.camel@Nokia-N900>
	  <CAE9FiQWnvB2VbBQQaEnDE0nf+Zwy6nyoGrEuVrUesQEzgYfbvA@mail.gmail.com>
In-Reply-To: <CAE9FiQWnvB2VbBQQaEnDE0nf+Zwy6nyoGrEuVrUesQEzgYfbvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Wed, 11 Apr 2012 12:43:51 +0100
Message-Id: <1334144631.30606.3.camel@Nokia-N900>
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 10 Apr 2012, 21:45:54 BST, Yinghai Lu <yinghai@kernel.org> wrote:

> On Tue, Apr 10, 2012 at 1:26 PM, Steven Newbury <steve@snewbury.org.uk>
> wrote:
> > > 
> > So far I'm concluding the BIOS isn't sane.  Is it possible to define a
> > custom memory map from the linux boot cmdline to set TOP_OF_LOW_MEM?
> 
> The BIOS have MMIO and memory overlapping...
> 
> > 
> > Obviously, I'd prefer getting everything allocated into the address
> > space available, and working, but if it comes down to it I'd accept a
> > hack like the above if there's no other way.
> 
> Could try to reduce carbus preallocated size.... boot with
> pci=cbmemsize=16M

I've managed to get the radeon to work by turning off the cardbus controller in the BIOS setup.  I'll try the patch and the above parameter next.
> 
> Please apply attached patch in addtition to allocate_high_at_first

Btw, I've verified why the intel gfx isn't working, intel-agp.c only reads the lower 32bits of the aperture location.  It is definitely supported over 4G by the hardware, see my other email.
