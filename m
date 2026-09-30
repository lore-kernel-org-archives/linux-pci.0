Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E23044E67E
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 11:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766306; cv=none; b=Ae5MF39d3XwJEwDj6+lQAQ+WJtPT25cKzckHYEEfQwSK8XTgIgsJN38U0kpN4Gc7+lL911veHskPZTrZUkp+KkE6Xp7rv8GGLunZOh9n22vcqOz22rLfJL8gU6u8kTv10at8bqkGrsOj9TwUVHZxHs/IP2w/5YoyCk7N7qq8Ka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766306; c=relaxed/simple;
	bh=HHq9UNquzPDtdMoyccF2ThYvbTD2T/81MxYQXFWnZlc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e2tqYAAZG35UJtaQVOAoSI5cuYQs+L0Me5GEuaJtGvWB4wZmtNQZ5pWuzdusA6E2+GQQjHEPF4TKolsZN8h2mdJabPQon7mHZ+BdHleXgJtgOqIImqoMuqnIElPLcI4HrUjC/4uWCfAh0EnZ0TjQfpUTFUvZT0GB3nqmP6qblGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyYN2FmR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyYN2FmR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C42F1F000FF;
	Wed, 30 Sep 2026 11:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790766290;
	bh=zxQj+5XbcKhkTQlL1PF9LfpzojqCG8+9Ym6F1/dl6wY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TyYN2FmRm5znzZ5GiaMpdnnNZ5KradEXGS/s9mg/kZozYTZ0g9rEHIKBo9d/aC3Ml
	 d/F2EtRxtzg2DjFVr9XXWWzgCu51A/DqIPfM+Y3m7WQ0b83iqkP25VRdGZrODJtqFj
	 pkLvWqos57FcSJ3Ygoz2lq6xDN7nam97RzGPFscNZXTYVmd0Ls7N6SjtMzyIeHoTTF
	 LJMo3FcBM3AIV3T3b31pqjxVGtiGZOEK0tDbdfmYhv00TfdnxTUTaPaAr8tQOFfR6L
	 uZN6Vgca5kMRA/IKPWW2tKbrHQcZv2R/PSZ3jtsTUcr/ImIy821zb5u4bznPqkSUin
	 jbQlzGawjvEEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: mediatek: Fix integer truncation in fls() and
 clamp size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260930105435.3660-1-sreekuttan2156239@gmail.com>
References: <20260930105435.3660-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 11:04:49 +0000
Message-Id: <20260930110450.0C42F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: silent hardware window truncation causes unmapped BARs
--

commit 3807ae15ec6ca796b24e06b510d2cb2153d9a5c8
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

PCI: mediatek: Fix integer truncation in fls() and clamp size

This commit fixes an integer truncation issue by using fls64() for 64-bit
resource sizes. It also clamps the resulting size_order to a maximum of 31
to avoid overflowing the 5-bit register field used in AHB2PCIE_SIZE().

> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/control=
ler/pcie-mediatek.c
> index 3a3e91cd0c211..ddc7ed28ef843 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
[ ... ]
> @@ -753,8 +756,13 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_=
port *port)
>  		mtk_pcie_enable_msi(port);
> =20
>  	/* Set AHB to PCIe translation windows */
> +	size =3D resource_size(mem);
> +	size_order =3D fls64(size);
> +	if (size_order > 31)
> +		size_order =3D 31;
> +

[Severity: High]
Does clamping the size order here in mtk_pcie_startup_port_v2() cause
unmapped BARs?

The hardware translation window size is clamped to size order 31, but the
patch does not adjust the OS-level mem resource (e.g., mem->end). If the
device tree provides a PCIe memory resource of 4 GiB or larger, the Linux
PCI core will allocate BARs within the full original window. Because the
hardware only translates the truncated portion, will CPU accesses to BARs
placed above the clamped limit fail with a data abort or bus error?

Additionally, using fls64(size) on a power-of-two size computes
ilog2(size) + 1, which may evaluate to a larger window than requested.

Should the driver reject oversized windows entirely, or shrink the OS
resource size to match the hardware reality?

>  	val =3D lower_32_bits(mem->start) |
> -	      AHB2PCIE_SIZE(fls(resource_size(mem)));
> +	      AHB2PCIE_SIZE(size_order);
>  	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
> =20
>  	val =3D upper_32_bits(mem->start);
[ ... ]
> @@ -829,8 +839,13 @@ static int mtk_pcie_startup_port_en7528(struct mtk_p=
cie_port *port)
>  		mtk_pcie_enable_msi(port);
> =20
>  	/* Set AHB to PCIe translation windows */
> +	size =3D resource_size(mem);
> +	size_order =3D fls64(size);
> +	if (size_order > 31)
> +		size_order =3D 31;
> +

[Severity: High]
Does this suffer from the same silent hardware window truncation issue as
mtk_pcie_startup_port_v2() above? The hardware translation window is
clamped without adjusting the corresponding OS-level resource.

>  	val =3D lower_32_bits(mem->start) |
> -	      AHB2PCIE_SIZE(fls(resource_size(mem)));
> +	      AHB2PCIE_SIZE(size_order);
>  	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
> =20
>  	val =3D upper_32_bits(mem->start);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930105435.3660=
-1-sreekuttan2156239@gmail.com?part=3D1
