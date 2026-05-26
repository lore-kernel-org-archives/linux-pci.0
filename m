Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5191A3A9D9C
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 19:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779824167; cv=none; b=BJb04whX8yTcZ8c8C12dbCoxA41PjyNV4uo5S/2HUoa4NxI1x/7c9pQ7rk3o0D2gRKB81UZrpoNRU2+Wn/V3nU+HtOl5C4FAE87gPqx+CaLoMIWMLQkkOBMfPtoqQ7QowP1k0u12k3IaHKVqWK2RsUpK4x6xdjMnW4S5ahrURSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779824167; c=relaxed/simple;
	bh=ht+aA8+1rh5OiTgD1g+u5xsGnyd0mU0XgHdEgGMS4zI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WUMoidQW5z8ToHkRmVcNkmilu3Vt09ltRP7SK+SMaBuA6uIYGcfEfmyd9HVjmB24hYIrIUUTBdoPJOtK3LOPOzU+nkJqHD6pZyU/towqgozyX2pqbU5T44Hen1Hz6IVn2+OoTtlpumQdmDahl1yKHlzuRnGRNsImtvygmW1zywM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3x4w4a2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3x4w4a2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06E71F000E9;
	Tue, 26 May 2026 19:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779824165;
	bh=pxg6Ph/OIz0LuwTVI/aqYgx/f9YPVQw+qJ/ySIWKdwQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k3x4w4a2S3PQOUVq8rP4+VBVL2DQWEA1cEhumggGTvh6ZyaxrMLGb1ldEEKcnmWEz
	 Wh/Z2wB8mh2J/GdoYFMnTimyuGMiDfA3H5rggTyEOS07Z3FdIhZp1o2Ek27Z5A59z1
	 +D8HZTQpnG69Upm0XEyDNMelVaunb3We78/AQ5qHT20/t+LwQ6Df4dRRM4xGun4pAc
	 4iu6Ayj4MnjVqsxhbbDGpCjmuXFFlVJFmRI9eNS4JwEF0MSrRGItbkqH7yTb/A8X8y
	 tc1m7SA0KWfmlyI3KN/PbrZyoVDtAnM73aQXUjw5MpJjIf57w7x9ii41s08fuRA2ZH
	 ec25N+cKQmyvQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/2] PCI/CXL: Enable usage of RDPAS to shortcut
 error device discovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260526182334.1010870-3-dave.jiang@intel.com>
References: <20260526182334.1010870-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 19:36:05 +0000
Message-Id: <20260526193605.D06E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The AER capability parsing loop in `rcrb_to_aer()` lacks cycle det=
ection and surprise removal checks, leading to an infinite loop.
- [High] Reading AER registers in `cxl_rch_get_err_src_id()` can perform ou=
t-of-bounds MMIO reads beyond the mapped boundary.
- [Low] The patch introduces references to an undeclared variable `dev` and=
 an undefined function `cxl_forward_error()`, while ignoring the correctly =
identified `pdev`.
--

commit 268f954c78990287261b8d16aa1b0af35992909d
Author: Dave Jiang <dave.jiang@intel.com>

PCI/CXL: Enable usage of RDPAS to shortcut error device discovery

This commit enables usage of RDPAS to shortcut error device discovery for
CXL RCHs. It probes the RCRB directly to read the AER capability block
and root status, rather than iterating through RCiEPs.

> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rc=
h.c
> index 3f3f6177a828b..75da53bd762cf 100644
> --- a/drivers/pci/pcie/aer_cxl_rch.c
> +++ b/drivers/pci/pcie/aer_cxl_rch.c

[ ... ]

