Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:64644 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932185Ab2HOUBV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Aug 2012 16:01:21 -0400
Date: Wed, 15 Aug 2012 22:01:16 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 01/10] PCI: Keep pci_fixup_irqs() around after init
Message-ID: <20120815200116.GB12870@avionic-0098.mockup.avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <1343332512-28762-2-git-send-email-thierry.reding@avionic-design.de>
 <CAErSpo7v+i8i=mXCs7ZW8DtGTDN_4AEntwYLqGG8FcCzweySFg@mail.gmail.com>
 <20120815192814.GA12870@avionic-0098.mockup.avionic-design.de>
 <CAErSpo6cjOzJegJqXzmk59DChExcbLK1sOhwyAyQL4FZkTN21A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
In-Reply-To: <CAErSpo6cjOzJegJqXzmk59DChExcbLK1sOhwyAyQL4FZkTN21A@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 15, 2012 at 01:42:39PM -0600, Bjorn Helgaas wrote:
> On Wed, Aug 15, 2012 at 1:28 PM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > On Wed, Aug 15, 2012 at 10:06:27AM -0700, Bjorn Helgaas wrote:
> >> On Thu, Jul 26, 2012 at 12:55 PM, Thierry Reding
> >> <thierry.reding@avionic-design.de> wrote:
> >> > When using deferred driver probing, PCI host controller drivers may
> >> > actually require this function after the init stage.
> >> >
> >> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> >> > ---
> >> > Changes in v3:
> >> > - none
> >> >
> >> > Changes in v2:
> >> > - use __devinit annotations
> >>
> >> Your original patch removed __init completely.  Here you change it to
> >> __devinit.  That means we decide whether to discard the function based
> >> on whether CONFIG_HOTPLUG is supported.  But I think your point is not
> >> about hotplug; it's merely that we should be able to scan a PCI bus
> >> after init-time.  We ought to be able to do a late PCI scan even if
> >> hotplug is not supported.
> >>
> >> Therefore, I'd be inclined to remove __init completely unless you have
> >> another reason for preferring __devinit.
> >
> > I thought __devinit would resolve to nothing if HOTPLUG is defined and
> > __init otherwise. That seemed more appropriate. However you are right
> > that it is useful to always have it available, so I'm fine with removing
> > the annotations altogether. Do you want me to follow up with a patch? Or
> > can you just take the first version? I'm not sure if it still applies.
>=20
> You're right about how __devinit works.  It's just that I don't think
> hotplug is actually relevant here.  We're trying to make
> pci_fixup_irqs() work after init, whether it's because of hotplug or
> simply because the arch scans host bridges after init.
>=20
> I applied this to my "next" branch.  Thanks!

Great! Thanks. It's nice to see the patch series shrink. =3D)

Thierry

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQLAAMAAoJEN0jrNd/PrOhEFIQAK3kNbIdYxs1GMd5vMRm1V67
ZJLdqBv9G5dwO/ryCmnVI2ZZeG5H1TD3CizzPkN/8ANRRx5lbicoY4Rxu1QsbsCR
8z29tUliIry8e6GrakucgzEMVNRas49pPxS6eBzwzZ6Xk+cWTD4dbyqrDJqRMent
ZSjXFVPprvEJA3IO6Nz7GGVgiNODweBSjHLzTusY/RDrcoPe+9FhEqqXiuXju/wQ
XfMG5zXLS8gxq4NK5RH9QYcsOswElrnkthcReTG+4HlyNWXpytrgxsUg8ASxw9co
hx8Dy/OYaVutUdqO9ky6v8J9rp7p7xvGl8ynNLqsoHzdDmz2c0A+G4rD2NoBg1Y4
ribx5tvhXRD9FVUZc4tqsgcikqFKuP5YQwwJgYMzBYT4amZCNrwl/kdQ3UZXFemq
nLQroeX53Nuka/Rew1igtHaMaFYIgN0ZruG7cGe1SAS+/9ULUHvaPCbbXu4CvoQD
T8lMjXadFaS28UMdb0rfI+mNVHIw/4ZYE2N3h2W3a4US+Ha6dnwtvbRCXpnqbHy2
zPnDEHORCvLFfnP0D4yu/KhOYRj+qEwBYPRsZxOukzwCaD8EHTwipRrvc9X28Czz
vB4hwu90qA2bSycvgPICDirtmog862lztqr1P5UwuTXJaihWeVG7jvIVojc6ehxJ
mtcihxwgvpXpqoeh9qhD
=MNUd
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
