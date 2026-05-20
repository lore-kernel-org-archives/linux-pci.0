Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD8C3C1974;
	Wed, 20 May 2026 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779269366; cv=none; b=AC2GzK3vN4xSpYi3iliL5mbZg5qvA5CQvW66qmfOVW1x7Gf/GFBEkIoi16WvFTFeXJ1OLLelQxbYjp0CGw/wVQtrxa50eARkC/HW9tIs161nuDEAgKfmmTHXusVV9EICH4LAivXNIM/O3sfsvlCXLZFGb4Cv5dgu5BH6Xv3CUME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779269366; c=relaxed/simple;
	bh=xzcZeoD0niZUNOJsg+qcrFRZ/GvRmasUv2WFxCUDc0I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QHOi8YMDlrYXpyynr/GjVcUX+LiUtRuZhPyC2nxJsuWA8ahAB0zac6Kvw6qUlGUGPoOh7vr72Rm1yKNKcrKEZvIhtHzBU8/umdb/odWn6wy4lPWT0hdITm3CBBUTBNrLvmHELEN0Ht6yETuFY7Ar77zkUY8B5EVRc5WNANe+Ceo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLvK/R+C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLvK/R+C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDD11F000E9;
	Wed, 20 May 2026 09:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779269363;
	bh=d3dUitqVHclDZ24VyLLVj/3e6tehsujLNP+nBiRE0GY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PLvK/R+ClRXHd4EPCx2dhi7VWBiJJEPsc3IDdBio0cGfbZ9XpFUnsQoltgtWXtl8t
	 VQn0OhW4K/cGgfCl2xKfGRrQuE1X0L9PDgbzcxzDpVGGml7y6Jxu+jxX2BSApJhDs2
	 5Rh5b5bhqIkV0ROcrM5wdRYZbDG+KxE985/Z+InaF/ohNqWdWR9OaWZabCky0+4O4P
	 sE2LowjIST//KMEnf8JpI3bVHhKnWc+uAzRF6MTk5X9INkvzoXvmr+3Q2g9MCLsPoF
	 vuENPIbzu2HCpzihstXFACU83okE5tOTyZHB+0ae1Ug88SME2GSjLgv1F1ugDwZPYT
	 bMj4meWWknb0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 3/3] of: Respect #{iommu,msi}-cells in maps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vijayanand Jitta" <vijayanand.jitta@oss.qualcomm.com>
Cc: imx@lists.linux.dev, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260520-parse_iommu_cells-v15-3-b5f99ad4e7e8@oss.qualcomm.com>
References: <20260520-parse_iommu_cells-v15-3-b5f99ad4e7e8@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 09:29:22 +0000
Message-Id: <20260520092923.0EDD11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Strict requirement for `#iommu-cells` or `#msi-cells` breaks MSI a=
llocations on standard-compliant controllers.
- [High] Array desynchronization when parsing legacy 0-cell maps padded to =
4 words per entry.
--

commit 23cece64ecb1dcea6290dbab34facbdac53ff293
Author: Robin Murphy <robin.murphy@arm.com>
Date:   Wed May 20 08:02:42 2026 +0000

of: Respect #{iommu,msi}-cells in maps

This commit adds support for parsing target nodes' #cells values for
iommu-map and msi-map properties, instead of assuming output specifiers
always have exactly 1 cell. It updates of_map_id() to parse multi-cell and
0-cell output specifiers and reflect the actual number of output specifier
cells.

> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index d658c26201353..f436e26763818 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c

[ ... ]

> @@ -2176,39 +2206,93 @@ int of_map_id(const struct device_node *np, u32 i=
d,

[ ... ]

> +		phandle =3D be32_to_cpup(map + offset + 1);
>  		phandle_node =3D of_find_node_by_phandle(phandle);
>  		if (!phandle_node)
>  			return -ENODEV;
> =20
> +		if (bad_map) {
> +			cells =3D 1;
> +		} else if (of_property_read_u32(phandle_node, cells_name, &cells)) {
> +			pr_err("%pOF: missing %s property\n", phandle_node, cells_name);
> +			of_node_put(phandle_node);
> +			return -EINVAL;
> +		}

[Severity: High]
Does this strict requirement for #iommu-cells or #msi-cells break MSI
allocations on standard-compliant controllers?

Several MSI controllers validly lack a #msi-cells property. For instance,
arm,gic-v2m-frame nodes do not require it. In
arch/arm64/boot/dts/qcom/ipq5018.dtsi, the pcie0 node defines:

msi-map =3D <0x0 &v2m0 0x0 0xff8>;

but v2m0 does not have #msi-cells.

Prior to this patch, of_map_id() implicitly consumed 4 words per entry and
succeeded. Will it now fail to find #msi-cells, print an error, and
return -EINVAL, propagating the error through of_msi_xlate() and breaking
MSI initialization on affected platforms?

> +
> +		if (cells > MAX_PHANDLE_ARGS) {

[ ... ]

> +		if (map_len - offset < 3 + cells) {
> +			of_node_put(phandle_node);
> +			goto err_map_len;
> +		}
> +
> +		out_base =3D map + offset + 2;
> +		offset +=3D 3 + cells;

[Severity: High]
Could this cause array desynchronization when parsing legacy 0-cell maps
that were padded to 4 words per entry?

Prior to this patch, of_map_id() mandated that the map property length must
be a multiple of 16 bytes:

if (!map_len || map_len % (4 * sizeof(*map)))
    return -EINVAL;

Consequently, if a legacy device tree targeted an MSI controller that
explicitly defined #msi-cells =3D <0> (such as RISC-V IMSIC nodes), it was
structurally forced to pad the 3-word map entry with a dummy 4th word to
satisfy the kernel's length check.

Since the new logic computes the entry stride dynamically as 3 + cells,
when parsing a legacy padded map with cells=3D0, does the code advance by 3
and incorrectly interpret the 4th dummy word of the first entry as the
id_base of the second entry?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520-parse_iomm=
u_cells-v15-0-b5f99ad4e7e8@oss.qualcomm.com?part=3D3
