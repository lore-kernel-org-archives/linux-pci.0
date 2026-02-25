Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F42296BD1
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772031692; cv=none; b=IeFNXAVt5EmAf3M05wLo/SXo1Kl27Tb8TPjVxx0jDVZjULBPwmVF+tBfgcpm1cOIaZVe2Pgoj4jIPuGFHNULVOA75i65/4QsYk9iMOTN7s+h9SjUw+494ga76hHEgu+eYWwc4HjSum6t2Dzxo9UFXsI65eB/xPvfZ36WMoKH2X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772031692; c=relaxed/simple;
	bh=82nkgV+efmUrsgOVBpEAxPzTDHpJBXpCyXEX0PE5PKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZ9sPjRBiXM6WyHYHXl9LgB4lOkTDdDzavzIrme20qs3xhm15DaPIDZL5fi8d46nJwcTuCthKIZboO1gAePUuyYXb7rgVYn8OBhWvYOSTlthGmfV713NzHzW376Dy+mOTwDRh9vO2qIgeGF0q7BBGtSbWq5yuyLnxExQHTSvkq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeZ4As1I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeZ4As1I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2308AC116D0;
	Wed, 25 Feb 2026 15:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772031692;
	bh=82nkgV+efmUrsgOVBpEAxPzTDHpJBXpCyXEX0PE5PKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TeZ4As1IXwcy3Pm3o0IoHD3Ttzh45ghkXl4+jK0Kzns7Z5pRAMSK/E8PP6rhu18vM
	 a4BRriRthWXod76fgBC/dKS4SKCHbemyE7SvtKC61OmHN77IKpwBwNxHJ+TQPpIuiL
	 6AMimXx5wdadjPuKFd1S37Vrf/GrD/Y2oLIQ5lH7yLFGbSYrrFRZRd+G7xlysGCGHR
	 fGMq2RXVvhp2kfHOdHN0MHTIQ+Q1zr2jlAxZyzdhvIvo91AHyRZcw9krNSRrKsGIZV
	 2BDqrBhFHPW83vLRCqcm4Vkr+U4jd0VX6uyOlv4Pb8NEJRo2rXANGoopzbEWyX7/Kl
	 f5qvlmJbrtk1w==
Date: Wed, 25 Feb 2026 20:31:24 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Koichiro Den <den@valinux.co.jp>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Fix regression in
 dw_pcie_ep_raise_msi_irq()
Message-ID: <qxcf4idjsbscd5tlgsbt3yg6xyngkn3wgaubaedgr24dx3pcsx@ejbrdqpryipe>
References: <20260210181225.3926165-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260210181225.3926165-2-cassel@kernel.org>

On Tue, Feb 10, 2026 at 07:12:25PM +0100, Niklas Cassel wrote:
> When using the nvmet-pci-epf EPF driver, and starting the EP before
> starting a host with UEFI, the UEFI performs NVMe commands e.g.
> Identify Controller, to get the name of the controller.
> 
> nvmet-pci-epf will post the CQE (completion queue entry) to the Admin
> Completion Queue, and then raise an IRQ (using
> dw_pcie_ep_raise_msi_irq()).
> 
> Once the host boots Linux, we will see a WARN_ON_ONCE() from
> dw_pcie_ep_raise_msi_irq(), and then the booting of the host hangs,
> because it never gets an IRQ when loading the nvme driver.
> 
> The reason is that the MSI target address used by UEFI and Linux might
> be different, which will cause dw_pcie_ep_raise_msi_irq() to simply
> return -EINVAL.
> 
> This was working before commit 8719c64e76bf ("PCI: dwc: ep: Cache MSI
> outbound iATU mapping"), so this is a regression.
> 
> Also, remove the warning, as we cannot know if there are operations in
> flight or not, so it seems wrong to print this warning unconditionally
> at every boot when e.g. nvmet-pci-epf is used with a host with UEFI.
> 
> Fixes: 8719c64e76bf ("PCI: dwc: ep: Cache MSI outbound iATU mapping")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

Bjorn, since this patch fixes a regression introduced in v7.0, could you please
take it for current -rc?

- Mani

> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 22 +++++++++++--------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 7e7844ff0f7e..5d8024d5e5c6 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -896,6 +896,19 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	 * supported, so we avoid reprogramming the region on every MSI,
>  	 * specifically unmapping immediately after writel().
>  	 */
> +	if (ep->msi_iatu_mapped && (ep->msi_msg_addr != msg_addr ||
> +				    ep->msi_map_size != map_size)) {
> +		/*
> +		 * The host changed the MSI target address or the required
> +		 * mapping size changed. Reprogramming the iATU when there are
> +		 * operations in flight is unsafe on this controller. However,
> +		 * there is no unified way to check if we have operations in
> +		 * flight, thus we don't know if we should WARN() or not.
> +		 */
> +		dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
> +		ep->msi_iatu_mapped = false;
> +	}
> +
>  	if (!ep->msi_iatu_mapped) {
>  		ret = dw_pcie_ep_map_addr(epc, func_no, 0,
>  					  ep->msi_mem_phys, msg_addr,
> @@ -906,15 +919,6 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  		ep->msi_iatu_mapped = true;
>  		ep->msi_msg_addr = msg_addr;
>  		ep->msi_map_size = map_size;
> -	} else if (WARN_ON_ONCE(ep->msi_msg_addr != msg_addr ||
> -				ep->msi_map_size != map_size)) {
> -		/*
> -		 * The host changed the MSI target address or the required
> -		 * mapping size changed. Reprogramming the iATU at runtime is
> -		 * unsafe on this controller, so bail out instead of trying to
> -		 * update the existing region.
> -		 */
> -		return -EINVAL;
>  	}
>  
>  	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);
> 
> base-commit: 43d324eeb08c3dd9fff7eb9a2c617afd3b96e65c
> -- 
> 2.53.0
> 

-- 
மணிவண்ணன் சதாசிவம்
