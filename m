Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:23306 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755694Ab2DORcG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Apr 2012 13:32:06 -0400
Message-ID: <4F8B0609.8010603@snewbury.org.uk>
Date: Sun, 15 Apr 2012 18:31:53 +0100
From: Steven Newbury <steve@snewbury.org.uk>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: "Barnes, Jesse" <jesse.barnes@intel.com>,
	Dave Airlie <airlied@linux.ie>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	DRI mailing list <dri-devel@lists.freedesktop.org>
Subject: Re: PCI resources above 4GB
References: <1333968563.5678.19.camel@infinity> <4F848357.3060007@snewbury.org.uk> <CAE9FiQXTgh3X4x+xD1T0ipsEbhbPtctYucfGeuWK=cq7kHeZ1Q@mail.gmail.com> <4F848E10.1090703@snewbury.org.uk> <CAE9FiQXvwYrJhLi91VDVtD4+OOfbGQ1U20-Cap+8tBZUt7QCkA@mail.gmail.com> <1334089568.4083.2.camel@Nokia-N900> <CAE9FiQWnvB2VbBQQaEnDE0nf+Zwy6nyoGrEuVrUesQEzgYfbvA@mail.gmail.com> <4F84A3EC.6030903@snewbury.org.uk> <CAE9FiQU+EEtBWrc66Sw4GFQjSy9Vh9fyFvhgQUheev_aVpAzrw@mail.gmail.com> <1334229754.30606.7.camel@Nokia-N900> <CAE9FiQXhzAOErMeQxz6U-BSYAK1LirHMpiFH90iRoXxwduPhPw@mail.gmail.com> <1334248841.2910.6.camel@Nokia-N900> <4F89B5E8.3040906@snewbury.org.uk> <4F89BC84.50308@snewbury.org.uk> <4F89C513.3000006@snewbury.org.uk> <4F89CB16.2000908@snewbury.org.uk> <4F89CE43.7040200@snewbury.org.uk> <CAE9FiQVwDNM9MkqG_g139LDf6Ypjx0uygzVqosDe=fF=c_Y3gA@mail.gmail.com> <4F8AA0DC.6010902@snewbury.org.uk> <4F8AB312.7060606@snewbury.org.uk> <4F8B04A4.4070507@snewbury.org.uk>
In-Reply-To: <4F8B04A4.4070507@snewbury.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 15/04/12 18:25, Steven Newbury wrote:
> On 15/04/12 12:37, Steven Newbury wrote:
>> On 15/04/12 11:20, Steven Newbury wrote:
>>> On 14/04/12 21:48, Yinghai Lu wrote:
> 
> [snip]
> 
>>>> On Sat, Apr 14, 2012 at 12:21 PM, Steven Newbury
> 
>>>>>> 
>>>>>> pci 0000:03:08.0: BAR 15: can't assign mem pref (size 
>>>>>> 0x18000000)
>>>>> Ah! Not enough space for the bridge window!:(
>>>>> 
> 
>>>> please append pci=norom ...
> 
>>> That worked.  Except of course the radeon driver can't POST the
>>>  card without the ROM! :-P
>> Can the ROM resource be mapped above 4G?
> I didn't really think that through, obviously it can't because
> it's not on a 64-bit capable bridge.  I wonder though, could it be
> shadowed then disabled early before the IOMEM?
I see there's "#if 0"'d helper functions for exactly that in rom.c.
They've been disabled since 2007!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+LBgkACgkQGcb56gMuC61NGgCeJoZY9iUXeM6GuhDAntEjVrAu
rsUAoIROJFA5xBrZ9qzYQTGSf7lTJUTA
=lofL
-----END PGP SIGNATURE-----
