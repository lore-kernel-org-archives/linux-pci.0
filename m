Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F18391513
	for <linux-pci@vger.kernel.org>; Mon,  7 Sep 2026 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792250; cv=none; b=SrYRNPZ7WPxPf4IBtnH9R95lDtge8gmSji+HXbzte2GK8vJbKuM94HDPDmySvuDlTxqj4FV2N8IvMTGpvGnGZNSRLHTPQte4t/+I451WOwHDEgvuiPXYbs6g5n+p5N6naqXO48cpSPcVC3esX/OqbQrbC0kJkciysdE43kWtbKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792250; c=relaxed/simple;
	bh=DZG2O5iJOhj/4Rlx2+pQe0RTfwbjbD2Z5o6Mxqtw1t8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jJUN1TTZU0nnnYwIs9ncbFxZw3oRRtpIs0Ud1QOrKovsxQQC1D4IZxDCNeog5X+Q0kmJzrrXXLkaDl+QXoplVGWsKDZkqvtJKhX98CpAiYlLaca7IJgF1Y4pbxM9Ll3jeHoecGEFQ1/FwMdlpkdfJBut5TrthjVqna+PNCQ7oOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESOxJkSL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESOxJkSL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF06B1F00A3A;
	Mon,  7 Sep 2026 14:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788792249;
	bh=9ie6WEZcVAAK/4lDWw6Sj5KJ4r8L547k7SWr/YGj31w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ESOxJkSLQ6kq0wpwqAZBEupymLcLRDmhsmmL+kkzDFLherA7ZzxtB++cXZApfxcom
	 1sCfT53sGH5FZSJqbi+6yWyOX/+7OnmH/lF2X4ZpRnE+eU9SGtK3zVlqCQlSAS8jxm
	 YTBWWtroQobpqa9VpvIdfZ46Ds7vLu2pK1Zp6C1npZKNCV0ujRTmEkPPyOZOzYjBIa
	 uWIp1eC9exLmxyiuU+j77sV1xH+gaycmW0pCXyWwK42rOhdLBeHw9ITMJgeMIP6EPB
	 J/Q1bHgz07+DNBMhsFkYKXAdPjFHtS4Fk54LPi6n7hcCK9PaL6wwgwcGxCqifDj45i
	 LK3nQehDkUDUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: qcom: Honor IOMMU provider's #iommu-cells in
 qcom_pcie_config_sid_1_9_0()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260907143349.317495-1-mani@kernel.org>
References: <20260907143349.317495-1-mani@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 14:44:08 +0000
Message-Id: <20260907144408.EF06B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Out-of-bounds memory read when `iommu-map` property length is less=
 than 2 cells.
- [High] Unvalidated `#iommu-cells` property causes integer overflow, leadi=
ng to out-of-bounds memory reads or divide-by-zero undefined behavior.

Pre-existing issues:
- [High] Infinite loop if the number of `iommu-map` entries exceeds the fix=
ed BDF-to-SID hardware table capacity.
--

commit 5e6355134714e5a9f21664a5ac644c1347a1924b
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

PCI: qcom: Honor IOMMU provider's #iommu-cells in qcom_pcie_config_sid_1_9_=
0()

