Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:49296 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360Ab2HOT2f (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Aug 2012 15:28:35 -0400
Date: Wed, 15 Aug 2012 21:28:14 +0200
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
Message-ID: <20120815192814.GA12870@avionic-0098.mockup.avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <1343332512-28762-2-git-send-email-thierry.reding@avionic-design.de>
 <CAErSpo7v+i8i=mXCs7ZW8DtGTDN_4AEntwYLqGG8FcCzweySFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
In-Reply-To: <CAErSpo7v+i8i=mXCs7ZW8DtGTDN_4AEntwYLqGG8FcCzweySFg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 15, 2012 at 10:06:27AM -0700, Bjorn Helgaas wrote:
> On Thu, Jul 26, 2012 at 12:55 PM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > When using deferred driver probing, PCI host controller drivers may
> > actually require this function after the init stage.
> >
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > ---
> > Changes in v3:
> > - none
> >
> > Changes in v2:
> > - use __devinit annotations
>=20
> Your original patch removed __init completely.  Here you change it to
> __devinit.  That means we decide whether to discard the function based
> on whether CONFIG_HOTPLUG is supported.  But I think your point is not
> about hotplug; it's merely that we should be able to scan a PCI bus
> after init-time.  We ought to be able to do a late PCI scan even if
> hotplug is not supported.
>=20
> Therefore, I'd be inclined to remove __init completely unless you have
> another reason for preferring __devinit.

I thought __devinit would resolve to nothing if HOTPLUG is defined and
__init otherwise. That seemed more appropriate. However you are right
that it is useful to always have it available, so I'm fine with removing
the annotations altogether. Do you want me to follow up with a patch? Or
can you just take the first version? I'm not sure if it still applies.

Thierry

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQK/hOAAoJEN0jrNd/PrOhHkgQAIfvIKVNOMWTBFIGpoX0FsNI
m525DKfOC/0hg/EamEbmowFjJQlNjLue5ovckVVuPaLiCt6IttrfA5uCoXYeYMpe
Nulv9WRg2vriS0OiNqb8D1Hj6P3+3QaPO8uGDuv9vo8+YoqasAMpHXJgxbWTBeC0
g96gNJx/BYRfwL3pQ5Rltx5tO0B40hHmbCuXA1YCrcOf12b5sE5N5dCowQRyBga+
TCmprXFAC70c4SDj+nOcS7QjrnNS2nWNykc+SVtzCMeU1oc9VgI1GfO7Mp1DinhY
JsA0Ffo4KNtXEBCQ7zLHgX4WihH/rvv4ae5uftYbO5wdkFmayVtZdsYwrvgrT3xj
hr4Oq2gG0Hwe++cO5eXviEKkJbKZDDw4VN2pw7y7Ce4VgGMp6SVRlMlz71JCwue9
Vhay/MyenFSKIkjnsyRUfRkYmCaD3o+v0Q3LaG+OpYlTb+Cesx6NSCU+9Pf7O1GM
aJUSq1T9mPBjIlRvtImbUi4gDXVzcSZOgdVhDvx0JrhyLBCsckiC3don0NYXPsce
6kU8ysKDIDh9uvl8Ci5d1Qj3tf9dKuM77tcvxeUhE5AovJRVic4cLw5CJ+/Uresh
/d4vMaw4KLtqu4hjLJrJTKiDkFXh8dHBM8EpFpOxOrjqDaUsqwZ7MbZc39tMO6/O
qJnRtzpaMir9T5TPYl4i
=rBEO
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
