Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5282F29E117;
	Tue, 26 May 2026 22:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779834502; cv=none; b=K1GXF6JUbMxyX9EDuPSy/JZSUdaly3J/ud9FW/pCmfV5ju4+X5QrX+HcuCtVx0TqRHpNQyxa6VO38WIVIiIDSgTjdtZfE5jDce6m9gjT9/hKwyeK/ibos8bODrhQPEseuNH8FOnRB72ZRyqCOErXjgfYL9pAAKWjXZBmXct4zFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779834502; c=relaxed/simple;
	bh=DSQS0+DexPCgxmMKRpQw5TgbaijpiO6FbzL/yZpD66w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=niblnCV1UZF6lpqrAYL2w2Xy9RVGjTB91kewpQiovgDrPjgliyi0StHiqnjD03HwRHBWd2Q9V/MdHjRq01OmwMu3Zk0vyBUwnacrHJnPLE5MULGxyQLHFHSfWEjwjnyqQVBZAY3k/OXoOrVrzoDEdT17M4qiH9v6R/LWKFkl6LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NZhFCWV4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NZhFCWV4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779834500; x=1811370500;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DSQS0+DexPCgxmMKRpQw5TgbaijpiO6FbzL/yZpD66w=;
  b=NZhFCWV4XlECvsW2/8+e50vsptMf80z/0ftBKGUUYbQBjwblEFLh7fjY
   BSWhF4ZQofDAjdyTRW1ypuJDdYDU9WhIejB6qrN+J/kmHsCs+hMVLGxNI
   +deckHcu2cVYjphUEgCIDGz+/PnaLlLlf7IwkfDPC0VwX99GXLMvZpRw+
   8+CsRI9g01aXftq6/NzjdPov5vS93XahkMQ3pvqTGTyU4HKbOkXqawz+9
   LmzLeGwpQH7IJ1Rl4SRNgIs2hSN3G/hquunbfxdA/t25tdtj1IyUhmXXI
   OCpiUpUQIyyRnX/fxz7FqEtAfmIJcF+e8htn6Cc/MPWHY+XVxZ3UTz/8k
   g==;
X-CSE-ConnectionGUID: bkjxajSHQxSier1y24SN1w==
X-CSE-MsgGUID: fLlJuOWHQpmXpk/BWeBfbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="84517404"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="84517404"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 15:28:19 -0700
X-CSE-ConnectionGUID: 4D0K4i7bR7qqgAX2V8b1xA==
X-CSE-MsgGUID: EEPbJoVOQ8KTLrJsNYEMNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="241215313"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.201]) ([10.125.110.201])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 15:28:18 -0700
Message-ID: <f3ff7198-ec67-4ac5-8c82-e47707fb533a@intel.com>
Date: Tue, 26 May 2026 15:28:17 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/12] NTB: epf: Report 0-based doorbell vector via
 ntb_db_event()
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 ntb@lists.linux.dev
References: <20260513024923.451765-1-den@valinux.co.jp>
 <20260513024923.451765-11-den@valinux.co.jp>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260513024923.451765-11-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/12/26 7:49 PM, Koichiro Den wrote:
> ntb_db_event() expects the vector number to be relative to the first
> doorbell vector starting at 0.
> 
> Vector 0 is reserved for link events in the EPF driver, so doorbells
> start at vector 1. However, both supported peers (ntb_hw_epf with
> pci-epf-ntb, and pci-epf-vntb) have historically skipped vector 1 and
> started doorbells at vector 2.
> 
> Pass (irq_no - 2) to ntb_db_event() so doorbells are reported as 0..N-1.
> If irq_no == 1 is ever observed, warn and ignore it, since the slot is
> reserved in the legacy layout and reporting it as DB#0 would collide with
> the real DB#0 slot.
> 
> Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
> Changes since v3:
>   - Ignore the reserved legacy slot instead of reporting it as DB#0.
>   - Drop a Reviewed-by tag due to the behavior change.
> 
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index c0bab3292075..7b0fc7ef00c6 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -81,6 +81,12 @@ enum epf_ntb_bar {
>  	NTB_BAR_NUM,
>  };
>  
> +enum epf_irq_slot {
> +	EPF_IRQ_LINK = 0,
> +	EPF_IRQ_RESERVED_DB, /* Historically skipped slot */
> +	EPF_IRQ_DB_START,
> +};
> +
>  #define NTB_EPF_MAX_MW_COUNT	(NTB_BAR_NUM - BAR_MW1)
>  
>  struct ntb_epf_dev {
> @@ -334,10 +340,14 @@ static irqreturn_t ntb_epf_vec_isr(int irq, void *dev)
>  	irq_no = irq - ndev->irq_base;
>  	ndev->db_val = irq_no + 1;
>  
> -	if (irq_no == 0)
> +	if (irq_no == EPF_IRQ_LINK) {
>  		ntb_link_event(&ndev->ntb);
> -	else
> -		ntb_db_event(&ndev->ntb, irq_no);
> +	} else if (irq_no == EPF_IRQ_RESERVED_DB) {
> +		dev_warn_ratelimited(ndev->dev,
> +				     "Unexpected reserved doorbell slot IRQ received\n");
> +	} else {
> +		ntb_db_event(&ndev->ntb, irq_no - EPF_IRQ_DB_START);
> +	}
>  
>  	return IRQ_HANDLED;
>  }

