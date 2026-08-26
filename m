Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF3E3BB699
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787736402; cv=none; b=tYfbfNPb9inTfJ7fcWPkNye2Wl07KNc8u5d3utJ4K1weDtjn3VZRFS8veUX+KiWKM1oQPCoRozJDhwNT+6UUDG0hUU4rnVZ1patdn4QrH576siicnwdV8pad++rLAgHdFtRXV2WuJAAeLs7z2UP3+h0Oxf/xh7sk/R93PRv6als=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787736402; c=relaxed/simple;
	bh=56f2jV3d6AApNXIgyoA3unc1DV8w7A9xshc4NrGjp/w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QvUuJxUAerfj1CKH53drH65h9pBpWyZZHdY7bsWhJSgWFnf4j0NoXCpSwAehZqZb/nSMLl9bb46ImYZaWzvmlkh4HwK3dhHK0SseCwt0XPEuj8B8SOl0jYp3KaFSQPt+G1a12S2GUuhWlUFDKxARB0zyaw0vkg3CXIsAMPRJO+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orQOEuwP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orQOEuwP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF281F01561;
	Wed, 26 Aug 2026 09:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787736401;
	bh=+qZ8jUoJAG4g+eML+hMT4glVxVmXUUhCCZbkEmx993o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=orQOEuwPPTidsyl3KdawVrguNzZGelS4QZPm7wZX5qM2TewS3S8qUaJCfd+6xPIfs
	 m3NSthEOBeZ+5Rlh1r7C8P2bbtB0+FC+sVnNv3cxb6abqFSmGHbg1XetoZF9EjwagG
	 pWGdnE/lEYhx9cm1EHfMpkuAEyXQpBY6hQCi6T1Q/GRBwEjnyd97JB69x824xShPE1
	 wDX1nnvEZ7JtOI9Us7bA0pTp/IhkEqOSAxnJwqDx/b4uHkTFKGq54G83QY0CZ29LNx
	 bTUJJNEmfQS8wgexYuIrUNoe+3FRQ3BHZQ437x45iAugrzILFWY8ERiMorvlxD5B2F
	 JOUUJbnp/nyDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] pci: designware: Set DMA_BYPASS bit in outbound IATU
 CTRL2 register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sumit Kumar" <sumit.kumar@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260826-dma_bypass-v1-1-3a53dc748ce2@oss.qualcomm.com>
References: <20260826-dma_bypass-v1-1-3a53dc748ce2@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 09:26:40 +0000
Message-Id: <20260826092640.CBF281F01561@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditionally setting PCIE_ATU_DMA_BYPASS on all outbound iATU w=
indows breaks built-in eDMA for platforms relying on iATU translation.
--

commit 0264996407d5cc39725b0bb26bca8b42a6f11d18
Author: Sumit Kumar <sumit.kumar@oss.qualcomm.com>

pci: designware: Set DMA_BYPASS bit in outbound IATU CTRL2 register

This commit unconditionally sets the DMA_BYPASS bit in PCIE_ATU_REGION_CTRL2
when programming outbound iATU regions for controllers >=3D 4.60A. This aims
to prevent unintentional address translation when DMA destination addresses
fall within an outbound iATU aperture.

> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/c=
ontroller/dwc/pcie-designware.c
> index 593388f29bdd4..9297d0e607e3a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -577,6 +577,8 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>  		/* The data-less messages only for now */
>  		val |=3D PCIE_ATU_INHIBIT_PAYLOAD | atu->code;
>  	}
> +	if (dw_pcie_ver_is_ge(pci, 460A))
> +		val |=3D PCIE_ATU_DMA_BYPASS;
>  	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, val);

[Severity: High]
Does unconditionally setting PCIE_ATU_DMA_BYPASS on all outbound iATU
windows break built-in eDMA for platforms that rely on iATU translation?

When a standard PCI endpoint function driver allocates an outbound memory
window using pci_epc_mem_map(), it gets a local CPU physical address which
is then programmed into the DMA engine.

Because this patch unconditionally bypasses the iATU for DMA, these
platforms will send the raw CPU physical address over the PCIe link instead
of the intended PCIe bus address. Could this regression lead to host memory
corruption, IOMMU faults, or silent data corruption on platforms where the
eDMA expects the iATU to handle the CPU-to-PCI address translation?

To support bypassing safely, would this need to be conditionally enabled via
a platform quirk, or require implementing the .pci_address callback in
dw_pcie_edma_ops to translate the CPU address in software before programming
the eDMA channel?

> =20
>  	/*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-dma_bypass=
-v1-1-3a53dc748ce2@oss.qualcomm.com?part=3D1
