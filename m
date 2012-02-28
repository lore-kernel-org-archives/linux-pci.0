Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy6-pub.bluehost.com ([67.222.54.6]:57386 "HELO
	oproxy6-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030256Ab2B1TJw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Feb 2012 14:09:52 -0500
Date: Tue, 28 Feb 2012 11:09:42 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, linux-pci@vger.kernel.org,
	Svante Signell <svante.signell@telia.com>
Subject: Re: [PATCH] x86/PCI: use host bridge _CRS info on MSI MS-7253
Message-ID: <20120228110942.3eb0cbdc@jbarnes-desktop>
In-Reply-To: <20120228185110.16227.58753.stgit@bhelgaas.mtv.corp.google.com>
References: <20120228185110.16227.58753.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/gwyYIJoV7bfu4DP.f1F4KmP"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/gwyYIJoV7bfu4DP.f1F4KmP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Feb 2012 11:51:10 -0700
Bjorn Helgaas <bhelgaas@google.com> wrote:

> From: Jonathan Nieder <jrnieder@gmail.com>
>=20
> In the spirit of commit 29cf7a30f8a0 ("x86/PCI: use host bridge _CRS
> info on ASUS M2V-MX SE"), this DMI quirk turns on "pci_use_crs" by
> default on a board that needs it.
>=20
> This fixes boot failures and oopses introduced in 3e3da00c01d0
> ("x86/pci: AMD one chain system to use pci read out res").  The quirk
> is quite targetted (to a specific board and BIOS version) for two
> reasons:
>=20
>  (1) to emphasize that this method of tackling the problem one quirk
>      at a time is a little insane
>=20
>  (2) to give BIOS vendors an opportunity to use simpler tables and
>      allow us to return to generic behavior (whatever that happens to
>      be) with a later BIOS update
>=20
> In other words, I am not at all happy with having quirks like this.
> But it is even worse for the kernel not to work out of the box on
> these machines, so...

Applied to my for-linus branch, thanks.

--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/gwyYIJoV7bfu4DP.f1F4KmP
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPTSZ2AAoJEIEoDkX4Qk9htGMP/0ipncNRIDGYiGE1HMlgGuia
PY3q9+AH+8ZgWMDI8bmOL4CK2TGFR94TuFK+kcKyRO0THlCwxGOty+jMdnsNwO0I
CYSXufA4x0zIEkEAXedfMYk+f3dP4UK+Ya/tXDDzSrqg7/NAFGv4ISeXPAtFCm6v
ym9OlR+5hBmUfrinbeLuR+jyUatGYtOGjJO3ARgltFkUT0wY+PAoqc2wB5fguZYt
e2cgfbZ77/wO/iTE82WhxZedrgm6ncMIYweneAH2pVpSOACS5hTuxPWZ4ZqsuxYE
KIv+EAJY/bTPhmC2wQ4fSNyrBzK6fNWmEvLsxcEXqd2MBLzrcTO2JQWD8vpHl1+l
zoimJneHD0VYFKDJfvzWD0sbPn1u9fkwNpSF+2kLEu4puDn5xTF3LXf6IOYIPkKT
qxIejkxBAhZjr4bsdoPgpUw8OChihihjPcZQTkjrFKSOCqzuDM4Ikt8Utqh9apKS
+yrsQnozFmnTRT+/FXiF3pS5E2ljEREAqVoVbm+i40korxyRd9Jv0cZUOwbQTZzg
4mVYHojmDGdYV/QiObpKirG0coy7xHYxHF9vC7Wav6ku/ub/MnwKnqjGHf6KBrUG
7D9s4q9rzSY8s3UVwMdssfyTUWW0YfAN93dLoyaI7NvldQ7m+Gk8KJSxvvcjsaew
vNtKlVPJxEP0GoUJa64F
=L4LZ
-----END PGP SIGNATURE-----

--Sig_/gwyYIJoV7bfu4DP.f1F4KmP--
