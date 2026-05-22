Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590CD370D6E
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464538; cv=none; b=GzdWK+CqeqlJE75D4C1SZkXylDRUObqOBBgdAdBqR1T8dGP+121In8lVzc4TM92Vv5V+cQ0MgRI5szGbyr8wBc4b3y2+/nREhVdQJVW1mR3/qKuoxSN+roiMgsdGJHYYFaV1Pjo7e9CgYRH3goYiN3H5jzHhugXxsvEiayffwf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464538; c=relaxed/simple;
	bh=9t8yDYVALDaHr/+UL3BokvoH9pXQxH6KAHWptUpsIIs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TtvOqxZvjg8GEi4NBb58XZnM5Jriup9Xg20Svwp2yPDyjmve0/06+iTE0ZzzsmBFA+acxRXFo/6MbhGNl3U0g8HL3xRkEd8a8/jkBigMLL2vZ62Eak2dkHQtaTdzgFypsVgORv36DpkPULRP37mLHDUVPiTX8F5dZMMbiJ/7r0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeZsw7OM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeZsw7OM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0D61F000E9;
	Fri, 22 May 2026 15:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779464536;
	bh=0JWFp+k0ki+beY7/lyLgJ/DNU6Tuq6aJ+0Tfmc5WBUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CeZsw7OM5mBvtE3CCUOmgiAMf1mwfDj65AfIL+txjtmZgjCWUMDdnSp8HCalp14Rs
	 1ABFKt1GNEJPP/mqOQnw/4CBJZI1PEGllkRJiuhOpjGPHtok0qYfe4kLsGCWnn2zNR
	 hvz35Tjfsr0USudLyOqchnX70XJ1gMQO7XyPsSr20r1mHDtMK3Je5+ZGxRFAxBqZzV
	 JCUSIbZqmKPatPk5Ti6lz1eRXTKXObizhqAo8YBifiG4dz9Fp4kg1eUtTcfdIMqJXG
	 4wQEdN/fmh4vbkKaWLFxfcYttI5JObP5gj5w4BOQvCAIaWK0cJJ0Ivn/TcOOjqStp1
	 IRs4wIoyM0jSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] PCI: vmd: Add feature to scan BIOS enumerated
 devices.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nirmal Patel" <nirmal.patel@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260522150829.5246-1-nirmal.patel@linux.intel.com>
References: <20260522150829.5246-1-nirmal.patel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 15:42:16 +0000
Message-Id: <20260522154216.AA0D61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] The driver unconditionally reads from fixed offsets in BAR4 withou=
t verifying that the BAR size is sufficiently large.
- [High] The PCI bus resource `.end` is unconditionally hardcoded to `0xff`=
, breaking legacy devices with smaller configuration BARs.

Pre-existing issues:
- [High] Allocated IRQ vectors are leaked in multiple error paths and durin=
g device teardown.
- [High] Per-CPU memory allocated for SRCU structures is leaked on error pa=
ths.
- [High] SRCU lock structures are destroyed before the IRQ handlers are unr=
egistered, allowing a use-after-free.
- [High] Subtracting a fixed offset from the resource bounds of MEMBAR2 wit=
hout verifying the actual BAR length causes an integer underflow.
--

commit 0653c66e9c93e9c62213a329c19bf93e4499969f
Author: Nirmal Patel <nirmal.patel@linux.intel.com>
Subject: PCI: vmd: Add feature to scan BIOS enumerated devices.

