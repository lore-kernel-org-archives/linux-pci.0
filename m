Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:44737 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752375AbcAFIft (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 Jan 2016 03:35:49 -0500
Date: Wed, 6 Jan 2016 09:35:36 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org
Subject: Re: [PATCH v2 2/4] PCI: rcar: Support runtime PM link state L1
 handling in pcie-rcar
Message-ID: <20160106083536.GC1525@katana>
References: <1451998831-27705-1-git-send-email-phil.edworthy@renesas.com>
 <1451998831-27705-3-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
In-Reply-To: <1451998831-27705-3-git-send-email-phil.edworthy@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 05, 2016 at 01:00:29PM +0000, Phil Edworthy wrote:
> The R-Car PCIe host controller does not handle L1 ASPM. Instead, the
> hardware needs assistance to transition to L1. When the controller
> has received a PM_ENTER_L1 DLLP, we can't access a card's config regs
> until we have got it out of L1 link state. The host controller will
> handle this as long as it has also been transitioned to L1 link state.
>=20
> So, when attempting a config access, check to see if the card has gone
> into L1, and if so, do the same for the host controller.
>=20
> This is based on a patch by Hien Dang <hien.dang.eb@rvc.renesas.com>
>=20
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> v2:
>  - Use readl_poll_timeout_atomic when waiting until we are in L1.

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWjNHYAAoJEBQN5MwUoCm2Xb8P/3W7WY0HhazK4lCu3hntg3bD
A7sg5yqG2gpHkVVBDYtTRDiKE44vmq2s9yojqeOEPsZVLvRSRG/9xSgDzZoD21xC
1N42kQCrsJWlKEkxxrbI8kABxszDAIBh5ot1nJcXj2/AUywQiV99+23Sz8685KH6
jFh9FZSsUNR596rH64932usA95cGYLvC11GCGQfXa6oeONbkgBMtihba0s5UbxcA
qRpXwkTES9mbPCOA+fp1lF8BRk0ziBnwnwXRagYtK1yjmsdNoKHslznMp6nv8hSF
gOJLZt0p8triVUiATSQ4nwMyhrjPgbiDsd7hn22Oapei7vepNGH8peCkIvwr+k1q
I/I8O+M/YclQQsl2CCoqElJx+x78Aba3u0w5KL9cHPWFU5m7OMvSbUsgr0UY3Lu7
075dYv5+RxLPBRZ63Qve5rnYWTia+IQLglBM6hfNifCO6//9/8yK+K7n7jioGCma
UBqVXkK4uwn6l56RPEaOUa0OwqI0LenEyn75q3+lJTYzX7qfNx21Q4eNG7qUNQG2
bI/amWFB49EormoUbegMKGaO+tYOKQb6ApsShSr/goyhuzrXsWkFSThdIzbRmgVT
gQmIeSm3oOeLFc6EylPkalaJd02vK5XT/SwXhXRfLXow/YB4eSTMMuJnqjPSdbpt
m7L6LTosEv5lYQ6q7J6/
=QxGW
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--
