Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy6-pub.bluehost.com ([67.222.54.6]:44143 "HELO
	oproxy6-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751092Ab1KKR5x (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2011 12:57:53 -0500
Date: Fri, 11 Nov 2011 09:58:14 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] msi:  Disable msi interrupts when we initialize a pci
 device
Message-ID: <20111111095814.4c3fc3c9@jbarnes-desktop>
In-Reply-To: <m1y5wj4ftd.fsf@fess.ebiederm.org>
References: <m1y5wj4ftd.fsf@fess.ebiederm.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/C_X3jJI6YJxKbD2.R09VDj_"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/C_X3jJI6YJxKbD2.R09VDj_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Oct 2011 11:46:06 -0700
ebiederm@xmission.com (Eric W. Biederman) wrote:

>=20
> I traced a nasty kexec on panic boot failure to the fact that we had
> screaming msi interrupts and we were not disabling the msi messages at
> kernel startup.  The booting kernel had not enabled those interupts so
> was not prepared to handle them.
>=20
> I can see no reason why we would ever want to leave the msi interrupts
> enabled at boot if something else has enabled those interrupts.  The pci
> spec specifies that msi interrupts should be off by default.  Drivers
> are expected to enable the msi interrupts if they want to use them.  Our
> interrupt handling code reprograms the interrupt handlers at boot and
> will not be be able to do anything useful with an unexpected interrupt.
>=20
> This patch applies cleanly all of the way back to 2.6.32 where I noticed
> the problem.
>=20
> Cc: stable@kernel.org
>=20

Applied to -next because I'm a chicken.

--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/C_X3jJI6YJxKbD2.R09VDj_
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJOvWI2AAoJEIEoDkX4Qk9hWt0P/2QTRVNyZSiMnLMqK3ZBduAG
5wXV/+zijfBnN4kQidhKmB9UvLkUFbUHWa7AcAm39BtKarEKUsNGqkRVBMoenz2l
hjPsxzTYRtXMmf4V3ozOzDFlwJIE32mxnJfmJ212V+9VuAkw72s9693xsc0rJeIZ
bcMWM/XIOuODrwI0Z1HZchZPjrCnVa/+BzqibMxFTYAfuFCCojI44RFOJUoKubow
FdZofHZMXC0/XweKWDZeWYQXKR7Kq0IJ5D5EjnJNoTyJ+gBaV2Lfsa2Z5yKt5Ttg
HnhuhqpDMui5pCwpYWLBbTB94PoOYBcT/M3gJ/fsrCrrA5ZaV6wdSGbGMSrn+/+w
eGZdRQADVElxtJEpmin4/b3OkBM4VQSuxuvEhimlMGF+eZdhbkz9J26hNKJEI5p+
RAbxAcciYP/hJJEWeLlYYfwoLwjDN+Sa6zE2g16IotiPHy4gdSsbWIxrrZrczOcf
GNabTp1JzRUZQcvRAyaPyNbbtnJU3yG7+JQCIxt2i+DNEl4ASSF2B+yAn2NczCUU
AxjsSwjYYQrSKRTxQdZiGkHkOWn2F37Eu3h6OXPfWan/IY3dQx+5AsjRi0ULTChG
4qttL8s8QYfFqdM9w/eQX4Rw280akoWBR3anabDUW/yIigUA6q1llNjOXwd/N6CS
n/JJN749B6MPTQvHAYY/
=DTQW
-----END PGP SIGNATURE-----

--Sig_/C_X3jJI6YJxKbD2.R09VDj_--
