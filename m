Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5D41D5170;
	Thu, 26 Mar 2026 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774541332; cv=none; b=tEVaGMn/7B4Oz/zfULJhI6WwfKfmgzzVXCvNgFHWmumKGLF62PfpPHOqgrTnRdcIs69pkG0Xx+ebYpWT/O+I1TnDMU6dK3VGn/kMN2aKtWTJ/SLStqLLjxjjn8wgjM2aBUJAF12QyXkpvBIuTzTIHLxg8jpXAIgDz3f0fCrojEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774541332; c=relaxed/simple;
	bh=pVgScUSOWXgtb3mZAaSpbFVwDY4tO4P3PEA0kM/XEEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iomwfnQfrv1/5jQsHpCQpdhhGAO0DxQYwjXsyQDmiBX6L/gxl5WNap77z99i2vaYn8sAugG/W7gwhichMNllW38VeTSTRShKt1Dw7Ptz59VQ9XHJEm5iPl1kj49vVZClo8pxHIpqqOwDRBYaaiGIeb/FgGmj372hVHtSPe/BcM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsQM/b1C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsQM/b1C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B38C116C6;
	Thu, 26 Mar 2026 16:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774541332;
	bh=pVgScUSOWXgtb3mZAaSpbFVwDY4tO4P3PEA0kM/XEEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nsQM/b1C0MzlSg2lb6md0c7j75J64bVLhlwz89eCM7e5Ko6IoDMFXRzT6z5121qgT
	 9HG95eQyoTyGkCCtok7P9OdRT6Y1p9S+MEiYVp4vRVcefvp8Ll4KXIwBQpYnx6gOF7
	 46+XjA2oW5UsBSz5Q7br9kMi4nPgu0FBHoH+sjJPG9fetkttrxt8wUqkcg1BRwTSKO
	 IacR9DtrWpojrF0IsXtPLmfNn/0/9mAGnYylcT/nQgqGZglo2OPX4NyfXX7wtuCLyn
	 7lJuIIDuITtDYWOInhNoQKmab7pYdY41ETnvwIRFudAvcM3lC0MeKjLSH6oi3blXkq
	 lEL+SlkwP11zQ==
Date: Thu, 26 Mar 2026 21:38:39 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Florian Eckert <fe@dev.tdt.de>
Cc: Chuanhua Lei <lchuanhua@maxlinear.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Johan Hovold <johan+linaro@kernel.org>, Sajid Dalvi <sdalvi@google.com>, 
	Ajay Agarwal <ajayagarwal@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] PCI: intel-gw: Enable clock before phy init
Message-ID: <acem5jvxct2izfwgqdtf52tijntkh6lz2eyeydsmfxzpue744i@nbzoe3ysilo6>
References: <20260317-pcie-intel-gw-v1-0-7fe13726ad4f@dev.tdt.de>
 <20260317-pcie-intel-gw-v1-2-7fe13726ad4f@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260317-pcie-intel-gw-v1-2-7fe13726ad4f@dev.tdt.de>

On Tue, Mar 17, 2026 at 11:12:50AM +0100, Florian Eckert wrote:
> To ensure that the boot sequence is correct, the dwc pcie core clock must
> be switched on before phy init call.
> 
> This changes are based on patched kernel sources of the MaxLinear SDK,
> which can be found at https://github.com/maxlinear/linux
> 

How can we treat Maxlinear kernel source as a reference for Intel driver?
Atleast, you need to provide some info onto why this should be trusted as a
reference like used a product etc...

> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
>  drivers/pci/controller/dwc/pcie-intel-gw.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
> index 3a85bd0ef1b7f9414ce19fe56d82a78e34e9b648..6110a8adb8732dbbd5e9e2db68a0606ccf032ae1 100644
> --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> @@ -292,13 +292,9 @@ static int intel_pcie_host_setup(struct intel_pcie *pcie)
>  
>  	intel_pcie_core_rst_assert(pcie);
>  	intel_pcie_device_rst_assert(pcie);
> -
> -	ret = phy_init(pcie->phy);
> -	if (ret)
> -		return ret;
> -
>  	intel_pcie_core_rst_deassert(pcie);
>  
> +	/* Controller clock must be provided earlier than PHY */
>  	ret = clk_prepare_enable(pcie->core_clk);
>  	if (ret) {
>  		dev_err(pcie->pci.dev, "Core clock enable failed: %d\n", ret);
> @@ -307,13 +303,17 @@ static int intel_pcie_host_setup(struct intel_pcie *pcie)
>  
>  	pci->atu_base = pci->dbi_base + 0xC0000;
>  
> +	ret = phy_init(pcie->phy);
> +	if (ret)
> +		goto phy_err;

You just messed up the whole error path. This one should branch to
err_disable_core_clk that disables core_clk and deasserts reset.

> +
>  	intel_pcie_ltssm_disable(pcie);
>  	intel_pcie_link_setup(pcie);
>  	intel_pcie_init_n_fts(pci);
>  
>  	ret = dw_pcie_setup_rc(&pci->pp);
>  	if (ret)
> -		goto app_init_err;
> +		goto phy_err;

And this to err_phy_exit that does phy_exit().

>  
>  	dw_pcie_upconfig_setup(pci);
>  
> @@ -322,13 +322,13 @@ static int intel_pcie_host_setup(struct intel_pcie *pcie)
>  
>  	ret = dw_pcie_wait_for_link(pci);
>  	if (ret)
> -		goto app_init_err;
> +		goto phy_err;
>  
>  	intel_pcie_core_irq_enable(pcie);
>  
>  	return 0;
>  

Here, you should add shuffle phy_exit() accordingly.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
