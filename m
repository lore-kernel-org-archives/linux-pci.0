Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.sf-mail.de ([62.27.20.61]:52046 "EHLO mail.sf-mail.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756565Ab2ARUEA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 18 Jan 2012 15:04:00 -0500
Received: from dslb-178-003-241-093.pools.arcor-ip.net ([::ffff:178.3.241.93] HELO eto.sf-tec.de) (auth=eike@sf-mail.de)
	by mail.sf-mail.de (Qsmtpd 0.21svn) with (DHE-RSA-AES256-SHA encrypted) ESMTPSA
	for <linux-pci@vger.kernel.org>; Wed, 18 Jan 2012 20:03:57 +0000
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-pci@vger.kernel.org
Subject: Re: PCI card not accessible; I/O ports at <ignored>
Date: Wed, 18 Jan 2012 21:03:25 +0100
Message-ID: <2291613.bPZ67F62Nj@eto>
In-Reply-To: <4F170DDB.3010105@meinberg.de>
References: <4F16EA07.4000607@meinberg.de> <20120118162858.GB22156@kroah.com> <4F170DDB.3010105@meinberg.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart44238330.HKVDQUrspZ"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--nextPart44238330.HKVDQUrspZ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch 18 Januar 2012, 19:22:19 schrieben Sie:
> Greg KH wrote:
> > On Wed, Jan 18, 2012 at 04:49:27PM +0100, Martin Burnicki wrote:
> >> Hi folks,
> >> 
> >> I'm maintaining the driver software for the PCI cards manufactured
> >> by our company, Meinberg Funkuhren in Germany. Basically our Linux
> >> driver supports all our PCI cards on all Linux kernels 2.6.x and
> >> 3.x. The PCI cards are e.g. GPS receivers, radio clocks, or IRIG
> >> time code receivers.
> > 
> > Nice, any reason why these drivers aren't in the main kernel.org tree?
> 
> Yes, you wouldn't like the coding style of our driver ;-)
> 
> Seriously, I have discussed this with some Linux guys before, and also
> with some folks from *BSD who also wanted to pick up the driver into
> their *BSD source trees.

I've had such a driver before. Trust me, it was a great relief once I got rid 
of it because I did not have to maintain the os abstraction layer anymore. And 
many of the lower level functions you need to do by hand for all systems can 
be done with fewer calls on nearly all systems. Just the borders of these 
calls differ between the systems, so you can't abstract this away in the 
wrapper layer.

And noone stops you to have your driver available for older kernel releases 
too. But plugging something in and it just works is just cool ;)

Eike
--nextPart44238330.HKVDQUrspZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEABECAAYFAk8XJZIACgkQXKSJPmm5/E7WaACfYAIk9m73NUGccbfj+qcfZo/M
bLQAnRd2CasQWDCiztgGt8kt1bsXwPtM
=Wbwt
-----END PGP SIGNATURE-----

--nextPart44238330.HKVDQUrspZ--

