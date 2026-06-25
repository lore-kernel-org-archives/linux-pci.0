Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18513364028
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 06:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782368430; cv=none; b=rnShwX+YOKq/NEqACp4qz5w+6GYcIDkREmOmN8paxtJ9v5c9Tb6YvwQbE/aRdx15aE0Zq8NdVKvAgFC1DZ/T/u828+5mh3yBLadctDtykhRaTOULZjBa3+Hh0LkmA19ZG/v+wcGpj14LaIP2RJo/rrERuJweOysYE7E4osfExzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782368430; c=relaxed/simple;
	bh=20yGuDkyv5ZxX0tMGt5BV1PzZNqDa6dkhdNy49bCqc8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YNbrCB52S1gG8x/yKhPSg56GG91+qkx5OLwn5tXNNzlznNMwFhqAkKUZQQ/hbS4Jo6M/gAGnZBpExc7E/ga+mXPdyuJOqFhOGkmvgw7CI0AtK75TYEk6j9uwda3xZmcJ0rb+huqmx0CVdZJo7Bmvw7aHSYajz4laBzCliil4wQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipkp400q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipkp400q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB8B1F000E9;
	Thu, 25 Jun 2026 06:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782368428;
	bh=x6OI9WsjMYnXQK7a2cCscY3Ls4yT8fL6jzQmecEni50=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ipkp400qvzfUb+xRIeJQYWV+X9NFvzwvVS3dxkcgNOW4WXQNueEQXz3X6kvMQ39Rx
	 xYva8ZXtTnzeriTy1tVZHRHVOA41gkqCqnpt9OMq3ZKzySxjl0/0/lVC9HfaS2JjAO
	 jWoz3WVG2E596H97e83ES8JA4wpm7IlZNxLOyT4O2kgGyAfpDPPkbIOHoAnk27DIUS
	 68hEq47yvbj+DgSHIUmHyhvwDcLzFQUcCP5pVZC+7zt6x0LOvqAR4aSEMVuM0uCdGc
	 75c9pnlv92R1s28vwLQVGe9J/bWazUtrTp/kYvdinJW7Y/1x0P93w0Rh7X6maiAIiW
	 DGVVWtpCWZbmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/8] PCI: vmd: Add support for second rootbus under
 VMD
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260625082940.1290740-8-szymon.durawa@linux.intel.com>
References: <20260625082940.1290740-1-szymon.durawa@linux.intel.com>
 <20260625082940.1290740-8-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 06:20:27 +0000
Message-Id: <20260625062028.0CB8B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Flawed arithmetic when configuring MEMBAR offsets guarantees o=
verlapping or gapped PCI resource windows between BUS0 and BUS1.
- [High] Failure to clean up VMD_BUS_0 on VMD_BUS_1 creation failure leads =
to a severe Use-After-Free.
- [High] Iterating over an unvalidated sum of disjoint bus ranges in `vmd_d=
omain_reset` causes missed bus resets and potential out-of-bounds MMIO acce=
sses.
- [Medium] VMD_RES_BUS1_CFGBAR is assigned an IORESOURCE_MEM resource as it=
s parent, corrupting the resource tree.
- [Medium] An uninitialized stack variable is assigned to resource bounds i=
f PCI config space reads fail.
--

commit 46d85add5d9d3ed310b9c5a3c11026a4231b01a9
Author: Szymon Durawa <szymon.durawa@linux.intel.com>
Subject: PCI: vmd: Add support for second rootbus under VMD

Starting from Intel Arrow Lake VMD enhancement introduces second root bus
support with fixed root bus number (0x80). It means that all 3 MMIO BARs
exposed by VMD are shared now between both buses (current BUS0 and
new BUS1).

Add new BUS1 enumeration and divide MMIO space to be shared between
both root buses.

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 2bfc16875d912..c68ea7837620d 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c

[ ... ]

