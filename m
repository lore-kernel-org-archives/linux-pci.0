Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:65179 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932626Ab3CVKNT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Mar 2013 06:13:19 -0400
Date: Fri, 22 Mar 2013 11:12:39 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v5 01/17] of/pci: Provide support for parsing PCI DT
 ranges property
Message-ID: <20130322101238.GA22929@avionic-0098.mockup.avionic-design.de>
References: <1363887025-19931-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1363887025-19931-2-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
In-Reply-To: <1363887025-19931-2-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2013 at 06:30:09PM +0100, Thomas Petazzoni wrote:
> From: Andrew Murray <Andrew.Murray@arm.com>
>=20
> This patch factors out common implementations patterns to reduce overall =
kernel
> code and provide a means for host bridge drivers to directly obtain struct
> resources from the DT's ranges property without relying on architecture s=
pecific
> DT handling. This will make it easier to write archiecture independent ho=
st bridge
> drivers and mitigate against further duplication of DT parsing code.
>=20
> This patch can be used in the following way:
>=20
> 	struct of_pci_range_iter iter;
> 	for_each_of_pci_range(&iter, np) {
>=20
> 		//directly access properties of the address range, e.g.:
> 		//iter.pci_space, iter.pci_addr, iter.cpu_addr, iter.size or
> 		//iter.flags
>=20
> 		//alternatively obtain a struct resource, e.g.:
> 		//struct resource res;
> 		//range_iter_fill_resource(iter, np, res);
> 	}
>=20
> Additionally the implementation takes care of adjacent ranges and merges =
them
> into a single range (as was the case with powerpc and microblaze).
>=20
> The modifications to microblaze, mips and powerpc have not been tested.
>=20
> Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>=20
> Compared to the v2 sent by Andrew Murray, Thomas Petazzoni did:
>=20
>  * Add a memset() on the struct of_pci_range_iter when starting the
>    for loop in for_each_pci_range(). Otherwise, with an uninitialized
>    of_pci_range_iter, of_pci_process_ranges() may crash.

This sounds like you're trying to do too much within the for loop. When
we discussed this previously I had a vague idea that this functionality
could be wrapped into something a bit more object-like.

What I had in mind was something like:

	struct of_pci_range_parser;
	struct of_pci_range;

	struct of_pci_range_parser parser;
	struct of_pci_range range;

	err =3D of_pci_range_parser(&parser, np);
	if (err < 0)
		return err;

	for_each_of_pci_range(range, parser) {
		struct resource res;

		...
		usage of range similar to iterator
		...

		of_pci_range_to_resource(&res, &range);
	}

In the above the of_pci_range structure pretty much replaces the
iterator and the whole is wrapped up within a parser structure to give
some extra flexibility and provides for easier (or more structured)
setup compared to doing all of it within the loop statement.

But aside from the (perceived?) increased robustness there's not a lot
of technical benefit over your implementation, so it isn't a very hard
objection. I find it to be a little more encapsulated and therefore
easier to work with, but that's possibly just a matter of taste.

Thierry

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRTC6WAAoJEN0jrNd/PrOhoCEP/2gGHiGUxvw3J4ohvti+uDj7
9q08Ky1GaVqpmTz02W7qMLoTv5AKxuNmz7ufWl5q6T4kdZtvMU5MLYrDCEtMu1mQ
/DtGtT4im+k2UvM2ZXP46dTlwpbgmJSjQOzdGMUKEvzwdrXhD//KEV6apV/Jasgg
AxqGb2F1NMf2UXn+fdhfLwKtFDMyF/kUfPP6NRSGV9s5Dz8AJRmvGr4Jl/8W7rF3
TLsPa61k8XplyqpSysQ2VNzKsZLh+ztaANd6t861YHO4vncp7onXT37Yu1bFuWN7
gFyWfnUinOCIP9/pE90dQkE2j8IvOfur6ZBbCTDnLx8cPCCAIXKWugNQUARmptkq
Gv0nBzoY+a55dDL9eLOJLDY2UsRwDtY7+dpBslyyRflct2K/0BSkMZGtnHEiNWcA
pRnfw/VdjbbK6ej+cwvloacRvlxKtNe5XNfZzqNSqhuu7OKz7yMd5PeHF4IaaDNb
tfGHrvGHb+nOELzQgEp0ODj5ppchHGvuMJchmCK3NEVqC0R8PmfVX991QPbskDun
4dL7wJsLxmppPwUjt5rs7ANTBvBY67TQBbxmt2OjoADLB4uKOkFushkSM3+sjQmi
x2KBDGaXwAFH5HiLzXd5IDUEvoiBuPMzdvEWXHna4cwFfU8Xp3KI+gt738m10iuE
ILDoPSsJNKq3cNuSXMal
=08CP
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
