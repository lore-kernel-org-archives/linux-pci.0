Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:45935 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757206Ab3HGHAA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Aug 2013 03:00:00 -0400
Received: by mail-bk0-f44.google.com with SMTP id mz10so443843bkb.17
        for <linux-pci@vger.kernel.org>; Tue, 06 Aug 2013 23:59:59 -0700 (PDT)
Date: Wed, 7 Aug 2013 08:59:56 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Jason Cooper <jason@lakedaemon.net>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCHv6 00/13] MSI support for Marvell EBU PCIe driver
Message-ID: <20130807065954.GA22906@manwe>
References: <1375363516-2620-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130806200256.GB19280@titan.lakedaemon.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
In-Reply-To: <20130806200256.GB19280@titan.lakedaemon.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2013 at 04:02:56PM -0400, Jason Cooper wrote:
> Thomas,
>=20
> In order to get some testing in -next, I've *tentatively* applied this
> series in the following way:
>=20
> +---+ mvebu/msi_common (1,2,3,10)
>     |
>     +---+---+ mvebu/msi_irq (4-9)
>             |
>             +---+---+ mvebu/msi_mvebu (11-13)
>=20
> I had to make one change to patch #9, I protected the last two blocks
> with #ifdef CONFIG_PCI_MSI to prevent a build failure at that point.
>=20
> mvebu/msi_common should be appropriate for Thierry to base off, however,
> I make no guarantees about the stability of the branch until I send a
> PR for it.  Code-wise, it should be fine, but the commit-ids may change
> due to adding Tested-by's, etc.

I noticed that patch 10 has my Reviewed-by, even though my comments
weren't addressed. They were about stylistic issues but I'd still like
to see them fixed now rather than having to fix them up later. Also I
think I gave my Tested-by on those patches somewhere already and I think
it's unlikely that anybody else will test them, so with the consistency
style fixes applied I don't see any reason why that branch can't be
stabilized right away.

Thierry

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSAfBqAAoJEN0jrNd/PrOhPKgQAKSZL7xAfnJiIg1jeRw0KxJZ
sU+fV3AbwZB6xCdulXfgKDmPEfvazbtBCVrjvsjKr45NfYyQnBdQi2RIIIbmFMYc
+MJ4mjbsYrJ5FgKfy/blxdx02dEp0h3HU4Tg5G5J2r87sQc124pkBoSaoH5rYiLA
1CapxUTr96en5/KZgVmYTl/1VNBZTkMqaXqZxbGTyBbdNEL2b7ALDx+GtrVKkmG0
ZUMWwg5PpHyeAxK1VJt7dpAgq0o+WECIIjL+kxW2BQ5C13ctQBdQvgqusrxa+uue
upjJxGdtbtftdTHI0JNzCLRxiWM38oX8AOYRtJWiJ3ToE1cFw17anBrMNmPKlzSC
hXLMYQx0gYfJtYu8j6UrMfS4dmhMRM7BCtQW0a8mp3QOgzBSSNeeCLc3nJzEqZQX
hBHhcggkHTb853khVJgjBgT/wpfnTfDU5vtyoj1FzdEEp6nOILP+B05La6ByRQKJ
2V2BRyUSGlowZdz+hxcl6iN1BWXri7E8HsKXE/C2TS1o7ghKNKd69kYqM2Czd4tg
Qb2D03tb0l3l9KlXhC3OScHdwbuw5mycod91aoxkNpULvmGmpOLdnUd4gmhqHDsB
xCh/xd4cFuqOJ3R2yK+KA61gqKm0puSeFzhNln5+dKNLtNRdqhF7y+i4RNQV6SML
KBBv9vF8kAw8+fD30tK0
=Pz4o
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
