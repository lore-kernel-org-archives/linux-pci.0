Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE234534AC
	for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782752504; cv=none; b=L9GNbsJ54lq2ysfpIFrTBPBa9zHiMbyuAu/FY2yCpvYqXqBy0okS1AFMxYgRZ+Nh43g4+fvLb7iQZIsz/C+nylHp033K6NnzwWLmsCg6H+lu+N88L5bXTb3d0ALNCHlsPOWuofrpgEniUrlqZnj33arne/ICZ3pRNTIPrOG6ecA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782752504; c=relaxed/simple;
	bh=ndnHir1wNIxs67HHaZWro5YUgK8feeHfrZFLmipdlpw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NKGn8VvQqPUcc5xKaIE/5kFw8g1ElHaf/2czTvhrtkOlU5NpYLoVgT/+nLx3lV41tcxwhQSBaZDScePybJP44L5/qx56ZCvRRQDZrZtOtjjTR3982+GfdFjRIhteMJyNIrIrMJXWjdS2Xeex6kgGC7qr6wA3gXBgRPMxz8QrnlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPeql8LB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPeql8LB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9879B1F000E9;
	Mon, 29 Jun 2026 17:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782752503;
	bh=YO53AXB2nBQMxSUpnYnSLouYf8M/RRzxNLEoSX64DYM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XPeql8LBEb0RYxVkAE/V3rXr/AcCVxu4B7ioXC7En4OF5179tG66h0u0n7ZX+R4z0
	 TsKEiyc6zT6kLqmVccHI8hvpzOjgniPSdh3JgGgpHKwzSiDYVyP902xs8fjWv6feHc
	 HXpOPEcqJ5UELkaT2Ol0umJtv03FH6D4mNjChsOaroTGnmp++lfbIk231ztyQsaBtt
	 jxjjYSZ+89eHInd0NvjCaN9CAH9gHOjQTCebdpPLKud/G9awHHOnR+gHojPCJ45IX+
	 +YZ1Y+eTs5j+ZezH3TS/6ocUgToOu5CTOjneF/sgsb8drsb6BHz6UaxACyIRUd9Enx
	 CAdlCQStdnqvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] PCI: vmd: Add feature to scan BIOS enumerated
 devices.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nirmal Patel" <nirmal.patel@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260629165025.268836-1-nirmal.patel@linux.intel.com>
References: <20260629165025.268836-1-nirmal.patel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 17:01:41 +0000
Message-Id: <20260629170142.9879B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unvalidated BAR 4 length could lead to an out-of-bounds read when =
accessing shadow registers.
--

commit 7affe7834934181c54062f23e6c8641c3fb30366
Author: Nirmal Patel <nirmal.patel@linux.intel.com>

PCI: vmd: Add feature to scan BIOS enumerated devices.

This commit adds support for newer VMD devices (ID 0x28c1) that rely on
the BIOS to enumerate the device tree and configure settings. It retrieves
the bus hide range and shadow register values from the VMD MMIO space in
BAR4/BAR5 and uses them to perform a bus scan.

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index d4ae250d4bc6d..a02f2cc3d6ede 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c

[ ... ]

> @@ -661,6 +706,46 @@ static int vmd_get_bus_number_start(struct vmd_dev *=
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

[Severity: High]
Can this cause an out-of-bounds read if the resource size of BAR 4 is
smaller than the SHADOW_MEMBAR1_28C1 offset?

If a malicious PCIe device (for example, connected via Thunderbolt) spoofs
the VMD device ID but presents a malformed, small BAR 4 (e.g., 4 KB),
pci_ioremap_bar() will only map the smaller size. The readq() call here
would then access unmapped memory, which could trigger a kernel panic via
a page fault in kernel mode.

Is there a way to validate the length of the BAR 4 resource against
the expected offsets before accessing these shadow registers?

> +	phys2 =3D readq(bar4 + SHADOW_MEMBAR2_28C1);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629165025.2688=
36-1-nirmal.patel@linux.intel.com?part=3D1
