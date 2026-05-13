Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80123C2E;
	Wed, 13 May 2026 00:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778630726; cv=none; b=hC7Lx10Z6WmyiFA4SneZLZOVKx+aLXQ/35fJsm4OqUXVct08LBK/3QIM/MPa91DPhe1ZP3LuWQd2/wzm+/TyLhE+vWY3IokyZt7buS5hyLU7mvOjFEHamz+G2skC/f5Uhu0LwBZuLQyud9vAKfZrRfg7hqkjCOzhJC+8/M5WKTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778630726; c=relaxed/simple;
	bh=RZYvMUBsdqb2XFXXfibRFHhK/Al0aA4SFrf3esDhf6U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H3d3wcqYqFR3ICfObWUMMAjCkZywUdDXgxiERFD6C7KNrcOvAbyp6rj+JLeSl+tT2s9IQkV6k1miD5zY7dkz8KEuIPCSgYrj12eQZ9nOqgiQI6384gvSUn3QbeSRnoMGmUewJPepNMX7izkQ4A/4tPUu1V6/neTsB6FwnOKlZYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKRRdxpK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKRRdxpK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55647C2BCB0;
	Wed, 13 May 2026 00:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778630726;
	bh=RZYvMUBsdqb2XFXXfibRFHhK/Al0aA4SFrf3esDhf6U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sKRRdxpK557JEXjoTU1/nT7ZiTx4pS8l0Nk9MoNYsDdpsiUejQILvIrrhJQCi7nkR
	 aZ3gFxV0OToQ76xzoW6nluXiA6QX1vVnGaQJXmUtufRTdZceZaK0Uh9mGjUWhXNcXc
	 IPSF1f3Cnd89e94KjCkvltB5VkQx5ZVukt2elcYiYhYsJyyKe87N1JtIs6kUtpqBen
	 TC5whJvwjGnrqq5G9EfSWg3ACEV0jho05E+K7/fM66rI9MB5z2fulHjjYiBTMpPPA+
	 yv2Vo2yNRh+xSqb/gVvTOz2uj8kSrxtYKAMMajH1a/pt3EJfjMv98wrlj3kTd9uq2t
	 hkIvTyrAT4bFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/23] dmaengine: sdxi: Add PCI initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: linux-pci@vger.kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260511-sdxi-base-v2-3-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-3-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 00:05:25 +0000
Message-Id: <20260513000526.55647C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The Kconfig symbol `CONFIG_SDXI` lacks a dependency on `PCI` or `P=
CI_MSI`, and the Makefile conditionally links `pci.o` using `sdxi-$(CONFIG_=
PCI_MSI) +=3D pci.o`.
- [Low] The return value of `dma_set_mask_and_coherent()` is ignored in `sd=
xi_pci_init()`.
--

commit bdb690a4c497e7a353f0143e03e32ba75daa6013
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Add PCI initialization

This commit adds PCI initialization to bind an SDXI device via the class
code. It maps the control registers and doorbell region, managing resources
with devres and registering the device with the generic SDXI core.

> diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
> new file mode 100644
> --- /dev/null
> +++ b/drivers/dma/sdxi/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_SDXI) +=3D sdxi.o
> +
> +sdxi-objs +=3D device.o
> +
> +sdxi-$(CONFIG_PCI_MSI) +=3D pci.o

If CONFIG_SDXI is enabled but CONFIG_PCI_MSI is disabled, pci.o is omitted
from the build. Because pci.c is the only file containing the driver
registration macro (module_pci_driver) and the module license declaration,
would this result in a module that lacks an initialization entry point and
fails to load properly while also tainting the kernel?

[ ... ]

> diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/dma/sdxi/pci.c
[ ... ]
> +static int sdxi_pci_init(struct sdxi_dev *sdxi)
> +{
> +	struct pci_dev *pdev =3D sdxi_to_pci_dev(sdxi);
> +	struct device *dev =3D &pdev->dev;
> +	int ret;
> +
> +	ret =3D pcim_enable_device(pdev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable device\n");
> +
> +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));

The return value of dma_set_mask_and_coherent() is ignored here. If the
platform or IOMMU does not support 64-bit DMA, this function returns an err=
or
code and leaves the device's DMA mask at its default 32-bit value.

Is it expected to proceed without handling the fallback or logging a warnin=
g?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-sdxi-base-=
v2-0-889cfed17e3f@amd.com?part=3D3
