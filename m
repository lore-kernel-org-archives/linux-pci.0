Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF08E317141;
	Thu,  5 Mar 2026 11:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772709338; cv=none; b=VYrfkV1vnvHccfouxPzyOJu9zNEuhlrrt0xg/raen2XLmppELm4cU8YErDX4LfKTfsSxh82B9xZiDCBTM8AzMEVJCAt9ZDBX/BoDvjOuDtrhak2W+A+9ufskl7S16sUuPKJzKyYvqwXD0g6si9ZnqxodShURp1XcObIjPotKmMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772709338; c=relaxed/simple;
	bh=f84p9u8gSLiZhGldYTY4ffnCogLnLcaZIH+N8KJWFS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+uuYe4+GkH7hvGeus8pBTQxDcLvPVacQb513JWQ3wp96wMom/z6s1a+1hH8iot8EyHIKjTshLWUroJ4MoTy4eg6b0tiqvfHrpcE7nvKenR/swgUoEHwvK5j8Ebhb7hO6g4mrDqC8Ea0rDMIAD6AJrlwVJkkGpoLyGnccQpfMJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnUnXYi/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnUnXYi/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073CEC2BC87;
	Thu,  5 Mar 2026 11:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772709338;
	bh=f84p9u8gSLiZhGldYTY4ffnCogLnLcaZIH+N8KJWFS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qnUnXYi/aClk9FCTkX6PZEpDVQy2Tj6+tR5KPpVhyUAl++AIKCgTde7y4jbg/6kGM
	 qp7ZiXPXZcs4BmkzF5/ZdMruhcB7RMUfM0XRL/d3Sw0FRnUnFf6aP6DYhRp9M49ym1
	 LsB3Y7aWzoBwY/RaYhe22qlx0eXXJxpz8KN3CUhcb5Nkxet5c0djb9YripcxT/4/NG
	 kBqmSxvm/pAywYlr7UsINQfZbp9i8uxmoBf407xwuZMQ7RfAwPVnyBf7cxWClz3VET
	 yVquqi+8dCr7ErmSCdld2DoDnopllc2UH2S4DYMTgXgfkFytXOI2VHSjRtdPoLMFdU
	 Yn2DWXs2GWS7w==
Date: Thu, 5 Mar 2026 16:45:23 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org, Frank.Li@nxp.com, den@valinux.co.jp, hongxing.zhu@nxp.com, 
	jingoohan1@gmail.com, vidyas@nvidia.com, cassel@kernel.org, 18255117159@163.com, 
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 9/9] PCI: tegra194: Add ASPM L1 entrance latency config
Message-ID: <pbeqyqvguc4jlcj42waqhdxnls4p64ye2eihge5xre7xapccsp@2avedn7ozhob>
References: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
 <20260303065758.2364340-10-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303065758.2364340-10-mmaddireddy@nvidia.com>

On Tue, Mar 03, 2026 at 12:27:58PM +0530, Manikanta Maddireddy wrote:
> For Tegra234, the HW PHY team conducted experiments and determined the
> optimal ASPM L1 entrance latency values: 8 us for Root Port mode and
> 16 us for Endpoint mode. Update the default ASPM L1 entrance latency
> configuration accordingly.
> 

Can you please make use of the new 'aspm-l1-entry-delay-ns' devicetree property?

- Mani

> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> Changes V1 -> V7: None
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index e0455d322166..accb2f8d3de8 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -240,6 +240,8 @@ struct tegra_pcie_dw_of_data {
>  	u32 cdm_chk_int_en_bit;
>  	u32 gen4_preset_vec;
>  	u8 n_fts[2];
> +	/* L1 Latency entrance values(Rest/Prod) */
> +	u32 aspm_l1_enter_lat;
>  };
>  
>  struct tegra_pcie_dw {
> @@ -710,6 +712,8 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
>  	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
>  	val &= ~PORT_AFR_L0S_ENTRANCE_LAT_MASK;
>  	val |= (pcie->aspm_l0s_enter_lat << PORT_AFR_L0S_ENTRANCE_LAT_SHIFT);
> +	val &= ~PORT_AFR_L1_ENTRANCE_LAT_MASK;
> +	val |= (pcie->of_data->aspm_l1_enter_lat << PORT_AFR_L1_ENTRANCE_LAT_SHIFT);
>  	val |= PORT_AFR_ENTER_ASPM;
>  	dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
>  }
> @@ -2472,6 +2476,7 @@ static const struct tegra_pcie_dw_of_data tegra194_pcie_dw_rc_of_data = {
>  	/* Gen4 - 5, 6, 8 and 9 presets enabled */
>  	.gen4_preset_vec = 0x360,
>  	.n_fts = { 52, 52 },
> +	.aspm_l1_enter_lat = 3,
>  };
>  
>  static const struct tegra_pcie_dw_of_data tegra194_pcie_dw_ep_of_data = {
> @@ -2481,6 +2486,7 @@ static const struct tegra_pcie_dw_of_data tegra194_pcie_dw_ep_of_data = {
>  	/* Gen4 - 5, 6, 8 and 9 presets enabled */
>  	.gen4_preset_vec = 0x360,
>  	.n_fts = { 52, 52 },
> +	.aspm_l1_enter_lat = 3,
>  };
>  
>  static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_rc_of_data = {
> @@ -2493,6 +2499,7 @@ static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_rc_of_data = {
>  	/* Gen4 - 6, 8 and 9 presets enabled */
>  	.gen4_preset_vec = 0x340,
>  	.n_fts = { 52, 80 },
> +	.aspm_l1_enter_lat = 4,
>  };
>  
>  static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_ep_of_data = {
> @@ -2505,6 +2512,7 @@ static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_ep_of_data = {
>  	/* Gen4 - 6, 8 and 9 presets enabled */
>  	.gen4_preset_vec = 0x340,
>  	.n_fts = { 52, 80 },
> +	.aspm_l1_enter_lat = 5,
>  };
>  
>  static const struct of_device_id tegra_pcie_dw_of_match[] = {
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
