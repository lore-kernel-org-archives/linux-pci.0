Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C5F22157B;
	Mon, 17 Aug 2026 08:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954235; cv=none; b=Wzwkt5crLTwPoqpTTCEbZNlIh2hI4AoaRpqQkBt8I6nXXltQjMU+GT2gWGlKoy1zaegTmK4Waw4kxfwm7/X2+SviNU9RP4D2U2+EsVN0lTucetlOT66cupCfRULyANOShq2ScAl/Au3HF/4leq4ehHqh3rEqklm55xegesMIYtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954235; c=relaxed/simple;
	bh=bItg8RiXH8pebcYQga3tKP9PnX4afze6UZNhqR9XSik=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TNixaM+zeQgaixysDwM8MD5hmjPoRUxp7o0eFN6HnuCMXlAXHmjdhR+zXTR02cwLtUjDI5tLUBSd04aEsF8DGL2WwLuraZju0BoT72pG9YrbAMNKuo6HB31HqLAqy4G79QXwsN6yG4G8P9MaW0T+wn6IVwOEZZ2IwlAkWZrF+BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGmgxjFz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGmgxjFz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDF21F000E9;
	Mon, 17 Aug 2026 08:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786954233;
	bh=E2+GFoj8tGTrEuAi1c5WRprFKvi7ECdk3f85wnoLEGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oGmgxjFz3YFcI9CTc3OKiKABUkvzYGI1qUhsj0QrhevxITpBh0v6MmuksmLLXu7bN
	 C1OiUscgng/ZHOug1LwY6YfNlFbXACUrBQ52JZgi3gsEDpknAyhDTqPNRIcezyFMvs
	 CUotztNI3lMe8DyvS2EpP6e5yVZZ/TkAxP/celJnVLjYfCJebyQBU/zQNu53XbbRZh
	 zgxYv5lekaWmF+cNKnup+omdxDvnKd6daAtfyjmjuJPDCck3hKU6YdB1wF2a5cx5cR
	 D2gL8Ps1ZpgmFeHNZBZWEWurXHcThrufW58S0Q6mEr4QwoT2DV4IzOtR1DoDUBfVlA
	 9pqA7AmiBxgmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] cxl/core: Skip non-CXL capabilities in MCAP
Reply-To: sashiko-reviews@lists.linux.dev
To: penn <engguopeng@buaa.edu.cn>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260817075854.17207-3-engguopeng@buaa.edu.cn>
References: <20260817075854.17207-1-engguopeng@buaa.edu.cn>
 <20260817075854.17207-3-engguopeng@buaa.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 08:10:33 +0000
Message-Id: <20260817081033.8DDF21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The function blindly trusts the hardware-provided `cap_count` with=
out validating it against the mapped register block size, leading to out-of=
-bounds MMIO reads.
- [High] Hardware-provided capability `offset` and `length` are not validat=
ed against the mapped register block bounds, allowing arbitrary physical me=
mory mapping.
--

--- Patch [2]: [PATCH v2 2/2] cxl/core: Skip non-CXL capabilities in MCAP -=
--
commit f423958d8928ff9878ca7f5a9766da9989945b54
Author: Penn <engguopeng@buaa.edu.cn>

cxl/core: Skip non-CXL capabilities in MCAP

This commit adds a check for the MCAP Vendor ID before interpreting an entry
as a CXL-defined capability. This prevents non-CXL entries from being
misinterpreted as CXL register blocks when MMPT is enabled.

> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 20c2d9fbcfe7d..ff1e1cbb9ca8d 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -134,8 +134,18 @@ void cxl_probe_device_regs(struct device *dev, void =
__iomem *base,
> =20
>  	for (cap =3D 1; cap <=3D cap_count; cap++) {

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to trust the
hardware-provided cap_count without validating it against the mapped regist=
er
block size?

A malicious or faulty CXL device could present a large cap_count (up to
65535) but advertise a small PCI BAR. Since cxl_probe_device_regs() iterates
up to cap_count without bounding the loop by the mapped size, the capability
header reads could fall outside the ioremapped memory region and cause a
kernel oops/panic due to a page fault.

>  		struct cxl_reg_map *rmap;
> +		u16 cap_id, vendor_id;
>  		u32 offset, length;
> -		u16 cap_id;
> +
> +		vendor_id =3D FIELD_GET(PCI_MCAP_HDR_VENDOR_ID,
> +				      readl(base + PCI_MCAP_HDR_BASE(cap) +
> +					    PCI_MCAP_HDR_REG_4));
> +		/*
> +		 * The Vendor ID field is reserved and reads as zero in legacy
> +		 * CXL capability headers. See CXL r3.2, Table 8-44.
> +		 */
> +		if (vendor_id && vendor_id !=3D PCI_VENDOR_ID_CXL)
> +			continue;
> =20
>  		cap_id =3D FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK,
>  				   readl(base + cap * 0x10));
>  		offset =3D readl(base + cap * 0x10 + 0x4);
>  		length =3D readl(base + cap * 0x10 + 0x8);

[Severity: High]
This is a pre-existing issue, but does this code properly validate the
untrusted, hardware-provided offset and length?

In cxl_map_device_regs(), these values are used to compute the physical
address for mapping:

cxl_map_device_regs() {
...
    addr =3D phys_addr + mi->rmap->offset;
    length =3D mi->rmap->size;
    *(mi->addr) =3D devm_cxl_iomap_block(host, addr, length);
...
}

Because they are never checked against the CXL register block's actual size
(map->max_size), a device providing arbitrarily large offsets could cause
the kernel to map unrequested physical address space, potentially leading to
unintended MMIO interactions and system instability.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817075854.1720=
7-1-engguopeng@buaa.edu.cn?part=3D2
