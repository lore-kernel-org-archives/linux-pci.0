Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:49085 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab3FUK26 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2013 06:28:58 -0400
Received: by mail-bk0-f47.google.com with SMTP id jg1so3264671bkc.6
        for <linux-pci@vger.kernel.org>; Fri, 21 Jun 2013 03:28:57 -0700 (PDT)
Date: Fri, 21 Jun 2013 12:28:54 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: [PATCHv3 10/11] arm: mvebu: indicate that this platform supports
 MSI
Message-ID: <20130621102853.GH12441@manwe>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1371660979-21588-11-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nOM8ykUjac0mNN89"
In-Reply-To: <1371660979-21588-11-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--nOM8ykUjac0mNN89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2013 at 06:56:18PM +0200, Thomas Petazzoni wrote:
> Now that all the pieces are in place, we can adjust the
> mach-mvebu/Kconfig file to indicate that this platform supports MSIs.
>=20
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index 9eb63d7..36951b1 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -15,6 +15,7 @@ config ARCH_MVEBU
>  	select ARCH_REQUIRE_GPIOLIB
>  	select MIGHT_HAVE_PCI
>  	select PCI_QUIRKS if PCI
> +	select ARCH_SUPPORTS_MSI if PCI

I think we can get rid of ARCH_SUPPORTS_MSI now. I actually wrote a
patch once to do that but haven't posted it yet. The reason is that
the new weak functions do the right thing if MSI isn't supported by
some architecture or platform.

Thierry

--nOM8ykUjac0mNN89
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRxCrlAAoJEN0jrNd/PrOhmUgQALpmzCBYr8jfD121vyikvtkp
BOkxxDKt6eqXC0v2RnE9HpNQNNvXG1rXon6acYfZgB0e7VAkcKa6QQUw3/OGfiGB
2vYBlzcdi/hqzQgB51rr6AOmQ2Xl78UW7IiEYtqgWkr8DIECqGTSOWR3Wt47gOnf
njn34+K05PnlAASnyvHCmkHr2Vzbtt1nFkTj59DZI6pZk4eMfImiSQIqLex3OOEE
Lmr739o1J/uIElu61sWpc1QpxA/PC2BXmwBURZbrbHV4LmERA6LsgHMISSZn6GK3
5s3jYJ8B8BIa19R9kqHcCrFnAkKYN5BlrYAQWL1vbRwced/Zq9yRalXD3fu7um9+
ASdWKxQNhcjqTLieqsVa36tKr1Ugn24uoJwUpmKM9/hL7yJPXb+qA4YIhQAOEzYG
l0S/+jGz35EAHmgkWtoomLgpdr4Xg9jn58v9xl6aS7QjQXZD5eJsueUG5x6cdTVR
Lwn0q3aG3GnGXZfocP36FFs4Z++U58G1Lu1bx74Bg4iuHjqKkq/Bu5+d+nXyH/si
Z0P4g25X/rDBK3Hg5WaQ4bUTdI7lv1sipiVYfPDEjUgdNjR6hl0yTn3ac2OfJOQW
6E/NIxMCE5ZUj72IlQHSpSI4/Fkloixk5dTbppJUEma+TILVwtqwJXlfSnzE38Nj
PQcW5Q2KhxObVKEQ/Y4Z
=mVIh
-----END PGP SIGNATURE-----

--nOM8ykUjac0mNN89--
