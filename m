Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA92400990
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785408205; cv=none; b=dTWhieRzZ0TJEP7bwm1gSLwWLQtSkZZIOJi2sgKVTZw9lDdw73CSHak4TwRIXv3m3jSNmyR8oOBIcfLOT34SBgnkXDnJbYlMgKd3hfxOduCe4Ne2HMiGMDNz90qxFu1kiht19Tj1pk0PG9jNnQhC0boNKF56p9gfdsn9TeamZ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785408205; c=relaxed/simple;
	bh=cTajQtb4iS0TgrEdoxJLCBM6CMTTNPmWo+POpqamyZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAgfWCmturywaZlgf4a95asdI2cDkvsSREuVhyYgCbnW/7iJlqoGmViyyRV1lw5IRJGiZBDmdjVzgSwqARj54ivKjMKW6doMcREdug8Xt5es3a13+1muKcl8/wPQ9dxHghFEMdnJyimaAgV0zlxlBuoBBzSn3UPFmz0ONCrdJ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5kKakO7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5kKakO7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7A11F000E9;
	Thu, 30 Jul 2026 10:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785408204;
	bh=z0YIOqbwsN6Jz+WC03tOKg5RCDTDkm9EhgRVM1lB7P4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K5kKakO7kR/MGCajALhRYQdhtXUTT3KNsO6gXzw89srU8I9fViY6W5bVn1kKhjWqb
	 vG9VJ5mXeIv4YWUJ+GjRo6e/j7u+9NHQqIntIe9KasJXlZ5MFLtd+CqqqSShDLUh9v
	 mUBjxUMLMPTihXFUK+sUEMffLZF5XTjQCRRi3arDMvaVQWFjwM+BQZe28ExrjbgamM
	 DSMQkJRa0cmzsSX1M4wL9b7gNyeuojtyBPVGLQSiTtq8Brya2F/9p6RBsHlwPFzGAZ
	 6K7O4bj6yt9FvNCuEB9fr/U+vuHbI2Jdy/EB5cvH2DibXXHIaeE/KmBrVZSwseAH4u
	 CxJkQ6xWdpHgA==
Date: Thu, 30 Jul 2026 12:43:20 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: DWC eDMA weirdness
Message-ID: <amsqyOvAHU8uD2Wa@ryzen>
References: <20260729202821.1153443-2-cassel@kernel.org>
 <ampndLtU32ODmncX@ryzen>
 <egai6rd3umstjhkuelrnemr2ywjlfccfk4tipaxodav426wxex@kuu76gvznusa>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <egai6rd3umstjhkuelrnemr2ywjlfccfk4tipaxodav426wxex@kuu76gvznusa>

On Thu, Jul 30, 2026 at 05:39:46PM +0900, Koichiro Den wrote:
> 
> I was struggling to reproduce this, but I think I figured out what triggers it.
> It happens when the 'dma' variant runs before DOORBELL_TEST, e.g. when running
> the full test suite with no arguments, or by running '-v dma' first.
> 
> I think the following patch fixes it:
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 89a4c498a17b..ec097c68cf5f 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -755,6 +755,7 @@ static int dw_edma_emul_irq_alloc(struct dw_edma *dw)
>                 return virq;
> 
>         irq_set_chip_and_handler(virq, &dw_edma_emul_irqchip, handle_level_irq);
> +       irq_set_status_flags(virq, IRQ_LEVEL);
>         irq_set_chip_data(virq, dw);
>         irq_set_noprobe(virq);
> 
> Could you test this?

That appears to fix my problem.

We have had a ton of DWC problems related to IRQs.
IIRC, most DWC IRQs, e.g. the embedded MSI controller on the PCIe controller
itself, works using level triggered IRQs.

However, e.g. MSIs themselves are by definition edge triggered, so there is
a difference of how you mark the IRQ handler in the DWC driver, and how you
configure the IRQ domain that you configure to the MSI/IRQ kernel code:
https://patchew.org/linux/20250205151635.v2.1.Id60295bee6aacf44aa3664e702012cb4710529c3@changeid/


Since this is for an IRQ within the PCIe controller, I think this is correct.



We've also seen problems where we've been clearing the level IRQ too
late, see e.g.
ca1658921b63 ("PCI: designware: Fix missing MSI IRQs")

which caused us to miss IRQs when two MSIs came very close after one another.



Kind regards,
Niklas
