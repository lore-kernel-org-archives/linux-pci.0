Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:40323 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753157Ab2DJSpB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Apr 2012 14:45:01 -0400
Message-ID: <4F847F9B.4010500@snewbury.org.uk>
Date: Tue, 10 Apr 2012 19:44:43 +0100
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

Rebuilding... I will let you know in a few minutes.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+Ef5sACgkQGcb56gMuC62zLgCdFzqBa5sU88XIEG2BkSlJnIby
qM8Ani2q1vYAWbx+SP5bYwt6/jQn72lc
=cNKw
-----END PGP SIGNATURE-----