> @@ -149,6 +149,94 @@ static int cxl_rch_handle_error_iter(struct pci_dev =
*dev, void *data)
>  	return 0;
>  }
> =20
> +static u16 rcrb_to_aer(void __iomem *rcrb)
> +{
> +	u16 offset;
> +	u32 cap_hdr;
> +
> +	/* Start from PCIe extended capabilities at offset 0x100 */
> +	offset =3D PCI_CFG_SPACE_SIZE;
> +	cap_hdr =3D readl(rcrb + offset);
> +	if (cap_hdr =3D=3D 0 || cap_hdr =3D=3D ~0u)
> +		return 0;
> +
> +	while (PCI_EXT_CAP_ID(cap_hdr) !=3D PCI_EXT_CAP_ID_ERR) {
> +		offset =3D PCI_EXT_CAP_NEXT(cap_hdr);
> +		if (!offset)
> +			return 0;
> +
> +		if (offset >=3D SZ_4K)
> +			return 0;
> +
> +		cap_hdr =3D readl(rcrb + offset);

[Severity: High]
Does this loop lack cycle detection and surprise removal checks?

If hardware fails or surprise removal occurs, readl() could return ~0u.
The macro PCI_EXT_CAP_NEXT(~0u) yields 0xffc, which bypasses the !offset
and offset >=3D SZ_4K checks, since 0xffc is less than 4096.

This could result in an infinite loop constantly reading from rcrb + 0xffc.

> +	}
> +
> +	return offset;
> +}
> +
> +DEFINE_FREE(iounmap, void __iomem *, if (_T) iounmap(_T))
> +static u16 cxl_rch_get_err_src_id(u64 rcrb_base)
> +{
> +	u32 root_status, err_src;
> +	void __iomem *aer_base;
> +	u16 aer_offset;
> +
> +	void __iomem *rcrb __free(iounmap) =3D ioremap(rcrb_base, SZ_4K);
> +	if (!rcrb)
> +		return 0;
> +
> +	aer_offset =3D rcrb_to_aer(rcrb);
> +	if (!aer_offset)
> +		return 0;
> +
> +	aer_base =3D rcrb + aer_offset;
> +
> +	root_status =3D readl(aer_base + PCI_ERR_ROOT_STATUS);

[Severity: High]
Can this result in an out-of-bounds MMIO read beyond the mapped boundary?

ioremap(rcrb_base, SZ_4K) requests exactly a 4096-byte MMIO mapping. While
rcrb_to_aer() ensures the AER capability header starts within this region,
adding register offsets like PCI_ERR_ROOT_STATUS or PCI_ERR_ROOT_ERR_SRC
(0x34) to a capability base near the end of the block (e.g., 0xffc) will
exceed the allocation boundary and potentially trigger a page fault.

> +	if (!(root_status & (PCI_ERR_ROOT_COR_RCV | PCI_ERR_ROOT_UNCOR_RCV)))
> +		return 0;
> +
> +	err_src =3D readl(aer_base + PCI_ERR_ROOT_ERR_SRC);
> +
> +	if (root_status & PCI_ERR_ROOT_UNCOR_RCV)
> +		return FIELD_GET(GENMASK(31, 16), err_src);
> +
> +	if (root_status & PCI_ERR_ROOT_COR_RCV)
> +		return FIELD_GET(GENMASK(15, 0), err_src);
> +
> +	return 0;
> +}
> +
> +static bool cxl_rch_handled_error_by_rdpas(struct pci_dev *rcec,
> +					   struct aer_err_info *info)
> +{
> +	u8 bus, devfn;
> +	u64 dsp_addr;
> +	u16 segment;
> +	u16 src_id;
> +	int rc;
> +
> +	rc =3D cxl_get_rdpas_by_rcec(rcec, &dsp_addr);
> +	if (rc)
> +		return false;
> +
> +	src_id =3D cxl_rch_get_err_src_id(dsp_addr);
> +	if (!src_id)
> +		return false;
> +
> +	/* Try uncorrectable error source first, then correctable */
> +	segment =3D pci_domain_nr(rcec->bus);
> +	bus =3D FIELD_GET(GENMASK(15, 8), src_id);
> +	devfn =3D FIELD_GET(GENMASK(7, 0), src_id);
> +
> +	struct pci_dev *pdev __free(pci_dev_put) =3D
> +		pci_get_domain_bus_and_slot(segment, bus, devfn);
> +	if (!pdev)
> +		return false;
> +
> +	cxl_forward_error(dev, info);

[Severity: Low]
Does this code introduce a compilation failure due to an undeclared variable
and undefined function?

The variable dev is not declared within this scope (the passed device
parameter is named rcec), and cxl_forward_error() does not appear to be
defined.

Additionally, it seems the correctly identified pdev is completely unused.

> +	return true;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526182334.1010=
870-1-dave.jiang@intel.com?part=3D2
