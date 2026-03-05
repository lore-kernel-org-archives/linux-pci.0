Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DD937F018;
	Thu,  5 Mar 2026 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707440; cv=none; b=fplaV/hL9/iuWB2ueRjZ7UFnYORDqOop36EGqs2v/GWEHXzTHoMg55C21i29mlf1aFc/goL1x3DcLN5lsu8JGZh6bnV0+wY1yG7pn5un13m+v65BBnHrJrJ0Fm3hXf4UZJbgR7dKgExEnmjKzWSHqn0bAwh5ApyzTGrIiFZilY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707440; c=relaxed/simple;
	bh=0Kiqz9Rzs1YlqHCpoNj87895SVqICgvPa419bedvoWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGFDa7RY7JhxM9X9aBfY1U8cTRBhRrIgCsSTKaIglZ4IV93jdM9CUr3s8v0PxHp9oc1JfAcunxVBNLK7P/6pmOIwIm8nHlpOsxEJNtyGKoeeNcKYkdrnrJNS7D9AK9CoBqHAr7yg7eLabNxr2N6uBl8EBr0rMALuhCSy3K+5mno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uw+R5yA3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uw+R5yA3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71D3C116C6;
	Thu,  5 Mar 2026 10:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772707439;
	bh=0Kiqz9Rzs1YlqHCpoNj87895SVqICgvPa419bedvoWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uw+R5yA3MUv4PNkkuKKCNLptSRP0jYEQjj+PCLPVGP8v6yQhjs/4uPELYXeX73Vwe
	 /S15IFd70DrxT4Q/TbZm739mMD0na4KMVQFhAGiDtTZC2kq3N/NyVOHjOTFkQtVpPS
	 RW/cI7YPDJmp2w7peOB5JV49w4u6DE62dtzWH0Qo7hvV7YGvao5m3ZXqg09ktdYWJt
	 X/MW2t/QGcGbCmrZ+nH5oOaKOgeoYcHgSLk5LDMLu24DQQNxz7eBKhtMi/6i1yjnMz
	 R+PJ/CcADurifvdLe2BIOs/7hUD5e+wAbCl/om4rZMPnoprUF84e63tkik3XPhK09p
	 Hx2OJMvGKiGDw==
Date: Thu, 5 Mar 2026 16:13:43 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org, Frank.Li@nxp.com, den@valinux.co.jp, hongxing.zhu@nxp.com, 
	jingoohan1@gmail.com, vidyas@nvidia.com, cassel@kernel.org, 18255117159@163.com, 
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 13/13] PCI: tegra194: Free resources during controller
 deinitialization
Message-ID: <bbv5jceuy7vj6t6h6ncxfaxgmrb4acuhzkazinwhyf2zru7pvi@f7maptqx6jqr>
References: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
 <20260303065448.2361488-14-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303065448.2361488-14-mmaddireddy@nvidia.com>

On Tue, Mar 03, 2026 at 12:24:48PM +0530, Manikanta Maddireddy wrote:
> From: Vidya Sagar <vidyas@nvidia.com>
> 
> Call pci_epc_deinit_notify() during controller deinitialization to free the
> resources allocated by Endpoint function driver. This is safe to call
> during PCIe assert sequence because we don't expect Endpoint function
> driver to touch hardware in deinit function.
> 

Are you sure? The epf-test driver itself touches DBI space during deinit.

- Mani

> Fixes: 40e2125381dc ("PCI: tegra194: Move controller cleanups to pex_ep_event_pex_rst_deassert()")
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> Changes V5 -> V7: None
> Changes V4 -> V5: Remove pci_epc_deinit_notify() call from pex_ep_event_pex_rst_deassert()
> Changes V1 -> V4: None
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index a311c31109e3..b1ae46761915 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1624,12 +1624,16 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
>  
>  static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
>  {
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct dw_pcie_ep *ep = &pci->ep;
>  	u32 val;
>  	int ret;
>  
>  	if (pcie->ep_state == EP_STATE_DISABLED)
>  		return;
>  
> +	pci_epc_deinit_notify(ep->epc);
> +
>  	ret = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, val,
>  		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_QUIET) ||
>  		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_ACT) ||
> @@ -1796,7 +1800,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>  	reset_control_deassert(pcie->core_rst);
>  
>  	/* Perform cleanup that requires refclk and core reset deasserted */
> -	pci_epc_deinit_notify(pcie->pci.ep.epc);
>  	dw_pcie_ep_cleanup(&pcie->pci.ep);
>  
>  	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
