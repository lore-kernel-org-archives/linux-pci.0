Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33563 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbcBJPwu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Feb 2016 10:52:50 -0500
Date: Wed, 10 Feb 2016 16:52:47 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Update for new XUSB pad controller bindings
Message-ID: <20160210155247.GA14584@ulmo>
References: <1455029465-9211-1-git-send-email-thierry.reding@gmail.com>
 <56BA107A.9050201@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
In-Reply-To: <56BA107A.9050201@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 09, 2016 at 09:14:50AM -0700, Stephen Warren wrote:
> On 02/09/2016 07:51 AM, Thierry Reding wrote:
> >From: Thierry Reding <treding@nvidia.com>
> >
> >The current XUSB pad controller bindings are insufficient to describe
> >PHY devices attached to USB controllers. New bindings have been created
> >to overcome these restrictions.
>=20
> New bindings have been created? Which ones; there were several attempts to
> enhance the bindings, but I wasn't aware that any of them had passed thro=
ugh
> review and been accepted.

Perhaps are being created would be more accurate. Though technically
this isn't really about the new binding, or at least not the details.
The most important part here is that this implements the driver code
that will control per-lane PHYs. At least that part was what everyone
had agreed on was the right move forward.

Also the goal is to land this change before the switch for the XUSB
pad controller goes in, because otherwise PCIe will be broken. I can
reword the commit message to clarify this.

Thierry

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWu1zLAAoJEN0jrNd/PrOh3hQQAKUcpCrGbQubqrbhoafwKiwv
UEAR4lhyP+PIkgT8fWTwlAqji16CkmuizuytJrm8U/x3t1Jiu18uipvHCUpwwaBK
rIG9QQnjqpnB5jCNUuy5pFSKR0IWBC8d4Pud3X7tDP1Rg+YPd8PCMoOwqJkjlGAU
WIpvNHujeEGu/lToPzJmcEDin5sco9EsCshfU7ifCJvpfXyeqs/usbgbpHU5DSzJ
RsZ5XF3UB5xni9xr4TQwBhBV36mYDZHyu5QUn7RTvBXvo1IJEmUWuUset8ltk+9t
5TGx0aTBplq36J/x/5/ckdRA69Gekdy85xeFtFW5VKIwv0trWRC6UVRJlci8Vfg4
Ofn3qKsaX8un6RukmTXbc0YzlfsW32KAlFrxrDPYl9UZJ8TBg6x6GxWGdC5mZDF8
QO3cTPCYGDKqjbFYl350XcUENVGUrA5FJ2+IWOElZ5NDdIcyGxGt2RaFcewRBmrj
H1dN7HNx++dXz9ovFSj0wyUsCcM5nZg6KV8ANpkIaVIxkVaLBcxdM5VdNpmS9dL3
fq7hN64YWJiPzkWcbfZvMAnfrMFPpnGXh/60NABeB17LXk7ofHiI4IbdcAFedwS4
XtPhy6EkFkXqrzYf1DGluTgqoBvncWWWFaun7kTP+Lz5sTUpk/dJl167C0BmjoZR
aowXt5YqZuzo8FeqY1Z1
=3B+n
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
