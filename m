Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314EB3203A0;
	Wed, 25 Feb 2026 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772038792; cv=none; b=MZ20BdrvaKDuFGeP5QOQj/MaPP+sH5fPWMFM1idYizXhZE7h7JWU7IUbSKxKE2ydBDGjJa9Okxsf+HpaPu6VCVyy5dXYjmDMDYcpwhzuH98BMnIp9m6MlTi3iDLjBUhUANsuNHN1NfHzY6Ejud/tTu2nvnfpXlodbnTB8yheqnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772038792; c=relaxed/simple;
	bh=uJ9BWQpmkbs7W1e9uEfwigN/WSI2DmJpcUoXCIWyAts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cV0DbE7pW4XxSDUqUgRg+u5EJjpARQU1ktF1XQM0F95/cFGfyJ7RXN3NYEKuJT0JeIuO+G032MApdc4oNmta2CVsG8D1DW19O/9t8JCL6VH6pmAyCDfrfNJ9vLQ0vcYtr79jLLZProXwY4RTl0aanozYDaqTCfhH7y4C1hX53io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ff2ke83R; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ff2ke83R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772038790; x=1803574790;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uJ9BWQpmkbs7W1e9uEfwigN/WSI2DmJpcUoXCIWyAts=;
  b=ff2ke83RvV0QPMduzYTtCIhpXlDrf0EgFctLRsAdhV/ApXiRYWpJeJCX
   VqYUJSazMpwtqnTsNqGgtUrOY3wMJzmxQrYAQXVb+DJhczXeEMSjfBXFr
   RaUdhGDQwLGaW/xBz5CAfk2KML/SI9/1Izg0eFvstKqyFst4i000YC+XW
   yIKrUlvpKLzEYq4kfKrRxfUBeayMV78wTdYP+EIrWvGpg7U7k5i7aK/lx
   58M3C+ESeoxQrgs0iJAsOUVrt+xtl27rld9HXulo283oPcgTG8VwbWuhn
   etrJlUpxGRW6oWFfxxB723bej+dixIlpJixfsIOcvvYUmRlYBGu/wjG7T
   g==;
X-CSE-ConnectionGUID: l8y4SJafRda22X0RX/F3sQ==
X-CSE-MsgGUID: 8MRayziJSw+x8vkRSEFfMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="76955179"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="76955179"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 08:59:48 -0800
X-CSE-ConnectionGUID: scLKyl7lTUyR102fI3YYcg==
X-CSE-MsgGUID: 5WBKC6akRWq1oxqDcFcHXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="239298566"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.111.98]) ([10.125.111.98])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 08:59:47 -0800
Message-ID: <59969b55-8360-4ae7-8e46-69e55c1e74d5@intel.com>
Date: Wed, 25 Feb 2026 09:59:46 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] NTB: epf: Report 0-based doorbell vector via
 ntb_db_event()
To: Koichiro Den <den@valinux.co.jp>, Frank.Li@nxp.com, kishon@kernel.org,
 jdmason@kudzu.us, mani@kernel.org, allenbh@gmail.com,
 kwilczynski@kernel.org, bhelgaas@google.com, jbrunet@baylibre.com,
 lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260224133459.1741537-1-den@valinux.co.jp>
 <20260224133459.1741537-9-den@valinux.co.jp>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260224133459.1741537-9-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/24/26 6:34 AM, Koichiro Den wrote:
> ntb_db_event() expects the vector number to be relative to the first
> doorbell vector starting at 0.
> 
> Vector 0 is reserved for link events in the EPF driver, so doorbells
> start at vector 1. However, both supported peers (ntb_hw_epf with
> pci-epf-ntb, and pci-epf-vntb) have historically skipped vector 1 and
> started doorbells at vector 2.
> 
> Pass (irq_no - 2) to ntb_db_event() so doorbells are reported as 0..N-1.
> If irq_no == 1 is ever observed, treat it as DB#0 and emit a warning, as
> this would indicate an unexpected change in the slot layout.
> 
> Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index ee499eaed4f3..00956ab2fbf5 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -333,10 +333,15 @@ static irqreturn_t ntb_epf_vec_isr(int irq, void *dev)
>  	irq_no = irq - pci_irq_vector(ndev->ntb.pdev, 0);
>  	ndev->db_val = irq_no + 1;
>  
> -	if (irq_no == 0)
> +	if (irq_no == 0) {
>  		ntb_link_event(&ndev->ntb);
> -	else
> -		ntb_db_event(&ndev->ntb, irq_no);
> +	} else if (irq_no == 1) {

Given that 0 and 1 have specific meanings, maybe create a enum with appropriate naming to make it more clear. Maybe something like this or however you want to name them:

enum EPF_IRQ_SLOT {
	EPF_IRQ_LINK = 0,
	EPF_IRQ_RESERVED_DB,
	EPF_IRQ_DB_START,
};
> +		dev_warn_ratelimited(ndev->dev,
> +				     "Unexpected irq_no 1 received. Treat it as DB#0.\n");
> +		ntb_db_event(&ndev->ntb, 0);
> +	} else {
> +		ntb_db_event(&ndev->ntb, irq_no - 2);

And then here you can do
ntb_db_event(&ndev->ntb, irq_no - EPF_IRQ_DB_START);

> +	}
>  
>  	return IRQ_HANDLED;
>  }

