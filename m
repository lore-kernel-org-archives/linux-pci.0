Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy6-pub.bluehost.com ([67.222.54.6]:38065 "HELO
	oproxy6-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932066Ab2CAS5J (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Mar 2012 13:57:09 -0500
Date: Thu, 1 Mar 2012 10:57:01 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Svante Signell <svante.signell@telia.com>,
	Carlos Luna <caralu74@gmail.com>
Subject: Re: [PATCH] x86/PCI: do not tie MSI MS-7253 use_crs quirk to BIOS
 version
Message-ID: <20120301105701.62ad4144@jbarnes-desktop>
In-Reply-To: <20120228213135.GA30986@burratino>
References: <20120228185110.16227.58753.stgit@bhelgaas.mtv.corp.google.com>
	<20120228213135.GA30986@burratino>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/quPdDehs=QSLGjeeuM.d=im"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/quPdDehs=QSLGjeeuM.d=im
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Feb 2012 15:31:35 -0600
Jonathan Nieder <jrnieder@gmail.com> wrote:

> Carlos was getting
>=20
> 	WARNING: at drivers/pci/pci.c:118 pci_ioremap_bar+0x24/0x52()
>=20
> when probing his sound card, and sound did not work.  After adding
> pci=3Duse_crs to the kernel command line, no more trouble.
>=20
> Ok, we can add a quirk.  dmidecode output reveals that this is an MSI
> MS-7253, for which we already have a quirk, but the short-sighted
> author tied the quirk to a single BIOS version, making it not kick in
> on Carlos's machine with BIOS V1.2.  If a later BIOS update makes it
> no longer necessary to look at the _CRS info it will still be
> harmless, so let's stop trying to guess which versions have and don't
> have accurate _CRS tables.
>=20
> Addresses https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D5533
> Also see <https://bugzilla.kernel.org/show_bug.cgi?id=3D42619>.
>=20
> Reported-by: Carlos Luna <caralu74@gmail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---

Applied to my for-linus branch, thanks.

--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/quPdDehs=QSLGjeeuM.d=im
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPT8Z9AAoJEIEoDkX4Qk9hT5gQAIYBALV89mkudohF7uaCKacK
ACpAMrkmgU0wYLKxBrQbG7Lkq75FTU8J5kwX7xH0jALb46LP8Q8hY1VU4A5ihqpU
j18Q848VF3W5yanwlnci5yWjF+7WG7b4+Cd+64noTGBfROqLQz8xrm8WKJ9mLNXV
rZRyPe3RYAUGh08jnPDg4LlZI0t7Jjj4slHO6vgQl1hMBvpXHhZud/ZRt9ZGDqAo
2Z+rALFn1g2Wpgq877uI4uoreHON205Xtb+Akmee+pa++nJhquCLP4M25QToZnyN
W23BZ5coOhxvs0hPVQNuIKQ/TNzfexPwbpaBvgLjL1CLG0I/zciCmhL7kVnqPbbh
r+woGzq0oLwHWCMtXNKCwzJ9qMUfl9BkoaFX5qls0pBHRt/Azm9j5z+u/rfHV8tn
JZFW5SELxvc2q3Mrg/CbQB2vzNhBHEKDz1tSav69AB/0bPkpAD0Lzu+BX8Xtfc3A
ixOoUNXcoahEqNH1R76C+vVjyhdGHxmjopzXDPzTuNdqNW9H363LdvNwGX8vnQEC
o8Fc+/Zx47CC3lTQ/QAuu8yyVBeBaRlGeAtXjclkIzw91WDOYCNnmc/HXkHoNij+
13/IuGdj8aQ4IY/EZ7zilo71Z/VCPok1IFXgG6jDhC0Zn7SBqPH+aOmmI450bbpK
GwDidVUmXGdAj2XnnoHB
=UIY4
-----END PGP SIGNATURE-----

--Sig_/quPdDehs=QSLGjeeuM.d=im--
