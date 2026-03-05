Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79171379991;
	Thu,  5 Mar 2026 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708672; cv=none; b=FBidURHOfYE3Mzi8sPkt7sBXh5BOc0yZbfE16d1O1JtVzmLt75fTEJvvnqRFsgqD5YbNNyoiy2zfmdiemYXiKTtC4Q/x6KZfJs8JgVvlYmW3i3tWEgTiegEZ3c57Z6S8SAExjmtS3qbdSbxiU2qXesGlxkIO4Somg5AQmUDfk3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708672; c=relaxed/simple;
	bh=SdGgdEokUAOTqWi1TY4+AsOJ6aYxO6MfPFw38gWKmUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2AXf1hGOTFaISK/qKDuW4K7tOeAWocu/aYh9acfW0FGjeofoQXUEoj1VAxQHesKQXd8zJtZSbRKVnz/jSTlH1jpm3gqzBVnN4xXZemuiXl3YP3yKqPyZi9oFRR4+WV4KIurQPxrwhBcKbuH0NAXCwKnfffRM+fXAfG+NlmKahk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GS7QfPG6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GS7QfPG6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB23C116C6;
	Thu,  5 Mar 2026 11:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772708672;
	bh=SdGgdEokUAOTqWi1TY4+AsOJ6aYxO6MfPFw38gWKmUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GS7QfPG6Ndv1Afh71GaJQRztATvCjCKHCvuEoUrrahl43lXO3UW1aNR17WDEb+oPT
	 RMZpBO0HKQMXqlJky9pBzU5ojvnaI7aPb4/dmaaEU329UcDF5UHae80YMly6XKBcCN
	 35+SVqQ9hkQWmriScn9iWCzdtjt6VRNj6Xq7x9WKcnlTwtScFOKSFW0RzwpaQWEZT/
	 S8O/7cb04FGYBLrbuoPBohGSmmrPoh3Jv0iH5q8vVms4IEQf32oFszy+TKm57fhwIj
	 qAcs0Ppo5JWA+xi/Frch//Wg3ZMJJmPrGSOrykY9OFIrsQ7jSowfPiOiGQJ/a2W10o
	 2mLv5sgMtfEzw==
Date: Thu, 5 Mar 2026 16:34:15 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org, Frank.Li@nxp.com, den@valinux.co.jp, hongxing.zhu@nxp.com, 
	jingoohan1@gmail.com, vidyas@nvidia.com, cassel@kernel.org, 18255117159@163.com, 
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/9] PCI: tegra194: Remove IRQF_ONESHOT flag during
 Endpoint interrupt registration
Message-ID: <7tgk6utaidtgt6ooeunpjirqnark7qzag7twdfvhcnnggxhn43@piwkbs4mg7iu>
References: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
 <20260303065758.2364340-4-mmaddireddy@nvidia.com>
 <2jjklvdczzdfalo7j3atb3lqirbbtzxsoyztaxffapzdoq5xg3@2osxbh3w6w6j>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2jjklvdczzdfalo7j3atb3lqirbbtzxsoyztaxffapzdoq5xg3@2osxbh3w6w6j>

On Thu, Mar 05, 2026 at 04:33:04PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Mar 03, 2026 at 12:27:52PM +0530, Manikanta Maddireddy wrote:
> > From: Vidya Sagar <vidyas@nvidia.com>
> > 
> > The Tegra PCIe Endpoint controller has a single interrupt line that is
> > shared between multiple interrupt sources:
> > 1. PCIe link state events (link up, hot reset done)
> > 2. Configuration space events (Bus Master Enable changes)
> > 3. DMA completion events
> > 
> > Currently, the interrupt is registered with IRQF_ONESHOT, which keeps the
> > interrupt line masked until the threaded handler completes. This prevents
> > the DMA driver from sharing the same interrupt line, as the DMA completion
> > interrupts would be blocked while the threaded handler processes link state
> > events.
> > 
> > Removing IRQF_ONESHOT is safe for the following reasons:
> > 
> > 1. The hard IRQ handler (tegra_pcie_ep_hard_irq) properly acknowledges and
> >    clears all interrupt status bits in hardware before returning. This
> >    prevents interrupt storms and ensures the interrupt controller can
> >    re-enable the interrupt line immediately.
> > 
> > 2. The hard IRQ handler explicitly checks for DMA interrupts
> >    (APPL_INTR_STATUS_L1_8_0_EDMA_INT_MASK) and marks them as handled,
> >    allowing the DMA driver's handler to process them separately.
> > 
> 
> Is this change actually present in the upstream driver? I can't see it, but just
> the definition of APPL_INTR_STATUS_L1_8_0_EDMA_INT_MASK.
> 

Ok, I see this change in the next patch. But this wording is wrong as it implies
that the driver currently handles it.

> > 3. The threaded handler (tegra_pcie_ep_irq_thread) only processes link-up
> >    notifications and LTR message sending. These operations don't conflict
> >    with DMA interrupt processing and don't require the interrupt line to
> >    remain masked.
> > 
> > This change enables the DMA driver to share the interrupt line with the
> > PCIe Endpoint driver, allowing both drivers to process their respective
> > events without blocking each other.
> > 
> 
> I don't know how the DMA driver can share the interrupt requested by the
> endpoint controller driver.
> 

Same here.

- Mani

> - Mani
> 
> > Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> > Tested-by: Jon Hunter <jonathanh@nvidia.com>
> > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > ---
> > Changes V6 -> V7: None
> > Changes V1 -> V6: Updated commit message
> > 
> >  drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > index 980988b7499c..352412680b4d 100644
> > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > @@ -2227,7 +2227,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
> >  		ret = devm_request_threaded_irq(dev, pp->irq,
> >  						tegra_pcie_ep_hard_irq,
> >  						tegra_pcie_ep_irq_thread,
> > -						IRQF_SHARED | IRQF_ONESHOT,
> > +						IRQF_SHARED,
> >  						"tegra-pcie-ep-intr", pcie);
> >  		if (ret) {
> >  			dev_err(dev, "Failed to request IRQ %d: %d\n", pp->irq,
> > -- 
> > 2.34.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
