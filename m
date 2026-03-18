Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5794B3019AA;
	Wed, 18 Mar 2026 22:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773874627; cv=none; b=mkNGWtHsKSGUq9R4CBr5fuAvHaGETGe9XKuoKEIcLClDK4vFHQvPf+YI+y1haWjtCnJRdVDnbJTD1dbeO3fNmkuFF9AwSegCstj1FnmGePNLOqXfFyaElbsIgAVUn75NUdFd31jFdN3ofzWzuTN7pa9sjLM/9Q4TbiecmDU4GxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773874627; c=relaxed/simple;
	bh=J9eFyQt+RNxkmVpkIC9e2wfZZJIE1ZbQthGVje/wtnI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DMFy+umSxHOzwrhcYZFtggoz8EuewNcFWHNwNHm0WS8k/udn2q47UZdeGgUoV8E6gGFMfr7glxHONAs1wjLSyc7LLBCjz6OJamuZIxxTWONl/VIeCtd/F3FRQkPdmWIQZ07fhaesys2OgZ79V0a22Yq4xwM1Ht3pEyV4JRWtI9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D28vBbji; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D28vBbji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72AAC19421;
	Wed, 18 Mar 2026 22:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773874627;
	bh=J9eFyQt+RNxkmVpkIC9e2wfZZJIE1ZbQthGVje/wtnI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=D28vBbjibKAyxnEBg6RdAT7/D+5FPMHJWBVXKpO+qEL6DYDnUjug95l0SLYGQMl/O
	 PAXBViZHDnsp+t3+ddIpzizyOEZb84/WTkzJewtfldObK0Gpc/ZZ36X18aB63O6c9O
	 AkW8X1F+SwwLhR348sL7NVbwOLhg0qTlPA9+1MXTe2cJq+JZPGNBYJBihwBR0fp1me
	 sDj9l+WTsCQBDcWTXrTwlYrEew0uRJFuNHUooNYP8PkBcMkrphchORPHCm3z6Qdb09
	 Yu9hv+hrfY9lO7JPcKA2AIBz1Ay+V+ZEOAGuU6oRA+aEx3IxBY2lOMms4AyDfvxU8l
	 4hLGF8ffcxjMw==
Date: Wed, 18 Mar 2026 17:57:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: bhelgaas@google.com, joerg.roedel@amd.com, kevin.tian@intel.com,
	jgg@nvidia.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, xueshuai@linux.alibaba.com
Subject: Re: [PATCH rc] PCI: Fix nested pci_dev_reset_iommu_prepare/done()
Message-ID: <20260318225705.GA479639@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318220028.1146905-1-nicolinc@nvidia.com>

On Wed, Mar 18, 2026 at 03:00:28PM -0700, Nicolin Chen wrote:
> Shuai found that cxl_reset_bus_function() calls pci_reset_bus_function()
> internally while both are calling pci_dev_reset_iommu_prepare/done().
> 
> This results in a nested pci_dev_reset_iommu_prepare/done() call:
>     cxl_reset_bus_function():
>         pci_dev_reset_iommu_prepare(); // outer
>         pci_reset_bus_function():
>             pci_dev_reset_iommu_prepare(); // inner (re-entry)
>             ...
>             pci_dev_reset_iommu_done(); // inner
>         pci_dev_reset_iommu_done(); // outer
> 
> However, pci_dev_reset_iommu_prepare() doesn't allow a re-entry for now.
> 
> Digging further, I found that most functions in pci_dev_specific_reset()
> except reset_ivb_igd() are calling pcie_flr() that has nested those two
> functions as well.
> 
> Drop the outer callbacks in:
>  - cxl_reset_bus_function()
>  - pci_dev_specific_reset()
> 
> Replace with adding the callbacks in:
>  + reset_ivb_igd()

This needs to say clearly what the issue is.  Deadlock?  Crash?
Corruption?

I guess it's a deadlock when the second call to
pci_dev_reset_iommu_prepare() acquires the group->mutex?

Since f5b16b802174 appeared in v7.0-rc1 (merged by Joerg), I guess
this fix also needs to be in v7.0 -- please confirm.

> Fixes: f5b16b802174 ("PCI: Suspend iommu function prior to resetting a device")
> Cc: stable@vger.kernel.org
> Reported-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Closes: https://lore.kernel.org/all/absKsk7qQOwzhpzv@Asurada-Nvidia/
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/pci/pci.c    |  7 -------
>  drivers/pci/quirks.c | 29 +++++++++++------------------
>  2 files changed, 11 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8479c2e1f74f..8f1fd083a84c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4958,12 +4958,6 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  	if (rc)
>  		return -ENOTTY;
>  
> -	rc = pci_dev_reset_iommu_prepare(dev);
> -	if (rc) {
> -		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", rc);
> -		return rc;
> -	}
> -
>  	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR) {
>  		val = reg;
>  	} else {
> @@ -4978,7 +4972,6 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
>  				      reg);
>  
> -	pci_dev_reset_iommu_done(dev);
>  	return rc;
>  }
>  
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 48946cca4be7..d1d210bc2a15 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3973,6 +3973,7 @@ static int reset_ivb_igd(struct pci_dev *dev, bool probe)
>  	void __iomem *mmio_base;
>  	unsigned long timeout;
>  	u32 val;
> +	int ret;
>  
>  	if (probe)
>  		return 0;
> @@ -3981,6 +3982,12 @@ static int reset_ivb_igd(struct pci_dev *dev, bool probe)
>  	if (!mmio_base)
>  		return -ENOMEM;
>  
> +	ret = pci_dev_reset_iommu_prepare(dev);
> +	if (ret) {
> +		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
> +		goto out_iounmap;
> +	}
> +
>  	iowrite32(0x00000002, mmio_base + MSG_CTL);
>  
>  	/*
> @@ -4006,8 +4013,10 @@ static int reset_ivb_igd(struct pci_dev *dev, bool probe)
>  reset_complete:
>  	iowrite32(0x00000002, mmio_base + NSDE_PWR_STATE);
>  
> +	pci_dev_reset_iommu_done(dev);
> +out_iounmap:
>  	pci_iounmap(dev, mmio_base);
> -	return 0;
> +	return ret;
>  }
>  
>  /* Device-specific reset method for Chelsio T4-based adapters */
> @@ -4257,22 +4266,6 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  	{ 0 }
>  };
>  
> -static int __pci_dev_specific_reset(struct pci_dev *dev, bool probe,
> -				    const struct pci_dev_reset_methods *i)
> -{
> -	int ret;
> -
> -	ret = pci_dev_reset_iommu_prepare(dev);
> -	if (ret) {
> -		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
> -		return ret;
> -	}
> -
> -	ret = i->reset(dev, probe);
> -	pci_dev_reset_iommu_done(dev);
> -	return ret;
> -}
> -
>  /*
>   * These device-specific reset methods are here rather than in a driver
>   * because when a host assigns a device to a guest VM, the host may need
> @@ -4287,7 +4280,7 @@ int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
>  		     i->vendor == (u16)PCI_ANY_ID) &&
>  		    (i->device == dev->device ||
>  		     i->device == (u16)PCI_ANY_ID))
> -			return __pci_dev_specific_reset(dev, probe, i);
> +			return i->reset(dev, probe);
>  	}
>  
>  	return -ENOTTY;
> -- 
> 2.34.1
> 