> @@ -537,11 +568,23 @@ static inline void vmd_acpi_end(void) { }
> =20
>  static void vmd_domain_reset(struct vmd_dev *vmd)
>  {
> -	u16 bus, max_buses =3D resource_size(&vmd->resources[VMD_RES_CFGBAR]);
> +	u16 bus, bus_cnt =3D resource_size(&vmd->resources[VMD_RES_CFGBAR]);
>  	u8 dev, functions, fn, hdr_type;
>  	char __iomem *base;
> =20
> -	for (bus =3D 0; bus < max_buses; bus++) {
> +	/*
> +	 * Total bus-number count (bus_cnt) when BUS1 root bus is present:
> +	 * initialized with BUS0 CFGBAR range, extended by BUS1 CFGBAR range pl=
us
> +	 * one bus number per root bus' own config space (bus_cnt is increased =
by 2)
> +	 * as the CFGBAR ranges do not include the root bus config space.
> +	 */
> +
> +	if (vmd->bus1_rootbus) {
> +		bus_cnt +=3D resource_size(&vmd->resources[VMD_RES_BUS1_CFGBAR]);
> +		bus_cnt +=3D 2;
> +	}
> +
> +	for (bus =3D 0; bus < bus_cnt; bus++) {
>  		for (dev =3D 0; dev < 32; dev++) {
>  			base =3D vmd->cfgbar + PCIE_ECAM_OFFSET(bus,
>  						PCI_DEVFN(dev, 0), 0);

[Severity: High]
The bus_cnt variable combines the sizes of both the BUS0 and BUS1 CFGBAR
ranges. If the ranges for BUS0 and BUS1 are sparse, does this continuous
loop up to the sum of their sizes end up missing the higher bus numbers?

Could this also access out-of-bounds MMIO offsets if the sum exceeds the
mapped region for ECAM?

[ ... ]

> @@ -799,6 +867,30 @@ static void vmd_configure_cfgbar(struct vmd_dev *vmd)
>  		       (resource_size(res) >> 20) - 1,
>  		.flags =3D IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
>  	};
> +
> +	if (vmd->bus1_rootbus) {
> +		u16 bus0_range =3D 0;
> +		u16 bus1_range =3D 0;
> +
> +		pci_read_config_word(vmd->dev, VMD_BUSRANGE0, &bus0_range);
> +		pci_read_config_word(vmd->dev, VMD_BUSRANGE1, &bus1_range);
> +
> +		/*
> +		 * Resize BUS0 CFGBAR range to make space for BUS1
> +		 * owned devices by adjusting range end with value stored in
> +		 * VMD_BUSRANGE0 register.
> +		 */
> +		vmd->resources[VMD_RES_CFGBAR].start =3D VMD_BUS_START(bus0_range);
> +		vmd->resources[VMD_RES_CFGBAR].end =3D VMD_BUS_END(bus0_range);
> +
> +		vmd->resources[VMD_RES_BUS1_CFGBAR] =3D (struct resource){
> +			.name =3D "VMD CFGBAR BUS1",
> +			.start =3D VMD_BUS_START(bus1_range),
> +			.end =3D VMD_BUS_END(bus1_range),
> +			.flags =3D IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
> +			.parent =3D res,
> +		};
> +	}
>  }

[Severity: Medium]
The res pointer here refers to VMD_CFGBAR, which is an IORESOURCE_MEM
resource. Is it safe to assign a memory resource as the parent to
VMD_RES_BUS1_CFGBAR, which is an IORESOURCE_BUS resource?

Will this cross-namespace parenting confuse the generic PCI resource
management?

[ ... ]

> @@ -840,41 +932,83 @@ static void vmd_configure_membar(struct vmd_dev *vm=
d,
>  static void vmd_configure_membar1_membar2(struct vmd_dev *vmd,
>  					  resource_size_t mbar2_ofs)
>  {
> -	vmd_configure_membar(vmd, 1, VMD_MEMBAR1, 0, 0);
> -	vmd_configure_membar(vmd, 2, VMD_MEMBAR2, mbar2_ofs, 0);
> +	if (vmd->bus1_rootbus) {
> +		u32 bus1_mbar1_ofs =3D 0;
> +		u64 bus1_mbar2_ofs =3D 0;
> +		u32 reg;
> +
> +		pci_read_config_dword(vmd->dev, VMD_MEMBAR1_OFFSET,
> +				      &bus1_mbar1_ofs);
> +
> +		pci_read_config_dword(vmd->dev, VMD_MEMBAR2_OFFSET1, &reg);
> +		bus1_mbar2_ofs =3D reg;

[Severity: Medium]
If pci_read_config_dword() fails due to a bus error or unsupported
operation, it leaves reg untouched. Could this result in uninitialized
stack memory being used to configure the physical MMIO allocation for
BUS1?

> +
> +		pci_read_config_dword(vmd->dev, VMD_MEMBAR2_OFFSET2, &reg);
> +		bus1_mbar2_ofs |=3D (u64)reg << 32;
> +
> +		/*
> +		 * Resize BUS MEMBAR1 and MEMBAR2 ranges to make space
> +		 * for BUS1 owned devices by adjusting range end with values
> +		 * stored in VMD_MEMBAR1_OFFSET and VMD_MEMBAR2_OFFSET registers
> +		 */
> +		vmd_configure_membar(vmd, VMD_RES_MBAR_1, VMD_MEMBAR1, 0,
> +				     bus1_mbar1_ofs);
> +		vmd_configure_membar(vmd, VMD_RES_MBAR_2, VMD_MEMBAR2,
> +				     mbar2_ofs, bus1_mbar2_ofs - mbar2_ofs);
> +
> +		vmd_configure_membar(vmd, VMD_RES_BUS1_MBAR_1, VMD_MEMBAR1,
> +				     bus1_mbar1_ofs, 0);
> +		vmd_configure_membar(vmd, VMD_RES_BUS1_MBAR_2, VMD_MEMBAR2,
> +				     mbar2_ofs + bus1_mbar2_ofs, 0);

[Severity: Critical]
The vmd_configure_membar() function subtracts the last argument from the
end of the resource. By passing bus1_mbar1_ofs as both the start offset
for BUS1 and the amount to subtract from the end of BUS0, won't the
resources overlap?

For example, if the offset is smaller than half the total BAR size, does
this cause identical physical MMIO ranges to be assigned to distinct
devices on BUS0 and BUS1?

[ ... ]

> @@ -1028,6 +1164,27 @@ static int vmd_enable_domain(struct vmd_dev *vmd, =
unsigned long features)
> =20
>  	vmd_bus_enumeration(vmd->bus[VMD_BUS_0], features);
> =20
> +	if (vmd->bus1_rootbus) {
> +		ret =3D vmd_create_bus(vmd, VMD_BUS_1, sd, offset);
> +		if (ret) {
> +			pci_err(vmd->dev, "Can't create BUS1: %d\n", ret);
> +			return ret;
> +		}

[Severity: High]
If vmd_create_bus() fails for VMD_BUS_1, this path returns early. However,
VMD_BUS_0 has already been fully created and enumerated earlier in this
function.

Since vmd_remove() is not called on the probe error path, does this leave
VMD_BUS_0 active while the struct vmd_dev context is subsequently freed by
devres, resulting in a use-after-free?

> +
> +		/*
> +		 * Primary bus is not set by pci_create_root_bus(), it is
> +		 * updated here
> +		 */
> +		vmd->bus[VMD_BUS_1]->primary =3D VMD_PRIMARY_BUS1;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625082940.1290=
740-1-szymon.durawa@linux.intel.com?part=3D7
