Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:60118 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340Ab2FMFys (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jun 2012 01:54:48 -0400
Date: Wed, 13 Jun 2012 07:54:37 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Mitch Bradley <wmb@firmworks.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
Message-ID: <20120613055437.GB31001@avionic-0098.mockup.avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-8-git-send-email-thierry.reding@avionic-design.de>
 <4FD66410.7090001@wwwdotorg.org>
 <20120612062124.GE4040@avionic-0098.adnet.avionic-design.de>
 <4FD763C5.3090500@wwwdotorg.org>
 <20120612172041.GA28010@avionic-0098.adnet.avionic-design.de>
 <4FD7943E.60302@firmworks.com>
 <4FD79CAE.9090006@wwwdotorg.org>
 <4FD79DE8.90603@firmworks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
In-Reply-To: <4FD79DE8.90603@firmworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Mitch Bradley wrote:
> On 6/12/2012 9:46 AM, Stephen Warren wrote:
> >On 06/12/2012 01:10 PM, Mitch Bradley wrote:
> >>On 6/12/2012 7:20 AM, Thierry Reding wrote:
> >...
> >>>I came up with the following alternative:
> >>>
> >>>	pci {
> >>>		compatible =3D "nvidia,tegra20-pcie";
> >>>		reg =3D<0x80003000 0x00000800   /* PADS registers */
> >>>		       0x80003800 0x00000200   /* AFI registers */
> >>>		       0x80004000 0x00100000   /* configuration space */
> >>>		       0x80104000 0x00100000   /* extended configuration space */
> >>>		       0x80400000 0x00010000   /* downstream I/O */
> >>>		       0x90000000 0x10000000   /* non-prefetchable memory */
> >>>		       0xa0000000 0x10000000>; /* prefetchable memory */
> >>>		interrupts =3D<0 98 0x04   /* controller interrupt */
> >>>		              0 99 0x04>; /* MSI interrupt */
> >>>		status =3D "disabled";
> >>>
> >>>		ranges =3D<0x80000000 0x80000000 0x00002000   /* 2 root ports */
> >>>			  0x80004000 0x80004000 0x00100000   /* configuration space */
> >>>			  0x80104000 0x80104000 0x00100000   /* extended configuration spac=
e */
> >>>			  0x80400000 0x80400000 0x00010000   /* downstream I/O */
> >>>			  0x90000000 0x90000000 0x10000000   /* non-prefetchable memory */
> >>>			  0xa0000000 0xa0000000 0x10000000>; /* prefetchable memory */
> >>>
> >>>		#address-cells =3D<1>;
> >>>		#size-cells =3D<1>;
> >>>
> >>>		port@80000000 {
> >>>			reg =3D<0x80000000 0x00001000>;
> >>>			status =3D "disabled";
> >>>		};
> >>>
> >>>		port@80001000 {
> >>>			reg =3D<0x80001000 0x00001000>;
> >>>			status =3D "disabled";
> >>>		};
> >>>	};
> >>>
> >>>The "ranges" property can probably be cleaned up a bit, but the most
> >>>interesting part is the port@ children, which can simply be enabled in=
 board
> >>>DTS files by setting the status property to "okay". I find that somewh=
at more
> >>>intuitive to the variant with an "enable-ports" property.
> >>>
> >>>What do you think of this?
> >>
> >>The problem is that children of a PCI-ish bus have specific expectations
> >>about the parent address format - the standard 3-address-cell PCI
> >>addressing.  So making a PCI bus node - even if it is PCIe - with 1
> >>address cell is a problem.
> >
> >Couldn't you put the #address-cells=3D<3>  underneath each port node, and
> >put any PCIe devices there rather than under the main PCIe controller
> >node? I'm not sure how the interrupt mapping table etc. would work in
> >that case, but that seems to solve the addressing issue.
>=20
> Yes, that would work just fine, and in fact would be preferable, if
> a "root port" is essentially an independent PCI bus.  The parent of
> those root ports should not be named "pci", though, as it is not in
> itself a PCI bus.  It could be called "pcis".

Yes, on Tegra each of the ports provides a separate PCI bus. How about nami=
ng
the parent "pcie-controller"? IMO that reflects the nature of the device
better, whereas "pcis" would seem more like a "virtual" node for collecting
similar children.

Thierry

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/YKx0ACgkQZ+BJyKLjJp/JYwCgpXG48eCe74WLWujfZGQSnQ4K
Gl8AnRbUqD8u/XLAwS0V+lIkcN2gbIG9
=pqcY
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
