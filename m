Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:62892 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109Ab2HMRkb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 13 Aug 2012 13:40:31 -0400
Date: Mon, 13 Aug 2012 19:40:03 +0200
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
Message-ID: <20120813174003.GA2527@avionic-0098.mockup.avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <50201E1D.5060200@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
In-Reply-To: <50201E1D.5060200@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--yLVHuoLXiP9kZBkt
Content-Type: multipart/mixed; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline


--6sX45UoQRIJXqkqR
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
>=20
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
>=20
> Thanks.

I've looked into this a bit, and it seems like ARM is using an open-
coded version of the pci_enable_resources() function here, with the only
difference being the unconditional enabling of both I/O and memory-
mapped access for bridges. On Tegra there is already a PCI fixup to do
this, so pci_enable_resources() can be used as-is. I came up with the
attached patch but haven't been able to test it yet.

Thierry

--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="0001-ARM-PCI-refactor-pcibios_enable_device.patch"
Content-Transfer-Encoding: quoted-printable

=46rom ebd69ae0a3d076e574da74d963cb3834b71dc6ad Mon Sep 17 00:00:00 2001
=46rom: Thierry Reding <thierry.reding@avionic-design.de>
Date: Mon, 13 Aug 2012 18:49:28 +0200
Subject: [PATCH] ARM: PCI: refactor pcibios_enable_device()

The implementation is an open-coded version on pci_enable_resources()
with a special case to enable I/O and memory-mapped functionality on
bridges. This commit reuses the existing PCI core implementation of the
pci_enable_resources() function. This also means that bridges no longer
enable I/O and memory-mapped functionality unconditionally. Platforms
where this is really required can add a corresponding fixup.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 arch/arm/kernel/bios32.c | 36 +-----------------------------------
 1 file changed, 1 insertion(+), 35 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 13fd97b..dfe25f7 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -601,41 +601,7 @@ resource_size_t pcibios_align_resource(void *data, con=
st struct resource *res,
  */
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
-	u16 cmd, old_cmd;
-	int idx;
-	struct resource *r;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	old_cmd =3D cmd;
-	for (idx =3D 0; idx < 6; idx++) {
-		/* Only set up the requested stuff */
-		if (!(mask & (1 << idx)))
-			continue;
-
-		r =3D dev->resource + idx;
-		if (!r->start && r->end) {
-			printk(KERN_ERR "PCI: Device %s not available because"
-			       " of resource collisions\n", pci_name(dev));
-			return -EINVAL;
-		}
-		if (r->flags & IORESOURCE_IO)
-			cmd |=3D PCI_COMMAND_IO;
-		if (r->flags & IORESOURCE_MEM)
-			cmd |=3D PCI_COMMAND_MEMORY;
-	}
-
-	/*
-	 * Bridges (eg, cardbus bridges) need to be fully enabled
-	 */
-	if ((dev->class >> 16) =3D=3D PCI_BASE_CLASS_BRIDGE)
-		cmd |=3D PCI_COMMAND_IO | PCI_COMMAND_MEMORY;
-
-	if (cmd !=3D old_cmd) {
-		printk("PCI: enabling device %s (%04x -> %04x)\n",
-		       pci_name(dev), old_cmd, cmd);
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-	return 0;
+	return pci_enable_resources(dev, mask);
 }
=20
 int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
--=20
1.7.11.4


--6sX45UoQRIJXqkqR--

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQKTvzAAoJEN0jrNd/PrOhJfIQAIFJN+tWZY0ayZJIzdP5EtbL
kcWpeldQaJhutoP4eOrgwGBqhzgtdp7XAyL4UnrRpHTXpDJfory5YRQ1MUucaXSy
Jafp7kDIfLLAqJsHpXHviblroxiPhvn+ODNY6Iv0sgcvSr9rQo8zdk+KKUzZYZ8F
MPFeWjRrK8/spN+u2vRyYzA8T81R1m5g4i0yJKu8wCiEu45iEIBYZOe1i8idk6+o
TxbfvP/I+8ypZwGs843ecIAC/EkZmev440r+App9q6ABFiAL3Xdu9G0sdiaTM2+y
lnnpRUSjKJf+wE9gw2ZdbR6DMTGkzt8SQX3Vx7BNkxTPFSUNKdjrMoIlt3Kvdql+
zXMHMz9E2uf3L6Q6E7tobnXSW9Xc5boj7iuTyS5UHhC5+qpQn79pIH76SThrxew1
xuxAFRf7KQ/Apm5gOGbn3P/3D9DNdl/LXGIHT1TPUNmPKCQD5eOQJQblVA9heGRE
hzTrbB498ZvkJ8FMK6bydy3JwuOI+QxK8pBxHkIFvgFsGb/eGrBy6c0OhT9lnXQP
+wI7koj2VcX4aQ8tOECRMvLMpkX5bz02ioA7tEQUKVM2OBTUsvFQ38Fga4koLuMQ
YXdEWx+mUzOJU/B5cuEh4uLFsQYAQmMkDPw4Mnc97Bzd/xSFH6+rGGnh3qRhIl5m
fx86W+wOoRdQH4PVZrFY
=DYZw
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--
