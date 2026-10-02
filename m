Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DDB1CAA92;
	Fri,  2 Oct 2026 21:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790977865; cv=none; b=Zw20LzOyjD1rrftPeZDTbrcYUBCBAk2Zi6uOuGNz5tp+KStoS3bJ78N6fO198VVDFyghvSix9KKmA5V4GdWiNgv6pSucpC/g6K4LfybnCSI5sineEs+0vCtBSbyvPPH100ckM+FBGMPmG71CFWjzAkzwW7jwD7RyRS6QTFPmj6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790977865; c=relaxed/simple;
	bh=1lpqgtTTfvgovbY+i/gmDqeiERrogpv45ktYkTnXgkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ji0J41QFlTN3fX4EBevUhUicxFe8b+veme1b4PgdjB+TBx0yUvUFxySVnqxzDwTO7e7LLBusW6vohXdAMzY8BxvbXeeXsrF1IQM4biJOdBid26h2UCGX0fA6Sjgxk/v2cBESbcqYxFGmJHjcg/jb/tXAuwwMzfnYrELHoj0cX/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AFcI4L3V; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AFcI4L3V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790977862; x=1822513862;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1lpqgtTTfvgovbY+i/gmDqeiERrogpv45ktYkTnXgkk=;
  b=AFcI4L3V3igw99PaM2LU6yofHbNeGWktOwa9qgoJGPyqSE8wOBWZv89F
   zZpRmYvK3MaseKTf+7HVTWU6iCfkeeJ7oLSKxDcIUEs5ueQ+6AiZPgfZB
   2R/d1RQArHYaefpqI0riaI1n/CzfE4GoCcZbfkIedxRt//TjwP9dzjKgx
   u1pj7yJY64SZELEC6obNNuiudSBQc+zE5xwYZ414wi+S9pVMTLYVgJLzz
   Ace3VYSTgMayAFb7CSiWNT870t7j1umkSmv2i51JKTrRxXxLwYeJqillg
   zScPrapK2A2LIhp7Q7qEdFMeQgX1pA+OWo5bhbTRLPWlVnH3is0iZZDtJ
   w==;
X-CSE-ConnectionGUID: bzjbzkMiSrmTgxqXFdl69A==
X-CSE-MsgGUID: 4pp/UdHvQYCxGz5u98wp+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="90883203"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90883203"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 14:51:02 -0700
X-CSE-ConnectionGUID: u0COSXgcRSa3gGAcqE0zEg==
X-CSE-MsgGUID: 4o4TxdHTSHmDE6r+f3hVcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="284398796"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.108.45]) ([10.125.108.45])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 14:51:01 -0700
Message-ID: <cc1a68c6-b057-4cc6-bd7a-0f3156bb1af4@intel.com>
Date: Fri, 2 Oct 2026 14:50:59 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 08/16] cxl: Reject overflowing HDM decoder ranges
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
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-9-smadhavan@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261001092227.3004747-9-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/1/26 2:22 AM, Srirangan Madhavan wrote:
> An HDM decoder with a nonzero size can report a base and size whose end
> address wraps the 64-bit address space. Reject that programming before
> publishing the decoder range, so enumeration and later reset handling
> cannot use the wrapped range.
> 
> Use check_add_overflow() for nonzero ranges. Preserve the existing
> empty-range representation for zero-size decoders.

Why split this out instead of just introduce it when the function is introduced in the previous patch?

DJ

> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/resource.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 8dfeb12de8c9..8d2fbc49a06f 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -115,16 +115,21 @@ int cxl_hdm_unpack_decoder(struct cxl_decoder_settings *settings, int id,
>  	int interleave_ways;
>  	unsigned long flags = 0;
>  	struct range hpa_range;
> +	u64 end;
>  	int rc;
>  
>  	if (!committed)
>  		size = 0;
>  	if (base == U64_MAX || size == U64_MAX)
>  		return -ENXIO;
> +	if (size && check_add_overflow(base, size - 1, &end))
> +		return -ENXIO;
> +	if (!size)
> +		end = base - 1;
>  
>  	hpa_range = (struct range) {
>  		.start = base,
> -		.end = base + size - 1,
> +		.end = end,
>  	};
>  
>  	if (committed) {

