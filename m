Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:50881 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755079Ab2DKJD4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Apr 2012 05:03:56 -0400
Message-ID: <4F8548E6.6030707@snewbury.org.uk>
Date: Wed, 11 Apr 2012 10:03:34 +0100
From: Steven Newbury <steve@snewbury.org.uk>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: PCI resources above 4GB
References: <1333968563.5678.19.camel@infinity>  <CAErSpo7hGvJSmq4U37XN9T7ZaYn55fyy9t3ER5BBCDdQ3XZxqw@mail.gmail.com>  <4F84110E.3000400@snewbury.org.uk>  <CAE9FiQVHf_pcXUspOtLXx4XminmzdWja3Ra2Wh5jQRbfNOQ1eQ@mail.gmail.com>  <4F8467AA.90305@snewbury.org.uk>  <CAE9FiQWaop0NE7ZJu6jVW3SnxLkOJ9hRKh4xMNk64XjCAMRMMw@mail.gmail.com>  <4F848357.3060007@snewbury.org.uk>  <CAE9FiQXTgh3X4x+xD1T0ipsEbhbPtctYucfGeuWK=cq7kHeZ1Q@mail.gmail.com>  <4F848E10.1090703@snewbury.org.uk>  <CAE9FiQXvwYrJhLi91VDVtD4+OOfbGQ1U20-Cap+8tBZUt7QCkA@mail.gmail.com>  <1334089568.4083.2.camel@Nokia-N900>  <CAE9FiQWnvB2VbBQQaEnDE0nf+Zwy6nyoGrEuVrUesQEzgYfbvA@mail.gmail.com>  <4F84A3EC.6030903@snewbury.org.uk>   <CAErSpo6GTarMUySce+n6x=TtqgfryzA5-88aKwL7L4snDp4MTA@mail.gmail.com> <1334122404.28676.2.camel@Nokia-N900>
In-Reply-To: <1334122404.28676.2.camel@Nokia-N900>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/04/12 06:33, Steven Newbury wrote:

>> In https://bugzilla.kernel.org/show_bug.cgi?id=10461#c12, I think
>> the problem you're seeing is that when you boot while docked,
>> the integrated i915 works, but the radeon in the dock does not.
>> That makes sense to me because they each want 256M of space, and
>> according to your _CRS info, there's only one possible location
>> with that much space (0xe0000000).   Do you happen to know what
>> Windows does in that
> 
> That's why I'm hoping to be able to reallocate the i915 aperture
> above 4GB, but this depends on what the chipset is capable of
> rather than what the BIOS exposes.

I've been reading the datasheets for the 965 chipset, and I've
discovered a few things (from "Intel 965 Express Family Datasheet"):

Section 3.2.3:

"Voids of physical addresses that are not accessible as general system
memory and reside within system memory address range (< TOLUD) are
created for SMM-mode and legacy VGA graphics compatibility. It is the
responsibility of BIOS to properly initialize these regions. Table 3-5
details the location and attributes of the regions.
Enabling/Disabling these ranges are described in the (G)MCH Control
register (GCC register, device 0, offset 52h)."

BIOS must initialise legacy regions < TOLUD (top of low usable DRAM),
it doesn't mention any other strict requirements on memory mappings,
but TOLUD itself, I would assume, is implicitly required to be
configured by the BIOS for everything else to fall into place.

...

Section 3.4 describes the memory reclaim configuration, which enables
remapping of the range of physical memory overlapped by:

•	High BIOS

•	HSEG

•	TSEG

•	Graphics stolen

•	XAPIC

•	Local APIC

•	FSB Interrupts

•	Mbase/Mlimit

•	Memory-mapped I/O space that supports only 32B addressing

It isn't specifically mentioned whether this is reconfigurable, but I
remember reading in a Microsoft document that Windows since 64 bit
Vista can freeze PCI devices and reassign PCI window ranges on device
hot-plug.  I'm not sure whether this comes into play, probably not...

...

Section 3.7 is *particularly* interesting to me:

Graphics Memory Address Ranges

"These ranges can reside above the Top-of-Low-DRAM and below High BIOS
and APIC address ranges or above Top of upper DRAM (TOUUD). They MUST
reside above the top of memory (TOLUD) and below 4 GB _or_above_TOUUD_
so they do not steal any physical DRAM memory space."

According to this section there's no reason the Graphics Aperture Base
can not be above TOUUD.

...

I guess I should read the PCIe specifications; I have read references
to the claim the specifications were developed around Microsoft's
requirements in their implementation since Longhorn (Vista),
specifically removing the 4GB limit (where compatible) when used with
64 bit OSs.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+FSOYACgkQGcb56gMuC63bugCbBZXxiXzNtrC0/qpHyRd6Wwts
Q+cAoLVDTezwPjTLuEpLDUO6ppGEOPI7
=x+g9
-----END PGP SIGNATURE-----
