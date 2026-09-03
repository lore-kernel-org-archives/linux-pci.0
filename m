Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7344FECD8;
	Thu,  3 Sep 2026 21:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788470512; cv=none; b=fPp7cA4ZHwZuqoRVEUZi1LTE+/mywpDGd4tyF0hJzCjjlpLpdflU+3eDOGXYJsxXGUPWDmqDljOuRGsIKnQYu0RWLrfbjNmi95GlCbXIPSaPwYjuNZR22lAA868DwmYbNjjoqVJ2IrxQg2l9ucXRe/AxqMKehV3KVLZag9O1hJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788470512; c=relaxed/simple;
	bh=YJqXVLIYRtuK1/RaNrfAZeRD2nONfYM2Ix9YmxubWZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qzVLvEb2nrNyMVZmScKXD2mPP0wWzV5fkVA6q/tV7eHpvN5SsNuakxfyMLelGYXfhKjjns+3s5etkp7jIqzuF60piTzuTZaCK4CwwIlHRFELFaW9CPqwuCtuUYlwwiNup84aQKIhF+DhYNM+0XJU0sThdeyxLXfoVZFCWIa+MvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F4Ys67wZ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F4Ys67wZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788470499; x=1820006499;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YJqXVLIYRtuK1/RaNrfAZeRD2nONfYM2Ix9YmxubWZc=;
  b=F4Ys67wZBmGd2QQBjbBR5anthklxVP8mhCIQIiw3Do1SVbuIh0PuQggW
   Dg2zXazB37lpPVNnLikVwjaHgPsW+HokrBQCnTEScPPrEvGDH94amrb3V
   +54b+zjF8/4dPOt/UJcWFRY3larjcsIefGkw4ZEkD7i+ypwypukmhsXpd
   RO5WDWAqS8oxQFHx6YZja1CVOQIRV8KyfpIQHpmTjYmj95XeOTTzlc5Zs
   U0ooWPRCW5eJC/X/R2JUaETgArTltkVbVzHacnL4Z3/eeCD1O2Jq4tKek
   QpqJjwvVvfQKke+L6Nqx/0JIsgC2s8qH23l9/wczVuw7N3rn+Edy1R8bD
   g==;
X-CSE-ConnectionGUID: VwZfF7elQquFsu6iAl/jnQ==
X-CSE-MsgGUID: UR6dbVM3Q1GkzaN2X6wMQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92787516"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="92787516"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 14:21:32 -0700
X-CSE-ConnectionGUID: VmKnbi7VSkagMq8lM2A2xQ==
X-CSE-MsgGUID: ehBiLw4lRIaUJXiZRlIETw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="270366955"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.110.190]) ([10.125.110.190])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 14:21:31 -0700
Message-ID: <01d2856a-b852-40b0-b144-e0f0ad018c7c@intel.com>
Date: Thu, 3 Sep 2026 14:21:29 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/27] vfio/cxl: Reject unsupported decoder topologies
 at bind
To: mhonap@nvidia.com, alex@shazbot.org, jgg@ziepe.ca, ankita@nvidia.com,
 jic23@kernel.org, alejandro.lucero-palau@amd.com, smadhavan@nvidia.com,
 corbet@lwn.net, skhan@linuxfoundation.org, dave@stgolabs.net,
 alison.schofield@intel.com, vishal.l.verma@intel.com, iweiny@kernel.org,
 ming.li@zohomail.com, yishaih@nvidia.com, skolothumtho@nvidia.com,
 kevin.tian@intel.com, bhelgaas@google.com, dmatlack@google.com,
 kees@kernel.org, gustavoars@kernel.org
Cc: cjia@nvidia.com, kjaju@nvidia.com, vsethi@nvidia.com, zhiw@nvidia.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260813093631.2288172-1-mhonap@nvidia.com>
 <20260813093631.2288172-11-mhonap@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260813093631.2288172-11-mhonap@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/13/26 2:36 AM, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> The guest drives a single virtual decoder whose memory maps 1:1, so a
> device with more than one HDM decoder, or an interleaved one, cannot be
> represented. Turn that assumption into an explicit refusal at bind rather
> than a silent misprogramming later.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/cxl/vfio_cxl_core.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> index 125e11354a46..7edc53b25576 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> @@ -36,10 +36,30 @@ static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
>  	if (!pdev->hdm)
>  		return -EPROBE_DEFER;
>  
> +	/* The guest drives one virtual decoder; multiple are unsupported. */
> +	if (pdev->hdm->decoder_count != 1)
> +		return -EOPNOTSUPP;
> +
>  	hdm_size = range_len(&pdev->hdm->settings[0].hpa_range);
>  	if (!hdm_size)
>  		return -ENXIO;
>  
> +	/* Interleaved decoders are unsupported. */
> +	if (pdev->hdm->settings[0].interleave_ways != 1)

Just a nit, but why not check the interleave before retrieve the range_len()? Get the simpler checks out of the way.

DJ


> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * The guest drives resets through the CXL Device DVSEC and polls the
> +	 * shadow for completion. If the host cannot service a function-scoped
> +	 * CXL reset (no reset DVSEC, a multifunction device, or no HDM reset
> +	 * support), that guest request could never complete, so refuse the
> +	 * device rather than advertise a reset the guest would poll on forever.
> +	 */
> +	if (!cxl_reset_capable(pdev)) {
> +		pci_err(pdev, "vfio-cxl: Unsupported device: host cannot service a CXL reset request\n");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
>  					  PCI_DVSEC_CXL_DEVICE);
>  	serial = pci_get_dsn(pdev);

