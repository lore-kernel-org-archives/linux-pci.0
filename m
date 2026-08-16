Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7726B3D9537;
	Sun, 16 Aug 2026 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786871985; cv=none; b=Y5c21yTXy3+lwi6uXMh0KtN7QABzD+diVlFlO+lF4lYy5pO6fUI8dbMKB5nXfAO+0Rc7SpWfF+CWqzJemoNb7U4MZZ7tQMC2PnPGyZg3AJZawx8Shn7OU3Cf3aw9+qPZh8x+imPbtopVJRZuA557vDeylluQFYKb3nQQhqjauYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786871985; c=relaxed/simple;
	bh=ZWlhL7HshxuLJFyaOckMTN/BH3mLWn/jY3xakTzPlLc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GcefLhRW7VaaSLVmZrb6ZlKHCf2qcHAELmtTxhDAoHccd5JkceAOSm/jt26H7sDU3p7hl793aK6eksXbIYemzkP+764zK1sJSaOP5S2dPKHKiqOhP/EWOSxjS3OHDZSsqtaAAGHtSsNN2TicwlFn2Mh3TF1pV1GqLwh4dnXxFfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mu+UTn9X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mu+UTn9X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAFE1F000E9;
	Sun, 16 Aug 2026 09:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786871984;
	bh=FtZkA6k5llgTTN28ud+GgLEigMd+uViHSjEV0kZ7hhw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mu+UTn9XHCtQibQuWNHkGVFBL4JHTe/zYV8NPKhny13k5idabAYnY1sTDPvylzWfy
	 JQ9zs+r8upUEIEo6VHMcaYjwAU5K8cEfrrloF+XLCLO+smQdltZFtjgv7tpTVFGcgN
	 DkpsryTvXIlMYxK+9N977SOwiEldyPeE4900Azni2sySd1d3PODr3fhvX3UcAPqFxz
	 nMm4GGgi+06e1GV504UiKaZBmiwUGK3kKWRB55dQuZK0jy4DVFaITQ+gu3Gq5sGrCz
	 FQW0DpZrmGEskh5gEUUthXC0EgEOUKQHNJw0BvHWAaAZ8HIq7wKaaHUaZ/V3RDe9VE
	 YgKAoXr/Xm2Iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] cxl/core: Skip non-CXL capabilities in MCAP
Reply-To: sashiko-reviews@lists.linux.dev
To: peng.guo@montage-tech.com
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260816084957.3316727-3-peng.guo@montage-tech.com>
References: <20260816084957.3316727-1-peng.guo@montage-tech.com>
 <20260816084957.3316727-3-peng.guo@montage-tech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 09:19:43 +0000
Message-Id: <20260816091943.CAAFE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The strict Vendor ID check in `cxl_probe_device_regs` incorrectly =
rejects valid capabilities on legacy CXL 2.0/3.0 devices.

Pre-existing issues:
- [High] Missing bounds checking on untrusted device-provided capability co=
unt can lead to out-of-bounds MMIO reads.
- [High] Unvalidated device-provided capability offsets allow arbitrary phy=
sical memory mapping.
--

--- Patch [2]: [PATCH 2/2] cxl/core: Skip non-CXL capabilities in MCAP ---
commit 6cdac110087d8d1e0117e2bb4680d99d50fc28fe
Author: pguo <peng.guo@montage-tech.com>

cxl/core: Skip non-CXL capabilities in MCAP

This commit adds a check for the MCAP Vendor ID before interpreting an entry
as a CXL-defined capability. It intends to prevent non-CXL entries, such as
MMPT and MMIO Mailbox, from being misidentified as CXL register blocks.

> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 20c2d9fbcfe7d..854a8bb4c4f35 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -135,7 +135,13 @@ void cxl_probe_device_regs(struct device *dev, void =
__iomem *base,
>  	for (cap =3D 1; cap <=3D cap_count; cap++) {

[Severity: High]
This is a pre-existing issue, but does this loop lack bounds checking again=
st
the mapped MMIO region size?

The cap_count is extracted from the device-provided capability array regist=
er
and can be as large as 65535.=20

Since base points to an ioremap region bounded by the remaining PCIe BAR si=
ze,
a large untrusted cap_count could cause the offset calculations within the
loop to exceed the mapped boundaries, leading to out-of-bounds MMIO reads.

>  		struct cxl_reg_map *rmap;
>  		u32 offset, length;
> -		u16 cap_id;
> +		u16 cap_id, vendor_id;
> +
> +		vendor_id =3D FIELD_GET(PCI_MCAP_HDR_VENDOR_ID,
> +				      readl(base + PCI_MCAP_HDR_BASE(cap) +
> +					    PCI_MCAP_HDR_REG_4));
> +		if (vendor_id !=3D PCI_VENDOR_ID_CXL)
> +			continue;

[Severity: High]
Does this strict check break legacy CXL 2.0 and 3.0 devices?

For pre-MCAP legacy devices, the offset for the Vendor ID in the capability
header is reserved and defined to read as zero.=20

Because this check unconditionally rejects any capability that doesn't
explicitly match PCI_VENDOR_ID_CXL, it will skip all valid capabilities
whose Vendor ID evaluates to zero.

Will this cause device probing to fail entirely for legacy hardware?

> =20
>  		cap_id =3D FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK,
>  				   readl(base + cap * 0x10));
>  		offset =3D readl(base + cap * 0x10 + 0x4);
>  		length =3D readl(base + cap * 0x10 + 0x8);

[Severity: High]
This is a pre-existing issue, but are the offset and length values validated
against the PCIe BAR boundaries?

These fields are read directly from untrusted device MMIO. Later, in
cxl_map_device_regs(), they are used to calculate the physical address for
mapping:

cxl_map_device_regs()
    addr =3D phys_addr + mi->rmap->offset;
    length =3D mi->rmap->size;
    *(mi->addr) =3D devm_cxl_iomap_block(host, addr, length);

Could a crafted offset and length allow the device to force the host kernel
to map and interact with arbitrary physical memory outside the device's BAR?

> =20
>  		rmap =3D NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260816084957.3316=
727-1-peng.guo@montage-tech.com?part=3D2
