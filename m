Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:35172 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115AbaGUVTh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jul 2014 17:19:37 -0400
Date: Mon, 21 Jul 2014 23:19:34 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Add debugfs support
Message-ID: <20140721211932.GB12076@mithrandir>
References: <1405062024-2364-1-git-send-email-thierry.reding@gmail.com>
 <53CD37CA.7020308@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
In-Reply-To: <53CD37CA.7020308@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2014 at 09:54:50AM -0600, Stephen Warren wrote:
> On 07/11/2014 01:00 AM, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Provide a debugfs file that shows the current link status for each root
> > port.
>=20
> Reviewed-by: Stephen Warren <swarren@nvidia.com>
>=20
> Does this patch conflict with or merge well with the Tegra124 PCIe
> driver patches, I wonder?

Yes. The Tegra124 PCIe patches are part of the same branch. My plan was
to get this merged for 3.17 (if it's not too late yet) and then submit
Tegra124 support for 3.18 soonish after 3.17 is released.

I also have a bunch of patches that allow the Tegra PCIe driver to be
built as a module (though that has even more cross-tree dependencies, so
should probably be phased in over a couple of cycles).

Thierry

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTzYPkAAoJEN0jrNd/PrOhuhYQALJriv+0xZQhNVSyPJIUovYB
snS3iOcKIu1kKpIIj2kh+Pp3AHVWZYM9Rv+cbTwZwIG0eehixu+3L+tICb/KHPV8
VX/w2EDBvIt42S/L3aRy+aKedNFYMyt0sTkEnqVahqf1VLBfqsieaNbAVUt7bVJi
iNi3c7KKwrZYtF1YEFPgqP7CjPDxbsDVTAVmMTtNJjOZaTVNF9obl2kNGnNcwPXV
LWxEORsjSprXQyKoNTQOu07hS0avSCWdjiU4dXNn+IO/9eBosPhx6Q1aG/t+Y9r3
/GMeON8YiIe8+lGnz1Q95U0HoPNdZEe39Aj/MnbyVgO4yRA1+xailsUCzRgBq85g
BT5yg3u8t/dAKuchx9Z9z2HgGxyQZeQGGUKPbeyby3hiQQRA55uxdHQMx1LEBEVv
VSLjKjxeYlL46UyiTdsEpOQqhqJmgQKZd0MWITp37FBr0otFFnpLFvDR67+DoCOr
9+pp44pWKQj5SqeY7XsMET0a2jZkR6Fd1XEg9Vwkg00V2RkEKT6wCeM0D4DC44nV
4S0J3qFMF4ZePdi6jTnzX3YqrSQIpn4U1W7QpSS1E8DcZnUvL5PSxRU+pq56g5KA
1Jwx9pCU565FaZh6SixFQPcJVlP9+V7/+WuCfJ6Efbcd9FUfMg9h4l55Ndh0ne0J
pVaE323PEEpnFOd64vyG
=OyXj
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
