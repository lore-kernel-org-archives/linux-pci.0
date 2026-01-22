Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C887F311C33;
	Thu, 22 Jan 2026 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769117642; cv=none; b=lxJvzLkQ+FbV+4UxBfApnha9/1zB9Wgg7XfU9e808gmabKBxKH029ofs30d7NHye+SVbTmZuIW+tB7i8G1s6u7XQrtvOc0HUjKC8Qh9b23mybMLHpKyouvJiKeACKZpDdIbIDunOyuPzyek4a+4zDOTInGBa01fnfBdm3rXh+m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769117642; c=relaxed/simple;
	bh=ZDLp1Wrb27MTd2Skz+4rimYJk1ZPc3WK52MD6uXa1DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPMb2Hr3lM7ZmHPRbgV6lif8Ra2Zx9Do+2+tAavWWHnalZ18YSiEpu8gRPQMH0bPlXozYTsFT2Q2tW6PN/5i4mMO3XNMX34w6Css/xx7Ot0AE4cLYY5Xtk4jBVCLKN+7Q+fbpqs3ZxDxvvqD8MifrgQJ94Lz/hlagy920bB+XeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYu2UrYr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYu2UrYr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90170C116C6;
	Thu, 22 Jan 2026 21:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769117642;
	bh=ZDLp1Wrb27MTd2Skz+4rimYJk1ZPc3WK52MD6uXa1DA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rYu2UrYrqw3vg6PM9EnT7gcbbRg4YknkfWsORkmbNI3cK2hAz9mPGDBsiMlgTYLo2
	 PnZLncYm9/tu/OlesquYtII/p61qYY0h6UIBMFECenVtRyu6t05GacVsrxC1psfu8s
	 gXC4qTg21sY/CGUju1zzJqVkJSiq4Xtu3XTn+ploWLP0+82eQx2HL4SfMPQm3/A/Wk
	 EuKKl+oYq5sU7u25174mTcYW6iuLTfWYOW6EU+1wNsFcDFT2VywfKO6TPihQmc+gON
	 70uWtOlABeWRk6G7l79bYNFOsgvqoDadbgmPpFGltoHA5/QFiJ0RyAfybqyQEij2Br
	 4el5ZuV1hZMPA==
Date: Thu, 22 Jan 2026 22:33:56 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	macro@orcam.me.uk
Subject: Re: [PATCH v2 3/3] PCI: dwc: Fix missing iATU setup when ECAM is
 enabled
Message-ID: <aXKXxEE2HhyxUxaH@ryzen>
References: <20251229-ecam_io_fix-v2-0-41a0e56a6faa@oss.qualcomm.com>
 <20251229-ecam_io_fix-v2-3-41a0e56a6faa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229-ecam_io_fix-v2-3-41a0e56a6faa@oss.qualcomm.com>

On Mon, Dec 29, 2025 at 04:12:43PM +0530, Krishna Chaitanya Chundru wrote:
> When ECAM is enabled, the driver skipped calling dw_pcie_iatu_setup()
> before configuring ECAM iATU entries. This left IO and MEM outbound
> windows unprogrammed, resulting in broken IO transactions. Additionally,
> dw_pcie_config_ecam_iatu() was only called during host initialization,
> so ECAM-related iATU entries were not restored after suspend/resume,
> leading to failures in configuration space access
> 
> To resolve these issues, the ECAM iATU configuration is moved into
> dw_pcie_setup_rc(). At the same time, dw_pcie_iatu_setup() is invoked
> when ECAM is enabled.
> 
> Rename msg_atu_index to ob_atu_index to track the next available outbound
> iATU index for ECAM and MSG TLP windows. Furthermore, an error check is
> added in dw_pcie_prog_outbound_atu() to avoid programming beyond
> num_ob_windows.
> 
> Fixes: f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling ECAM mechanism using iATU 'CFG Shift Feature'")
> Reported-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Closes: https://lore.kernel.org/all/alpine.DEB.2.21.2511280256260.36486@angie.orcam.me.uk/
> Tested-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 41 ++++++++++++++---------
>  drivers/pci/controller/dwc/pcie-designware.c      |  3 ++
>  drivers/pci/controller/dwc/pcie-designware.h      |  2 +-
>  3 files changed, 29 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 88b6ace0607e97bf6dd6bf7886baaa13bf267e6e..cb1b5b2a2fe61eb5901e57a60f8f333b1c3e766b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -430,10 +430,10 @@ static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
>  	/*
>  	 * Root bus under the host bridge doesn't require any iATU configuration
>  	 * as DBI region will be used to access root bus config space.
> -	 * Immediate bus under Root Bus, needs type 0 iATU configuration and
> +	 * Immediate bus under Root Bus needs type 0 iATU configuration and
>  	 * remaining buses need type 1 iATU configuration.
>  	 */
> -	atu.index = 0;
> +	atu.index = pci->ob_atu_index;

Here you change atu.index = pp->ob_atu_index;

>  	atu.type = PCIE_ATU_TYPE_CFG0;
>  	atu.parent_bus_addr = pp->cfg0_base + SZ_1M;
>  	/* 1MiB is to cover 1 (bus) * 32 (devices) * 8 (functions) */
> @@ -443,6 +443,8 @@ static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
>  	if (ret)
>  		return ret;
>  
> +	pci->ob_atu_index++;
> +

Here you increment pp->ob_atu_index;

>  	bus_range_max = resource_size(bus->res);
>  
>  	if (bus_range_max < 2)
> @@ -455,7 +457,13 @@ static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
>  	atu.size = (SZ_1M * bus_range_max) - SZ_2M;
>  	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;

Yet here you do not assign atu.index = pp->ob_atu_index;

this means that you will overwrite the settings for the iATU that you just
configured above, rather than using a different iATU.

So this seems broken.

I have posted a patch proposal that avoids introducing a new struct member.

Perhaps you can help test it:
https://lore.kernel.org/linux-pci/aXKUW8euDVaRJofR@ryzen/


Kind regards,
Niklas

>  
> -	return dw_pcie_prog_outbound_atu(pci, &atu);
> +	ret = dw_pcie_prog_outbound_atu(pci, &atu);
> +	if (ret)
> +		return ret;
> +
> +	pci->ob_atu_index++;
> +
> +	return 0;
>  }
>  
>  static int dw_pcie_create_ecam_window(struct dw_pcie_rp *pp, struct resource *res)
