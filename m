Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961071B4257;
	Thu,  5 Mar 2026 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708989; cv=none; b=gmagHPkO19Kouja2zqQJO1n/UH3vuhFyjtMVRFhN7ReWSzwZ84eZkUTlSlZodNXmS8+9vve/2GIEZ6yyEH1wPw7+/xDXt5KMzJP6OraVpxY7jhKyZbQlgmBlo0eTpWoPoxgvrieBG/7Sbf8jenN01VLsD/Ml9KaMYXiwckgqxkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708989; c=relaxed/simple;
	bh=gtgNAxbHJcZxz2wzydobvlT+Iu/3PB2YfdCDeQcuTkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZSRZWBhly3Tfrrc5/cIuUFhoqis8C20eEmF6hUTWAvyt3Zs6eUiebtC9jSe5FfARkPgHb+t9pQNnGzTTbKNcC2x6P7WiDvqkTia7V1BCzK/aXe73F4e3bjkTQRaTBIzKKKyu32ts4At/DWH8T+dJ1zsZwx8U+ay1rJuGVDbaWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKPaVsdj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKPaVsdj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FCCC116C6;
	Thu,  5 Mar 2026 11:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772708989;
	bh=gtgNAxbHJcZxz2wzydobvlT+Iu/3PB2YfdCDeQcuTkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tKPaVsdjdClG8jtVpTTZ4OnM129iPTWqmotplJe3VVAdAQ7P2kzdmVcAg1U3tn/Tq
	 ePLJoprMdiqmKtOjHTBIc9zXgYb8rt8gzTLqjaHt0eKnPHFBglPPffcin4/51HxejU
	 V6GJhrMExvSSMvg/5xsmHkw1MuxQK+r/+eLZ+H5VkMFlO6mzIorizpG63LUdCdqPDR
	 QzEHOZkl6ETtNgBBQu+lHMYCShmJRfYrmER9MKN/hQDPrysw65TvlE+tUokIJ8jyxh
	 XPRJtpRTMHJAG+1y5746JszQOaBtolY5mNGUAmo85aEORgULrNPZzCVgyU+qLEby0z
	 humEOKB0GFscA==
Date: Thu, 5 Mar 2026 16:39:33 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org, Frank.Li@nxp.com, den@valinux.co.jp, hongxing.zhu@nxp.com, 
	jingoohan1@gmail.com, vidyas@nvidia.com, cassel@kernel.org, 18255117159@163.com, 
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 6/9] PCI: tegra194: Disable L1.2 capability of
 Tegra234 EP
Message-ID: <pvi52yfy72jd3jfambb7efq6255cwjbh4wzlakwpb7vyatxi7h@3ywjmthheiq5>
References: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
 <20260303065758.2364340-7-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303065758.2364340-7-mmaddireddy@nvidia.com>

On Tue, Mar 03, 2026 at 12:27:55PM +0530, Manikanta Maddireddy wrote:
> From: Vidya Sagar <vidyas@nvidia.com>
> 
> When Tegra234 is operating in the Endpoint mode with L1.2 enabled, PCIe
> link goes down during L1.2 exit. This is because Tegra234 is powering up
> UPHY PLL immediately without making sure that the REFCLK is stable.
> This is causing UPHY PLL to not lock to the correct frequency and leading
> to link going down. There is no hardware fix for this, hence do not
> advertise the L1.2 capability in the Endpoint mode.
> 
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

There should be Fixes tag pointing to the commit that added Tegra234 support.

- Mani

> ---
> Changes V1 -> V7: None
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 8f95910e99bc..070eb7f4058d 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -236,6 +236,7 @@ struct tegra_pcie_dw_of_data {
>  	bool has_sbr_reset_fix;
>  	bool has_l1ss_exit_fix;
>  	bool has_ltr_req_fix;
> +	bool disable_l1_2;
>  	u32 cdm_chk_int_en_bit;
>  	u32 gen4_preset_vec;
>  	u8 n_fts[2];
> @@ -688,6 +689,22 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
>  	if (pcie->supports_clkreq)
>  		pci->l1ss_support = true;
>  
> +	/*
> +	 * Disable L1.2 capability advertisement for Tegra234 Endpoint mode.
> +	 * Tegra234 has a hardware bug where during L1.2 exit, the UPHY PLL is
> +	 * powered up immediately without waiting for REFCLK to stabilize. This
> +	 * causes the PLL to fail to lock to the correct frequency, resulting in
> +	 * PCIe link loss. Since there is no hardware fix available, we prevent
> +	 * the Endpoint from advertising L1.2 support by clearing the L1.2 bits
> +	 * in the L1 PM Substates Capabilities register. This ensures the host
> +	 * will not attempt to enter L1.2 state with this Endpoint.
> +	 */
> +	if (pcie->of_data->disable_l1_2 && pcie->of_data->mode == DW_PCIE_EP_TYPE) {
> +		val = dw_pcie_readl_dbi(pci, l1ss + PCI_L1SS_CAP);
> +		val &= ~(PCI_L1SS_CAP_PCIPM_L1_2 | PCI_L1SS_CAP_ASPM_L1_2);
> +		dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, val);
> +	}
> +
>  	/* Program L0s and L1 entrance latencies */
>  	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
>  	val &= ~PORT_AFR_L0S_ENTRANCE_LAT_MASK;
> @@ -2465,6 +2482,7 @@ static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_ep_of_data = {
>  	.mode = DW_PCIE_EP_TYPE,
>  	.has_l1ss_exit_fix = true,
>  	.has_ltr_req_fix = true,
> +	.disable_l1_2 = true,
>  	.cdm_chk_int_en_bit = BIT(18),
>  	/* Gen4 - 6, 8 and 9 presets enabled */
>  	.gen4_preset_vec = 0x340,
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
