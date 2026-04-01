Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCC22E8DEC;
	Wed,  1 Apr 2026 12:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775046466; cv=none; b=qHGPSNDDXXKXA1zyE24/wAmGNwMjsTi+BJBFVwL3RdD28RuNc60itwqYS7KObfwa+ZCOsoJt0+wji95K1dvlVXfyYj3mkEKTy26Y1ZiZCwUgwzdjzJL6QvaSW4SdAh1YCtreyJU5gvGTuNt67yLizb6bvpx3oDkaYd/pvbaeH9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775046466; c=relaxed/simple;
	bh=aOQGf1z4MCJNyR1C0bAjjVji5JxDSKUr1t/FqKSUX2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbU9QvSBxS3Jr/QtRF0WCnaM292pETQ3Fr04QMAKDxWwbvytPQv4++zbIFND6dwhrtW2dMHm6p/0CokjU9RCkTm9862traz+izFE8Jl4O3V/ZVN8/n94hUtTCQCTsVJqOe7ZafNGQa/BvNe684QwBV2oGYnQCj/2pq03uCJ9/r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1XLCbiD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1XLCbiD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB43C4CEF7;
	Wed,  1 Apr 2026 12:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775046466;
	bh=aOQGf1z4MCJNyR1C0bAjjVji5JxDSKUr1t/FqKSUX2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u1XLCbiDXlNSUDoh0PD7XBxJ0sy3N3p0IHnsHQ4bvt1ksI29jrPot6zt0JPfimKNe
	 Sr7x9sMrCeYUbGaI7A/E6NbVsJKtYzklfveqoEckMGp91TjVFJzkhuuowifJaOnwHj
	 jVNiDCj02mibOGGJptyP6+8Hr16VaXnfeREiGugtRzuj9pxtuAoOZ6i2F0YlE+6YU7
	 dG+Cv9iq1Rx+YCuAbeFF0RHwUWYleOI0xr8xpgnElAMbU/iI9+SGpViVXdG8Ac8O5C
	 uKOZy5NwQ30CbnsW8HZe3gevfpTFd+hqLx/2oHw4w4A8dAeGfn21i9ebQ7YS0NLIqG
	 8pnGx6mH5lCsA==
Date: Wed, 1 Apr 2026 17:57:39 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, jingoohan1@gmail.com, kwilczynski@kernel.org, 
	bhelgaas@google.com, robh@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Fix type mismatch for kstrtou32_from_user
 return value
Message-ID: <e55eajqhjh4hgpgzlm4cr6lh5sw6eulkgn2iy53blwmttr7hq3@ndoeigvy2v3q>
References: <20260401023048.4182452-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260401023048.4182452-1-18255117159@163.com>

On Wed, Apr 01, 2026 at 10:30:48AM +0800, Hans Zhang wrote:
> kstrtou32_from_user() returns int, but the return value was stored in
> a u32 variable 'val', risking sign loss. Use a dedicated int variable
> to correctly handle the return code.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>

Can you add Fixes tag also?

- Mani

> ---
>  .../controller/dwc/pcie-designware-debugfs.c  | 21 +++++++++++--------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> index 0d1340c9b364..9461be074490 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> @@ -208,10 +208,11 @@ static ssize_t lane_detect_write(struct file *file, const char __user *buf,
>  	struct dw_pcie *pci = file->private_data;
>  	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
>  	u32 lane, val;
> +	int ret;
>  
> -	val = kstrtou32_from_user(buf, count, 0, &lane);
> -	if (val)
> -		return val;
> +	ret = kstrtou32_from_user(buf, count, 0, &lane);
> +	if (ret)
> +		return ret;
>  
>  	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG);
>  	val &= ~(LANE_SELECT);
> @@ -347,10 +348,11 @@ static ssize_t counter_enable_write(struct file *file, const char __user *buf,
>  	struct dw_pcie *pci = pdata->pci;
>  	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
>  	u32 val, enable;
> +	int ret;
>  
> -	val = kstrtou32_from_user(buf, count, 0, &enable);
> -	if (val)
> -		return val;
> +	ret = kstrtou32_from_user(buf, count, 0, &enable);
> +	if (ret)
> +		return ret;
>  
>  	mutex_lock(&rinfo->reg_event_lock);
>  	set_event_number(pdata, pci, rinfo);
> @@ -408,10 +410,11 @@ static ssize_t counter_lane_write(struct file *file, const char __user *buf,
>  	struct dw_pcie *pci = pdata->pci;
>  	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
>  	u32 val, lane;
> +	int ret;
>  
> -	val = kstrtou32_from_user(buf, count, 0, &lane);
> -	if (val)
> -		return val;
> +	ret = kstrtou32_from_user(buf, count, 0, &lane);
> +	if (ret)
> +		return ret;
>  
>  	mutex_lock(&rinfo->reg_event_lock);
>  	set_event_number(pdata, pci, rinfo);
> 
> base-commit: 9147566d801602c9e7fc7f85e989735735bf38ba
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
