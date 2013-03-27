Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 27 Mar 2013 14:04:18 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Andrew Murray <Andrew.Murray@arm.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>,
	'Grant Likely' <grant.likely@secretlab.ca>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jingoo Han <jg1.han@samsung.com>,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>,
	"linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	'Surendranath Gurivireddy Balla' <suren.reddy@samsung.com>,
	'Thomas Abraham' <thomas.abraham@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v3] of/pci: Provide support for parsing PCI DT ranges
 property
Message-ID: <20130327130418.GA10480@avionic-0098.mockup.avionic-design.de>
References: <20130326162022.GA25625@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
In-Reply-To: <20130326162022.GA25625@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2013 at 04:20:23PM +0000, Andrew Murray wrote:
> This patch factors out common implementation patterns to reduce overall k=
ernel
> code and provide a means for host bridge drivers to directly obtain struct
> resources from the DT's ranges property without relying on architecture s=
pecific
> DT handling. This will make it easier to write archiecture independent ho=
st bridge
> drivers and mitigate against further duplication of DT parsing code.
>=20
> This patch can be used in the following way:
>=20
> 	struct of_pci_range_parser parser;
> 	struct of_pci_range range;
>=20
> 	if (of_pci_range_parser(&parser, np))
> 		; //no ranges property
>=20
> 	for_each_of_pci_range(&parser, &range) {
>=20
> 		/*
> 			directly access properties of the address range, e.g.:
> 			range.pci_space, range.pci_addr, range.cpu_addr,
> 			range.size, range.flags
>=20
> 			alternatively obtain a struct resource, e.g.:
> 			struct resource res;
> 			of_pci_range_to_resource(&range, np, &res);
> 		*/
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

Tested-by: Thierry Reding <thierry.reding@avionic-design.de>

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRUu5SAAoJEN0jrNd/PrOhIg8QAK7GeB7tx8qPNJKxD4qKD6mi
mBWePcVpcS0nG4OZkVH7p4/8n09krshGJW8lUg4YG8BjGipZcrYdOiExSY0ZpW7m
sd5Zs+P6OKtVVkjn0nRdfwctXmwSl70N4ofo/MzIcI6mXyDsQCSgOoiieE2wm9zd
aCiU7gHm3NP9vZBY5Z2aKLFsgeEiA3GASSWGw4MWU16t+zWCTbp0Kv1X1quVCE8r
0Fqp5tIVX7Xx/1S+DAjyntlPs0EMFPCuBlNTB5U0dRUabxT8RORcRDWEQ+3FKpcM
mZY7u6jkqZQxP8WnYjC8Upb8OefMK7RUXIOukvsmRVZECoUbcWBpbaAElbZk3qNw
ytJiR9bBhQBS/z+txUq2ZG1lpe9IYPERruCoUAx3nJlJ8KxUGQUf6z/zei/qwp8a
7fuUVVi8FuMT29P5dYn40DV4fgytI/x5dATR85g/xO5KkFvAL7CbPJEvekGmMKVU
tNeOEpmw6K249XUCSLthGvh7Imh6hIBK9IEROnBUnKtgApCKVPtpVLrq1aTliVZc
D9euw7Wknl+9Yl8ionY5+fE6nzrYIjcGbn+CYNIyz9gSURh+Evxs05tXLmSOACss
4W32IIqrvZ2YwhiMNumCdLh+ovhzeW5hvdbIZ9lTSDQ3VypXIu76OE5Xcq2Q9mdD
mfhblBZA86XCTC4xKbUB
=FbDu
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
