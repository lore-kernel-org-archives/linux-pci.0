Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:18694 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751251Ab2DRHVm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Apr 2012 03:21:42 -0400
Message-ID: <4F8E6B70.8020506@snewbury.org.uk>
Date: Wed, 18 Apr 2012 08:21:20 +0100
From: Steven Newbury <steve@snewbury.org.uk>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: "Barnes, Jesse" <jesse.barnes@intel.com>,
	Dave Airlie <airlied@linux.ie>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	DRI mailing list <dri-devel@lists.freedesktop.org>
Subject: Re: PCI resources above 4GB
References: <1333968563.5678.19.camel@infinity> <4F84A3EC.6030903@snewbury.org.uk> <CAE9FiQU+EEtBWrc66Sw4GFQjSy9Vh9fyFvhgQUheev_aVpAzrw@mail.gmail.com> <1334229754.30606.7.camel@Nokia-N900> <CAE9FiQXhzAOErMeQxz6U-BSYAK1LirHMpiFH90iRoXxwduPhPw@mail.gmail.com> <1334248841.2910.6.camel@Nokia-N900> <4F89B5E8.3040906@snewbury.org.uk> <4F89BC84.50308@snewbury.org.uk> <4F89C513.3000006@snewbury.org.uk> <4F89CB16.2000908@snewbury.org.uk> <4F89CE43.7040200@snewbury.org.uk> <CAE9FiQVwDNM9MkqG_g139LDf6Ypjx0uygzVqosDe=fF=c_Y3gA@mail.gmail.com> <4F8AA0DC.6010902@snewbury.org.uk> <4F8AB312.7060606@snewbury.org.uk> <4F8B04A4.4070507@snewbury.org.uk> <4F8B0609.8010603@snewbury.org.uk> <CAE9FiQUsQjUNeW1sa_mQL6MEaDhxvoMhFaN9wLPAqOXzh+AXPQ@mail.gmail.com> <CAE9FiQVzC2YCkXtFDPkCMVMcMqt9c0t8hKVvpgFpwjRdBen0Uw@mail.gmail.com> <CAE9FiQX7iVYZSoEJVVHJTx1gUSKh6RP+iJRGJqMZmDgkFDnPQQ@mail.gmail.com> <CAE9FiQXrF+o9UW-J+UDSN3OR4SOWWAZwJbH=39k4xFf2m-Jd9A@mail.gmail.com>
In-Reply-To: <CAE9FiQXrF+o9UW-J+UDSN3OR4SOWWAZwJbH=39k4xFf2m-Jd9A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 16/04/12 18:29, Yinghai Lu wrote:
> On Sun, Apr 15, 2012 at 11:54 PM, Yinghai Lu <yinghai@kernel.org>
> wrote:
>> On Sun, Apr 15, 2012 at 1:06 PM, Yinghai Lu <yinghai@kernel.org>
>> wrote:
>>>> 3. use pci_bus_allocate_resource in drm/radeon driver ...
>>>> ===> but that could fail. so could hack it like a. disable
>>>> bar 0x10 and steal BAR address, then set 0x30 to that address
>>>> then copy ROM to ram. after that, disable rom again and set
>>>> back address to 0x10. You try to update radeon_get_bios() to
>>>> achieve that.
>> 
>> patches for solution 3: map_rom.patch will try to borrow mem or
>> mem pref bar for ROM copying
>> 
>> and You still need to use pci=norom
> 
> map_rom.patch missed one !
> 
> Please check map_rom_v2.patch

I've been really busy, and I'm going to be mostly unavailable until
Monday.  I will get back to it as soon as I can.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+Oa3AACgkQGcb56gMuC63HogCfWQTdBSlNcj9zwHy9m4duwmHI
A4YAn2bVH1M4BjPxdfzb+AdX7v3wW79Q
=mUxP
-----END PGP SIGNATURE-----
