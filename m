Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:48429 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756452AbbAILZx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jan 2015 06:25:53 -0500
Date: Fri, 9 Jan 2015 12:25:50 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: add helper function to find root port for
 device
Message-ID: <20150109112549.GD16465@ulmo>
References: <1418929903-8506-1-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RhUH2Ysw6aD5utA4"
In-Reply-To: <1418929903-8506-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2014 at 08:11:42PM +0100, Lucas Stach wrote:
> This adds a simple way to get the root port a given device
> is connected to.
>=20
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> v2: new patch in v2
> ---
>  drivers/pci/search.c | 20 ++++++++++++++++++++
>  include/linux/pci.h  |  1 +
>  2 files changed, 21 insertions(+)
>=20
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index a81f413083e4..c3ae1c52c7cf 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -385,3 +385,23 @@ int pci_dev_present(const struct pci_device_id *ids)
>  	return 0;
>  }
>  EXPORT_SYMBOL(pci_dev_present);
> +
> +/**
> + * pci_get_rootport - Returns the root port the given device is connecte=
d to.
> + * @dev: PCI device for which the root port should be found.
> + */
> +struct pci_dev *pci_get_rootport(struct pci_dev *dev)

I think pci_find_root_port() would be slightly more consistent with the
existing API.

Thierry

--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUr7q9AAoJEN0jrNd/PrOh1JEP/RVWSfK1mGlJwPBpkqAtWz6g
7pcULe6Gn/jfBeXPrIgJxaJpGq+coPLYkBXOToB/BAesIiSN6WH6X/CXMe34idNG
QXmHclXJz5A5BPDn516N+7ts0quc2Uik4PE6ps3AphhWBxn9U/0p0Yz3Ujpg3eHI
g07IvTVph4V9yefhr21Bux3QGvqSCsQyBIoRiKkApzAgo1gKT+klQ6DWPXXILEmb
mPagxCK1+9OT01wAgBNT0QE3pEaFZhRkMbwGKfY/crlh6qv0YLnyn5ePOEntdki6
StDl6Mez6P9LgjcdzGQ8/mUFccajVLtbEYaGcxOzFCQiksQOd2uizVGJVWcx2zvZ
9V9IHjH0PFUCnFm5OMNSvF12nLxcIExnnkXTrhaESwMrLUEsuHGXU1i0joWSZHva
gwGdJBDzWdP266dNTBz9gp/+p8GSJjoCXBy40X5P0/55vxKz6UN28gc+Sb1NnzKO
CoB4iO1AYttAeu4AYIx0/bRe8BjAmshubyLbl9vKPKY1rr/jBAtI0kCoRN+nIYUC
DIKxtUlgHlWwI9emKbJtQarhDguWkzD6h7pZuKy6hACsFpmbz7+3qwLETyRi76I8
knytbjuH/iahjrhQSwyCIy47+vDw8ikdOvDFqIsOt4eydsLE3fIjpkYE+ypzu/1T
l8jpMG6ugN/onu+DRW6h
=FSrE
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--
