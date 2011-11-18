Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:35545 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755256Ab1KRTW0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2011 14:22:26 -0500
Received: by mail-fx0-f47.google.com with SMTP id t2so4845783faa.6
        for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2011 11:22:25 -0800 (PST)
Date: Fri, 18 Nov 2011 21:22:22 +0200
From: Felipe Balbi <balbi@ti.com>
To: Greg KH <greg@kroah.com>
Cc: Felipe Balbi <balbi@ti.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] DWC3: use module_pci_driver
Message-ID: <20111118192220.GC11736@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
References: <20111118181249.GA29495@kroah.com>
 <20111118181424.GB29495@kroah.com>
 <20111118190413.GA11736@legolas.emea.dhcp.ti.com>
 <20111118191117.GA25016@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
In-Reply-To: <20111118191117.GA25016@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 18, 2011 at 11:11:17AM -0800, Greg KH wrote:
> On Fri, Nov 18, 2011 at 09:04:14PM +0200, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Fri, Nov 18, 2011 at 10:14:24AM -0800, Greg KH wrote:
> > > From: Greg Kroah-Hartman <gregkh@suse.de>
> > >=20
> > > This cuts down on the boilerplate code.
> > >=20
> > >=20
> > > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > > Cc: Felipe Balbi <balbi@ti.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> >=20
> > Looks good to me. It would be nice to see a similar patch for
> > dwc3-omap.c moving the platform_driver_register to this new macro :-)
>=20
> We already have a platform driver macro in the tree, feel free to move
> it to use it now if you want :)

great, will do for 3.3 merge window.

--=20
balbi

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOxrBsAAoJEIaOsuA1yqRECGMP/1JBdZgpoJjOmBjUV5QfT72t
lyROYEsgpKwQyrEbU/k5+6q9gmna8XMfDiEg+/apE1a8I/xKrkxVLdv/bmOywDCz
qtLIJ/i6oPJVNMBcIhXo6rZv1UWimke6EbvAuYch3SthVK3c3eti0nPBvSW2Q6PK
d7EeWaUBT24XufUbBM67VWZqqxBa2MmzggeRkjLJuE04ZDS6zotjFFRm9gJnf7C8
hborq8hxL7wptXnXJxHgmEH75JOYqGK23iPPT5pFx+C/Yl/26xVgjbKbZmvPtDot
dE0dKNWVDvxYYaw54Z4dc/G9F82eHN6aA47QXAr2k7SMQ9CnUSah2ZKaUXQIACG9
snTFrPZxc4jnHwEIlAQVX2lU4+1UaE1lzu0tEqCxjeIEzUYA28JH+KsF1xaZtD5Z
BvyW3b0g5ObSvxvBGypRL0jBkRU/2+JP/Pnfo89B6kjThBFSxdgg+YXVSDK/a/KS
RN0fTXH+7IdUTVGa2DHCktknnOKAE6FR+QETuecgzzn+83FPUKEDCYIfKCVNGaKU
DDvGxdMSpQcT/AEmjJ2zO+sulSHg/t3w8jOSwGSd/mvFg68ghp8ZvKjXjkMKa8Fy
kgvJKu3ZE1WuCGvrZ0geYI2/reJKMBN4ZqK1oT1HDYS4Yo5i/7v08dkA7JoH02dT
AOgYuFaXFtONXBIKz4bw
=B1pE
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--
