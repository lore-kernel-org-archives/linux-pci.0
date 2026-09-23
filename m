Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9DB220F49;
	Wed, 23 Sep 2026 02:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790128902; cv=none; b=S3loZuCZrqoZdlMNh+Ysb9XxotsRBbVwMxocdVSx1wnBj//XvOFES6E0ED5+G4w3Zj3EWHiHg8rEjkOC4bsI4TzEYClcLkIEgYHQX3JCOVs1SpjBaT3Z/RPjBWJtMRGMpAg+Bx3tfeOrd/wTiIVTpxuqtYJt92JYLj8IXFng+8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790128902; c=relaxed/simple;
	bh=ZgVNSFeTe/HJ9vBMJ6vp/h/XlFTAvvazfvLqzT7bUL0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tCj9iWepx2oYm4i5CqKgKAsAbgng8/9oonsJl+SZfYSwAhec/iKNmXaVIhZHsQthosQGD+AAyKTFbjrxP5bd37ApJmAULukYUn/opXfMR+QhVyc/V1pbuN+7NIis0SDdyLmPNAUQ0o671LCTkqFzCDx6XsFWSVKY8QHFWGfqbkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5YgxVQ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5YgxVQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F0C1F000FF;
	Wed, 23 Sep 2026 02:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790128901;
	bh=MowjCBxwz8ywWb18hm+CAVrVXSQROllqzBoHs7l8C2A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m5YgxVQ4/KirAby5sMTW4XrSbSJ1YZi6MdzX8p6JW0yuu/rSfaj/4MLN+hniAEn3S
	 MvRe9sMjTYxhtgQreguQcUz99PDR6q9GRyOv8JdOyM/+qkY1ghb1xDmy1XsxRO6zx3
	 OtXRCys1W9Lp0rjGa0pOuK239UNHqmbFHchkclZfFi9MGvLeo0+zFuPAvV5yThXXkQ
	 gpetmAdf8jmJwUh0axEHbj59zVgHRsLcU8LPbSv5SIc4HADMp1QgWbWw8CaKVYrjMr
	 AV7fjZbDNv5Lpfze7DHPRZkfBvWANuTuPLMF7HYVLygYZhBpl2FrC4gVszmWs6DBMl
	 KteBU+hlEn/ZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/6] PCI: spacemit-k1: Add Spacemit K3 PCIe host
 controller support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260923015016.64069-7-inochiama@gmail.com>
References: <20260923015016.64069-1-inochiama@gmail.com>
 <20260923015016.64069-7-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 02:01:40 +0000
Message-Id: <20260923020141.21F0C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: mmio access before clocks and resets are enabled causes crash
--

commit f8b3a671e2cd8186deb7de2df88df163e1636aa6
Author: Inochi Amaoto <inochiama@gmail.com>

PCI: spacemit-k1: Add Spacemit K3 PCIe host controller support

This commit adds driver support for the PCIe controller on the Spacemit
K3 SoC. It introduces a new device data structure and initialization
callbacks specific to K3 hardware.

> diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/=
controller/dwc/pcie-spacemit-k1.c
> index ec59ccb710ec1..c3b935f424cd7 100644
> --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c

[ ... ]

> +static int k3_pcie_parse_port(struct k1_pcie *k1)
> +{
> +	u32 status0, status1, status2;
> +
> +	/* Clear the status registers */
> +	status0 =3D readl_relaxed(k1->link + K3_PHY_AHB_IRQSTATUS_INTX);
> +	status1 =3D readl_relaxed(k1->link + INTR_STATUS);
> +	status2 =3D readl_relaxed(k1->link + K3_ADDR_INTR_STATUS1);

[Severity: High]
Does this trigger a synchronous external abort or SError during probe?

Looking at k1_pcie_probe(), the driver calls data->parse_port() before
dw_pcie_host_init():

k1_pcie_probe()
  data->parse_port() -> k3_pcie_parse_port()
  ...
  dw_pcie_host_init()
    host_ops->init() -> k3_pcie_init()
      k1_pcie_enable_resources()

The clocks and resets are enabled later in k1_pcie_enable_resources().
Will these early MMIO accesses in k3_pcie_parse_port() crash the kernel
if the bootloader didn't leave the controller clocked and out of reset?

> +
> +	writel_relaxed(status0, k1->link + K3_PHY_AHB_IRQSTATUS_INTX);
> +	writel_relaxed(status1, k1->link + INTR_STATUS);
> +	writel_relaxed(status2, k1->link + K3_ADDR_INTR_STATUS1);
> +
> +	return k1_pcie_parse_port(k1);
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923015016.6406=
9-1-inochiama@gmail.com?part=3D6
