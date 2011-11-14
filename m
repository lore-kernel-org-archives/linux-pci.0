Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy6-pub.bluehost.com ([67.222.54.6]:46252 "HELO
	oproxy6-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751191Ab1KNRnT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2011 12:43:19 -0500
Date: Mon, 14 Nov 2011 09:43:55 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Ralf Jung <ralfjung-e@gmx.de>,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH] PCI hotplug: shpchp: don't blindly claim non-AMD 0x7450
 device IDs
Message-ID: <20111114094355.4f1c7f19@jbarnes-desktop>
In-Reply-To: <CAErSpo6KSYqyj_oOVLo=rQFPZhE=CawZrhcF3TJT4sjnev9G+g@mail.gmail.com>
References: <20110823161643.27268.89203.stgit@bhelgaas.mtv.corp.google.com>
	<20110826142424.4757cfe9@jbarnes-desktop>
	<CAErSpo6KSYqyj_oOVLo=rQFPZhE=CawZrhcF3TJT4sjnev9G+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/snDVLI8iyUl1lVllGFAhdnc"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/snDVLI8iyUl1lVllGFAhdnc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Nov 2011 10:37:14 -0700
Bjorn Helgaas <bhelgaas@google.com> wrote:

> On Fri, Aug 26, 2011 at 3:24 PM, Jesse Barnes <jbarnes@virtuousgeek.org> =
wrote:
> > On Tue, 23 Aug 2011 10:16:43 -0600
> > Bjorn Helgaas <bhelgaas@google.com> wrote:
> >
> >> Previously we claimed device ID 0x7450, regardless of the vendor, whic=
h is
> >> clearly wrong. =A0Now we'll claim that device ID only for AMD.
> >>
> >> I suspect this was just a typo in the original code, but it's possible=
 this
> >> change will break shpchp on non-7450 AMD bridges. =A0If so, we'll have=
 to fix
> >> them as we find them.
> >
> > Applied to my for-linus branch, thanks.
>=20
> Jesse, I think this one got lost (at least, I don't see it in the
> current upstream tree).

Thanks for checking; looks like it got lost in my kernel.org transition
somehow.  Queued to for-linus now.

--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/snDVLI8iyUl1lVllGFAhdnc
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJOwVNbAAoJEIEoDkX4Qk9hi+0P/1zLoUts25o+djAlUEsIcACi
TyPgh2R5rYTG0uigDqNM2MowYqg2DEPpGVNSb09OeDCJ/JB1pYlWQWwr3lhmZAVK
gAcUMYcUwNUjATTvaoFP6tetum1O6UrEVpqZGpzlP+Yl4m0SKvrnulPkLOsuwe0w
562pbOzUY/4D4/hphiU5Jz1FAAUSu5iF1Lhfya1fr1XmOz3YZN2BeXt51i8Yl2Bh
i7olhPzrPchuckQVSn7a0U+6F9s56OPibv5qRPbGWrVXAMu6cR4jM3LdIR7R/yWJ
zDz57MvyX+SRFOKEL+INvmgCalEM4CVhOpZDsQ8sCHpwF18thJNleA4J823+uxXd
sLCpGf2yTB3BC2XgSwYENxjP+WyjDZAOsQL2I6NLXgj9G3PQtoyxl0bCtpEXnK/B
WQrcrjxcCY4p4z4+Euixl5M6Jk4RLovhfQtkkCNLyMR5I/4TCo2e6EeG9iDg+wpj
ed85f7Nviv+sAhsesv0AVTWj9dG0p9d4ca6m2kUM4SvOq4AGKlIp3UzbF5dDa/pK
q2LjXQ0IKkb3dqMm8KU3Vhx+MvETWI5erz2jJtTnq4hXrcSwyF6puv8SQEmPH0Jh
n8kR7l2DrUD5SPtuFA2jzO7B+jDEIJTaqPdsiiQxMPEzHrnPFCsxXain8gaswZaP
UbDXnRlj4KFAy1DzLS7F
=QRMO
-----END PGP SIGNATURE-----

--Sig_/snDVLI8iyUl1lVllGFAhdnc--
