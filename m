Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33022 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbeFBRnC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 2 Jun 2018 13:43:02 -0400
Date: Sat, 2 Jun 2018 19:42:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: bhelgaas@google.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Check for PCIe downtraining conditions
Message-ID: <20180602174259.GA14870@amd>
References: <20180531150535.9684-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
In-Reply-To: <20180531150535.9684-1-mr.nuke.me@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-05-31 10:05:33, Alexandru Gagniuc wrote:
> PCIe downtraining happens when both the device and PCIe port are
> capable of a larger bus width or higher speed than negotiated.
> Downtraining might be indicative of other problems in the system, and
> identifying this from userspace is neither intuitive, nor straigh
> forward.
> Instead, check for such conditions on device probe, and print an
> appropriate message.
>=20

> +	if (dev_cur_width < max_link_width) {
> +		/* Lanes might not be routed, so use info instead of warn. */
> +		pci_info(dev, "PCIe downtrain: Port and device capable of x%d, but lin=
k running at x%d",
> +			 max_link_width, dev_cur_width);
> +	}

Would "warn" be right loglevel?
									Pavel
								=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsS1yMACgkQMOfwapXb+vLn9wCeLrJpI37mN9luuXqrNZ6OhyAH
nz4AoLLXIXxQqAtoiW4dNmxIXCI70hEi
=sEfL
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
