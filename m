Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B906B3D2FE1
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782143793; cv=none; b=FzHkzrYsmr3j4kQK0z+f19Y4afS1FWuK9sGJXvD22IEpSCBDaV0qSOctAJPVEgybVT0oZtJDA6IEgwKxQFcHvUNzggxELL3FA/JpgCVQK9xfwiU9r9jncTjXRXV3Bn4E4Gy/1yP6bkn5lwExeLo6HSSbn9hxuglZAAhyn4rLjK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782143793; c=relaxed/simple;
	bh=LfIivbfV3mYvLmdHFWtUIDRcWwkMdTYmJFRILwiLDf0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fwzVDPCRTWRM9C57PcAFO6InenrPJTP1KkAQw7pWtJ7+y85+WnUo0PeBxo63LVcWJ8WCQ48MxyH3HJvR8roulAAmhsAnyc1DsTFbTzrWI9L/0X29Vy4Rc/Blh+dcyLIHk0utkZcu6w104gZ8+eCYngUOSqW00VKl49QfMz18wCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nd9ffDr7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nd9ffDr7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462341F00A3A;
	Mon, 22 Jun 2026 15:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782143792;
	bh=dEbuY52JC/R1Yo0sYyrOyqykn5G7vmkZnJ9Wj5VbuCE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nd9ffDr70urh8EvcgCHBhO8GeRotG1NPBWe0HuHxI3ZKbxJ9KSC4dRH7ovePTljVj
	 b2ZtlL55KUe1YZz6DJQEF8GbJDZiMSz7DCNQORqjgx2ippQznr3rShWV3hqMBw1AZ/
	 OUFPKj6LHJyBOeBvQ1n8gxzBZwEvR58700KminmL30bEY9Cw77K39m/7h2aCDAgw1X
	 J17z+sngSI3X3C+D15dZnC+TKbBD8x9ozdobjtlJLcV6zni7YNMuIEO5e+RxLpHV2k
	 988bWxlTXy8FN8OlAyM24d/YqGw5WzJSJy77i9G9nLx5bGAR3d1F9YcPwrkqAu7U/4
	 2SEk2qosutWAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] PCI: vmd: Add feature to scan BIOS enumerated
 devices.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nirmal Patel" <nirmal.patel@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260622154325.119809-1-nirmal.patel@linux.intel.com>
References: <20260622154325.119809-1-nirmal.patel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 15:56:31 +0000
Message-Id: <20260622155632.462341F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] vmd_remove_irq_domain() returns early for devices with VMD_FEA=
T_USE_BIOS_INFO, permanently leaking the IRQ domain and its fwnode, and cau=
sing an exploitable Use-After-Free.
- [High] vmd_domain_reset() accesses incorrect ECAM offsets when VMD_FEAT_U=
SE_BIOS_INFO is set, failing to reset actual VMD bridges and corrupting unr=
elated MMIO configuration space.
- [Medium] The new `vmd_get_bus_info_from_bar4()` function accesses MMIO re=
gions in BAR4 at hardcoded offsets without validating that the mapped BAR i=
s sufficiently large.
--

commit 371d26de7e81b3dcfea77481a03dd53acb14c51c
Author: Nirmal Patel <nirmal.patel@linux.intel.com>

PCI: vmd: Add feature to scan BIOS enumerated devices.

Newer VMD devices with ID 0x28c1 use BIOS enumeration for the device tree.
This commit updates the VMD driver to read bus hide ranges and shadow
registers from VMD BAR4 to perform bus scans for these devices.

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index d4ae250d4bc6d..a4e03f10a54d6 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c

[ ... ]

