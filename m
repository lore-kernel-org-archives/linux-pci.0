Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C76D3EEAF8;
	Thu, 24 Sep 2026 16:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267007; cv=none; b=ooYsA+94WLYanmAigV9K6gSrJ1DFjh5fmQyj1GKHl0HhVIpLcGE/6iCD5LbgiMG1DkQMthNA++lwhjhwS9vBmhvIiU4lbGU0ET4oWWFlt67WsjBAyYpz8VSG9QNyp8sHzSZ+Ami6Vudthk/+R5waCyJnPRZs3MLEUX9I4fzutR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267007; c=relaxed/simple;
	bh=XY8mhyHWt+Mtjz7hAMGBrRbsX8Yl2+pfnMjqq1lyOOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjP/HfDxncJYyo3yKSNY2wVSg/MG5/1QPSmIcE68Jt42Kmn8yLKbL6gBvxJVYnYSt4rQkx0sctSZAXqRbJ4SVdIDGLf5QJhdJ6pGwNG2k+MdvQVq8gSRtzHxacrH6Ksm1sWyIfMrGLBoOK595gu0BoNSFyfTRJJHuOu76HHTv8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TyLxLATN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TyLxLATN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790267005; x=1821803005;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XY8mhyHWt+Mtjz7hAMGBrRbsX8Yl2+pfnMjqq1lyOOA=;
  b=TyLxLATNzOwrl0YFPjs5jTE26LSxVyJ52JnHlsccqMLAogPx81WHzrOv
   7WdIxhMcRrrS8RA1bjd0fM90pWRqpWI+MfL2c5DUVSmvschlOqvq8tUiF
   3RU73xsOhBGq5KxfGGIyFqSrGuAYy9z4ktByBKqkNbKs2A1WRr6cn6qX4
   E6ZYwlOeVgWO/eOwET3kzumeL9YEK/b+6iCP92K3RCNHZxByrWYNNcJtf
   Vt8ljBBcU/bSYXDQELzFfNO4bXsngJWDntNSHjZ9cWoq4A40v2Hc1a8MH
   VobuBsUMPBiSu3U8X0X8JLnkNNn3I3Nqabx18YCoSLdtBpt/HEc12L4Of
   A==;
X-CSE-ConnectionGUID: lsXh7ABXTkeyMIMya0ti4A==
X-CSE-MsgGUID: 2BWoJlCYTVaIHfhGNTireg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="93764829"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="93764829"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 09:23:24 -0700
X-CSE-ConnectionGUID: TwcqMMYZRQaXL+OXSPDT5A==
X-CSE-MsgGUID: c9mRK/JZQ4iybfdbSS2l1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="303591595"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.110.186]) ([10.125.110.186])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 09:23:23 -0700
Message-ID: <c33f3b54-60d0-4a1d-986f-e7187cdf5b4d@intel.com>
Date: Thu, 24 Sep 2026 09:23:21 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 01/15] cxl: Drop stale decoder interleave limit
 comment
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-2-smadhavan@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260922083924.2451158-2-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/22/26 1:39 AM, Srirangan Madhavan wrote:
> CXL 2.0 added 16-way memory interleaving, making the comment that the
> specification supports only 8-way interleaving stale. Remove the comment
> without changing CXL_DECODER_MAX_INTERLEAVE.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Link: https://lore.kernel.org/linux-cxl/20260912003057.3db9335c@jic23-hlaptop/
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/cxl.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 3ef0810ab86b..9e0500d56866 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -269,10 +269,6 @@ enum cxl_decoder_type {
>  	CXL_DECODER_HOSTONLYMEM = 3,
>  };
>  
> -/*
> - * Current specification goes up to 8, double that seems a reasonable
> - * software max for the foreseeable future
> - */
>  #define CXL_DECODER_MAX_INTERLEAVE 16
>  
>  #define CXL_QOS_CLASS_INVALID -1

