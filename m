Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:60838 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016Ab2HGSVH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Aug 2012 14:21:07 -0400
Date: Tue, 7 Aug 2012 20:20:24 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Russell King <linux@arm.linux.org.uk>, linux-tegra@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 00/10] ARM: tegra: Add PCIe device tree support
Message-ID: <20120807182024.GA11328@avionic-0098.mockup.avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <50201E1D.5060200@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
In-Reply-To: <50201E1D.5060200@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 06, 2012 at 01:42:21PM -0600, Stephen Warren wrote:
> On 07/26/2012 01:55 PM, Thierry Reding wrote:
> > This patch series adds support for device tree based probing of the PCIe
> > controller found on Tegra SoCs.
>=20
> Thierry, I just tested all Tegra boards in v3.6-rc1, and noticed that
> PCIe doesn't work on TrimSlice when booting use device tree. I think I
> found the cause, and I can't see why the same problem doesn't affect
> this series. Perhaps you can enlighten me?
>=20
> When booting TrimSlice (or Harmony) using board files, Tegra's PCIe is
> initialized using a subsys_initcall to tegra_pcie_init() directly (or
> for Harmony to harmony_pcie_init() which then calls tegra_pcie_init()).
>=20
> The final thing tegra_pcie_init() does is call pci_common_init(). This
> calls pcibios_init_hw() which calls hw->scan() which calls
> pci_scan_root_bus() which adds a device object for each device on the
> PCIe bus. However, since this happens very early in the boot sequence, I
> believe the enumerated PCIe devices don't immediately get probed.
> Instead, control gets returned to pci_common_init() which I believe then
> calls pci_bus_assign_resources() which actually sets up the resources
> for those devices. Later, the PCIe devices actually get probed, and
> everything works.
>=20
> However, when booting using device tree, with the code currently in
> v3.6-rc1, tegra_pcie_init() is called late in the boot sequence, and so
> in the sequence described above, as soon as pci_scan_root_bus() adds a
> device, it gets probed, before the device object's resources have been
> set up, which results in the following failure:
>=20
> PCI: Device 0000:01:00.0 not available because of resource collisions
>=20
> ... because of the following code in pcibios_enable_device():
>=20
> > 	for (idx =3D 0; idx < 6; idx++) {
> > 		/* Only set up the requested stuff */
> > 		if (!(mask & (1 << idx)))
> > 			continue;
> >=20
> > 		r =3D dev->resource + idx;
> > 		if (!r->start && r->end) {
> > 			printk(KERN_ERR "PCI: Device %s not available because"
> > 			       " of resource collisions\n", pci_name(dev));
>=20
> Doesn't this same problem exist when instantiating the PCIe device
> itself from device tree as in your patch series? If not, can you explain
> why?

I think I've seen this before as well but hadn't had the time to
investigate further. The devices that failed to initialize were serial
ports I think. Perhaps the ordering here is the key. All the drivers
that I use for the PCI devices are loaded as modules, so they'll probe
the devices much later anyway. The serial driver is an exception here as
it is builtin.

> Now, the obvious solution in v3.6 would be to simply have
> tegra_pcie_init() be called at the same early stage in the boot process
> when booting using device tree as it is when booting using board files.
> This works for TrimSlice.
>=20
> However, on Harmony, it doesn't work, because PCIe on Harmony depends on
> regulators, and the regulators are accessed using an I2C bus that is
> instantiated from DT, and the instantiation of the I2C bus happens
> fairly late in the boot process so can't be found early during the boot
> sequence. See harmony_regulator_init() for the failing code.
>=20
> Does anyone have any good ideas (small, self-contained patches) for
> solving this in v3.6 in such a way that PCIe works on both TrimSlice and
> Harmony?

To me this looks like a problem in the probing code. Drivers' .probe()
shouldn't be called on devices that haven't had their resources assigned
yet. Perhaps nobody has ever seen this before because the ordering
always ensured that the PCI controller driver was loaded first.

Thierry

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQIVxoAAoJEN0jrNd/PrOho90P/01oIODwJG7mLqxCp6EPeMO8
n3GpjqHDDvHWAlMfN7ndq9xPgYnHgZ2Cq43qhfr6/ps+s71EZXmMu75nxGaxpByG
igreDRA6BQRoCClZipoOrVz22a510jSHRhZ4ANKbseLz3IfHmvmk6YH0g+qG0KH1
128Wa97n/mpzACFBn19vk292Ikd7J85vJlt3Y1E6BIDMPAS6YPOxMtB0Z3DrlSia
7M+4UWbGFtoveIMX0RJROKYJvmcL7CnG/iIYOQZj5ZTl7VwByNuF+SzCb64RTToC
nmVQji3IpVQ/raVJ71EKKIxKzzLdKT6SK1/5L4j+eJXv/xXRZhP7UsqM7TuLqoX7
CVWN27bvIOQX5ffD8ZT8dvSFDFb8U2zdkfw7B6alDwZFDTNCiO6PQKaDCS4+wlKc
Ma7Y/gWdazPs2Lek9RRptkKqSEZwiF3L9++Lp69/UExC+kTUA4URwTX9Q1sTpAFA
Rt3zkXVJdQ33BOf9nPYAZV2aOO3H7vi5+AlC6fMaq8yS4pjc0rOprrzk8IoRyYas
48XdOd82grZ2jzeHkvY5sY/xOhSILVZbwHGIlzJWi5g11k3YO6oHwyHTJL8SZwvO
1C7JbgaP9ng7EBJLhRaGiwKNBsdyqjkr4WqQMeeoChIQwTnReBWer74ZWbvj64qG
3i+gxyViOmVUvoXXkdnF
=GGeB
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
