Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394A6442397;
	Thu,  3 Sep 2026 11:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788433768; cv=none; b=DA4Hri5puyD7+Qzy4E3j7squZYHgeAlgJKZh/ekSmjET0Q5ihAvlKVB7tg+KMKnZLvwoDi0UKouiz/+jdb6x+FlaC8T8fgOg3p4AwUlSfKn6KxwWKAkwJ3Pgem/1FaEc+ja2jXMAJVnPQQS+Znvm/6OZVz5b4rzJBbXGOE+n1B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788433768; c=relaxed/simple;
	bh=TmXT+HYN/cU8mnCSt18o8JTXi5x1O3m8DS+9K5/x93E=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kiAQtCwTQ/oDpjUMygC0KbqAGyY3P5U09L+zxifRWw13iwT9uH8rsK3Ge1LCh/cTXMvlU9DutlJngsm5JtDIxGZL0G2fYI2Gn+2au3dxXiRwLjm/J8kjqWGLOU08+2i4X/VDot+HEfAe/ve45W0MiIcS59BJDRkcCr31YGN8FzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=neaei5Jv; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="neaei5Jv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788433767; x=1819969767;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TmXT+HYN/cU8mnCSt18o8JTXi5x1O3m8DS+9K5/x93E=;
  b=neaei5Jvw6lhIc1CRMJARY4h/k0CY+UE6B02j4Y9hw4w2vqSqskfw3E8
   28WbwgG67rnvkkAhPvWjRdL5KYRAS797ucAq5oNATZqCDB/y0foZYxjEo
   khnx3vo0QOAsQew5C6H7BQMRX43PqXpkude459Bgclc7JOe/918Fd+VC1
   IWiQqHKAM1JgcgrzIXindlGyrpVkhsgW7Xodj1+s+SHCLIu1OURPkrPbP
   DWuXjQRFGtjoTxIxDj4HaRAeOU4aqnghP1kaFNfEvDqhHo+NvDbLZvzAf
   WDX+0/kKHtSzRdqeDm08GNuw0pd0rKNFX2ZeP+AdWfOG3tiHjJHmlnkaj
   A==;
X-CSE-ConnectionGUID: Kw7gzP+mSya9l9oRZmtP+A==
X-CSE-MsgGUID: 5zZ3RLplQ+ap81HJ8+wkFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="106280295"
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; 
   d="scan'208";a="106280295"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 04:09:26 -0700
X-CSE-ConnectionGUID: 7ybkDdxCTm2vi62RQYiZ9Q==
X-CSE-MsgGUID: YXYnFQ57Rl6uQYrIgjgAWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; 
   d="scan'208";a="268372803"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.119])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 04:09:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 3 Sep 2026 14:09:16 +0300 (EEST)
To: Wei Wang <wei.w.wang@hotmail.com>
cc: bhelgaas@google.com, jgg@nvidia.com, jic23@kernel.org, error27@gmail.com, 
    kwilczynski@kernel.org, rdunlap@infradead.org, akpm@linux-foundation.org, 
    bp@alien8.de, alex@shazbot.org, kevin.tian@intel.com, 
    manivannan.sadhasivam@oss.qualcomm.com, 
    LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 6/6] PCI: Add the enhanced ACS controls check to
 pci_acs_flags_enabled()
In-Reply-To: <SI2PR01MB439314CABFD64FC0586F2FF8DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Message-ID: <59e3d834-2628-7ef3-b07a-33ce6e7dd482@linux.intel.com>
References: <SI2PR01MB4393F337A792CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com> <SI2PR01MB439314CABFD64FC0586F2FF8DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 3 Sep 2026, Wei Wang wrote:

