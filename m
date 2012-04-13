Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:44066 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751474Ab2DMLp6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Apr 2012 07:45:58 -0400
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
Content-Type: multipart/mixed; boundary="=-y4tNaSRrkuxfTJq28KCQ"
Date: Fri, 13 Apr 2012 12:45:29 +0100
Message-Id: <1334317529.2910.21.camel@Nokia-N900>
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--=-y4tNaSRrkuxfTJq28KCQ
Content-Type: text/plain; charset=utf-8
Content-ID: <1334317528.2910.16.camel@Nokia-N900>
Content-Transfer-Encoding: 8bit

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

I pulled this in on top of a branch with any of the prior PCI patches since they conflict anyway.

It's not stable, crashes soon after GMA comes up. (Could be unrelated breakage in linus/master? Probably not but I will verify.)  I noticed the high allocations are occuring from the top of 64-bit address-space, whilst /proc/cpuinfo shows only 48 bits of virtual addressing.  Could that be why..?

Also, when not docked GMA still isn't mapped high so there's no room for the 256M radeon pref mem.

Attached /proc/iomem output for docked and undocked.
--=-y4tNaSRrkuxfTJq28KCQ
Content-Disposition: attachment; filename=iomem.undocked
Content-Type: text/plain; name=iomem.undocked
Content-ID: <1>
Content-Transfer-Encoding: 7bit

00000000-0000ffff : reserved
00010000-0009efff : System RAM
0009f000-0009ffff : reserved
000c0000-000c7fff : Video ROM
000cf000-000cffff : Adapter ROM
000f0000-000fffff : System ROM
00100000-df65a7ff : System RAM
  01000000-0136ddbd : Kernel code
  0136ddbe-0169127f : Kernel data
  0172f000-01809fff : Kernel bss
df65a800-dfffffff : reserved
  df65a800-df6fffff : pnp 00:0d
  df700000-df7fffff : pnp 00:0d
e0000000-efffffff : 0000:00:02.0
f0000000-f01fffff : PCI Bus 0000:0d
f0200000-f0200fff : Intel Flush Page
f6900000-f69fffff : PCI Bus 0000:09
  f69f0000-f69fffff : 0000:09:00.0
    f69f0000-f69fffff : tg3
f6a00000-f6bfffff : PCI Bus 0000:0d
f6c00000-f6cfffff : PCI Bus 0000:0c
  f6cfe000-f6cfffff : 0000:0c:00.0
    f6cfe000-f6cfffff : iwl4965
f6dfb700-f6dfb7ff : 0000:00:1f.3
f6dfb800-f6dfbfff : 0000:00:1f.2
  f6dfb800-f6dfbfff : ahci
f6dfc000-f6dfffff : 0000:00:1b.0
  f6dfc000-f6dfffff : ICH HD audio
f6e00000-f6efffff : 0000:00:02.0
f6f00000-f6ffffff : 0000:00:02.1
f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
  f8000000-fbffffff : reserved
    f8000000-fbffffff : pnp 00:0d
fec00000-fec0ffff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
  fed00000-fed003ff : pnp 00:08
fed18000-fed1bfff : reserved
  fed18000-fed1bfff : pnp 00:0d
fed1c000-fed1c3ff : 0000:00:1d.7
  fed1c000-fed1c3ff : ehci_hcd
fed1c400-fed1c7ff : 0000:00:1a.7
  fed1c400-fed1c7ff : ehci_hcd
fed20000-fed8ffff : reserved
  fed20000-fed3ffff : pnp 00:0d
  fed40000-fed44fff : pnp 00:0a
  fed45000-fed8ffff : pnp 00:0d
feda0000-feda5fff : reserved
  feda0000-feda3fff : pnp 00:0d
  feda4000-feda4fff : pnp 00:0d
  feda5000-feda5fff : pnp 00:0d
feda6000-feda6fff : pnp 00:0d
fee00000-fee0ffff : reserved
  fee00000-fee0ffff : pnp 00:0d
    fee00000-fee00fff : Local APIC
ffa00000-ffbfffff : pnp 00:0d
ffc00000-ffdfffff : PCI Bus 0000:0b
ffe00000-ffffffff : reserved
  ffe00000-ffffffff : pnp 00:0d
