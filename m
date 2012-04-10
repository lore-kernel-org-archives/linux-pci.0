Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:45432 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754732Ab2DJVUF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Apr 2012 17:20:05 -0400
Message-ID: <4F84A3EC.6030903@snewbury.org.uk>
Date: Tue, 10 Apr 2012 22:19:40 +0100
From: Steven Newbury <steve@snewbury.org.uk>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: PCI resources above 4GB
References: <1333968563.5678.19.camel@infinity> <CAErSpo7hGvJSmq4U37XN9T7ZaYn55fyy9t3ER5BBCDdQ3XZxqw@mail.gmail.com> <4F84110E.3000400@snewbury.org.uk> <CAE9FiQVHf_pcXUspOtLXx4XminmzdWja3Ra2Wh5jQRbfNOQ1eQ@mail.gmail.com> <4F8467AA.90305@snewbury.org.uk> <CAE9FiQWaop0NE7ZJu6jVW3SnxLkOJ9hRKh4xMNk64XjCAMRMMw@mail.gmail.com> <4F848357.3060007@snewbury.org.uk> <CAE9FiQXTgh3X4x+xD1T0ipsEbhbPtctYucfGeuWK=cq7kHeZ1Q@mail.gmail.com> <4F848E10.1090703@snewbury.org.uk> <CAE9FiQXvwYrJhLi91VDVtD4+OOfbGQ1U20-Cap+8tBZUt7QCkA@mail.gmail.com> <1334089568.4083.2.camel@Nokia-N900> <CAE9FiQWnvB2VbBQQaEnDE0nf+Zwy6nyoGrEuVrUesQEzgYfbvA@mail.gmail.com>
In-Reply-To: <CAE9FiQWnvB2VbBQQaEnDE0nf+Zwy6nyoGrEuVrUesQEzgYfbvA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/04/12 21:45, Yinghai Lu wrote:
> On Tue, Apr 10, 2012 at 1:26 PM, Steven Newbury
> <steve@snewbury.org.uk> wrote:
>>> 
>> So far I'm concluding the BIOS isn't sane.  Is it possible to
>> define a custom memory map from the linux boot cmdline to set
>> TOP_OF_LOW_MEM?
> 
> The BIOS have MMIO and memory overlapping...
> 
>> 
Another thought, normally the integrated graphics has an "AGP"
aperture of 256M @0xe0000000, which is detected by agpgart-intel, this
will need to be moved up above 4G to free up 0xe0000000 for the
radeon, assuming the "agp_bridge" has a 64bit base register...  I
noticed in my docked dmesg, "AGP aperture is 256M @ 0x20000000", but
the PCI base: "120000000-12fffffff : 0000:00:02.0" so only 32bits have
been set in agpgart-intel.  Explains why i915 wasn't initialised.

>> Obviously, I'd prefer getting everything allocated into the
>> address space available, and working, but if it comes down to it
>> I'd accept a hack like the above if there's no other way.
> 
> Could try to reduce carbus preallocated size.... boot with
> pci=cbmemsize=16M
> 
> Please apply attached patch in addtition to allocate_high_at_first
> 
I'll try first thing tomorrow.  I'm away from the docking station now.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+Eo+wACgkQGcb56gMuC60FOgCgoB9QFZPFKCXs8gG0qJIX9NK3
CacAn1q9D958ql7K+nZrKLNHB86fsnHQ
=vRtc
-----END PGP SIGNATURE-----
