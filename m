Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:29777 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753869Ab2DLLUr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Apr 2012 07:20:47 -0400
From: Steven Newbury <steve@snewbury.org.uk>
Reply-To: Steven Newbury <steve@snewbury.org.uk>
To: Yinghai Lu <yinghai@kernel.org>,
	"Barnes, Jesse" <jesse.barnes@intel.com>,
	Dave Airlie <airlied@linux.ie>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	DRI mailing list <dri-devel@lists.freedesktop.org>
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
	  <CAE9FiQU+EEtBWrc66Sw4GFQjSy9Vh9fyFvhgQUheev_aVpAzrw@mail.gmail.com>
In-Reply-To: <CAE9FiQU+EEtBWrc66Sw4GFQjSy9Vh9fyFvhgQUheev_aVpAzrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Thu, 12 Apr 2012 12:22:34 +0100
Message-Id: <1334229754.30606.7.camel@Nokia-N900>
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 12 Apr 2012, 01:57:17 BST, Yinghai Lu <yinghai@kernel.org> wrote:

> On Tue, Apr 10, 2012 at 2:19 PM, Steven Newbury <steve@snewbury.org.uk>
> wrote:
> > Another thought, normally the integrated graphics has an "AGP"
> > aperture of 256M @0xe0000000, which is detected by agpgart-intel, this
> > will need to be moved up above 4G to free up 0xe0000000 for the
> > radeon, assuming the "agp_bridge" has a 64bit base register...  I
> > noticed in my docked dmesg, "AGP aperture is 256M @ 0x20000000", but
> > the PCI base: "120000000-12fffffff : 0000:00:02.0" so only 32bits have
> > been set in agpgart-intel.  Explains why i915 wasn't initialised.
> 
> Attached patch should fix that high 32bit missing problem.

Thanks, that fixed it! :) I had a similar patch I've been working on but I had my fix in the wrong place!

In the working case, initially the BIOS has set GMA to within the low system DRAM 0xC0000000 obviously invalid.  This conflict is detected and it's relallocated to 0x12000000.

I've attempted to modify probe.c to disable 64-bit BARs not allocated above 4G so they get reallocated above when possible later.  It seemed to work, but again broke GMA despite the BAR originally containing an invalid address as mentioned above, it seems for some reason something is different when the conflict is detected and rellocated, compared to disabling it early then allocating a valid value..?

It would be useful to preserve as much low PCI memory address space as possible for hotplug devices (like my Radeon), but the other problem is small regions get allocated at the bottom, resulting in the inability to find large aligned regions later on.  I see code to default to top-down allocation was reverted, I guess I'm going to have to dig into the archive to find out why...

Thanks for all your help so far, I've been learning a lot over the last few days.
