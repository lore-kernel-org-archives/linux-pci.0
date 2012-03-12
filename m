Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:38221 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754728Ab2CLOcN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Mar 2012 10:32:13 -0400
Date: Mon, 12 Mar 2012 14:32:11 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Liam Girdwood <lrg@ti.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Olof Johansson <olof@lixom.net>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 11/11] ARM: tegra: pcie: Add device tree support
Message-ID: <20120312143210.GJ3110@opensource.wolfsonmicro.com>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-12-git-send-email-thierry.reding@avionic-design.de>
 <4F59253D.7070100@wwwdotorg.org>
 <20120312120610.GA14020@sirena.org.uk>
 <20120312141705.GA16395@avionic-0098.mockup.avionic-design.de>
 <20120312142340.GI3110@opensource.wolfsonmicro.com>
 <20120312142857.GA6694@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OX7PPUk8qMPP4++R"
In-Reply-To: <20120312142857.GA6694@avionic-0098.mockup.avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--OX7PPUk8qMPP4++R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 12, 2012 at 03:28:58PM +0100, Thierry Reding wrote:

> In that case I'll mark the *-supply properties required. Would it be a good
> idea to mention this (or even give an example with fixed regulators) in the
> binding documentation or can I assume this to be common knowledge?

Probably the best thing here is to just reference the regulator binding
documentation which mentions -supply properties (or should do) and then
clarify that if need be.  No sense in putting things like this into the
binding document for a specific driver, there's nothing driver specific.

--OX7PPUk8qMPP4++R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPXgi/AAoJEBus8iNuMP3dtrUP/jdURXjgr3P59n7MLL/cQxOS
mwJKy5iOzNaTD8hx7zRXiw1HiJIudZhhpNJbF69EIcbm+7z8XPtvQKEA4Xy4inds
5Coa2fuRnTN1c0py8XOqUaDvtzxkjnipbfS5AUuHU346cdQLaqhG9quTowwT1JeE
rgJG+m9df9d5tywd2I9GTRDXNQpY5YxlBhi84lIG5diN4a9wjhRSY/xi/02RH0Na
Ay0F0/2OPRIiEuEYH9k8bJPJsMW5Qt0jcIikTlaiDScX+Y5CK26HFAvd8X1tPSes
2dwtVciIQ9bqFAGis6pOhPOJ5Ye48tmSmw7pSTHgj0PeY2ZwfA0xjbzoqpjlxdk6
tUjNNWoM59Jt4wZ+pN5RmlOD7kQKm0YEI2ZwtZTDtqary5XNlCPr53k071iGia+5
5zIH+p9HSw1q6pWcRkRmKle8LtkHpr2xn1R/S21o139u9DvsGwZQV+89ulhYGU3M
8zRO1Q7CYP9t040REFaEEG6CLCfMMmG5fxQsjJJ3XFGopwbEdCkAGXcDLyCxef/d
sa+gd8E45EUgd0hhZ7xZQduo5Gf59/fZ0o54V9KlUKqXxescKZuWUp+MZ2Sz5+Rc
fxgxkZVb7pT9VJaRU6ZWBCeU+pBWUJQ6b0EnjO0t/yAN0FIdxtsFRxs7lalRuA22
qsJDVoeXg1LA8t4E0b8f
=6xXw
-----END PGP SIGNATURE-----

--OX7PPUk8qMPP4++R--
