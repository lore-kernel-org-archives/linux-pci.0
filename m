Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60257273803;
	Thu,  5 Mar 2026 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772706906; cv=none; b=eKjZbeCS0KdW9c3MoK/suMAYQfHOoFRFNj1v8P2okkkmhFzXeNYuQVVHZdXSK8Nq7HFFl6sTMKlWDVnCXknH9B1EizfBuw2zfbT1+4DtuiZg3SrogjJLxsyvVOlxb2fgurKYih1vd3SM5Osj9B71caaHHcj+w8aFvvLZ4byceYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772706906; c=relaxed/simple;
	bh=SHJrA8v6gZzVpEbA5JWqCBf2oH3mvCG/bchjwaakkwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoSLqr70d5/65LloN0IyOxVnTx3eQhgtUBYyFyov8Sanq4g+PxNfVWcXa1Tj457cuTCv23MpKLbDiirTLKmIaCqP8hmWhyFoJd1NmHYYyY/uRH1WMmne3GBwBet/OpDrJTFWOpG3kxPhZquNQZVPSZWXHutCc+HVeiMhB2CyFzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgMFW8M7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgMFW8M7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A7BC116C6;
	Thu,  5 Mar 2026 10:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772706905;
	bh=SHJrA8v6gZzVpEbA5JWqCBf2oH3mvCG/bchjwaakkwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PgMFW8M7Lma9TY3ZH9uzD5hW8NrbJs+osBrZMZea7orT6Y8vtiSC3fv7PnW/RoEk2
	 FJ6r5gGefVBTo1HGq4fKGrfykYibx5D9H71ZuHbKFmSaoZ3D3zVR1tDvEIuxg5uHvO
	 PIsP/+J1T0kH47Uv3kLf4EB54FJMFHFqx730KeiIqMLrlpsK6G37qogr1xu2LzZjRn
	 FSgq1grBGzlNSlsvuD8C+UZXv+nG3OEDhiiXdzLffXXpwcDBAM6hsva/YhYo7OKsoL
	 ullFXxyKojqaNrPGSZd2M4ToNecTtkRYK/nhYuxiykMxhu5o/s3Qe/SB2jerAaySV1
	 iUefltgkZLl3w==
Date: Thu, 5 Mar 2026 16:04:50 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org, Frank.Li@nxp.com, den@valinux.co.jp, hongxing.zhu@nxp.com, 
	jingoohan1@gmail.com, vidyas@nvidia.com, cassel@kernel.org, 18255117159@163.com, 
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 11/13] PCI: tegra194: Use HW version number
Message-ID: <bc7t56twrq25v2rwoghyoiuantmpozknhnyaq27qiafmnv7u2r@yppijlhxtzpl>
References: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
 <20260303065448.2361488-12-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303065448.2361488-12-mmaddireddy@nvidia.com>

On Tue, Mar 03, 2026 at 12:24:46PM +0530, Manikanta Maddireddy wrote:
> Tegra194 PCIe driver uses custom version number to detect Tegra194 and
> Tegra234 IPs. With version detect logic added, version check results
> in mismatch warnings.
> 

What warnings? This sounds like a separate fix.

> Use HW version numbers in Tegra194 driver to avoid this kernel warnings.
> 
> Fixed version check to enable ecrc for Tegra194.

This is a separate fix, so separate patch. Do not combine two unreleated fixes
in a single patch.

- Mani

> Existing 490A check is left intact in case any HW relying on existing check.
> 
> Fixes: a54e19073718 ("PCI: tegra194: Add Tegra234 PCIe support")
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> Changes V1 -> V7: None
> 
>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  drivers/pci/controller/dwc/pcie-designware.h | 2 ++
>  drivers/pci/controller/dwc/pcie-tegra194.c   | 4 ++--
>  3 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 345365ea97c7..0dac5d2f5a83 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -559,7 +559,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>  	if (upper_32_bits(limit_addr) > upper_32_bits(parent_bus_addr) &&
>  	    dw_pcie_ver_is_ge(pci, 460A))
>  		val |= PCIE_ATU_INCREASE_REGION_SIZE;
> -	if (dw_pcie_ver_is(pci, 490A))
> +	if (dw_pcie_ver_is(pci, 490A) || dw_pcie_ver_is(pci, 500A))
>  		val = dw_pcie_enable_ecrc(val);
>  	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index f4cf1602cc99..5bceadbd2c9f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -34,8 +34,10 @@
>  #define DW_PCIE_VER_470A		0x3437302a
>  #define DW_PCIE_VER_480A		0x3438302a
>  #define DW_PCIE_VER_490A		0x3439302a
> +#define DW_PCIE_VER_500A		0x3530302a
>  #define DW_PCIE_VER_520A		0x3532302a
>  #define DW_PCIE_VER_540A		0x3534302a
> +#define DW_PCIE_VER_562A		0x3536322a
>  
>  #define __dw_pcie_ver_cmp(_pci, _ver, _op) \
>  	((_pci)->version _op DW_PCIE_VER_ ## _ver)
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 1963165967b9..1c6543341fb9 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -35,8 +35,8 @@
>  #include <soc/tegra/bpmp-abi.h>
>  #include "../../pci.h"
>  
> -#define TEGRA194_DWC_IP_VER			0x490A
> -#define TEGRA234_DWC_IP_VER			0x562A
> +#define TEGRA194_DWC_IP_VER			DW_PCIE_VER_500A
> +#define TEGRA234_DWC_IP_VER			DW_PCIE_VER_562A
>  
>  #define APPL_PINMUX				0x0
>  #define APPL_PINMUX_PEX_RST			BIT(0)
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
