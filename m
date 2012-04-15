Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:49591 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751534Ab2DOLbj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Apr 2012 07:31:39 -0400
Message-ID: <4F8AB183.6070205@snewbury.org.uk>
Date: Sun, 15 Apr 2012 12:31:15 +0100
From: Steven Newbury <steve@snewbury.org.uk>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: "Barnes, Jesse" <jesse.barnes@intel.com>,
	Dave Airlie <airlied@linux.ie>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	DRI mailing list <dri-devel@lists.freedesktop.org>
Subject: Re: PCI resources above 4GB
References: <1333968563.5678.19.camel@infinity> <CAErSpo7hGvJSmq4U37XN9T7ZaYn55fyy9t3ER5BBCDdQ3XZxqw@mail.gmail.com> <4F84110E.3000400@snewbury.org.uk> <CAE9FiQVHf_pcXUspOtLXx4XminmzdWja3Ra2Wh5jQRbfNOQ1eQ@mail.gmail.com> <4F8467AA.90305@snewbury.org.uk> <CAE9FiQWaop0NE7ZJu6jVW3SnxLkOJ9hRKh4xMNk64XjCAMRMMw@mail.gmail.com> <4F848357.3060007@snewbury.org.uk> <CAE9FiQXTgh3X4x+xD1T0ipsEbhbPtctYucfGeuWK=cq7kHeZ1Q@mail.gmail.com> <4F848E10.1090703@snewbury.org.uk> <CAE9FiQXvwYrJhLi91VDVtD4+OOfbGQ1U20-Cap+8tBZUt7QCkA@mail.gmail.com> <1334089568.4083.2.camel@Nokia-N900> <CAE9FiQWnvB2VbBQQaEnDE0nf+Zwy6nyoGrEuVrUesQEzgYfbvA@mail.gmail.com> <4F84A3EC.6030903@snewbury.org.uk> <CAE9FiQU+EEtBWrc66Sw4GFQjSy9Vh9fyFvhgQUheev_aVpAzrw@mail.gmail.com> <1334229754.30606.7.camel@Nokia-N900> <CAE9FiQXhzAOErMeQxz6U-BSYAK1LirHMpiFH90iRoXxwduPhPw@mail.gmail.com> <1334248841.2910.6.camel@Nokia-N900> <4F89B5E8.3040906@snewbury.org.uk> <CAE9FiQW_GWWg6GOjG5q4ufAX0-WX=kTpWjWNY3pUt_3v4ZVLYQ@mail.gmail.com>
In-Reply-To: <CAE9FiQW_GWWg6GOjG5q4ufAX0-WX=kTpWjWNY3pUt_3v4ZVLYQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 15/04/12 04:21, Yinghai Lu wrote:
> On Sat, Apr 14, 2012 at 10:37 AM, Steven Newbury
> <steve@snewbury.org.uk> wrote:
>> I've created a new quirk utilising an extra PCI resource flag to
>> force reallocation of the resource.  It's the first approach I've
>> had any success at.  It does work.  Only "Intel Page Flush" now
>> gets allocated @0xe0000000!
> 
> Maybe we can be more aggressive with pci=pref_bar to reassign all
> pref mem.
> 
> Please check attached patch.
Had the same effect as my patch in allocating the 256MB GMA BAR high.

00000000-0000ffff : reserved
00010000-0009efff : System RAM
0009f000-0009ffff : reserved
000c0000-000c7fff : Video ROM
000cf000-000cffff : Adapter ROM
000f0000-000fffff : System ROM
00100000-df65a7ff : System RAM
  01000000-0136df3d : Kernel code
  0136df3e-0169127f : Kernel data
  0172f000-01809fff : Kernel bss
df65a800-dfffffff : reserved
  df65a800-df6fffff : pnp 00:0d
  df700000-df7fffff : pnp 00:0d
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
fed1d000-fed1dfff : Intel Flush Page
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
fef00000-feffffff : PCI Bus 0000:04
  fefbc000-fefbffff : 0000:04:00.1
    fefbc000-fefbffff : ICH HD audio
  fefc0000-fefdffff : 0000:04:00.0
  fefe0000-feffffff : 0000:04:00.0
ffa00000-ffbfffff : pnp 00:0d
ffc00000-ffdfffff : PCI Bus 0000:0b
ffe00000-ffffffff : reserved
  ffe00000-ffffffff : pnp 00:0d
100000000-11fffffff : System RAM
fef800000-fef9fffff : PCI Bus 0000:09
fefa00000-fefbfffff : PCI Bus 0000:0d
fefc00000-fefdfffff : PCI Bus 0000:0c
fefe00000-fefffffff : PCI Bus 0000:0b
ff0000000-fffffffff : 0000:00:02.0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+KsYMACgkQGcb56gMuC62iIQCfWJ7oLOrcL/88YzalEzIrWY/a
LbgAnjzqkflQKzJVDhs0qQ/gxQ1a9FXH
=/ae3
-----END PGP SIGNATURE-----