100000000-11fffffff : System RAM
fffa00000-fffbfffff : PCI Bus 0000:09
fffc00000-fffdfffff : PCI Bus 0000:0c
fffe00000-fffffffff : PCI Bus 0000:0b

--=-y4tNaSRrkuxfTJq28KCQ
Content-Disposition: attachment; filename=iomem.test
Content-Type: text/plain; name=iomem.test
Content-ID: <0>
Content-Transfer-Encoding: 7bit

00000000-0000ffff : reserved
00010000-0009efff : System RAM
0009f000-0009ffff : reserved
000c0000-000c7fff : Video ROM
000cf000-000cffff : Adapter ROM
000f0000-000fffff : System ROM
00100000-df65a7ff : System RAM
  01000000-0136ddbd : Kernel code
  0136ddbe-0169127f : Kernel data
  0172f000-01809fff : Kernel bss
df65a800-dfffffff : reserved
  df65a800-df6fffff : pnp 00:0e
  df700000-df7fffff : pnp 00:0e
e0000000-efffffff : PCI Bus 0000:03
  e0000000-efffffff : PCI Bus 0000:04
    e0000000-efffffff : 0000:04:00.0
f0000000-f0000fff : Intel Flush Page
f6700000-f68fffff : PCI Bus 0000:03
  f6700000-f68fffff : PCI Bus 0000:04
    f67dc000-f67dffff : 0000:04:00.1
      f67dc000-f67dffff : ICH HD audio
    f67e0000-f67fffff : 0000:04:00.0
    f6800000-f681ffff : 0000:04:00.0
f6900000-f69fffff : PCI Bus 0000:09
  f69f0000-f69fffff : 0000:09:00.0
    f69f0000-f69fffff : tg3
f6a00000-f6bfffff : PCI Bus 0000:0d
f6c00000-f6cfffff : PCI Bus 0000:0c
  f6cfe000-f6cfffff : 0000:0c:00.0
    f6cfe000-f6cfffff : iwl4965
f6dfb700-f6dfb7ff : 0000:00:1f.3
f6dfb800-f6dfbfff : 0000:00:1f.2
  f6dfb800-f6dfbfff : ahci
f6dfc000-f6dfffff : 0000:00:1b.0
  f6dfc000-f6dfffff : ICH HD audio
f6e00000-f6efffff : 0000:00:02.0
f6f00000-f6ffffff : 0000:00:02.1
f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
  f8000000-fbffffff : reserved
    f8000000-fbffffff : pnp 00:0e
fec00000-fec0ffff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
  fed00000-fed003ff : pnp 00:08
fed18000-fed1bfff : reserved
  fed18000-fed1bfff : pnp 00:0e
fed1c000-fed1c3ff : 0000:00:1d.7
  fed1c000-fed1c3ff : ehci_hcd
fed1c400-fed1c7ff : 0000:00:1a.7
  fed1c400-fed1c7ff : ehci_hcd
fed20000-fed8ffff : reserved
  fed20000-fed3ffff : pnp 00:0e
  fed40000-fed44fff : pnp 00:0b
  fed45000-fed8ffff : pnp 00:0e
feda0000-feda5fff : reserved
  feda0000-feda3fff : pnp 00:0e
  feda4000-feda4fff : pnp 00:0e
  feda5000-feda5fff : pnp 00:0e
feda6000-feda6fff : pnp 00:0e
fee00000-fee0ffff : reserved
  fee00000-fee0ffff : pnp 00:0e
    fee00000-fee00fff : Local APIC
ffa00000-ffbfffff : pnp 00:0e
ffc00000-ffdfffff : PCI Bus 0000:0b
ffe00000-ffffffff : reserved
  ffe00000-ffffffff : pnp 00:0e
100000000-11fffffff : System RAM
fef800000-fef9fffff : PCI Bus 0000:09
fefa00000-fefbfffff : PCI Bus 0000:0d
fefc00000-fefdfffff : PCI Bus 0000:0c
fefe00000-fefffffff : PCI Bus 0000:0b
ff0000000-fffffffff : 0000:00:02.0

--=-y4tNaSRrkuxfTJq28KCQ--

