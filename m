Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4CB41C6A;
	Wed, 22 Apr 2026 06:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776838558; cv=none; b=YtcqXoGZ2/YlsTLM//fywdyOorbgKSxlb4sT1b4fY7DmG55DHH8zFD8OJE9JDyt6oWDWihap+bxcpcfG9KB9/jCTDK6ylH2G0BrB1PdsKQGvytTghHyi0yIqmHp8dGgpNR8XCUWms2320wFLl4g/kV8eFF2TSn8c17+wqNgQNoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776838558; c=relaxed/simple;
	bh=wNW80J9+6cZEODBKEuNJBOLTJ4Is+qz3rHCTGu+9o+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qOZtTdXlcmIhllaVQ8NPcVG8QpPY/8qXyYYMU9TVojIItTj2eF/Es9PGJt4UCDjeaURa1LcfYgxWd1i4bge2HkE2Zc34qh/gAV7LexKvZ/QqOdEyux6OIg66s/IwN++s0VBzcIAdRK7C3+1XRjkvi/CWP/gdJXjYatu31upS02I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D511bxnO; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D511bxnO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776838556; x=1808374556;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wNW80J9+6cZEODBKEuNJBOLTJ4Is+qz3rHCTGu+9o+w=;
  b=D511bxnO+G3dKFEjkzI88SGLVlzh7wSN4qGMgd/OtwVnasKefAx+JcJh
   AH0bzEbcBL5AzLMeLNuY9ZO5VY7spSKVPYYzX/iX9pYD0kr4SuzPFCWO2
   VAubcGnISSh8cs2KijSYr+GJiSbsL4LEu7I3XQA0B35SnhLQ30oeiwCkW
   oXTv9u87d0PTDf8Djyipo2VTVbf85vW2bVTm4X+Rj0TgdnST16pq84Vf1
   WxoHYyTAJWKljBpWFNxICCpJyaPXTE5DwzpySa81I4EwrBHAlYdP0TqLd
   nnE+myWcPNwSJ+3Tag48GAoWLyZa7fdj0pk54sMKtQFVa+UY0Nz3KmOZm
   w==;
X-CSE-ConnectionGUID: Uqu6aBLzSbiHQ/PONe0S/g==
X-CSE-MsgGUID: yNSAFwtMQ9KBcVn7pWBVpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77765898"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77765898"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 23:15:55 -0700
X-CSE-ConnectionGUID: 2R1ctoaSQaaYdcrEGlRJGA==
X-CSE-MsgGUID: RYB6JcRSSRyoZ6TmdWoRfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="227926992"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 23:15:52 -0700
Message-ID: <cbcbea4e-c857-4b75-a55d-ba3f89cdf22d@linux.intel.com>
Date: Wed, 22 Apr 2026 14:13:49 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] PCI: Propagate FLR return values to callers
To: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
 Kevin Tian <kevin.tian@intel.com>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, vsethi@nvidia.com,
 Shuai Xue <xueshuai@linux.alibaba.com>
References: <cover.1776381841.git.nicolinc@nvidia.com>
 <8bc784e505dc04ca81582307c4a70babbf58eca0.1776381841.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <8bc784e505dc04ca81582307c4a70babbf58eca0.1776381841.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/17/26 07:28, Nicolin Chen wrote:
> A reset failure implies that the device might be unreliable. E.g. its ATC
> might still retain stale entries. Thus, the IOMMU layer cannot trust this
> device to resume its ATS function that can lead to memory corruption. So,
> the pci_dev_reset_iommu_done() won't recover the device's IOMMU pathway if
> the device reset fails.
> 
> Those functions in the pci_dev_reset_methods array invoke pcie_flr(), but
> do not check the return value. Propagate them correctly.
> 
> Given that these functions have been running okay, and the return values
> will be only needed for an incoming work. This is not treated as bug fix.
> 
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/pci/quirks.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 48946cca4be72..05ce12b6b2f76 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3957,7 +3957,7 @@ static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, bool probe)
>   	 * supported.
>   	 */
>   	if (!probe)
> -		pcie_flr(dev);
> +		return pcie_flr(dev);
>   	return 0;
>   }
>   
> @@ -4015,6 +4015,7 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, bool probe)
>   {
>   	u16 old_command;
>   	u16 msix_flags;
> +	int ret;
>   
>   	/*
>   	 * If this isn't a Chelsio T4-based device, return -ENOTTY indicating
> @@ -4060,7 +4061,7 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, bool probe)
>   				      PCI_MSIX_FLAGS_ENABLE |
>   				      PCI_MSIX_FLAGS_MASKALL);
>   
> -	pcie_flr(dev);
> +	ret = pcie_flr(dev);

It makes more sense to return early here on failure. There is no need to
perform the subsequent steps if pcie_flr() fails. Would something like
the following work?

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 757a296eae41..9e0f29ac9f95 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4015,6 +4015,7 @@ static int reset_chelsio_generic_dev(struct 
pci_dev *dev, bool probe)
  {
         u16 old_command;
         u16 msix_flags;
+       int ret;

         /*
          * If this isn't a Chelsio T4-based device, return -ENOTTY 
indicating
@@ -4060,7 +4061,9 @@ static int reset_chelsio_generic_dev(struct 
pci_dev *dev, bool probe)
                                       PCI_MSIX_FLAGS_ENABLE |
                                       PCI_MSIX_FLAGS_MASKALL);

-       pcie_flr(dev);
+       ret = pcie_flr(dev);
+       if (ret)
+               return ret;

         /*
          * Restore the configuration information (BAR values, etc.) 
including

>   
>   	/*
>   	 * Restore the configuration information (BAR values, etc.) including
> @@ -4069,7 +4070,7 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, bool probe)
>   	 */
>   	pci_restore_state(dev);
>   	pci_write_config_word(dev, PCI_COMMAND, old_command);
> -	return 0;
> +	return ret;
>   }
>   
>   #define PCI_DEVICE_ID_INTEL_82599_SFP_VF   0x10ed
> @@ -4152,9 +4153,7 @@ static int nvme_disable_and_flr(struct pci_dev *dev, bool probe)
>   
>   	pci_iounmap(dev, bar);
>   
> -	pcie_flr(dev);
> -
> -	return 0;
> +	return pcie_flr(dev);
>   }
>   
>   /*
> @@ -4166,14 +4165,16 @@ static int nvme_disable_and_flr(struct pci_dev *dev, bool probe)
>    */
>   static int delay_250ms_after_flr(struct pci_dev *dev, bool probe)
>   {
> +	int ret;
> +
>   	if (probe)
>   		return pcie_reset_flr(dev, PCI_RESET_PROBE);
>   
> -	pcie_reset_flr(dev, PCI_RESET_DO_RESET);
> +	ret = pcie_reset_flr(dev, PCI_RESET_DO_RESET);
>   
>   	msleep(250);

The same there, ...

>   
> -	return 0;
> +	return ret;
>   }
>   
>   #define PCI_DEVICE_ID_HINIC_VF      0x375E
> @@ -4189,6 +4190,7 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
>   	unsigned long timeout;
>   	void __iomem *bar;
>   	u32 val;
> +	int ret;
>   
>   	if (probe)
>   		return 0;
> @@ -4209,7 +4211,7 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
>   	val = val | HINIC_VF_FLR_PROC_BIT;
>   	iowrite32be(val, bar + HINIC_VF_OP);
>   
> -	pcie_flr(pdev);
> +	ret = pcie_flr(pdev);


... and here.

>   
>   	/*
>   	 * The device must recapture its Bus and Device Numbers after FLR
> @@ -4236,7 +4238,7 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
>   reset_complete:
>   	pci_iounmap(pdev, bar);
>   
> -	return 0;
> +	return ret;
>   }
>   
>   static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {

Thanks,
baolu
