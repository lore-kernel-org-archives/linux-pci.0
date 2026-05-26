Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC87F346E4E;
	Tue, 26 May 2026 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779834106; cv=none; b=XBKGCWlZk/HWV8CD9M+wVXkhtc87hCW1J4wIEbzbawAEjseTK/5gVfkmZ0yC0O1twKAyV+32yhPd9PDmd60JtbwsnKgMZEfkdxfODVXjqpknG/SpCFkB3JlMmAtMjAeY2NX0JxOZxPfOH7G8exVE0zPQFSGJSOi4EYnLTfNPlow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779834106; c=relaxed/simple;
	bh=Bm1tgzILPd6uRJcBm7JFVm4neFWc2cwsMzZLBvCEAmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=spsCGFlmxLIcnQ6G6QQKWsUnIQcYZ3ffpGY3vxuCKJsobC2K1eVEbqsPRfhqOw3kGdu/tb/DGaQGgmD2bs5K36vKojlGf2KlNy9AOvvNsfz3OFjwhfdGRjOXpyYmzY+YKk1okEOsuv88njfL+IGts1WqYAQBopVOnXKBLACaqYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X/rS8K8g; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X/rS8K8g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779834105; x=1811370105;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Bm1tgzILPd6uRJcBm7JFVm4neFWc2cwsMzZLBvCEAmU=;
  b=X/rS8K8gB07XFNdOUfoR7rl8D4QMTHAyGXAAWnC3ROCwS75oYk3WhMGJ
   1Cm2z5UQJ0FuRnxVX52Lg3KjQErqf3IMgSR63A6Tbdf3IA6smge7FaRUm
   j5Z4YT+uG5BAEKzXD1XVLeZxnkJoYSmU6rw6G0O2jDakWWDy3mjsST1zR
   J9jFAtE56x7SwCxuVBvmYrpTGALdoeF76JwMExQvqnib1QogUlQklhp9X
   Q/KCmVkKe/cOLJ1b1HBNRCOpN/0wDjqNx+T7guqTtMNVSgP2srweVOTWS
   nz+y0Brv+tkhKgROUsU6jjGNUs2/U3IR9ZhesA6yLdCAZHneZlDX1+IV0
   Q==;
X-CSE-ConnectionGUID: MKbJm4hWTtqqbO/nvlKVnw==
X-CSE-MsgGUID: UxgwwIs/Qu2Ir3Cg+dP4IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="90964523"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="90964523"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 15:21:44 -0700
X-CSE-ConnectionGUID: 2QZv5FJZRL++ShI7Zzx7dQ==
X-CSE-MsgGUID: zhj5ZSSLQPOTxwpdhmLWJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="241214001"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.201]) ([10.125.110.201])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 15:21:43 -0700
Message-ID: <f0396614-7d0e-4607-8a53-6e421ad46f03@intel.com>
Date: Tue, 26 May 2026 15:21:42 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/12] NTB: epf: Make db_valid_mask cover only real
 doorbell bits
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
 <20260513024923.451765-10-den@valinux.co.jp>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260513024923.451765-10-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/12/26 7:49 PM, Koichiro Den wrote:
> ndev->db_count includes an unused doorbell slot due to the legacy extra
> offset in the peer doorbell path. db_valid_mask must cover only the real
> doorbell bits and exclude the unused slot.
> 
> Set db_valid_mask to BIT_ULL(db_count - 1) - 1.
> 
> Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
> Changes since v3:
>   - Drop the post-init db_count lower-bound check; ntb_epf_init_isr()
>     already requests at least NTB_EPF_MIN_DB_COUNT + 1 vectors.
> 
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index 21d942824983..c0bab3292075 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -580,7 +580,11 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
>  		return ret;
>  	}
>  
> -	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
> +	/*
> +	 * ndev->db_count includes an extra skipped slot due to the legacy
> +	 * doorbell layout, hence -1.
> +	 */
> +	ndev->db_valid_mask = BIT_ULL(ndev->db_count - 1) - 1;
>  	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
>  	ndev->spad_count = readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
>  

