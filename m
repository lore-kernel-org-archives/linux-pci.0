Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AF5369990;
	Fri, 28 Aug 2026 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787932801; cv=none; b=OQMHSm2AEw0IEeDtQjB9aaCJNJb0Ywy5Ao3Y7DbcdNf+J5ksdlAldUsaUhOc1/DjPikfLwxJHNDEUmD3LtXIaakm7hsKJ61KFv/J+GaxFvF0BuhHR8HDjFGQvgkCSL1Gg75IcCU8IZJZs+raG3yDevsOOMLFeNCFLtZVnXQlS+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787932801; c=relaxed/simple;
	bh=+AegtlUreBw0TeBD9YP48QLV31KMxegwuKNHebyj7aU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=shXiOkNr02zNbPjUPB/GgaU1qOzWURbmuCbbN3ZkaZsOP8zQdR3aBaGHUEXJ9gwVCRTSzFAuFBBIfLbtKZMHW8/7rQ9PovTw0ucblpdj3RhoES1Jn9CzXToY7F4I4CJjne5s9sHswy4Eofyf6Xgy8CbFcrBXNO7MSltiCFv0jfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OyQVta7M; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OyQVta7M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787932800; x=1819468800;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+AegtlUreBw0TeBD9YP48QLV31KMxegwuKNHebyj7aU=;
  b=OyQVta7MhpZlVYPMRo6qGbJctjw7X8uK9WL6cr8fh0WNWCsWWhIEi8lG
   Yj5MOM2P1V8Ha07ZDyBUTjaj1ROWuedM2UI+qwqTv8tn9qbyE/ce5fOv9
   zmQ9CBnxQ2qxQLINzAFpAXmuFqkZyb1cXeiO1euzolHBxM34/FirqYVW7
   u24vhTk/s0GyZlq60NAGXpF1WlXyUMGewVtNJk9MsmHu91L0pUtt7Nmvo
   xSeF3oTYGJiWDvoZa/hFQd2BpwAKQd3TKcTfcI+qkFaAhPvmF1pxZBKw+
   s31V0or1ht2/2o6sBgoKgMwU9kv+BfW4EGpsWXM2/OyzKM4Zv+GCl/AFi
   A==;
X-CSE-ConnectionGUID: bzcJr0CwSGKBxknMPW6XgQ==
X-CSE-MsgGUID: eqQGFVmZRM2E0rFXnk/B2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="88299642"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="88299642"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 08:59:59 -0700
X-CSE-ConnectionGUID: yOu767KDTN6AfmDdD3kNLw==
X-CSE-MsgGUID: qX/wSVlXQTum0ztYfomArA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="266388794"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.180]) ([10.125.109.180])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 08:59:57 -0700
Message-ID: <dbc6658c-9c3d-4590-b9c3-784dcc7846cc@intel.com>
Date: Fri, 28 Aug 2026 08:59:55 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/27] cxl: Establish media readiness in
 cxl_mem_probe()
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
 <20260813093631.2288172-5-mhonap@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260813093631.2288172-5-mhonap@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/13/26 2:36 AM, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> media_ready was only ever set by cxl_pci, in advance of registering a
> memdev and with CXL Memory Device register assumptions. A consumer that
> creates a memdev without cxl_pci, such as a mailbox-less Type-2
> accelerator brought up through devm_cxl_probe_mem(), therefore handed
> cxl_mem a device with media_ready still false, and cxl_mem_probe()
> rejected it with -EBUSY. __devm_cxl_add_memdev() turns that into -ENXIO
> back to the caller and the bind fails.
> 
> Move the readiness wait into cxl_mem_probe() so every memdev consumer
> gets a ready resource regardless of how the memdev was created. When
> media_ready is not already set, wait on the device's DVSEC
> Mem_Info_Valid and Mem_Active bits and mark it ready. cxl_pci keeps
> setting media_ready before it registers its memdev, so that path skips
> the wait.
> 
> The CXL Memory Device register group is optional and many Type-2 devices
> do not implement it, so cxl_await_media_ready() must not read the Memdev
> Status register unless the group is mapped. Reading regs.memdev on a
> device that lacks it would fault. Gate that read on regs.memdev; the
> DVSEC bits already prove readiness for such devices.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>

Agree with Alex's review. First part needs to be a separate patch. And second part, please see drivers/net/ethernet/sfc/efx_cxl.c:efx_cxl_init() on media ready for CXL type2. That should be handled before devm_cxl_probe_mem() gets called. And with that, maybe the first chunk is not even needed?

DJ
> ---
>  drivers/cxl/core/pci.c | 15 +++++++++++----
>  drivers/cxl/mem.c      |  9 +++++++--
>  2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 08d4c955137d..9b372d5a1aa4 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -151,7 +151,6 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>  	int d = cxlds->cxl_dvsec;
>  	int rc, i, hdm_count;
> -	u64 md_status;
>  	u16 cap;
>  
>  	rc = pci_read_config_word(pdev,
> @@ -172,9 +171,17 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  			return rc;
>  	}
>  
> -	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> -	if (!CXLMDEV_READY(md_status))
> -		return -EIO;
> +	/*
> +	 * It is possible some Type-2 devices (CXL_DEVTYPE_DEVMEM) do not
> +	 * implement regs.memdev; only consult the Memdev Status register when
> +	 * the group is actually present.
> +	 */
> +	if (cxlds->regs.memdev) {
> +		u64 md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> +
> +		if (!CXLMDEV_READY(md_status))
> +			return -EIO;
> +	}

You probably get less code churn if you just returned here:

if (!cxlds->regs.memdev)
	return 0;

DJ

>  
>  	return 0;
>  }
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 798e5c369cfc..9c6e99b9124c 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -105,8 +105,13 @@ static int cxl_mem_probe(struct device *dev)
>  	struct dentry *dentry;
>  	int rc;
>  
> -	if (!cxlds->media_ready)
> -		return -EBUSY;
> +	if (!cxlds->media_ready) {
> +		rc = cxl_await_media_ready(cxlds);
> +		if (rc)
> +			return rc;
> +		cxlds->media_ready = true;
> +		dev_dbg(dev, "CXL media ready\n");
> +	}
>  
>  	/*
>  	 * Someone is trying to reattach this device after it lost its port

