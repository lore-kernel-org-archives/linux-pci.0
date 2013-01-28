Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:61385 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331Ab3A1WQT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2013 17:16:19 -0500
Date: Mon, 28 Jan 2013 23:16:04 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 02/27] of/pci: Add of_pci_get_devfn() function
Message-ID: <20130128221604.GA24858@avionic-0098.mockup.avionic-design.de>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <5106F4EA.20904@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
In-Reply-To: <5106F4EA.20904@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2013 at 03:00:10PM -0700, Stephen Warren wrote:
> On 01/28/2013 11:56 AM, Thomas Petazzoni wrote:
> > From: Thierry Reding <thierry.reding@avionic-design.de>
> >=20
> > This function can be used to parse the device and function number from a
> > standard 5-cell PCI resource. PCI_SLOT() and PCI_FUNC() can be used on
> > the returned value obtain the device and function numbers respectively.
>=20
> > diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
>=20
> >  static inline int __of_pci_pci_compare(struct device_node *node,
> >  				       unsigned int devfn)
> >  {
> > -	unsigned int size;
> > -	const __be32 *reg =3D of_get_property(node, "reg", &size);
> > +	int err;
>=20
> I think I commented when Thierry posted this, that calling that "err"
> seems a little odd. Thierry replied:
>=20
> Maybe renaming the devfn parameter to data and using devfn for the local
> variable would be more obvious.

That's already fixed up in my series. I was going to wait until I was
done with the MSI rework but maybe posting an intermediate version is in
order to share the latest state.

Thierry

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRBvijAAoJEN0jrNd/PrOhLk0QAIhczqnE4DKkXglRdP7d4zMF
badqCVSf9AEerqzeKn6Kuq+zxfyn4W+x4s//RWoWH8uu+hx8sspKTtuaZQ+42BZ3
zx6cBb9d0zWVm4qm3YfQifpvBNAYr+00S3307tcis85VR+IUM+rw2qGoxj3gyT85
7LNMpjafahOhKwecDn6lHK6A6Roje265jOGLMDk9MIFc4mMonoaJxQhTdQStsHS8
yYdmn7mGQJi6hoFMcqoUE9rUjAXlSsbgv2l6hApbuwf+cxP7fse5f9Feps4dEGBN
MGB3NrnsUOXZTB8fQPDRSKNqeIpVxEg6vGV7Das5s8CrydffAr6/RGM/O/jK1deR
zoySD+wzjON7/qK46LsmpbtNpAFJEnrj+vU+7U4mfmexu+y82516TW+HBXBACKOE
NNsVWm4eJPvwVq0yXJ9TTwOeKO4ZcaYiAUiFP6ojodwIt2wXQYprTTMl3P50GgsT
6QcV/z6GKeJGp52Ny4T5rx6TXCV0Yifo5wnTU/EDDS0O80ONHO8mIo/vPEYSER1s
JmU485GFlGNjtjDIiR1hFKYASS68wMUQUp3Us3efxBUHUZUBvo8RxePfZbmmDZtr
FZPQUs7FkfVq25rPlVT08BkWJ7NGxbhRA0+3Ne5MwAverNE/ImZHStt7rLEtEydq
V05AmdPay0H2eCr4o2iW
=PhVp
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
