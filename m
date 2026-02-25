Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A972222A9;
	Wed, 25 Feb 2026 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039086; cv=none; b=Ny7gAtwQmRk5zzQUiRIN4uS+Br3U0K0Lofhajgx9oIlpNJkEnZRMZsp2Pfx2EMb860BG7phPTgoCVSgfxfQlCCvs8EQqINgonwcr3cdzsYShymy48TvaxHLQKmIr8xhpBiRo4UKhLl2+GY4avkoQXy66/vsGKIfqufnOIgsaLnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039086; c=relaxed/simple;
	bh=NNSLk/mzuRhlf5SQt4v4wmAT/v/xmMkOUnUanR8BoQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/+1Ph3Bh6bwQYDjCu22ThxW5ayP+6zUury1+0Yy/CeQOtBpgWdkGeuBz3/8Li/EhVrGMGPoIwxfs/oer2z4XhvVAp981VJZ3Bb1ggl+OPUi96+3A+BD/parqaD5piQ6wdOgUMcYaZcaN9by/hQKsL32kW7TzCMTKRZw7LqV/hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F8l25Um0; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F8l25Um0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772039084; x=1803575084;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NNSLk/mzuRhlf5SQt4v4wmAT/v/xmMkOUnUanR8BoQ8=;
  b=F8l25Um0TGDpJrY2KxFUZ+b+uqDurpte4e/YAiBYP4NB9l2fx10JP0jI
   +eoYI0WtLXvga9yDMrCESY/xR97jkY3FA40YBrnBOYklkuVmbN3BuKAZr
   Cr5D3vbRKcPUHoESgV62kDpm8a4QNrR2DfvLqFDBQhWFuWqGLxC9f863S
   Oox1PzTNa3XM7WL8nB+zS410q+4ZYfkm2Vm9I2by3b8IYZrHC980e/U58
   nEEPrNrdreU/FO/HRGjpXbqyB+QoBVwKcFKukSw4p7hYv7yETFuc5G7mR
   YdLXwsaUiSgnipvXs2YqXdHHD02NlkpAYOaeVdnCxoPfN3GHALo1NolFi
   g==;
X-CSE-ConnectionGUID: qrISB1CJTOOlo8vonm5klQ==
X-CSE-MsgGUID: 6jWcW8SFRbic/IkQ/5qflw==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="76956232"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="76956232"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 09:04:44 -0800
X-CSE-ConnectionGUID: D8rcoCrTT2WDAXFLjVm+Bg==
X-CSE-MsgGUID: yo0Y5VVsR9yyooLhsIBrbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="239299311"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.111.98]) ([10.125.111.98])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 09:04:43 -0800
Message-ID: <99bea052-80f4-4552-8e98-4b99094c8335@intel.com>
Date: Wed, 25 Feb 2026 10:04:42 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] NTB: epf: Fix doorbell bitmask handling in
 db_read/db_clear
To: Koichiro Den <den@valinux.co.jp>, Frank.Li@nxp.com, kishon@kernel.org,
 jdmason@kudzu.us, mani@kernel.org, allenbh@gmail.com,
 kwilczynski@kernel.org, bhelgaas@google.com, jbrunet@baylibre.com,
 lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260224133459.1741537-1-den@valinux.co.jp>
 <20260224133459.1741537-10-den@valinux.co.jp>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260224133459.1741537-10-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/24/26 6:34 AM, Koichiro Den wrote:
> The EPF driver currently stores the incoming doorbell as a vector number
> (irq_no + 1) in db_val and db_clear() clears all bits unconditionally.
> This breaks db_read()/db_clear() semantics when multiple doorbells are
> used.
> 
> Store doorbells as a bitmask (BIT_ULL(vector)) and make
> db_clear(db_bits) clear only the specified bits. Use atomic64 operations
> as db_val is updated from interrupt context.
> 
> Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index 00956ab2fbf5..0018adc35f16 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -6,6 +6,7 @@
>   * Author: Kishon Vijay Abraham I <kishon@ti.com>
>   */
>  
> +#include <linux/atomic.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> @@ -102,7 +103,7 @@ struct ntb_epf_dev {
>  	unsigned int self_spad;
>  	unsigned int peer_spad;
>  
> -	int db_val;
> +	atomic64_t db_val;
>  	u64 db_valid_mask;
>  };
>  
> @@ -331,15 +332,16 @@ static irqreturn_t ntb_epf_vec_isr(int irq, void *dev)
>  	int irq_no;
>  
>  	irq_no = irq - pci_irq_vector(ndev->ntb.pdev, 0);
> -	ndev->db_val = irq_no + 1;
>  
>  	if (irq_no == 0) {
>  		ntb_link_event(&ndev->ntb);
>  	} else if (irq_no == 1) {
>  		dev_warn_ratelimited(ndev->dev,
>  				     "Unexpected irq_no 1 received. Treat it as DB#0.\n");
> +		atomic64_or(BIT_ULL(0), &ndev->db_val);
>  		ntb_db_event(&ndev->ntb, 0);
>  	} else {
> +		atomic64_or(BIT_ULL(irq_no - 2), &ndev->db_val);

Again here the bits probably can use a define or enum instead of magic numbers.

DJ

>  		ntb_db_event(&ndev->ntb, irq_no - 2);
>  	}
>  
> @@ -524,7 +526,7 @@ static u64 ntb_epf_db_read(struct ntb_dev *ntb)
>  {
>  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
>  
> -	return ndev->db_val;
> +	return atomic64_read(&ndev->db_val);
>  }
>  
>  static int ntb_epf_db_clear_mask(struct ntb_dev *ntb, u64 db_bits)
> @@ -536,7 +538,7 @@ static int ntb_epf_db_clear(struct ntb_dev *ntb, u64 db_bits)
>  {
>  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
>  
> -	ndev->db_val = 0;
> +	atomic64_and(~db_bits, &ndev->db_val);
>  
>  	return 0;
>  }

