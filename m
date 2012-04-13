Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:11223 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753016Ab2DMIfI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Apr 2012 04:35:08 -0400
From: Steven Newbury <steve@snewbury.org.uk>
Reply-To: Steven Newbury <steve@snewbury.org.uk>
To: Yinghai Lu <yinghai@kernel.org>
Cc: "Barnes, Jesse" <jesse.barnes@intel.com>,
	Dave Airlie <airlied@linux.ie>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
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
	 <1334229754.30606.7.camel@Nokia-N900>
	 <CAE9FiQXhzAOErMeQxz6U-BSYAK1LirHMpiFH90iRoXxwduPhPw@mail.gmail.com>
	 <1334248841.2910.6.camel@Nokia-N900>
	  <CAE9FiQXvHjW3pL4Nrb-3Oqw5Ht-7MqCL7_isL+Gm41qWOd1yRQ@mail.gmail.com>
In-Reply-To: <CAE9FiQXvHjW3pL4Nrb-3Oqw5Ht-7MqCL7_isL+Gm41qWOd1yRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Fri, 13 Apr 2012 09:34:36 +0100
Message-Id: <1334306076.2910.10.camel@Nokia-N900>
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 13 Apr 2012, 09:26:55 BST, Yinghai Lu <yinghai@kernel.org> wrote:

> On Thu, Apr 12, 2012 at 9:40 AM, Steven Newbury <steve@snewbury.org.uk>
> wrote:
> > > > 
> > > > It would be useful to preserve as much low PCI memory address
> > > > space as possible for hotplug devices (like my Radeon), but the
> > > > other problem is small regions get allocated at the bottom,
> > > > resulting in the inability to find large aligned regions later on.
> > > >  I see code to default to top-down allocation was reverted, I
> > > > guess I'm going to have to dig into the archive to find out why...
> 
> Please check attached patches that will find_resource with fit. It may
> leave space for your hotplug devices.
> 
>     PCI: Should add children device res to fail list
>     PCI: Try to allocate mem64 above 4G at first
>     intel-gtt: Read 64bit for gmar_bus_addr
>     PCI: Make sure assign same align with large size resource at first
>     resource: make find_resource could return just fit resource
>     PCI: Don't allocate small resource in big empty space.
>     resource: only return range with needed align
> 
> You can get them from
> 
>             
> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
> for-pci-res-alloc
> 
Thanks Yinghai, I'll give it a spin.

