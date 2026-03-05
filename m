Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E6A374E53;
	Thu,  5 Mar 2026 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772703821; cv=none; b=lS29t6eTN6xdymoc2Xf623csi7etxzqIWgFTYcR5kMwmpTKO3jnNLzPCuB2u+c8qwKnCMUulvQ0K94Zqvi+twACkINyR8CZjoncJm0O0mP1PzsyFMjMTbIoqAbO7ZnRmR8CLkoDme8Q2kNrzfa7U0bNWTybtDiuXR0kmV4EmAc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772703821; c=relaxed/simple;
	bh=fS48OwWxLVQHQhxLkHNDQvrzSzRV8rXwmnPDQKMYEaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFk3pNgFXWSTsToXAm7XgrWx9/fJpVry/UhsVCmjG+Ap0xgQfYLMVzu2v5ERzBa7g7iTMdUv81gWng+k4E3egXKQlFyhDN/ZLeA++72DlAsHaTLClco5KfLLAcvn9ZHhBuJSYt6Z3/U2Qmde50MKmKwjYfZiHdJic/gO4bkg8TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hex5f4Fx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hex5f4Fx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4192DC19425;
	Thu,  5 Mar 2026 09:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772703820;
	bh=fS48OwWxLVQHQhxLkHNDQvrzSzRV8rXwmnPDQKMYEaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hex5f4FxVqyBvO50uxxL/kGCRviV/vUbl3rVgwQakLATKwEkSWLr8Pqu5H2gr4RNw
	 hf22gixN1bF4hII8addLtj0cfu4kHfO7jmistmqVIR+PrPvEHVupOYbOTErThtKapg
	 k5KX5D046lzbUpMTXx2zZqMAuKqvFHUXm4/KTaZ53k022SKojRYIzucGnGXaloDgsP
	 2AjRXHyqJT1lqZCekSYUU7NKaqAOKpb3JMYH6LSLWnC8npW1XBZmEMqDhbKoqmzPZK
	 XuBOvuoULr9U+7Czw2br+yfbO8vDiwt/umknwh2dO6/kEGY3LSoauhQv8LgAJGyqD6
	 cc9K7goRCDACQ==
Date: Thu, 5 Mar 2026 15:13:23 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org, Frank.Li@nxp.com, den@valinux.co.jp, hongxing.zhu@nxp.com, 
	jingoohan1@gmail.com, vidyas@nvidia.com, cassel@kernel.org, 18255117159@163.com, 
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 06/13] PCI: tegra194: Disable direct speed change for
 EP
Message-ID: <4zxcmzsm6l3zbz4pblp7c67xpn6q6okpqcilupv6l22ce4gcno@b4htj36ngr33>
References: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
 <20260303065448.2361488-7-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303065448.2361488-7-mmaddireddy@nvidia.com>

On Tue, Mar 03, 2026 at 12:24:41PM +0530, Manikanta Maddireddy wrote:
> From: Vidya Sagar <vidyas@nvidia.com>
> 
> Disable direct speed change for the Endpoint to prevent it from initiating
> the speed change post physical layer link up at gen1. This leaves the speed
> change ownership with the host.
> 

Why?

- Mani

> Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> Changes V1 -> V7: None
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 7dcf3e3596dd..2da3478f0b5f 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1805,6 +1805,10 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>  
>  	reset_control_deassert(pcie->core_rst);
>  
> +	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> +	val &= ~PORT_LOGIC_SPEED_CHANGE;
> +	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> +
>  	if (pcie->update_fc_fixup) {
>  		val = dw_pcie_readl_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF);
>  		val |= 0x1 << CFG_TIMER_CTRL_ACK_NAK_SHIFT;
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
