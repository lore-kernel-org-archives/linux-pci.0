Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2F635E920;
	Tue,  3 Mar 2026 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772542524; cv=none; b=ErsW/wLmniv8TJwvR8TXkvu+VvE3JJMNVD/JbeFiP1sfRbVG2+mMJ/eAs3jCDZlD6NEEC4653nTI7O74ug/Q2yb0AM1ZZGNvQZjdkmr7KzB8D2LoKl5bXhoeqX+NlgNIU/ahvIUVR00TmqpAL1+9sUWw8BNuVTHWrJl/Vox0xGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772542524; c=relaxed/simple;
	bh=X7b0l5UfpEPWh6pSTR7k8bTJKcNnW2Q28ca5oRWkO4o=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jCTiS39XWL952F/UUyLpW+fvupd69J7fl8kTxeoPga0bjmfD6GMwKK8HvjoxK/b82B2TXx9sfsz+RuxjdUypZ9uFkEwxpnD6tHgB7ym7MozbxhgVBmT5zHz8rf/mj0F3hLfz2xGQ7bN0ZQBmC/MhQm3IxWWcrKGTXRiz6cjpSS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KLjPPtb2; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KLjPPtb2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772542524; x=1804078524;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=X7b0l5UfpEPWh6pSTR7k8bTJKcNnW2Q28ca5oRWkO4o=;
  b=KLjPPtb2dPbnbjjBc7q2nGY2BnssYt7TmRxs35ejJxOthp7cGnjjRQTS
   B6HDhWOLGSrPup4HxOtEFwQ+SqkHMjHlCY2OSX7rMUq2c8AwuDVJou88o
   3eb+6esKuMkxcE2zxFpALxKyNpqemZQB5eo0tmW86oGKBqkkldhc+NG5S
   WGc49YQ9fIzEvx/lh4eZ6dHVoNbpX9HwGXKM09pxOx6491fusvxhkw4PC
   09y2fx6yT/WS/5UuM78lbQqYfQbNMLnqXPALzYnmLC+o8qZsLGg8JaScz
   t/0/i+UhS/p2sg6kMxWIrwFCKnbC4QePBKETlWaigi8bf/9EoabpjVvt8
   Q==;
X-CSE-ConnectionGUID: ugj7WDSFTSSKsgr7EWYTuA==
X-CSE-MsgGUID: n6Upv6zBR/OBVYbvs+2rZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="77186571"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="77186571"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 04:55:24 -0800
X-CSE-ConnectionGUID: nZbChQzFQkWg50S7DU73BQ==
X-CSE-MsgGUID: KG2z3iOlQNSR6U/9yrGaWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="255869916"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.62])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 04:55:21 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 3 Mar 2026 14:55:18 +0200 (EET)
To: "haoyu.lu" <hechushiguitu666@gmail.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: probe: Fix spacing around operators
In-Reply-To: <20260303073655.2047-1-hechushiguitu666@gmail.com>
Message-ID: <9ea9a54d-4a07-fd75-59df-0addeff46090@linux.intel.com>
References: <20260303073655.2047-1-hechushiguitu666@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 3 Mar 2026, hechushiguitu666@gmail.com wrote:

> From: "haoyu.lu" <hechushiguitu666@gmail.com>
> 
> Fix checkpatch.pl warnings for missing spaces around operators:
> 
> - size-1 -> size - 1
> 
> - PCI_BRIDGE_RESOURCES+i -> PCI_BRIDGE_RESOURCES + i
> 
> - 60*1000 -> 60 * 1000
> 
> Signed-off-by: haoyu.lu <hechushiguitu666@gmail.com>
> ---
>  drivers/pci/probe.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index bccc7a4bdd79..e54fa8a9f377 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -119,7 +119,7 @@ static u64 pci_size(u64 base, u64 maxbase, u64 mask)
>  	 * Get the lowest of them to find the decode size, and from that
>  	 * the extent.
>  	 */
> -	size = size & ~(size-1);
> +	size = size & ~(size - 1);
>  	/*
>  	 * base == maxbase can be valid only if the BAR has already been
> @@ -594,7 +594,7 @@ void pci_read_bridge_bases(struct pci_bus *child)
>  
>  	pci_bus_remove_resources(child);
>  	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++)
> -		child->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
> +		child->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES + i];

Convert to pci_resource_n().

>  
>  	pci_read_bridge_io(child->self,
>  			   child->resource[PCI_BUS_BRIDGE_IO_WINDOW], false);
> @@ -2600,7 +2600,7 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
>  	struct pci_dev *dev;
>  	u32 l;
>  
> -	if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, 60*1000))
> +	if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, 60 * 1000))

This should use linux/units.h *_PER_* constant instead of 1000.

>  		return NULL;
>  
>  	dev = pci_alloc_dev(bus);
> 

-- 
 i.

