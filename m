Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:64108 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106Ab3FRL0L (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2013 07:26:11 -0400
Received: by mail-bk0-f49.google.com with SMTP id mz10so1697146bkb.8
        for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2013 04:26:09 -0700 (PDT)
Date: Tue, 18 Jun 2013 13:26:04 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Maen Suleiman <maen@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Grant Likely <grant.likely@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/8] irqchip: armada-370-xp: implement MSI support
Message-ID: <20130618112604.GD6322@mithrandir>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370536888-8871-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130612104207.GE30841@mithrandir>
 <20130618104338.584098e1@skate>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZJcv+A0YCCLh2VIg"
In-Reply-To: <20130618104338.584098e1@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--ZJcv+A0YCCLh2VIg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2013 at 10:43:38AM +0200, Thomas Petazzoni wrote:
> Dear Thierry Reding,
>=20
> On Wed, 12 Jun 2013 12:42:40 +0200, Thierry Reding wrote:
> > On Thu, Jun 06, 2013 at 06:41:24PM +0200, Thomas Petazzoni wrote:
> > [...]
> > > @@ -292,6 +454,8 @@ static int __init armada_370_xp_mpic_of_init(stru=
ct device_node *node,
> > > =20
> > >  #endif
> > > =20
> > > +	armada_370_xp_msi_init(node);
> > > +
> >=20
> > So I see that you don't have access to the original platform device
> > here, but you could use of_find_device_by_node() to obtain it and pass
> > that into armada_370_xp_msi_init() in order to set the msi_chip.dev
> > field. Or you could do the lookup in armada_370_xp_msi_init() if you
> > don't need it for anything else in armada_370_xp_mpic_of_init().
>=20
> As I replied to Grant, of_find_device_by_node() returns NULL, I believe
> because the all IRQ controller driver initialization is done pretty
> early, before the of_platform_populate() call is made, so there is no
> platform_device associated with the IRQ controller node at the time the
> armada_370_xp_mpic_of_init() function is called.
>=20
> Do you see another approach, especially in relation to your comment on
> PATCH 2/8 ?

Hmmm, that's too bad. The only other possibility that I see is that you
could associate the struct device at a later point when it becomes
available, but looking at the irqchip driver it doesn't look like you
get notification of that either. I suppose you could add a
platform_driver to it and hook things up in its .probe() callback, but
I'm not sure if that's in line with how the irqchip was designed. Adding
Grant Likely and Thomas Gleixner on Cc, maybe they have better advice.

Looking at other irqchip drivers I find it a bit odd to see how they're
structured, though. We've been preaching for years that drivers should
be well-encapsulated and told everybody it was bad to use globals and
they should be associating driver-specific data with each instance of a
device. Then comes along irqchip and all of a sudden it's okay to use
globals again. It feels a bit fragile.

Thierry

--ZJcv+A0YCCLh2VIg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRwEPMAAoJEN0jrNd/PrOhs28P/1H/gW7o+TkJeFeiI+LyoOHC
AvFVaEEbFv2iVRVZoASw3sUHolG3cxXHF0ZeUY995F7WfUtwDzY9JWDsP1nTEaLB
HMaCl1kI9ZGdYHZy8sHTXFcqJhUs+iQlsGAaeiKf2KdZ8Nb/hJVGcMdHXToi0UHl
JAP4dRwGjJU9AqqqvDSdb7fk+MLLHaY+X3bUc4ifneVLvO5/FlYIdzx8O0w+xPr6
uh3uV7k+DgEkVNGqvv0YaNSo0IG6lee8X01PwtbS8tIiGpl9p1PAYD2hhSSh6EQc
cQnDk8Ahmcz+gMtcpULrK17cpcxrJpL30iBgvpaVo4afccIhAuGauhzG+gWUgNR0
BbviokSzDWDvhxFGeDPuyb9hGrQTUatxRYn/Wpp45r6SlWdiV6KjhJ02SWXq7tnB
Cj1FuWv6MK+D2jAQrKecsycq0YK+SckX+UWOyYmrByao347LtHaswhgcFLu5kOZm
dnNY2XTKjWx9maX8VgxyaysJaJQQYCt7fXmH6U4gqQr9HxEsVK8VkHuuond7YvTX
L+5HH5T4ggOzqp5rMPDrWWKuMCjdOcKCz74+w7XTDiJfgkQoE++9R1ofMaDw7AHm
DIqkOoQKyPG08rCc6Uz3uLDQ5EJguJaTEhkFAb+zAtsSkkWNuv1LtUdLfuIzXFbj
73CREXN9TV2tBMRNQ/kK
=ZSoE
-----END PGP SIGNATURE-----

--ZJcv+A0YCCLh2VIg--
