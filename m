Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:51299 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab3CNUjT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Mar 2013 16:39:19 -0400
Date: Thu, 14 Mar 2013 21:38:58 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Mitch Bradley <wmb@firmworks.com>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Message-ID: <20130314203858.GA4539@avionic-0098.mockup.avionic-design.de>
References: <20130312213006.GA23717@avionic-0098.mockup.avionic-design.de>
 <20130312220854.GA23112@obsidianresearch.com>
 <20130313081815.GD25940@avionic-0098.mockup.avionic-design.de>
 <20130313170205.GB24042@obsidianresearch.com>
 <20130313192628.GA28714@avionic-0098.mockup.avionic-design.de>
 <5140E85A.3040900@firmworks.com>
 <20130313220235.GA29895@avionic-0098.mockup.avionic-design.de>
 <20130313222102.GA28336@obsidianresearch.com>
 <20130314090120.GA2224@avionic-0098.mockup.avionic-design.de>
 <20130314172555.GA14048@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
In-Reply-To: <20130314172555.GA14048@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2013 at 11:25:55AM -0600, Jason Gunthorpe wrote:
> [trimm'd the cc list]
>=20
> On Thu, Mar 14, 2013 at 10:01:20AM +0100, Thierry Reding wrote:
>=20
> > It turns out that this works with the Tegra driver because it uses the
> > new of_pci_process_ranges() function and simply overwrites earlier
> > matches by subsequent ones.
> >=20
> > 	ranges =3D <0x82000000 0 0 0x80000000 0 0x00001000   /* port 0 registe=
rs */
> > 		  0x82000000 0 0 0x80001000 0 0x00001000   /* port 1 registers */
> > 		  0x81000000 0 0 0x82000000 0 0x00010000   /* downstream I/O */
> > 		  0x82000000 0 0 0xa0000000 0 0x10000000   /* non-prefetchable memory=
 */
> > 		  0xc2000000 0 0 0xb0000000 0 0x10000000>; /* prefetchable memory */
>=20
> Okay.. There is still something funny here, the 3rd dword of the child
> address should not be 0 in every line and there shouldn't be overlaps
> in the child address space.
>=20
> I'm assuming 0x80000000, 0xa0000000 and 0xb0000000 are real CPU physical
> addresses?

Yes.

> Then it should probably look like:
>=20
> ranges =3D <0x82000000 0 0x80000000  0x80000000  0 0x00001000   /* port 0=
 registers */
> 	  0x82000000 0 0x80001000  0x80001000  0 0x00001000   /* port 1 register=
s */
> 	  0x81000000 0          0  0x82000000  0 0x00010000   /* downstream I/O =
*/
> 	  0x82000000 0 0xa0000000  0xa0000000  0 0x10000000   /* non-prefetchabl=
e memory */
> 	  0xc2000000 0 0xb0000000  0xb0000000  0 0x10000000>; /* prefetchable me=
mory */
>=20
> Which says 'access to CPU address 0xa0000000 produces a PCI-E memory TLP =
with
> address 0xa0000000' - this is the 'normal' case, I assume that is what
> happens on tegra?
>=20
> It also says 'access to CPU address 0x82000000 produces a PCI-E IO TLP
> with address 0' - this translation is something Linux typically
> expects..
>=20
> Then you'd go on to have:
>=20
>                pci@1,0 {
>                         device_type =3D "pci";
>                         assigned-addresses =3D <0x82000000 0 0x80000000  =
0 0x1000>;
>                         reg =3D <0x000800 0 0 0 0>;
>                }
>                pci@2,0 {
>                         device_type =3D "pci";
>                         assigned-addresses =3D <0x82000000 0 0x80001000  =
0 0x1000>;
>                         reg =3D <0x001000 0 0 0 0>;
>                }
>=20
> Notice I've made the upper dw of assigned-addresses's size 0 and
> included the full 3dw from the appropriate ranges line.

Okay, that all makes sense.

> > So the above will actually work along with the corresponding root-port
> > "assigned-addresses" properties. I still don't like it much because I
> > don't think it accurately reflects the hardware.=20
>=20
> There are lots of valid ways to model the same HW :(
>=20
> Bear in mind, for the PCI case - the OF PCI bindings model the HW
> through the eyes of the abstractions in the PCI specification. That is
> to say, they are not supposed to be an exact representation of the on
> chip architecture.

That seems to be at odds with most other uses of DT that I've come
across. Generally the guideline seems to be to describe hardware
irrespective of the underlying implementation and leave it up to the
driver to translate the DT description into something the OS can use.

> Perhaps this would be clearer if you used 'pcie-root-complex' as the
> name of the top level node?

Perhaps. I'm not sure.

> > same kludgy, non-spec conformant smack that my original proposal had
> > because it uses assigned-addresses for something it wasn't intended
> > to.
>=20
> Yes, only the top level 'reg' method avoids going outside any specs.

Yes. It has a couple of other disadvantages, though, so if what we've
been discussing here is in any way acceptable I'd rather go with that
solution, even if I'm not entirely happy about it either.

Thierry

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRQjViAAoJEN0jrNd/PrOhjLMP/0nS9+2R8Q6TmOUWMPwGW/9g
T6mq2ZnWFEA40PyU2FFtyRdp7sleuWzx5ZUaXuLJ5RQ2XYOPXDhaIC/+r3iGsgeK
VN+XlOkOrPuylqrmhyAOUqlk32WOuypUyI7rr9Si3l+7GfyagZobYIfuvusolrkN
Jz6M2dR+27M6oWs3+rygsfW5bgOtxwE4XkqEH3NPFYpHW1YDThJdDqAFGz1Aadh1
zPEFyfGP9u4Bgd+UmLzrUAdMYWwfXGoTtLrAAI0Z47IxLdhDS9JskE03Zj5QdQJw
rEso3CkGKnL5tUbbyRfz1RMFvUKu/A8y0Oua0beDMUUqysYXbsw82PUxba675N4H
mHNckfj/8kZuxQx+OGfdMucP/lFZ8ZqNE8+2qPabg0z1hL+K36tAG/rRgL1pOV2X
7MM925GFLs4XsGYXNrn6lBmnBnuWlSmD08y+KmrniLoXFDFzyKcqOtzfygcKVe9D
+O21o/rvjnlzJJcK5HY0LTVpKFveIDNd6yKrRLhnbw7AnN1OSC3SD+86L6AukOvu
g0WnrPp8UL0LT4fdtqIGv5fI77GZcnhItCpYUxz/qx+E0lmN02TUrWxyPFmqOZtT
2ue7axWKuCDGMUjGEBe+LG7jQZMfgp05dRRJTAb/84erBsjifTjAz4r/GNA4PlWG
kypEybh3GU+wIkWwM+ws
=v5K4
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
