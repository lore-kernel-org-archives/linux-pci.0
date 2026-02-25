Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2424A36A006;
	Wed, 25 Feb 2026 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772038066; cv=none; b=lVbEQGhUmIU5kV3M+CokrJxLzB/zB9O1ry1K6LCMbtLmv9OfJ0oZHgSO+OeD3OejDEWUBBTw56GnYQ+y1s8iO14wFklxp1VgKROrKs0VcbAq6QVogHbabQA1daMt/O19zXP2tJ7CPC1VkjNbTDlx6QQav0QD8TqjrRt3m6C1N7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772038066; c=relaxed/simple;
	bh=Ww7jBXJpFuUjgO2c/UkPWNS73bT08e3YJt0wwVSjjDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0VmQfJTbfBc2F+7AytywVFU7T6paHlepLdVic1f9kGQv1aUkhzM7PaNroQ7esr9GoMiTgZz6CzjbsN+/cdd0klvZLMMcJKJyK3AKVgmYB4l5Vwsaj53zRhZPsyMWI9gmcw6JKjaQy4KdZVFG+mGBatPtBwPe5Tz9KoNGhrIhKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OT/cA+t0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OT/cA+t0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772038065; x=1803574065;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ww7jBXJpFuUjgO2c/UkPWNS73bT08e3YJt0wwVSjjDM=;
  b=OT/cA+t0CRFyuu26pds2fGEOZFhosYvwQbTOIYpsTVZtJypovBLRZS03
   UsxYkZStiFvfWrtIGw/E65EhrHRDgiqubaiKFu61N3GggpeoSmMkbJF9S
   wf7xeQCq5Zln6yIXRiF33hipJnaPhX429rtcjDmibF/Uq4yB4tBJoPxH9
   DNYWpNZq5YjS+o5UhavALrxQ4NSQZKmnchnnYPJ33dQNNtOHHnQ/VII/h
   CEaPagrCNCPUR/OpVFXXziF25Ul44XoBXGCLJN7O/N9cS6csHxh2ikYba
   OcG+0AudUfWoCZwO/TxtuEj2XDLW93HlPGRpBBq+fja0hPubLfQdEe1qj
   A==;
X-CSE-ConnectionGUID: Cc7z6lNzQcKuufABsFS+Nw==
X-CSE-MsgGUID: 6Uj3MTXNRf6n2iGl8Fhf8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="98552756"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="98552756"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 08:47:44 -0800
X-CSE-ConnectionGUID: D4OKonMzS0OuYauDIlGuAA==
X-CSE-MsgGUID: B1ez37z+RhK0joDrepZ6SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="215506610"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.111.98]) ([10.125.111.98])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 08:47:43 -0800
Message-ID: <8ff7a843-bc0d-4ee0-b1d4-94d31e071fcd@intel.com>
Date: Wed, 25 Feb 2026 09:47:43 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] NTB: epf: Make db_valid_mask cover only real
 doorbell bits
To: Koichiro Den <den@valinux.co.jp>, Frank.Li@nxp.com, kishon@kernel.org,
 jdmason@kudzu.us, mani@kernel.org, allenbh@gmail.com,
 kwilczynski@kernel.org, bhelgaas@google.com, jbrunet@baylibre.com,
 lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260224133459.1741537-1-den@valinux.co.jp>
 <20260224133459.1741537-8-den@valinux.co.jp>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260224133459.1741537-8-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/24/26 6:34 AM, Koichiro Den wrote:
> ndev->db_count includes an unused doorbell slot due to the legacy extra
> offset in the peer doorbell path. db_valid_mask must cover only the real
> doorbell bits and exclude the unused slot.
> 
> Set db_valid_mask to BIT_ULL(db_count - 1) - 1.
> 
> Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index bce7130fec39..ee499eaed4f3 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -580,7 +580,13 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
>  		return ret;
>  	}
>  
> -	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
> +	if (ndev->db_count < NTB_EPF_MIN_DB_COUNT) {
> +		dev_err(dev, "db_count %u is less than %u\n", ndev->db_count,
> +			NTB_EPF_MIN_DB_COUNT);
> +		return -EINVAL;
> +	}
> +
> +	ndev->db_valid_mask = BIT_ULL(ndev->db_count - 1) - 1;

I would suggest adding a comment in the code for why this is for future readers.

DJ

>  	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
>  	ndev->spad_count = readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
>  