This commit introduces the VMD_FEAT_USE_BIOS_INFO feature flag for device
0x28c1. It parses configuration parameters, bus start ranges, and shadow
registers directly from the BIOS-populated BAR4/BAR5 MMIO space rather
than enumerating the tree dynamically.

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index d4ae250d4bc6d..7c90243b5ff0c 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
[ ... ]
> @@ -661,6 +686,46 @@ static int vmd_get_bus_number_start(struct vmd_dev *=
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
> +
> +	bar4 =3D pci_ioremap_bar(vmd->dev, 4);
> +	if (!bar4)
> +		return -ENOMEM;
> +
> +	/* Read shadow registers for MEMBAR1 and MEMBAR2 physical addresses. */
> +	phys1 =3D readq(bar4 + SHADOW_MEMBAR1_28C1);

[Severity: High]
Does this code read out-of-bounds if the hardware presents a smaller BAR4?

pci_ioremap_bar() maps the available resource, but there doesn't appear to
be a check verifying that the BAR length is at least large enough to cover
the fixed offsets being read, such as 0x2840 (BASE_ID_REG_28C1).

Could a misconfigured or malicious device trigger an out-of-bounds MMIO
read here?

> +	phys2 =3D readq(bar4 + SHADOW_MEMBAR2_28C1);
[ ... ]
> @@ -711,6 +776,53 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
>  	return 0;
>  }
> =20
> +static int vmd_prepare_offsets_and_bus(struct vmd_dev *vmd,
> +					unsigned long features,
> +					resource_size_t *membar2_offset,
> +					resource_size_t *offset1,
> +					resource_size_t *offset2)
> +{
> +	int ret;
> +
> +	/*
> +	 * Shadow registers may exist in certain VMD device ids which allow
> +	 * guests to correctly assign host physical addresses to the root ports
> +	 * and child devices. These registers will either return the host value
> +	 * or 0, depending on an enable bit in the VMD device.
> +	 */
> +	/*
> +	 * For certain VMD devices (i.e. 0x28C1), BIOS places device info
> +	 * in BAR4 shadow registers to determine the base bus number and memory
> +	 * offsets.
> +	 */
> +	if (features & VMD_FEAT_USE_BIOS_INFO) {
> +		*membar2_offset =3D MEMBAR2_OFFSET_28C1;

[Severity: High]
This is a pre-existing issue, but can setting this offset cause an integer
underflow later?

In vmd_enable_domain(), the resource start is calculated as:

	vmd->resources[2] =3D (struct resource) {
		.name  =3D "VMD MEMBAR2",
		.start =3D res->start + membar2_offset,
		.end   =3D res->end,
		...
	};

If the physical MEMBAR2 length provided by the hardware is smaller than
membar2_offset, start becomes greater than end, which could cause
resource_size() to underflow and yield a massively inflated memory window.

> +		ret =3D vmd_get_bus_info_from_bar4(vmd, offset1, offset2);
> +		if (ret)
> +			return ret;
> +	} else if (features & VMD_FEAT_HAS_MEMBAR_SHADOW) {
[ ... ]
> @@ -784,38 +896,16 @@ static int vmd_enable_domain(struct vmd_dev *vmd, u=
nsigned long features)
>  	struct pci_dev *dev;
>  	int ret;
> =20
> -	/*
> -	 * Shadow registers may exist in certain VMD device ids which allow
[ ... ]
> -	if (features & VMD_FEAT_HAS_BUS_RESTRICTIONS) {
> -		ret =3D vmd_get_bus_number_start(vmd);
> -		if (ret)
> -			return ret;
> -	}
> +	ret =3D vmd_prepare_offsets_and_bus(vmd, features, &membar2_offset,
> +					  &offset[0], &offset[1]);
> +	if (ret)
> +		return ret;
> =20
>  	res =3D &vmd->dev->resource[VMD_CFGBAR];
>  	vmd->resources[0] =3D (struct resource) {
>  		.name  =3D "VMD CFGBAR",
>  		.start =3D vmd->busn_start,
> -		.end   =3D vmd->busn_start + (resource_size(res) >> 20) - 1,
> +		.end   =3D 0xff,

[Severity: High]
Does unconditionally setting the end to 0xff cause a regression for legacy
VMD devices with smaller configuration BARs?

Older devices on client platforms might have smaller CFGBARs. Claiming buses
up to 255 might cause the PCI subsystem to erroneously assign bus numbers
that fall outside the hardware's actual ECAM capabilities.

>  		.flags =3D IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
>  	};
> =20
> @@ -868,19 +958,21 @@ static int vmd_enable_domain(struct vmd_dev *vmd, u=
nsigned long features)
>  	 * acceptable because the guest is usually CPU-limited and MSI
>  	 * remapping doesn't become a performance bottleneck.
>  	 */
> -	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
> -	    offset[0] || offset[1]) {
> -		ret =3D vmd_alloc_irqs(vmd);
> -		if (ret)
> -			return ret;
> +	if (!(features & VMD_FEAT_USE_BIOS_INFO)) {
> +		if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
> +		    offset[0] || offset[1]) {
> +			ret =3D vmd_alloc_irqs(vmd);
> +			if (ret)
> +				return ret;
> =20
> -		vmd_set_msi_remapping(vmd, true);
> +			vmd_set_msi_remapping(vmd, true);
> =20
> -		ret =3D vmd_create_irq_domain(vmd);
> -		if (ret)
> -			return ret;
> +			ret =3D vmd_create_irq_domain(vmd);
> +			if (ret)
> +				return ret;

[Severity: High]
This is a pre-existing issue, but are IRQ vectors leaked when errors occur
here?

The PCI subsystem guidelines mandate calling pci_free_irq_vectors() in error
paths after a successful pci_alloc_irq_vectors(). If vmd_create_irq_domain()
fails, we return directly without freeing the vectors allocated in
vmd_alloc_irqs(). This same cleanup omission appears to exist in vmd_remove=
()
as well, potentially leading to system IRQ capacity exhaustion.

Additionally, if vmd_alloc_irqs() fails midway through devm_request_irq(),
does it return without cleaning up the successfully initialized SRCU
structures from previous loop iterations? The per-CPU memory allocated by
init_srcu_struct() might be leaked.

[Severity: High]
Also a pre-existing issue, but does using devm_request_irq() for the
handlers cause a use-after-free during device teardown?

In vmd_remove(), the driver calls vmd_cleanup_srcu() which destroys the SRCU
structures. However, since the IRQs are managed by devres, they aren't
deregistered until after vmd_remove() returns.

If an interrupt fires in this window, vmd_irq() would call srcu_read_lock()
on an already-destroyed SRCU structure.

> +		} else {
> +			vmd_set_msi_remapping(vmd, false);
> +		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522150829.5246=
-1-nirmal.patel@linux.intel.com?part=3D1
