Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:22853 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752105Ab2DOKTX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Apr 2012 06:19:23 -0400
Message-ID: <4F8AA093.5000206@snewbury.org.uk>
Date: Sun, 15 Apr 2012 11:18:59 +0100
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

I'll give it a go, but not sure if it will work if it causes the GMA
1Mb MEMIO above 4G.  From my testing the i915 driver isn't happy with
that.  Lower part of the framebuffer is corrupted (overlapping
something?), and the Xorg driver fails to initialise (just garbage on
the screen).  Not sure what's happing there, I tried to duplicate your
gma_addr patch for the other 64-bit registers read into gtt_addr and
reg_addr.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+KoJMACgkQGcb56gMuC6056gCcCLtdrliMEudCY32F5Vobz9+I
vc0AnRX0vy6vI9EBtSqxI6KpkHIMQ0o4
=teYN
-----END PGP SIGNATURE-----
