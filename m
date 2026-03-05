Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E685F37FF70;
	Thu,  5 Mar 2026 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708585; cv=none; b=kGssR3FBFpPQt5JS9xrQDl0BB8YxJUkypmcyZ8UhN39ftkGygNMdOQUu5UnLQ7JvnAqdJZzSv6iohEmzwyh574s3zxgxNfXGQ0YEDBOHuYG3Cfy5ZYe6V7R2BbHkCudnK9aMUJgf+Rf6+++I5qqVnW+mnfb8aXxL1m224DiLNeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708585; c=relaxed/simple;
	bh=m3OvAiCaeL/Hh0MZvVwE+H8H8Ra63fd16RQ19d4SNgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0iLElGyUmNuNhKiESJUZQ8ymR8dJhpyQY+PEMWidguPzkTEpjurjMmFAc2jsf/WCF97b+3xyKaiSEM4/ojOujScnYdnd/UHWpPkR7a90aKr1wLa9ZwYYmfxim8KNPPYurxBujAL0FW0K+6wGlCcyabaY9KGQrGcYE6qPMVY69E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeRsmjgW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeRsmjgW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFBE9C116C6;
	Thu,  5 Mar 2026 11:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772708584;
	bh=m3OvAiCaeL/Hh0MZvVwE+H8H8Ra63fd16RQ19d4SNgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UeRsmjgWdNdGnQtYIE/MIwaXjDBu05Tv8WvumkfbYszS7YvyHHhbMKEw+Pb2ocGlE
	 31oiB8aucbknyCTwHOZkAPsCozG29pA5wKock8FEbrJn+ZHm5QG1dW1Dpjcetko1Dm
	 w12BFEWKT8csawRD3J2FcKBvlHy68EtG47h9hp0iShOW6M4cE0nob96u8BHNpGT/xi
	 cSIQaHIRgCq34IwXTBoJ4x/WCtw+cUl5FTHpEfivSI7Gqd6VuAGqhRQnarzquwqJcg
	 hWn8SDJTQOF8K0CEMgwCHuYy/NqsgZXfhKILqvNuaExWHEZy0RBF344inWcCeDkdmQ
	 +W971DXx99RRg==
Date: Thu, 5 Mar 2026 16:32:47 +0530
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
Message-ID: <2jjklvdczzdfalo7j3atb3lqirbbtzxsoyztaxffapzdoq5xg3@2osxbh3w6w6j>
References: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
 <20260303065758.2364340-4-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303065758.2364340-4-mmaddireddy@nvidia.com>

On Tue, Mar 03, 2026 at 12:27:52PM +0530, Manikanta Maddireddy wrote:
> From: Vidya Sagar <vidyas@nvidia.com>
> 
> The Tegra PCIe Endpoint controller has a single interrupt line that is
> shared between multiple interrupt sources:
> 1. PCIe link state events (link up, hot reset done)
> 2. Configuration space events (Bus Master Enable changes)
> 3. DMA completion events
> 
> Currently, the interrupt is registered with IRQF_ONESHOT, which keeps the
> interrupt line masked until the threaded handler completes. This prevents
> the DMA driver from sharing the same interrupt line, as the DMA completion
> interrupts would be blocked while the threaded handler processes link state
> events.
> 
> Removing IRQF_ONESHOT is safe for the following reasons:
> 
> 1. The hard IRQ handler (tegra_pcie_ep_hard_irq) properly acknowledges and
>    clears all interrupt status bits in hardware before returning. This
>    prevents interrupt storms and ensures the interrupt controller can
>    re-enable the interrupt line immediately.
> 
> 2. The hard IRQ handler explicitly checks for DMA interrupts
>    (APPL_INTR_STATUS_L1_8_0_EDMA_INT_MASK) and marks them as handled,
>    allowing the DMA driver's handler to process them separately.
> 

Is this change actually present in the upstream driver? I can't see it, but just
the definition of APPL_INTR_STATUS_L1_8_0_EDMA_INT_MASK.

> 3. The threaded handler (tegra_pcie_ep_irq_thread) only processes link-up
>    notifications and LTR message sending. These operations don't conflict
>    with DMA interrupt processing and don't require the interrupt line to
>    remain masked.
> 
> This change enables the DMA driver to share the interrupt line with the
> PCIe Endpoint driver, allowing both drivers to process their respective
> events without blocking each other.
> 

I don't know how the DMA driver can share the interrupt requested by the
endpoint controller driver.

- Mani

> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> Changes V6 -> V7: None
> Changes V1 -> V6: Updated commit message
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 980988b7499c..352412680b4d 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2227,7 +2227,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>  		ret = devm_request_threaded_irq(dev, pp->irq,
>  						tegra_pcie_ep_hard_irq,
>  						tegra_pcie_ep_irq_thread,
> -						IRQF_SHARED | IRQF_ONESHOT,
> +						IRQF_SHARED,
>  						"tegra-pcie-ep-intr", pcie);
>  		if (ret) {
>  			dev_err(dev, "Failed to request IRQ %d: %d\n", pp->irq,
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