> The enhanced ACS controls introduced by PCIe Gen 5 ensures better device
> isolation. On devices that support the PCI_ACS_ECAP capability, the
> controls are required to be enabled properly:
> - ACS I/O Request Blocking needs to be enabled to avoid unintended
>   upstream I/O requests.
> - ACS DSP and USP Memory Target Access Control needs to be set with
>   Request Redirect or Request Blocking to ensure the Downstream and
>   Upstream Port memory resource ranges are not accessed by upstream
>   memory requests.
> - ACS Unclaimed Request Redirect needs to be enabled to ensure accesses to
>   areas that lies within a Switch's Upstream Port memory apertures but not
>   within any Downstream Port memory apertures get redirected.
> 
> To maintain compatibility with legacy devices that lack PCI_ACS_ECAP
> support, pci_acs_enabled() skips checking for the capability.
> 
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/pci/pci.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 50a3b61f9898..b951195d5adc 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3648,6 +3648,57 @@ void pci_configure_ari(struct pci_dev *dev)
>  	}
>  }
>  
> +static bool pci_dev_has_memory_bars(struct pci_dev *pdev)
> +{
> +	int i;
> +
> +	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
> +		if (pci_resource_flags(pdev, i) & IORESOURCE_MEM)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool pci_acs_ecap_enabled(struct pci_dev *pdev, u16 ctrl)
> +{
> +	struct pci_dev *upstream_pdev;
> +
> +	/*
> +	 * For ACS DSP/USP Memory Target Access Control, either Request
> +	 * Redirect or Request Blocking must be enabled to enforce isolation.
> +	 * According to PCIe spec 7.0, the DSP Memory Target Access is
> +	 * applicable to both Root Ports and Switch Downstream Ports that have
> +	 * applicable Memory BAR space to protect. So if the device does not
> +	 * have a Memory BAR, it skips the check.
> +	 */
> +	if (pci_dev_has_memory_bars(pdev) &&
> +	    FIELD_GET(PCI_ACS_DMAC_MASK, ctrl) != PCI_ACS_MAC_RB &&
> +	    FIELD_GET(PCI_ACS_DMAC_MASK, ctrl) != PCI_ACS_MAC_RR)
> +		return false;
> +
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM) {
> +		upstream_pdev = pci_upstream_bridge(pdev);
> +
> +		/*
> +		 * The USP Memory Target Access is only applicable to
> +		 * downstream ports that have applicable Memory BAR space in
> +		 * the Switch Upstream Port to protect.
> +		 */
> +		if (upstream_pdev && pci_dev_has_memory_bars(upstream_pdev) &&
> +		    FIELD_GET(PCI_ACS_UMAC_MASK, ctrl) != PCI_ACS_MAC_RB &&
> +		    FIELD_GET(PCI_ACS_UMAC_MASK, ctrl) != PCI_ACS_MAC_RR)
> +			return false;
> +
> +		/* PCI_ACS_URRC is applicable to Downstream Ports only. */
> +		if (!(ctrl & PCI_ACS_URRC))
> +			return false;
> +	}
> +
> +	/* PCI_ACS_IB is applicable to both Root and Downstream Ports. */
> +	return !!(ctrl & PCI_ACS_IB);

When the return type is bool, !!() construct is unnecessary.

> +}
> +
>  static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
>  {
>  	int pos;
> @@ -3665,6 +3716,18 @@ static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
>  	acs_flags &= (pdev->acs_capabilities | PCI_ACS_EC);
>  
>  	pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl);
> +
> +	if (acs_flags & PCI_ACS_ECAP) {
> +		if (!pci_acs_ecap_enabled(pdev, ctrl))
> +			return false;
> +		/*
> +		 * The check for the required controls in PCI_ACS_ECAP has
> +		 * passed. Clear the ECAP flag and continue to check the
> +		 * basic ACS controls.
> +		 */
> +		acs_flags &= ~PCI_ACS_ECAP;
> +	}
> +
>  	return (ctrl & acs_flags) == acs_flags;
>  }
>  
> @@ -3723,6 +3786,8 @@ bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
>  	 */
>  	case PCI_EXP_TYPE_DOWNSTREAM:
>  	case PCI_EXP_TYPE_ROOT_PORT:
> +		/* PCI_ACS_ECAP applies to Root and Downstream Ports only */
> +		acs_flags |= PCI_ACS_ECAP;
>  		return pci_acs_flags_enabled(pdev, acs_flags);
>  	/*
>  	 * PCIe 3.0, 6.12.1.2 specifies ACS capabilities that should be
> 

-- 
 i.

