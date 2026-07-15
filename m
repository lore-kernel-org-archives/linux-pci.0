Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD363B42C1;
	Wed, 15 Jul 2026 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784134655; cv=none; b=NGPPdk3uqasUcQR0Sx2LK48hWFE4sodbLxx7+oLHlLwsu4AMC5c36iDcNesz1KUnYaKeIGrJTnoXp10Qpnxpbg4fo5NtQMZ0Md8gN+fiZ6RNFJ5KyGLW/zaX553ZiU9yXmW0FbWQ7MbX9HZXSMO+vrxlneSZoDmzufgve2bX4zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784134655; c=relaxed/simple;
	bh=Pq4y6qnLtvjviP2Zi8BuhQDTnkCwN/9xPoVMO4J8Gnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0oSKWRuEn/SOQM4bisJZ0fREoZ0WpOSiM6zHcfpydKklwqWmu6PTBSZupPW6Y0fRkTt2xtkCfEVT3vCb0HwMQ7xZKRmF6pYWRDstG2LG+eA3USLIsdY04wk1eo1trmF5izy1ftlGRW4upjLLG7GHbneOOQUk9gkqC5Ubfoqpyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=US/Fxzwx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="US/Fxzwx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DBB1F000E9;
	Wed, 15 Jul 2026 16:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784134653;
	bh=h8IsfLR7lhufmkHDSRLz+r+v8CXY6XC0EXO2JeuAauM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=US/FxzwxUlJ7/bxG680yEC1Jgx0JEE6EQob5n8V6GcuYnJNae2arDR+t2rt/gDPvW
	 UVgROl+P5QO31pkX/hOgXooXYE9rKNx2/NQcvgVfEn3xn5ELd70EHnh2sbdErwo6n2
	 S2CYqKtfSQavVU3lOyI6YFS8otqiWyQE5U+FRUQBmDyezlSnS+1eVA4XhoenOAVA8V
	 tsPjcNubS7CL+LRDh84LqHRvFz+uH66YSksb5lXVaU6Ls/F5qgVS6MVxTVJV+2rZzl
	 jLxuf8hW90YeOlCbr7YXhwKsETv16YdoAoprc8OFw7WAgUC9kxbljQHRF0N0MajefI
	 RxSJbYqATxaAA==
Date: Wed, 15 Jul 2026 18:57:24 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: hongxing.zhu@oss.nxp.com
Cc: frank.li@nxp.com, jingoohan1@gmail.com, l.stach@pengutronix.de, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v1] PCI: dwc: Add force_l2 flag for platforms requiring
 L2 entry without D3cold
Message-ID: <4d77g33u465lemzlal4mtf4b7vqxgrmjgtoars2yypbyuaz2ae@rrqsfc3ml4af>
References: <20260706024752.3256106-1-hongxing.zhu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260706024752.3256106-1-hongxing.zhu@oss.nxp.com>

On Mon, Jul 06, 2026 at 10:47:52AM +0800, hongxing.zhu@oss.nxp.com wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Some platforms like i.MX have their PCIe RC controllers powered off
> during system suspend, requiring full re-initialization on resume.
> These platforms need to enter L2 state to properly notify endpoints
> before power loss, even when D3cold is not supported.
> 

So during suspend, RC goes down but the EP stays powered ON? And due to RC
suddenly going down, EP is observing LDn?

Can you control RC power during suspend from pci-imx6 driver? I guess not.

Also, is this behavior applicable to all i.MX6 platforms? If so, how the suspend
worked before?

> Add a force_l2 flag to allow platform drivers to request L2 entry
> during suspend regardless of D3cold capability, and enable it for
> i.MX PCIe controllers.
> 

PCIe base spec r7.0, sec 5.2, mentions that the system software should
transition the device into D3Hot before broadcasing the PME_Turn_Off message.
So here we'd be violating that section of the spec if the endpoint is in
non-D3Hot state.

But honestly, I don't have a better solution than intiating L2 entry sequence
forcefully. Atleast, it should be documented in the comments and patch
description.

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c             | 5 +++++
>  drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++--
>  drivers/pci/controller/dwc/pcie-designware.h      | 5 +++++
>  3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index f55a68f60eea9..ea0b4eb03c1d0 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1966,6 +1966,11 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  		 */
>  		imx_pcie_add_lut_by_rid(imx_pcie, 0);
>  	} else {
> +		/*
> +		 * i.MX RC is powered off during suspend, force L2 entry to
> +		 * ensure proper endpoint notification before power loss.
> +		 */
> +		pci->pp.force_l2 = true;
>  		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_SKIP_L23_READY))
>  			pci->pp.skip_l23_ready = true;
>  		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_KEEP_MSI_CAP))
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 06722259d2e37..e3f022d2d453a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1222,14 +1222,18 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
>  
>  int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  {
> -	bool pme_capable = false;
> +	bool d3cold, pme_capable = false;
>  	int ret = 0;
>  	u32 val;
>  
>  	if (!dw_pcie_link_up(pci))
>  		goto stop_link;
>  
> -	if (!pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable))
> +	d3cold = pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable);
> +	/*
> +	 * Enter L2 if D3cold is possible or platform requires forced L2 entry
> +	 */
> +	if (!d3cold && !pci->pp.force_l2)
>  		return 0;
>  
>  	if (pci->pp.ops->pme_turn_off) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index de4b245b1758c..5e88459e0cfa0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -471,6 +471,11 @@ struct dw_pcie_rp {
>  	bool			native_ecam;
>  	bool                    skip_l23_ready;
>  	bool			skip_pwrctrl_off;
> +	/*
> +	 * Force L2 entry even if D3cold not possible (e.g., when RC loses
> +	 * power).
> +	 */
> +	bool                    force_l2;

Can it be called, 'suspend_poweroff' to indicate the actual quirk?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
