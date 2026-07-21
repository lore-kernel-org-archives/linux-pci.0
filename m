Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F21319B5A3;
	Tue, 21 Jul 2026 16:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651503; cv=none; b=LDt0CI/bhRcoO1Sd4WcBPc063DDillCD9JwpJddCxf5yyxWn0vslotr/RWsNg87vKammsiOTt+uEVDHNBgAFsEVP318IBiG25Z8AIYs3FIt4Qw/rvkKDvwddatGRZ+OUINwVvlklu4ox64NMzmBcKXocrwGzLK1JhDT12DmElmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651503; c=relaxed/simple;
	bh=oSkqbYsT57Uhh47Nn43Ehxhf658vR74Vq2LBl+Zsxck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BrZRUnVJrMPnw+ecsLejzupHdcBFTUbq3Gst8Lw0wAN5bk9BijoA9syDF+KuLZDhQ3tdmzu+yp8fTrxHHA4OnBuhqCIIQ9hiGjX18XqiKMmK1QkGhtVyIn5eNkkAYoLUdOyN6YKLTACVcAhFZmrHvJsM7ffnI96N/v/rWeUj9Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YDYjODna; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YDYjODna"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784651501; x=1816187501;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oSkqbYsT57Uhh47Nn43Ehxhf658vR74Vq2LBl+Zsxck=;
  b=YDYjODnaXaHdJL7GR9S5ABBuM/mRrH7xQlbfRDnuIs3MiVDPU5FcUi+O
   Nth6iOuBrn3IBrEQjehrB/pPv+MEWtaXv8qLrHyGU070vw0UCCFFeQ4Je
   5kxYwvQ5Am28ueIC1EViWKDvZKH3lt2uOdp9p/mE9As+DxcaM9wv26haQ
   1VP0KpQQMEkWPLf32AmxfDVRbBMKA2ufwpRAsVF4bpqaxYInwdk+MgC+f
   L6pXUIcJeUtbPj6OqM7+g9SIXk5Q+jbhNg4Vq1n0QTcoPMGfGCIT6N8Nh
   5xg3xfdkfvjkTwr+2OL+8SREcHEAL3ZeKf1qyhAqgtwupqM/NYj9VroVC
   w==;
X-CSE-ConnectionGUID: 4Hh3gRoHRya017TgdkHsHg==
X-CSE-MsgGUID: vurcD8+vQNKWm2w+2xD9jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85297862"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="85297862"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 09:31:41 -0700
X-CSE-ConnectionGUID: g8booNh7QYaPY4NOqA3PPw==
X-CSE-MsgGUID: muK8gKtuStm1POZdlw1TBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="281085855"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.109.244]) ([10.125.109.244])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 09:31:39 -0700
Message-ID: <ec8a1857-df4a-45d4-9554-954116af5084@intel.com>
Date: Tue, 21 Jul 2026 09:31:38 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] dmaengine: ioat: use sysfs_emit() in per-channel
 sysfs show()
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, Kelvin Cao <kelvin.cao@microchip.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 George Ge <george.ge@microchip.com>, Jaeyoung Chung <jjy600901@snu.ac.kr>
References: <20260721155739.62120-1-logang@deltatee.com>
 <20260721155739.62120-11-logang@deltatee.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260721155739.62120-11-logang@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/21/26 8:57 AM, Logan Gunthorpe wrote:
> Convert the sprintf() calls in the per-channel sysfs attribute show()
> functions to sysfs_emit().
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dma/ioat/sysfs.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
> index e796ddb5383f..976134df8108 100644
> --- a/drivers/dma/ioat/sysfs.c
> +++ b/drivers/dma/ioat/sysfs.c
> @@ -24,12 +24,12 @@ static ssize_t cap_show(struct dma_chan *c, char *page)
>  {
>  	struct dma_device *dma = c->device;
>  
> -	return sprintf(page, "copy%s%s%s%s%s\n",
> -		       dma_has_cap(DMA_PQ, dma->cap_mask) ? " pq" : "",
> -		       dma_has_cap(DMA_PQ_VAL, dma->cap_mask) ? " pq_val" : "",
> -		       dma_has_cap(DMA_XOR, dma->cap_mask) ? " xor" : "",
> -		       dma_has_cap(DMA_XOR_VAL, dma->cap_mask) ? " xor_val" : "",
> -		       dma_has_cap(DMA_INTERRUPT, dma->cap_mask) ? " intr" : "");
> +	return sysfs_emit(page, "copy%s%s%s%s%s\n",
> +		dma_has_cap(DMA_PQ, dma->cap_mask) ? " pq" : "",
> +		dma_has_cap(DMA_PQ_VAL, dma->cap_mask) ? " pq_val" : "",
> +		dma_has_cap(DMA_XOR, dma->cap_mask) ? " xor" : "",
> +		dma_has_cap(DMA_XOR_VAL, dma->cap_mask) ? " xor_val" : "",
> +		dma_has_cap(DMA_INTERRUPT, dma->cap_mask) ? " intr" : "");
>  
>  }
>  static const struct ioat_sysfs_entry ioat_cap_attr = __ATTR_RO(cap);
> @@ -39,8 +39,8 @@ static ssize_t version_show(struct dma_chan *c, char *page)
>  	struct dma_device *dma = c->device;
>  	struct ioatdma_device *ioat_dma = to_ioatdma_device(dma);
>  
> -	return sprintf(page, "%d.%d\n",
> -		       ioat_dma->version >> 4, ioat_dma->version & 0xf);
> +	return sysfs_emit(page, "%d.%d\n",
> +			   ioat_dma->version >> 4, ioat_dma->version & 0xf);
>  }
>  static const struct ioat_sysfs_entry ioat_version_attr = __ATTR_RO(version);
>  
> @@ -118,7 +118,7 @@ static ssize_t ring_size_show(struct dma_chan *c, char *page)
>  {
>  	struct ioatdma_chan *ioat_chan = to_ioat_chan(c);
>  
> -	return sprintf(page, "%d\n", (1 << ioat_chan->alloc_order) & ~1);
> +	return sysfs_emit(page, "%d\n", (1 << ioat_chan->alloc_order) & ~1);
>  }
>  static const struct ioat_sysfs_entry ring_size_attr = __ATTR_RO(ring_size);
>  
> @@ -127,7 +127,7 @@ static ssize_t ring_active_show(struct dma_chan *c, char *page)
>  	struct ioatdma_chan *ioat_chan = to_ioat_chan(c);
>  
>  	/* ...taken outside the lock, no need to be precise */
> -	return sprintf(page, "%d\n", ioat_ring_active(ioat_chan));
> +	return sysfs_emit(page, "%d\n", ioat_ring_active(ioat_chan));
>  }
>  static const struct ioat_sysfs_entry ring_active_attr = __ATTR_RO(ring_active);
>  
> @@ -135,7 +135,7 @@ static ssize_t intr_coalesce_show(struct dma_chan *c, char *page)
>  {
>  	struct ioatdma_chan *ioat_chan = to_ioat_chan(c);
>  
> -	return sprintf(page, "%d\n", ioat_chan->intr_coalesce);
> +	return sysfs_emit(page, "%d\n", ioat_chan->intr_coalesce);
>  }
>  
>  static ssize_t intr_coalesce_store(struct dma_chan *c, const char *page,

