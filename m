Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9309B35BDA8;
	Tue, 26 May 2026 22:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779835676; cv=none; b=obEzxJmUtIvl6n4y9FmGcI2CB2b0tiiy5hPWVAAb/LOE8E47td6r0bXPXDay0qRGfbgl3c0Xq1yQpNcRzGBeoAfSnI5OQl0XtbDzpFa8WDGR/FkFBX7dl5LCCjEYuf0ZhqNGLHbFQRVN6klxTLDNp0qUFZFGCa8JvEWASo66oe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779835676; c=relaxed/simple;
	bh=O5uTN27BF36DAXd06ix4dau0tICxmL5fNLt6KjcYUZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LeruYI3wp4kMHUxpgaQdZxCsctEN4J1aMDOJT68pT7PbBkCQ/CCq7GdctcXTSxJZ0zIgU6UPuAAm+yi67rHcPsDyASP8g20oVIPflwxZH5mMiER9y0zo3udTzd6X4L9AmDGQ45N0UYco6rzytOMij/uHubf/ulAgI63SDBt7l+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BD4oOGY5; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BD4oOGY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779835674; x=1811371674;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O5uTN27BF36DAXd06ix4dau0tICxmL5fNLt6KjcYUZU=;
  b=BD4oOGY5k5Dx4ySluQmDBHOUnWVaJdSNylnmajP5Ahm0uomPFGDqM7yv
   qeCy5yG9GUAwdncim9yc6rmF0G/kFkQKTY2teKVZe5Lkp2JWZfmCvueAR
   K18zhIJQ1iZkLhgyJZ9pFFC8MPFNgB6dGsEXbfNFFnJwcCt32eFMvj/BW
   YpLW/bUNN8y1O/AOACslDyRrHhd5+TY0fw0ruL5jiMGM9KrNlL8lKYKcW
   9yzcKqx5yzcqJwtQXcCYTsE9mwHarrgI2+PLe2c0r0nljeYdAN+iBiy1w
   Ld+v5F1nmdQFmjECBMclX4JwAvRqe/XnOO3hrSHeHOQQm3uRvnHecoejs
   A==;
X-CSE-ConnectionGUID: C8dry+hXSFK5CsznfNXe7Q==
X-CSE-MsgGUID: QjEwPI5PSCKwwRrRF6pCTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="98237329"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="98237329"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 15:47:53 -0700
X-CSE-ConnectionGUID: fCeP+KYKSNagPHgmKSZUGw==
X-CSE-MsgGUID: xEPJYFdZSYKPO9Nb4iLsZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="241895626"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.201]) ([10.125.110.201])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 15:47:54 -0700
Message-ID: <b7eb89db-bce8-4b1d-a1d9-0757b718d275@intel.com>
Date: Tue, 26 May 2026 15:47:53 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/12] NTB: epf: Implement db_vector_count/mask for
 doorbells
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
 <20260513024923.451765-13-den@valinux.co.jp>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260513024923.451765-13-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/12/26 7:49 PM, Koichiro Den wrote:
> Implement .db_vector_count and .db_vector_mask so ntb core/clients can
> map doorbell events to per-vector work.
> 
> Report vectors as 0..(db_count - 2) (skipping the unused slot) and return
> BIT_ULL(db_vector) for the corresponding doorbell bit. Use
> ntb_epf_db_vector_count() for bounds checks in ntb_epf_db_vector_mask(), so
> the same lower-bound guard is applied before building the bitmask.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
> Changes since v3:
>   - Reuse ntb_epf_db_vector_count() from ntb_epf_db_vector_mask() for bounds.
>   - Return 0 when db_count is below NTB_EPF_MIN_DB_COUNT.
>   - Drop Reviewed-by tags due to the changes.
> 
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index 10618e462229..af5755472842 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -434,6 +434,36 @@ static u64 ntb_epf_db_valid_mask(struct ntb_dev *ntb)
>  	return ntb_ndev(ntb)->db_valid_mask;
>  }
>  
> +static int ntb_epf_db_vector_count(struct ntb_dev *ntb)
> +{
> +	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> +	unsigned int db_count = ndev->db_count;
> +
> +	/*
> +	 * db_count includes an extra skipped slot due to the legacy
> +	 * doorbell layout. Expose only the real doorbell vectors.
> +	 */
> +	if (db_count < NTB_EPF_MIN_DB_COUNT)
> +		return 0;
> +
> +	return db_count - 1;
> +}
> +
> +static u64 ntb_epf_db_vector_mask(struct ntb_dev *ntb, int db_vector)
> +{
> +	int nr_vec;
> +
> +	/*
> +	 * db_count includes one skipped slot in the legacy layout. Valid
> +	 * doorbell vectors are therefore [0 .. (db_count - 2)].
> +	 */
> +	nr_vec = ntb_epf_db_vector_count(ntb);
> +	if (db_vector < 0 || db_vector >= nr_vec)
> +		return 0;
> +
> +	return BIT_ULL(db_vector);
> +}
> +
>  static int ntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
>  {
>  	return 0;
> @@ -568,6 +598,8 @@ static const struct ntb_dev_ops ntb_epf_ops = {
>  	.spad_count		= ntb_epf_spad_count,
>  	.peer_mw_count		= ntb_epf_peer_mw_count,
>  	.db_valid_mask		= ntb_epf_db_valid_mask,
> +	.db_vector_count	= ntb_epf_db_vector_count,
> +	.db_vector_mask		= ntb_epf_db_vector_mask,
>  	.db_set_mask		= ntb_epf_db_set_mask,
>  	.mw_set_trans		= ntb_epf_mw_set_trans,
>  	.mw_clear_trans		= ntb_epf_mw_clear_trans,

