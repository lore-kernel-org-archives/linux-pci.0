Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:59695 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754093Ab2EUR1Z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 May 2012 13:27:25 -0400
Message-ID: <4FBA7AEE.3090402@snewbury.org.uk>
Date: Mon, 21 May 2012 18:27:10 +0100
From: Steven Newbury <steve@snewbury.org.uk>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: linux-pci@vger.kernel.org,
	DRI mailing list <dri-devel@lists.freedesktop.org>
Subject: Re: PCI resources above 4GB
References: <1333968563.5678.19.camel@infinity> <4F89CE43.7040200@snewbury.org.uk> <CAE9FiQVwDNM9MkqG_g139LDf6Ypjx0uygzVqosDe=fF=c_Y3gA@mail.gmail.com> <4F8AA0DC.6010902@snewbury.org.uk> <4F8AB312.7060606@snewbury.org.uk> <4F8B04A4.4070507@snewbury.org.uk> <4F8B0609.8010603@snewbury.org.uk> <CAE9FiQUsQjUNeW1sa_mQL6MEaDhxvoMhFaN9wLPAqOXzh+AXPQ@mail.gmail.com> <CAE9FiQVzC2YCkXtFDPkCMVMcMqt9c0t8hKVvpgFpwjRdBen0Uw@mail.gmail.com> <CAE9FiQX7iVYZSoEJVVHJTx1gUSKh6RP+iJRGJqMZmDgkFDnPQQ@mail.gmail.com> <CAE9FiQXrF+o9UW-J+UDSN3OR4SOWWAZwJbH=39k4xFf2m-Jd9A@mail.gmail.com> <4F96770D.2050606@snewbury.org.uk> <4FB227D3.7090002@snewbury.org.uk> <CAE9FiQX48eCS85eWMFxm6fCWgu2zwxvSywtQhsf-35WEvBfJVQ@mail.gmail.com> <4FB4EE99.10509@snewbury.org.uk> <4FB4F039.2040308@snewbury.org.uk> <CAE9FiQUpdVJeF06BtqOKo448n1oH+AMJyC03FpB13=fOdkwM+w@mail.gmail.com> <CAE9FiQWOoEX3H6V7+c+azm8DJieX8bpXRmsYuOE+ZUDJ-p3-yQ@mail.gmail.com> <CAE9FiQU1Bq3xpo0m_eNwBHoxF+oH=pXpg59hQguf_5GpWytyKg@mail.gmail.com>
In-Reply-To: <CAE9FiQU1Bq3xpo0m_eNwBHoxF+oH=pXpg59hQguf_5GpWytyKg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 18/05/12 10:08, Yinghai Lu wrote:
> On Fri, May 18, 2012 at 12:45 AM, Yinghai Lu <yinghai@kernel.org>
> wrote:
>> On Thu, May 17, 2012 at 9:36 AM, Yinghai Lu <yinghai@kernel.org>
>> wrote:
>>> On Thu, May 17, 2012 at 5:34 AM, Steven Newbury
>>> <steve@snewbury.org.uk> wrote:
>>>> -----BEGIN PGP SIGNED MESSAGE----- Strange, the busn branch
>>>> is merged with for-pci-res-alloc, but for some reason it
>>>> isn't working.  Only the bridge is detected, not the devices
>>>> behind it.
>>> 
>>> Can you post the boot log ? maybe recently reordering patches
>>> applying sequence break it.
>> 
>> Never mind, found the problem.
> 
> updated for-pci-res-alloc branch. please check it.
> 
Tested and working fine now.  Some random update broke gnome-shell, so
couldn't test it straight away.  In the end I gave up fixing it and
reverted to an earlier system snapshot.  btrfs can be very useful! :)

There is an outstanding issue with i915 though.  With the moved BAR
the screen remains blank when i915 loads (should show fbcon) and
doesn't light up until X initialises. (X produces a modeset I assume.)
 After that everything works fine.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+6eu4ACgkQGcb56gMuC61InACfa+SvYmWXxJb3x1YTXOJhQWLE
0HkAoKcKhk7elSx1LIaxVdrxiBZibzDa
=MaOP
-----END PGP SIGNATURE-----
