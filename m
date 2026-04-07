Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15206394498;
	Tue,  7 Apr 2026 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775550357; cv=none; b=rpvSltbIS9CEVwoK5mpKS5Crq5c8dkuBiukn4qgbaDN5JeMk2etoW1EJjv8ehU5i9gX9BjOnvWrJWsBUpCurK2COBSCJkUQ3uL6oxXT3FywLvgCN4Enee7uL9tC/RRgEi57poW8XEspy3XTyJbh3M47ngQOShcOiFrjnwbWCCO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775550357; c=relaxed/simple;
	bh=NOOfJANXyUWskr2hnKRMxpBIpD7dQu4FuqOw7Se01NM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pN3xacjzX38+q661pDYcb3x9QwMyO16e4WHgOpZp1pwwqCoRBxQT4bjARqkW3tLWxWLg4uljVFsVZEgb/wQAnxNTh9nHKSXcYJVLAa+U8boxstkF3y3O1Xg+ByUOXCL/lZCHxoP12A4lmNtvynf8T3spfHSVqSE9/tMx73AZ8lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NYSBY3aF; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NYSBY3aF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775550356; x=1807086356;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NOOfJANXyUWskr2hnKRMxpBIpD7dQu4FuqOw7Se01NM=;
  b=NYSBY3aFWQ1BRv5gxf1qvhnzr26laaVTeu3xPMfbBYrvF8AylMthLefn
   0RefwsEUV/SQztsNR9E7VtPHdRw68KfwFPAAmdsplRb4+TlEq6WIUExBj
   IEqlLA6P9H3txVo9UoSCNEhBQN1hyFP1sWquQLj7VicBLMwwK8Nt9Pi6Q
   sOZ2IJsusW5UCJzQ4teZXtobnXNBKkmkcZ1M1r/nVO2yUC7kdiUvP7vp+
   44C3YGYcOYGPD8chSMxOzDU6uOhdM9pbDPc+or+wwpofug3UC+xNolcbN
   6ux+vfzrhgN+f0Tfw4HP0Scp6wPPQDDeSE346bshGyuL5L40ypbZGO66U
   w==;
X-CSE-ConnectionGUID: rrnsRpT4Rni+2a7fA7G/hw==
X-CSE-MsgGUID: qEZ+jMQNSvWUoi/HG/8jnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="87580893"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="87580893"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 01:25:55 -0700
X-CSE-ConnectionGUID: fyJj+8C8TJSJQR7paVFt8A==
X-CSE-MsgGUID: 26XtL99YSkitBkZPYsfmMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="225356161"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.110])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 01:25:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 7 Apr 2026 11:25:49 +0300 (EEST)
To: Hans Zhang <18255117159@163.com>
cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
    kwilczynski@kernel.org, mani@kernel.org, jingoohan1@gmail.com, 
    robh@kernel.org, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/3] PCI: dwc: Use common speed conversion function
In-Reply-To: <20260406105613.1228673-4-18255117159@163.com>
Message-ID: <d2bb9eae-8731-b438-87dd-fcbcf2a17551@linux.intel.com>
References: <20260406105613.1228673-1-18255117159@163.com> <20260406105613.1228673-4-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 6 Apr 2026, Hans Zhang wrote:

> Replace the private switch-based speed conversion in
> dw_pcie_link_set_max_speed() with the public pci_bus_speed2lnkctl2()
> function.
> 
> This eliminates duplicate conversion logic and ensures consistency with
> other PCIe drivers, while handling invalid speeds by falling back to
> hardware capabilities.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 06792ba92aa7..ab8dee5d6c7a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -861,24 +861,12 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
>  	ctrl2 = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
>  	ctrl2 &= ~PCI_EXP_LNKCTL2_TLS;
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
> +	link_speed = pci_bus_speed2lnkctl2(link_speed);

Its signature is:

u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)

Using link_speed variable both for in and out does contradict with the
expected typing.

Maybe it would be beneficial to rename the current 'link_speed' to 
'ctrl2_speed' (or something along those lines) to differentiate Link 
Control 2 speed representation from PCI core's internal link speed 
representation. And then reintroduce link_speed variable as the 
pci_bus_speed. ...But this is just my suggestion, there may be better ways 
to untangle this type abuse.

> +	if (link_speed == 0) {
>  		/* Use hardware capability */
>  		link_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
>  		ctrl2 &= ~PCI_EXP_LNKCTL2_HASD;
> -		break;
>  	}
>  
>  	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2, ctrl2 | link_speed);
> 

-- 
 i.

