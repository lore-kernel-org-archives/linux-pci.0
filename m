Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646BC3D75AA
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785234335; cv=none; b=r+wXZfxuFpZJFrOepMf/D4A3++1oWBrQUeRjEqTuTik3uACiFbwOIWosAcP8H27zadyEhm/2bNjwSjCuv/0LVf52zYndAcIK52K6bLPFA79UxGDit4IHIe4CNFBo6lytU0R5KZgGF3BsmsCGFQ5jNXu0kSQqZK3RNyPIOEStggA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785234335; c=relaxed/simple;
	bh=bLGqfXMmxsf36vEFhD3RLwnr3ydH2qBXPO70SMWF8Gc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sSENAw3Lk2lneLjuELm+OG7BjaYuguPBs50DnZiry/TDTbeyjSBe91asG8gSvroO+9XsZiWCNCbpfW7FGmPmdTuH10O1sxAiQ+RotMQEUsTZxNYfB/DtTjimaLACSQalKRoIrr0ZD7hceuw/mF+WbJfwg6QoZoBGvVzGIeje2zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEYfjtEz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEYfjtEz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F9C1F000E9;
	Tue, 28 Jul 2026 10:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785234334;
	bh=I7pfX7U87Ci3h1QPVk3cDs9cPsu65CVmRuQKs2TXV1Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AEYfjtEzfbZOqsUbHKJBTlvMP08mYMh+0wG+CkET3G5xY7ZiUpELdyKbq8nQj5OaY
	 DwgbGezebLIOcgH8DMaqrsz97zOuMpAgWT7rqZUSulZPHAEltz3XtzHFdF+FeEPxqo
	 9wkEK//uSBiHqgZktPgV8epNIFTMMAhPpdkrpnk/TkXDmwwUPOfjNsQ5ZAOhx+y0Lj
	 W8RrFdGz8uIU5i1afraiYvikn0Fk82sNzG2uNE4Tyw6tWO136fboizgWGlje5zWA1C
	 6Y3atUMPq8VZlW7vdGhSFENCR11pOiGoYlh+/3VpuWjLeYpXRwpomwyaCesSLPZraZ
	 Vks8x7i76qeIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: mediatek-gen3: Fix 64-bit type truncation in
 mtk_pcie_set_trans_table()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260728101413.4575-1-sreekuttan2156239@gmail.com>
References: <20260728101413.4575-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 10:25:33 +0000
Message-Id: <20260728102533.D3F9C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch replaces a 32-bit ffs() call with an undefined 64-bit fu=
nction ffs64(), breaking the build. Furthermore, if trivially corrected to =
use the kernel's __ffs64(), it introduces a severe logic error due to 0-bas=
ed indexing.

Pre-existing issues:
- [High] Silent failure when available PCIe translation tables are exhauste=
d.
--

--- Patch [1]: [PATCH] PCI: mediatek-gen3: Fix 64-bit type truncation in mt=
k_pcie_set_trans_table() ---
commit 5abeef37aefeb0da627b6bdbff1cc75a0b1bd361
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

PCI: mediatek-gen3: Fix 64-bit type truncation in mtk_pcie_set_trans_table()

This commit updates address truncation calculations to use 64-bit helpers
like fls64() and BIT_ULL() to prevent truncation above 4GB.

> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/co=
ntroller/pcie-mediatek-gen3.c
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c

[ ... ]

> @@ -334,10 +334,10 @@ static int mtk_pcie_set_trans_table(struct mtk_gen3=
_pcie *pcie,
> =20
>  	while (remaining && (*num < PCIE_MAX_TRANS_TABLES)) {
>  		/* Table size needs to be a power of 2 */
> -		table_size =3D BIT(fls(remaining) - 1);
> +		table_size =3D BIT_ULL(fls64(remaining) - 1);
> =20
>  		if (cpu_addr > 0) {
> -			addr_align =3D BIT(ffs(cpu_addr) - 1);
> +			addr_align =3D BIT_ULL(ffs64(cpu_addr) - 1);

[Severity: High]
Does this introduce a build failure and a potential logic error?

The kernel does not provide an ffs64() macro, which seems like it will
cause an immediate build failure.

If this is trivially fixed by using the kernel's __ffs64(), wouldn't the=20
0-based return value cause issues here?=20

The original ffs() is 1-based, meaning ffs(cpu_addr) - 1 correctly calculat=
es
the alignment shift.

With a 0-based __ffs64(cpu_addr) - 1, the shift could result in undefined
behavior by shifting by -1 if the first set bit is bit 0, or it could halve
the intended alignment requirement.

[ ... ]

>  		cpu_addr +=3D table_size;
>  		pci_addr +=3D table_size;
>  		remaining -=3D table_size;
>  		(*num)++;
>  	}
> =20
>  	if (remaining)
>  		dev_warn(pcie->dev, "not enough translate table for addr: %#llx, limit=
ed to [%d]\n",
>  			 (unsigned long long)cpu_addr, PCIE_MAX_TRANS_TABLES);
> =20
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but does this function silently fail when
translation tables are exhausted?

If remaining is greater than 0 and *num reaches PCIE_MAX_TRANS_TABLES,
the loop exits and a warning is printed, but the function returns 0.

Could this leave the hardware in a partially unmapped state, leading to
subsequent synchronous aborts when the unmapped PCIe windows are accessed?

Should this return an error code like -ENOMEM instead of 0 on resource
exhaustion?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728101413.4575=
-1-sreekuttan2156239@gmail.com?part=3D1
