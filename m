Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:43161 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754257Ab1KRTET (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2011 14:04:19 -0500
Received: by bke17 with SMTP id 17so4552824bke.0
        for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2011 11:04:17 -0800 (PST)
Date: Fri, 18 Nov 2011 21:04:14 +0200
From: Felipe Balbi <balbi@ti.com>
To: Greg KH <greg@kroah.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] DWC3: use module_pci_driver
Message-ID: <20111118190413.GA11736@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
References: <20111118181249.GA29495@kroah.com>
 <20111118181424.GB29495@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
In-Reply-To: <20111118181424.GB29495@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 18, 2011 at 10:14:24AM -0800, Greg KH wrote:
> From: Greg Kroah-Hartman <gregkh@suse.de>
>=20
> This cuts down on the boilerplate code.
>=20
>=20
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Looks good to me. It would be nice to see a similar patch for
dwc3-omap.c moving the platform_driver_register to this new macro :-)

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOxqwtAAoJEIaOsuA1yqREgMgP/1GRE2e/w3JvSaZcfCVqBE+F
8qaAxuHITkIpK8i/Pnc0+lg+Ax4aN1OxJZllSYX6mVAnewNo5G/nw6qvBaTRx+GX
02y5Fs/fYV0G5B2y/RuMSSFA/bp2/Wy5DQEjXNxhWh9JOOatN81mEZ4RVG1rFdso
vH7IM1B1Fy3XxRpkV53L+2NS4vCwoLvLpXj5P541+XuYThSIZnMVuKUca2ojAfIg
+ZnCiTVJQ4yCHZOEkj4bjsS/CKi8OT0jkLMvKtIt3B3sTpqWUmdL43v/9y4PSApQ
XMCAg+70A330ZUconNW5UTPe8mMAwv8zbcB2gdyX4dvznRos6RNXEggF/2+QiCRs
54Q5NkaMcCdA0SNFGwJaBZ8NZC69ajaXicdMv08L83vz/TbKx+OnKLFiKSEA3fkC
jEo8GjH8IpNSVYy1AS5pRnlJcYKoRPIEF6VMrv832spr5HyI02JuKhZuQ0SadhWf
XUFzaBzNqEFSDJthJOb3d8gvcUTQLjovrl07JvLV+f5KMeJwrqz6YTJL86arKWZt
LnyMyLE+e4wNYwZ6a+LfgyGAQAihN5TR+rbBZH+yj4ZZY6ZHZqFxFD8plePzkMpG
OD3shNAlW2JpV2Es6e3IkmU7Qs1vtKewedzh/k/74TlTL888eRTGS6hcADfRvWnE
QzvZOhX51sFU6Tcvq8Vm
=YQCR
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
