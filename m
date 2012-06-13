Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59252 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455Ab2FMGp1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jun 2012 02:45:27 -0400
Date: Wed, 13 Jun 2012 08:45:19 +0200
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
Message-ID: <20120613064519.GD31001@avionic-0098.mockup.avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-8-git-send-email-thierry.reding@avionic-design.de>
 <4FD66410.7090001@wwwdotorg.org>
 <20120612062124.GE4040@avionic-0098.adnet.avionic-design.de>
 <4FD763C5.3090500@wwwdotorg.org>
 <20120612172041.GA28010@avionic-0098.adnet.avionic-design.de>
 <4FD7A36B.9090409@wwwdotorg.org>
 <4FD7B085.1020006@firmworks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
In-Reply-To: <4FD7B085.1020006@firmworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Mitch Bradley wrote:
> On 6/12/2012 10:15 AM, Stephen Warren wrote:
> >On 06/12/2012 11:20 AM, Thierry Reding wrote:
> >...
> >>I came up with the following alternative:
> >>
> >>	pci {
> >>		compatible =3D "nvidia,tegra20-pcie";
> >>		reg =3D<0x80003000 0x00000800   /* PADS registers */
> >>		       0x80003800 0x00000200   /* AFI registers */
> >>		       0x80004000 0x00100000   /* configuration space */
> >>		       0x80104000 0x00100000   /* extended configuration space */
> >>		       0x80400000 0x00010000   /* downstream I/O */
> >>		       0x90000000 0x10000000   /* non-prefetchable memory */
> >>		       0xa0000000 0x10000000>; /* prefetchable memory */
> >>		interrupts =3D<0 98 0x04   /* controller interrupt */
> >>		              0 99 0x04>; /* MSI interrupt */
> >>		status =3D "disabled";
> >>
> >>		ranges =3D<0x80000000 0x80000000 0x00002000   /* 2 root ports */
> >>			  0x80004000 0x80004000 0x00100000   /* configuration space */
> >>			  0x80104000 0x80104000 0x00100000   /* extended configuration space=
 */
> >>			  0x80400000 0x80400000 0x00010000   /* downstream I/O */
> >>			  0x90000000 0x90000000 0x10000000   /* non-prefetchable memory */
> >>			  0xa0000000 0xa0000000 0x10000000>; /* prefetchable memory */
> >>
> >>		#address-cells =3D<1>;
> >>		#size-cells =3D<1>;
> >>
> >>		port@80000000 {
> >>			reg =3D<0x80000000 0x00001000>;
> >>			status =3D "disabled";
> >>		};
> >>
> >>		port@80001000 {
> >>			reg =3D<0x80001000 0x00001000>;
> >>			status =3D "disabled";
> >>		};
> >>	};
> >>
> >>The "ranges" property can probably be cleaned up a bit, but the most
> >>interesting part is the port@ children, which can simply be enabled in =
board
> >>DTS files by setting the status property to "okay". I find that somewha=
t more
> >>intuitive to the variant with an "enable-ports" property.
> >>
> >>What do you think of this?
> >
> >As a general concept, this kind of design seems OK to me.
> >
> >The "port" child nodes I think should be named "pci@..." given Mitch's
> >comments, I think.
> >
> >The port nodes probably need two entries in reg, given the following in
> >our downstream driver:
> >
> >>         int rp_offset =3D 0;
> >>         int ctrl_offset =3D AFI_PEX0_CTRL;
> >...
> >>         for (port =3D 0; port<  MAX_PCIE_SUPPORTED_PORTS; port++) {
> >>                 ctrl_offset +=3D (port * 8);
> >>                 rp_offset =3D (rp_offset + 0x1000) * port;
> >>                 if (tegra_pcie.plat_data->port_status[port])
> >>                         tegra_pcie_add_port(port, rp_offset, ctrl_offs=
et);
> >>         }
> >
> >(which actually looks likely to be horribly buggy for port>1 and only
> >accidentally correct for port=3D=3D1, but anyway...)
> >
> >But instead, I'd be tempted to make the top-level node say:
> >
> >	#address-cells =3D<1>;
> >	#size-cells =3D<0>;
> >
> >... so that the child nodes' reg is just the port ID. The parent node
> >can calculate the addresses/offsets of the per-port registers within the
> >PCIe controller's register space based on the ID using code roughly like
> >what I quoted above:
> >
> >	pci@0 {
> >		reg =3D<0>;
> >		status =3D "disabled";
> >	};
> >
> >	pci@1 {
> >		reg =3D<0>;
> >		status =3D "disabled";
> >	};
> reg =3D <1> ?
>=20
> >
> >
> >That would save having to put 2 entries in the reg, and perhaps remove
> >the need for any ranges property.
>=20
> ISTM that having two reg entries, specifying the rp and ctrl
> registers, is preferable to having code to calculate the addresses.
> That makes the code simpler and the device tree more directly
> descriptive of the hardware layout.  The less "magic" (in this case,
> the register address calculation), the better.

The problem with this approach is that since the control registers are
within the AFI register range, both the reg and ranges properties of the
parent would have to include these holes. Furthermore it means that the
controller driver would have to remap the AFI registers in chunks, for the
sole reason of splitting out the controle registers.

Would it be acceptable to make an exception in this case and use the port's
second reg entry as an offset into the AFI register range instead?

Thierry

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/YNv8ACgkQZ+BJyKLjJp+nxwCeIETw2MF0LjWdgN3T2Gou6MfH
IfkAn3kaoCzPbnQFlx2Yk85kIfXh6zwR
=QoJm
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
