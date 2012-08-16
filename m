Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:54421 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384Ab2HPS1W (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Aug 2012 14:27:22 -0400
Date: Thu, 16 Aug 2012 20:27:03 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 05/10] resource: add PCI configuration space support
Message-ID: <20120816182703.GA31005@avionic-0098.mockup.avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <1343332512-28762-6-git-send-email-thierry.reding@avionic-design.de>
 <CAErSpo4qg45brVRwEbw3=R04VsbnvUowSMWcT+M6VoAxbf3Cqg@mail.gmail.com>
 <20120814055542.GB16181@avionic-0098.mockup.avionic-design.de>
 <CAErSpo6LYpkC5wop53S1r1z3ov4+w4soqrQARzbbouVs1trzUg@mail.gmail.com>
 <20120814180142.GA9430@avionic-0098.mockup.avionic-design.de>
 <CAErSpo4Efy-Dt67rktzNiYfZfOTSu=pmYtyGd3tR-zZQ3jDGtA@mail.gmail.com>
 <20120815064902.GB15665@avionic-0098.mockup.avionic-design.de>
 <502D0F3C.4010308@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
In-Reply-To: <502D0F3C.4010308@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 16, 2012 at 09:18:20AM -0600, Stephen Warren wrote:
> On 08/15/2012 12:49 AM, Thierry Reding wrote:
> ...
> > Stephen: Could you try to find out whether the regular
> > configuration space translation can just be omitted if we already
> > set up the one for the extended configuration space? In
> > tegra_pcie_setup_translations(), BAR 0 is setup for regular
> > configuration space (which requires a 16 MiB region), while BAR 1
> > is setup for the extended configuration space (requiring a full 256
> > MiB region). However, if I understand correctly, each of the
> > registers that can be accessed via the BAR 0 translation can also
> > be accessed via the BAR 1 translation. That seems like we're=20
> > wasting the 16 MiB set aside for the BAR 0 mapping.
>=20
> I have confirmed that in theory, the EXTCFG space can indeed be used
> to access any register, making the regular config space redundant.
> However, using the HW this way has apparently received less validation.

Okay. I wasn't expecting anything else really. I'll give this a try next
time I get my hands on some Tegra hardware. If that works maybe we
should make up for the missing validation by testing this more
thoroughly.

Thierry

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQLTt3AAoJEN0jrNd/PrOh57QP/2WauFMNuvW/b7vsckbS+H2P
r+pAbulRkCGqphnhol9UGf4kEHrCOsyeGiHbKHbqqhT4945VOkWnHf4T8IMGsP5q
bkUnKU6Tl1Dv2TFTSerWeMfu6L3y1eQzVgKsYOTJ7NiHH7p8D2Lnn4Sg9TxR7f70
JRzJEEzKV9gtglg0+4+spTvRbNL5UT+quYqSbmHrXdQ8gT3mrxdlOmcGtNH4Ncoq
aEShNayR/aqX5/zt8tO9nDpzZxyyjhXEzyl/3oNivPlZQagjFIQnvaBi8WcUS+0r
026w30bzUlnHnsL2E5ulMyjav5mblix+K5Xi0zy43bvImjC2Z62BBGOZjIf2S6Sl
fL0RMvQKDPyNTcm1ftMTtw39XEOfBAUEpR8Y/e5WyWHP5Xo5175zXx9+acyjB9yr
ezXjgVAMufVJ8YgBGiA0iHWinH/Jei6javQWX0rHf7mcI96giv8yyLLn9IiYgA3v
st7vRKJc/BdLaEQQMumExqdq5AAWOap0prpZFP+ibxO5EGxnDLk3GbPvZk67TvG4
5VxxCredNtMq/niK1qM7WcgBszi6WmlrY0VaP28RUpanEAE01+Piu03BK7oumHAC
2ee8YjgfyYVXtIrIjKG2T9UKZSVM4wkwIelfEUaA10A/57HOSS+OwBU5iRf075VZ
TW7JqZbTgSspQnFqZm/Z
=nuaA
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
