Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF7549253D;
	Thu, 11 Jun 2026 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200511; cv=none; b=Zs8b9Suf0SHXHegHNgRblcK5/Ydk4CXZ5XXuclmoaxd1XMxAYLVCREOEuPPaZd87rkAj5ihS1VvKwd2oLkPMSlso3XckOxEn6OEQnY6L9ZW+KPnOmXvE4QbJl+CoRG0ryfTVrhujCCVmknX0i/WRjvfIaWdbldm8UxPx748PjE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200511; c=relaxed/simple;
	bh=2AC46tZvYykjigg7GBMN536x6RAo0aprT9jrGOsEWg0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ouGU3VKxqHGE3QhO/lzxrgD2fggCdqupkLov1e9seOeMpaBZSYIYQvb1gulOisHmrJ+F9nW9IYQOUePKOB5aoWblEiTvn/+w/jZTazOWbDPJq72hsYIHb/znD3aIsSAsyuifKJXcXqiBvxBFaAtQWJSsXB4FX0tQkQBo4qlJLSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mR8xjL9Z; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mR8xjL9Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781200511; x=1812736511;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2AC46tZvYykjigg7GBMN536x6RAo0aprT9jrGOsEWg0=;
  b=mR8xjL9Z/Ve2/MxK2UiVJcISoKSjapRPpCtHw2V+ZRLcXWs9ToDDAdkR
   pUIjuTn4sh6corj0q7M5SzQVr8vugI167En0mS7yG4KDbYoq7QRJIJ0za
   4vajY10vqSLBrW7P8g3kxoX3iAH/H5IT1MW8AXKggYmmWn1/eifXep4D6
   X3a2dp3mOMSeLrjZpp3DTDkyMbZJ2cYf4/PJu+Wv1wN3y0blC1HGWGLQm
   xqiLFutjJc52pW0qG8aOE2hJRLIqaqpAL4/+xayMNg5Zoauvj1mzauGox
   E3Ptl241Cc9AWsOpp+ubkVPXkVNFTEhNeoCP6buogkf2YTvOtshnATouX
   g==;
X-CSE-ConnectionGUID: A0DOU9iXQMmfrMBMB4SC+g==
X-CSE-MsgGUID: cfJcbzZVSKa7XsODuRwO9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81931227"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="81931227"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:55:10 -0700
X-CSE-ConnectionGUID: Z3EvVDVNRSaJmgg8XNl1rg==
X-CSE-MsgGUID: 3ISxqkw6TvCTTuxd6yYqdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="250844127"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.157])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:55:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Jun 2026 20:55:01 +0300 (EEST)
To: Hans Zhang <18255117159@163.com>
cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
    kwilczynski@kernel.org, mani@kernel.org, jingoohan1@gmail.com, 
    robh@kernel.org, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v7 3/3] PCI: dwc: Use common speed conversion function
In-Reply-To: <20260407130450.1489318-4-18255117159@163.com>
Message-ID: <9fed4498-0218-872c-0fb2-92c33c8726b7@linux.intel.com>
References: <20260407130450.1489318-1-18255117159@163.com> <20260407130450.1489318-4-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 7 Apr 2026, Hans Zhang wrote:

> Replace the private switch-based speed conversion in
> dw_pcie_link_set_max_speed() with the public pci_bus_speed2lnkctl2()
> function.
> 
> This eliminates duplicate conversion logic and ensures consistency with
> other PCIe drivers, while handling invalid speeds by falling back to
> hardware capabilities.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 28 +++++++-------------
>  1 file changed, 9 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 06792ba92aa7..10895f6a8e6e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -843,8 +843,10 @@ EXPORT_SYMBOL_GPL(dw_pcie_upconfig_setup);
>  
>  static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
>  {
> -	u32 cap, ctrl2, link_speed;
> +	u32 cap, ctrl2;
> +	enum pci_bus_speed link_speed;
>  	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	u16 ctrl2_speed;
>  
>  	cap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
>  
> @@ -861,30 +863,18 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
>  	ctrl2 = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
>  	ctrl2 &= ~PCI_EXP_LNKCTL2_TLS;

Not directly related to this patch but I wonder why this function gets the 
speed from LNKCTL2 instead of taking it from LNKCAP2_SLS.

>  
> -	switch (pcie_get_link_speed(pci->max_link_speed)) {
> -	case PCIE_SPEED_2_5GT:
> -		link_speed = PCI_EXP_LNKCTL2_TLS_2_5GT;
> -		break;
> -	case PCIE_SPEED_5_0GT:
> -		link_speed = PCI_EXP_LNKCTL2_TLS_5_0GT;
> -		break;
> -	case PCIE_SPEED_8_0GT:
> -		link_speed = PCI_EXP_LNKCTL2_TLS_8_0GT;
> -		break;
> -	case PCIE_SPEED_16_0GT:
> -		link_speed = PCI_EXP_LNKCTL2_TLS_16_0GT;
> -		break;
> -	default:
> +	link_speed = pcie_get_link_speed(pci->max_link_speed);
> +	ctrl2_speed = pci_bus_speed2lnkctl2(link_speed);
> +	if (ctrl2_speed == 0) {
>  		/* Use hardware capability */
> -		link_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
> +		ctrl2_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
>  		ctrl2 &= ~PCI_EXP_LNKCTL2_HASD;
> -		break;
>  	}

I again lament a bit that pcie_capability_read_*() cannot be used early in 
the controller drivers, which might allow using e.g. 
pcie_get_supported_speeds() here (depending on whether the small 
differences this function has compared it are really meaningful or not). 

But this is not really a problem this series is trying to address so as 
stated in my comment to the other patch, no objection to this change.

> -	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2, ctrl2 | link_speed);
> +	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2, ctrl2 | ctrl2_speed);
>  
>  	cap &= ~((u32)PCI_EXP_LNKCAP_SLS);
> -	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, cap | link_speed);
> +	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, cap | ctrl2_speed);
>  
>  }
>  
> 

-- 
 i.

