Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:59677 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264Ab3CHUPV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Mar 2013 15:15:21 -0500
Date: Fri, 8 Mar 2013 21:13:40 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Mitch Bradley <wmb@firmworks.com>,
	Lior Amsalem <alior@marvell.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Message-ID: <20130308201339.GA26322@avionic-0098.mockup.avionic-design.de>
References: <20130307174955.GC20840@obsidianresearch.com>
 <20130307194830.GA1811@avionic-0098.mockup.avionic-design.de>
 <20130307200235.GB20695@obsidianresearch.com>
 <20130307204726.GB1811@avionic-0098.mockup.avionic-design.de>
 <51392B4D.9040404@gmail.com>
 <20130308071443.GA5772@avionic-0098.mockup.avionic-design.de>
 <20130308165228.GB4094@obsidianresearch.com>
 <20130308191227.GA6551@avionic-0098.mockup.avionic-design.de>
 <513A3F4F.2090501@firmworks.com>
 <20130308200245.GC29435@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
In-Reply-To: <20130308200245.GC29435@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2013 at 01:02:46PM -0700, Jason Gunthorpe wrote:
> On Fri, Mar 08, 2013 at 09:43:11AM -1000, Mitch Bradley wrote:
[...]
> > 2) The "@0,0" and "@1,0" suffixes do not correspond to the reg values
> > <0x0800 0 0 0 0> and <0x1000 0 0 0 0> using any rule that I know.
>=20
> @0,1,0 (bus,device,fn) could be more appropriate, but that is
> cosmetic?

The OF PCI specification is pretty strict about this as well. It says in
section 2.2.1.3. that only the DD and DD,FF forms can appear in a device
path.

Thierry

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJROkZzAAoJEN0jrNd/PrOhjOYQAK2XmBbA+p5sqjGBjfDOxGc/
Q3Amkf4FE7o2fYrJacrsdo7uMgQQbghzer5JRjj2Qc2g3YMbp3BaQpOrkFRZAHj5
CQIrkBbRQtvuLC73ojeLuGTUD+eLRMpbByEENMM2kUXIOTQqKmtMcIdVF4vlWrFp
wvi4TK4YFnybBUP0hX7MRI7qgI4EmfNupPv0aCRbu+mHsEkVA1mF0ELbUtCPpQ8w
6h7AnawR06KkXIqk5cidcpXEK+XMjwJlEseceMPlQxiVkbDZ68I7DeXe0qjDrizN
x6uvBNvABkk9YHbKth7g99/I5h8BgCZl8jqVnyFKATifSh6rJ6oQEqXciz/tyxg0
XT5ZSyLDMeUsO1hfsVfYe56S5Tj9Af9yofSqK6ZGdq/QzXi1hW2mB4ZNsTJigMVx
RYwg0RKOXXcVXY8l8uiewjV4TyjS2xzWjZbQgvMBG6bzNTRsqKi35MAO/n7YXpfx
vWrIAiTbCPhN4HEZ2RsNtLSfPr7MJ7BtAaq6vNGhbRtQQjoYoeUlRDEC6yZK1yVA
y5jy554dwDgquh491iEsHpZkejaAzsdQyp1pO6e6JK8UDWF3NHsG/1ul0bG+Bl66
8YFGvFrDlUn3wU16wMkWOO6iClzEHVhhfS2yFISIPyYKvJZM3cPxUE+jL3r/2uE3
LBPdgW+hLfR/NUnHwqf+
=QXul
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
