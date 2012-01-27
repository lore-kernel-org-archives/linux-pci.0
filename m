Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 27 Jan 2012 10:29:41 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: Add iobusn_resource and insert root bus range
 to that tree.
Message-ID: <20120127102941.22eb826f@jbarnes-desktop>
In-Reply-To: <1327360018-10929-2-git-send-email-yinghai@kernel.org>
References: <1327360018-10929-1-git-send-email-yinghai@kernel.org>
	<1327360018-10929-2-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/QdF18X9l4Bvr7ZErsM=vlQr"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/QdF18X9l4Bvr7ZErsM=vlQr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Jan 2012 15:06:55 -0800
Yinghai Lu <yinghai@kernel.org> wrote:

> now only root bus number range is in that tree.
>=20
> later every bus will have extra busn_res, and linked them toghter to iobu=
sn_resource.
>=20
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---

This needs to be split into at least a few patches:
  - one to add the bus resource tracking infrastructure to the core
  - one to add tracking to the core
  - one patch per arch

and acks and tested-bys from the arch folks.

Thanks,
--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/QdF18X9l4Bvr7ZErsM=vlQr
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJPIu0VAAoJEIEoDkX4Qk9hfHkQAK0kfm2pKxZ9WFHknfCbUn3u
zz7VNX3gma6TakbEYSb/Ywlu7m580NR0uPPsicr2GFZyXwHQGVSfclND9PqUaZcP
f3TDaue4TXloK/py1X60qYZlyhp1aLVw0zezqiS90a1ebsSYGdqcLqX1wAFKi1l6
sgvqoyUqP4y48/wStT5FxDUJAVAr7T6UMiUj6Xu6k0WtWDofCW9UqY9Fy+4DGlZL
ZQas4DnUUQkWMKXH2QF8uhdMZ8+MaaiL1Igv2ioIGiV4YOhTIWrPnPXlD1CqmOrs
C/piFYc7AicsUf1bsvaye+U4TfwKkesEIfsS17mBWcvhUU+bNg91ZWRNpZaMX7T8
v5OwrpVQogDZMhwqYRke6TG19r2a4OEuOmmS+tH11/gJHyf06JnxWhqfMd/QShM2
qY/eaRhqBBh4tpzZHCJw9RTg95dRWJlfXB6OnHLdT+voi513nepXuJ1EzGRaK3HX
gJrnQvfKVno5yrvYRIG/UCXYOLs7IPuYqUOGnwv2S4ySOks4PHHb+1Fxz+jWgGpP
fHFG2MAh2T5ynNOLoqAFFa67av2qSjSLUIrxDPcC7xSnBgLZMqtRQBsOR6wENx7q
7vYIDV9HKIBRPluxTUb0TE2w1di7qxszYn+dzKUdyYxymZr8u26MUOgsqa1jBwCC
v2g3+uMijqKsPEHALzx5
=x2h/
-----END PGP SIGNATURE-----

--Sig_/QdF18X9l4Bvr7ZErsM=vlQr--