This commit updates qcom_pcie_config_sid_1_9_0() to properly handle
iommu-map entries where the IOMMU provider uses more than one iommu-cell.
It dynamically calculates the per-entry stride based on the IOMMU's
#iommu-cells property instead of assuming a fixed four-word stride.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index b58a607b713f5..42cbeef083caf 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
[ ... ]
> @@ -1143,50 +1143,90 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pc=
ie *pcie)
> =20
>  static int qcom_pcie_config_sid_1_9_0(struct qcom_pcie *pcie)
>  {
[ ... ]
> +	if (size % sizeof(*map)) {
> +		dev_err(dev, "Malformed iommu-map property\n");
> +		return -EINVAL;
> +	}
> +	nr_cells =3D size / sizeof(*map);
> +
> +	/*
> +	 * Each iommu-map entry is: rid-base (1 cell), phandle (1 cell),
> +	 * IOMMU specifier (#iommu-cells cells), length (1 cell). Read
> +	 * #iommu-cells from the IOMMU provider referenced by the first
> +	 * entry to compute the per-entry stride.
> +	 */
> +	phandle =3D be32_to_cpu(map[1]);

[Severity: High]
Can this cause an out-of-bounds read if the iommu-map property is too short?

The function verifies the property size is a multiple of 4 bytes, but fails
to verify the minimum required length (at least 2 cells) before accessing
map[1] to extract the phandle. A malformed device tree with an iommu-map
property of 4 bytes (1 cell) could trigger an out-of-bounds memory read
during probe.

> +	iommu_np =3D of_find_node_by_phandle(phandle);
> +	if (!iommu_np) {
> +		dev_err(dev, "Failed to find IOMMU node in iommu-map\n");
> +		return -ENODEV;
> +	}
> +
> +	if (of_property_read_u32(iommu_np, "#iommu-cells", &iommu_cells))
> +		iommu_cells =3D 1;
> +	of_node_put(iommu_np);
> +
> +	entry_cells =3D 3 + iommu_cells;

[Severity: High]
Does this code allow an unvalidated #iommu-cells property to cause an
integer overflow?

If a device tree specifies an excessively large value for #iommu-cells,
such as 0xFFFFFFFE, entry_cells =3D 3 + iommu_cells will wrap around to 1.
If the value is 0xFFFFFFFD, it wraps to 0.

> +
> +	/*
> +	 * Retain backward compatibility with DTs that describe iommu-map
> +	 * with 4-cell entries against an IOMMU declaring #iommu-cells =3D 2,
> +	 * matching the fallback in drivers/of/base.c::of_check_bad_map().
> +	 */
> +	if (iommu_cells =3D=3D 2 && !(nr_cells % 4)) {
[ ... ]
> +	}
> +
> +	if (nr_cells % entry_cells) {

[Severity: High]
Could the above integer overflow lead to a divide-by-zero here?

If entry_cells wrapped to 0 due to an overflow, this modulo operation will
trigger undefined behavior (divide-by-zero). If it wrapped to a small
non-zero number like 1, it could pass this check and result in
nr_map =3D nr_cells / 1, potentially causing out-of-bounds reads in the
subsequent loop.

> +		dev_err(dev, "Malformed iommu-map property\n");
> +		return -EINVAL;
> +	}
> +	nr_map =3D nr_cells / entry_cells;
> +
>  	/* Enable BDF to SID translation by disabling bypass mode (default) */
>  	val =3D readl(pcie->parf + PARF_BDF_TO_SID_CFG);
[ ... ]
>  	/* Look for an available entry to hold the mapping */
>  	for (i =3D 0; i < nr_map; i++) {
> -		__be16 bdf_be =3D cpu_to_be16(map[i].bdf);
> -		u32 val;
> +		u32 bdf =3D be32_to_cpu(map[i * entry_cells]);
> +		u32 sid =3D be32_to_cpu(map[i * entry_cells + 2]);
> +		__be16 bdf_be =3D cpu_to_be16(bdf);
>  		u8 hash;
> =20
>  		hash =3D crc8(qcom_pcie_crc8_table, (u8 *)&bdf_be, sizeof(bdf_be), 0);

[Severity: High]
This is a pre-existing issue, but can this loop cause a kernel hard lockup?

Just below this in qcom_pcie_config_sid_1_9_0(), there is a linear probing
loop to handle hash collisions:

		while (val) {
			u8 current_hash =3D hash++;
			...
			val =3D readl(bdf_to_sid_base + hash * sizeof(u32));
		}

The hardware table has a capacity of 256 slots (CRC8_TABLE_SIZE). If a devi=
ce
tree specifies more than 256 entries in iommu-map (or if hash collisions fi=
ll
all slots), the while (val) loop continuously increments the 8-bit hash ind=
ex
and reads occupied slots, wrapping indefinitely. It lacks a termination
condition for a full translation table.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907143349.3174=
95-1-mani@kernel.org?part=3D1
