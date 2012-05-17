Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from queueout04-winn.ispmail.ntl.com ([81.103.221.58]:39222 "EHLO
	queueout04-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932283Ab2EQQGG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 May 2012 12:06:06 -0400
Message-ID: <4FB4F039.2040308@snewbury.org.uk>
Date: Thu, 17 May 2012 13:34:01 +0100
From: Steven Newbury <steve@snewbury.org.uk>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: linux-pci@vger.kernel.org,
	DRI mailing list <dri-devel@lists.freedesktop.org>
Subject: Re: PCI resources above 4GB
References: <1333968563.5678.19.camel@infinity> <CAE9FiQXhzAOErMeQxz6U-BSYAK1LirHMpiFH90iRoXxwduPhPw@mail.gmail.com> <1334248841.2910.6.camel@Nokia-N900> <4F89B5E8.3040906@snewbury.org.uk> <4F89BC84.50308@snewbury.org.uk> <4F89C513.3000006@snewbury.org.uk> <4F89CB16.2000908@snewbury.org.uk> <4F89CE43.7040200@snewbury.org.uk> <CAE9FiQVwDNM9MkqG_g139LDf6Ypjx0uygzVqosDe=fF=c_Y3gA@mail.gmail.com> <4F8AA0DC.6010902@snewbury.org.uk> <4F8AB312.7060606@snewbury.org.uk> <4F8B04A4.4070507@snewbury.org.uk> <4F8B0609.8010603@snewbury.org.uk> <CAE9FiQUsQjUNeW1sa_mQL6MEaDhxvoMhFaN9wLPAqOXzh+AXPQ@mail.gmail.com> <CAE9FiQVzC2YCkXtFDPkCMVMcMqt9c0t8hKVvpgFpwjRdBen0Uw@mail.gmail.com> <CAE9FiQX7iVYZSoEJVVHJTx1gUSKh6RP+iJRGJqMZmDgkFDnPQQ@mail.gmail.com> <CAE9FiQXrF+o9UW-J+UDSN3OR4SOWWAZwJbH=39k4xFf2m-Jd9A@mail.gmail.com> <4F96770D.2050606@snewbury.org.uk> <4FB227D3.7090002@snewbury.org.uk> <CAE9FiQX48eCS85eWMFxm6fCWgu2zwxvSywtQhsf-35WEvBfJVQ@mail.gmail.com> <4FB4EE99.10509@snewbury.org.uk>
In-Reply-To: <4FB4EE99.10509@snewbury.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 17/05/12 13:27, Steven Newbury wrote:
> On 15/05/12 18:42, Yinghai Lu wrote:
>> On Tue, May 15, 2012 at 2:54 AM, Steven Newbury 
>> <steve@snewbury.org.uk> wrote:
> 
>>> I'll get re-synced back up, and if they're still relevant give 
>>> the patches a test.  Is there an updated branch I should work 
>>> from?
> 
>> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
>
>> 
> 
> for-pci-res-alloc
> 
>> and attached patch.
> 
>> Thanks
> 
>> Yinghai
> 
> Hi Yinghai, I also cherry-picked the pref_bar patch and my local
> "Intel Flush Page" patch.
> 
> It boots, and the Intel GMA is allocated >4G, but the radeon
> doesn't get detected with "for-pci-res-alloc" on hotplug (needs
> busn-alloc patches),
Strange, the busn branch is merged with for-pci-res-alloc, but for
some reason it isn't working.  Only the bridge is detected, not the
devices behind it.

so I can't test it.  Booting docked, then undocking/docking
> does work though.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+08DkACgkQGcb56gMuC62miwCgv7nU/Uf3CccBwbqFLHTQL2Zp
wygAoLsYma5GaAVHorCRxjS5v6Hw2fQx
=bGut
-----END PGP SIGNATURE-----