> @@ -374,6 +393,9 @@ static void vmd_set_msi_remapping(struct vmd_dev *vmd=
, bool enable)
> =20
>  static void vmd_remove_irq_domain(struct vmd_dev *vmd)
>  {
> +	if (!!(vmd->features & VMD_FEAT_USE_BIOS_INFO))
> +		return;
> +

[Severity: Critical]
Does this early return bypass irq_domain_remove() and irq_domain_free_fwnod=
e(),
permanently leaking the IRQ domain?

In vmd_enable_domain(), vmd_create_irq_domain() is successfully called
for these devices because VMD_FEAT_CAN_BYPASS_MSI_REMAP is not set.

If the IRQ domain remains globally registered, could it cause a use-after-f=
ree
when its struct vmd_dev host_data pointer is automatically freed by devres
during device removal?

>  	/*
>  	 * Some production BIOS won't enable remapping between soft reboots.
>  	 * Ensure remapping is restored before unloading the driver.

[ ... ]

> @@ -393,7 +415,12 @@ static void __iomem *vmd_cfg_addr(struct vmd_dev *vm=
d, struct pci_bus *bus,
>  				  unsigned int devfn, int reg, int len)
>  {
>  	unsigned int busnr_ecam =3D bus->number - vmd->busn_start;
> -	u32 offset =3D PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);
> +	u32 offset;
> +
> +	if (!!(vmd->features & VMD_FEAT_USE_BIOS_INFO))
> +		busnr_ecam =3D bus->number;
> +
> +	offset =3D PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);

[Severity: High]
Since the ECAM offset calculation now uses the absolute bus number for
VMD_FEAT_USE_BIOS_INFO devices, does vmd_domain_reset() also need to be
updated?

Looking at vmd_domain_reset(), it iterates bus from 0 to max_buses and
calculates the MMIO address like this:

drivers/pci/controller/vmd.c:vmd_domain_reset() {
    ...
    for (bus =3D 0; bus < max_buses; bus++) {
        for (dev =3D 0; dev < 32; dev++) {
            base =3D vmd->cfgbar + PCIE_ECAM_OFFSET(bus,
                                    PCI_DEVFN(dev, 0), 0);
    ...
}

If the VMD buses start at a higher number (e.g., 128), could this hardcoded
loop cause vmd_domain_reset() to miss the actual VMD bridges and perform
MMIO reads/writes to incorrect offsets in the lower half of the BAR?

>  	if (offset + len >=3D resource_size(&vmd->dev->resource[VMD_CFGBAR]))
>  		return NULL;

[ ... ]

> @@ -661,6 +688,46 @@ static int vmd_get_bus_number_start(struct vmd_dev *=
vmd)
>  	return 0;
>  }
> =20
> +static int vmd_get_bus_info_from_bar4(struct vmd_dev *vmd,
> +				       resource_size_t *offset1,
> +				       resource_size_t *offset2)
> +{
> +	u64 phys1, phys2, bar4_2840;
> +	void __iomem *bar4;
> +	u32 base_id;
> +	u8 base_bus;
> +
> +	bar4 =3D pci_ioremap_bar(vmd->dev, 4);
> +	if (!bar4)
> +		return -ENOMEM;
> +
> +	/* Read shadow registers for MEMBAR1 and MEMBAR2 physical addresses. */
> +	phys1 =3D readq(bar4 + SHADOW_MEMBAR1_28C1);
> +	phys2 =3D readq(bar4 + SHADOW_MEMBAR2_28C1);

[Severity: Medium]
Could these reads access unmapped kernel memory if the device's BAR4 is
smaller than expected?

Since SHADOW_MEMBAR1_28C1 and BASE_ID_REG_28C1 access offsets like 0x2818
and 0x2840, should we verify that pci_resource_len(vmd->dev, 4) is large
enough to cover these offsets before performing the readq() calls?

> +	/*
> +	 * Read and set bus start number from Base ID register. 24-bit Base ID
> +	 * register is part of 64-bit shadowed reqid hide range register and
> +	 * holds segment, bus, device and function.
> +	 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622154325.1198=
09-1-nirmal.patel@linux.intel.com?part=3D1
