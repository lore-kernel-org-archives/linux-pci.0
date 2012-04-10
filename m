Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:61379 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753366Ab2DJTA6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Apr 2012 15:00:58 -0400
Message-ID: <4F848357.3060007@snewbury.org.uk>
Date: Tue, 10 Apr 2012 20:00:39 +0100
From: Steven Newbury <steve@snewbury.org.uk>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: PCI resources above 4GB
References: <1333968563.5678.19.camel@infinity> <CAErSpo7hGvJSmq4U37XN9T7ZaYn55fyy9t3ER5BBCDdQ3XZxqw@mail.gmail.com> <4F84110E.3000400@snewbury.org.uk> <CAE9FiQVHf_pcXUspOtLXx4XminmzdWja3Ra2Wh5jQRbfNOQ1eQ@mail.gmail.com> <4F8467AA.90305@snewbury.org.uk> <CAE9FiQWaop0NE7ZJu6jVW3SnxLkOJ9hRKh4xMNk64XjCAMRMMw@mail.gmail.com>
In-Reply-To: <CAE9FiQWaop0NE7ZJu6jVW3SnxLkOJ9hRKh4xMNk64XjCAMRMMw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/04/12 19:40, Yinghai Lu wrote:
> On Tue, Apr 10, 2012 at 10:02 AM, Steven Newbury
> <steve@snewbury.org.uk> wrote:
>> 
>>> 
>>> Can you please try attached patches with pci=nocrs?
>>> 
>>> for pci=use_crs, we need find safe place beyond _CRS, because
>>> your _CRS limit under 4g.
>>> 
> ..
>> So far it has changed behaviour:
>> 
>> Many devices now assigned above 4g.
>> 
>> When booted while docked i915 fails to initialise, along with
>> radeon as before.
>> 
>> When undocked i915 initialises, but radeon still fails when
>> hot-docked.
>> 
>> I've attached output of 'lspci -vvv', 'cat /proc/iomem', and
>> "dmesg.log" for the docked case.
>> 
>> Also, "dmesg-hotplug.out" for hot docking after boot.
> 
> looks good,  please only apply
> 
> allocate_high_at_first.patch
> 
> Yinghai

Seems to be exactly the same.  When started docked (so I think both
'cards' try to claim the same preferred addresses) the integrated i965
GFX gets reassigned high:
120000000-12fffffff : 0000:00:02.0

But it's quite possible the i915 module doesn't currently handle this
case and so fails to initialise.

I'm not sure why the Radeon doesn't get assigned a high address when
hot-plugged..?

These are the only entries in /proc/iomem above 4GB:


Booted UNDOCKED, then hot-docked

100000000-11fffffff : System RAM
120000000-1201fffff : PCI Bus 0000:0b
120200000-1203fffff : PCI Bus 0000:0c
120400000-1205fffff : PCI Bus 0000:09


Booted DOCKED

100000000-11fffffff : System RAM
120000000-12fffffff : 0000:00:02.0
130000000-1301fffff : PCI Bus 0000:0b
130200000-1303fffff : PCI Bus 0000:0c
130400000-1305fffff : PCI Bus 0000:0d
130600000-1307fffff : PCI Bus 0000:09
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+Eg1cACgkQGcb56gMuC61hTgCeLIPkAEr1btlgzwmmGAqbnPZq
/CEAn16oEFbgvWH0ifOL0FFiQTodBf1U
=JBs3
-----END PGP SIGNATURE-----
