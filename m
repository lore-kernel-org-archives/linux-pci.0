Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874BB3812EF;
	Thu, 24 Sep 2026 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269397; cv=none; b=ObE8FprE4t8zttcErNhLhlMymq/CJHDuNdgYGSaKswz4S0apRaSZ/wz+pBbPHcwASv4kBTU2kmA90P46hswSsk1zUdce3NKKYghBEKDYc4KT7FqIdIuoxd0W8+EHhJDdS6S6Xgzmw1E34zJz0W1gkIBRmAyXaXXeBNxnKOH9yIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269397; c=relaxed/simple;
	bh=uLN0PLp38P1ERr1lmZ+b+Qi7oSMitMGBCDGQZA29yL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAZv0IZJukZeXdTHA3mmULloMvORhfPOODewBmqguTbZRCP9so+cc/uDoUZDxjgzX6o+RdLtyBdOeuLrjOVekbI0c+kQPIxiJYixKRsBGkUhHh0UoKZh+v4+/pKQ6GIhr2Cbr61UPdIX7r8WIaDJT0bKDHKB+qlfTgdZHEvbFqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LmrnO4fk; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LmrnO4fk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790269396; x=1821805396;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uLN0PLp38P1ERr1lmZ+b+Qi7oSMitMGBCDGQZA29yL4=;
  b=LmrnO4fk/3Ct670CQ8yi41cw9YOxjZSBJxA/s31urnyI83o9tdcy1iAT
   RrML8MASh5TyuSisFYf2J0Wyy0o1WEA3XIn8OxgAz40RmqBu1HbFci+OW
   FhtP8pA9zFPGFFVYjqvMc2nU3qFKbtxZ1jdIu/Aoh8PYKxiOTwIhXfYMy
   y4ljmFjLO4xa6PMlGWeG0R1cyQLs1/mNBSYAGmUBveaiseFl9CBwe9oy4
   gnaUYixmUZtub6yQkamzavOKug3JIcgTASpnYsQNPdNsRh67t1o4Mg/K0
   S30LvXMXiibOjoAGjDf/+n3qZkBxeg5j4WQ8VO2GscD1MDSiWDaJK2Wye
   A==;
X-CSE-ConnectionGUID: 8aUwxsNASMyIXclNBt+SWQ==
X-CSE-MsgGUID: y6wQNyZvTHC/apV9WD8h3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="91155459"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="91155459"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 10:03:15 -0700
X-CSE-ConnectionGUID: aS7c0gCDQN6fFrHh+Zk+Zw==
X-CSE-MsgGUID: +gVmZIy9SXOvEjbiO3rPOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="277263362"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.110.186]) ([10.125.110.186])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 10:03:14 -0700
Message-ID: <33a1c478-3912-4441-8a37-7e91600581f3@intel.com>
Date: Thu, 24 Sep 2026 10:03:12 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 04/15] cxl: Move decoder declarations to shared header
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
 <20260922083924.2451158-5-smadhavan@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260922083924.2451158-5-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/22/26 1:39 AM, Srirangan Madhavan wrote:
> Move the common decoder declarations to include/cxl/cxl.h for use by
> shared decoder settings. Preserve their layout and documentation.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/cxl.h | 37 -------------------------------------
>  include/cxl/cxl.h | 41 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 40 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 9e0500d56866..44ff3334648c 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -264,45 +264,8 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>  #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
>  #define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)
>  
> -enum cxl_decoder_type {
> -	CXL_DECODER_DEVMEM = 2,
> -	CXL_DECODER_HOSTONLYMEM = 3,
> -};
> -
> -#define CXL_DECODER_MAX_INTERLEAVE 16
> -
>  #define CXL_QOS_CLASS_INVALID -1
>  
> -/**
> - * struct cxl_decoder - Common CXL HDM Decoder Attributes
> - * @dev: this decoder's device
> - * @id: kernel device name id
> - * @hpa_range: Host physical address range mapped by this decoder
> - * @interleave_ways: number of cxl_dports in this decode
> - * @interleave_granularity: data stride per dport
> - * @target_type: accelerator vs expander (type2 vs type3) selector
> - * @region: currently assigned region for this decoder
> - * @flags: memory type capabilities and locking
> - * @target_map: cached copy of hardware port-id list, available at init
> - *              before all @dport objects have been instantiated. While
> - *              dport id is 8bit, CFMWS interleave targets are 32bits.
> - * @commit: device/decoder-type specific callback to commit settings to hw
> - * @reset: device/decoder-type specific callback to reset hw settings
> -*/
> -struct cxl_decoder {
> -	struct device dev;
> -	int id;
> -	struct range hpa_range;
> -	int interleave_ways;
> -	int interleave_granularity;
> -	enum cxl_decoder_type target_type;
> -	struct cxl_region *region;
> -	unsigned long flags;
> -	u32 target_map[CXL_DECODER_MAX_INTERLEAVE];
> -	int (*commit)(struct cxl_decoder *cxld);
> -	void (*reset)(struct cxl_decoder *cxld);
> -};
> -
>  /*
>   * Track whether this decoder is free for userspace provisioning, reserved for
>   * region autodiscovery, whether it is started connecting (awaiting other
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 802b143de83d..69941f7fdb76 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -5,8 +5,10 @@
>  #ifndef __CXL_CXL_H__
>  #define __CXL_CXL_H__
>  
> +#include <linux/device.h>
>  #include <linux/node.h>
>  #include <linux/ioport.h>
> +#include <linux/range.h>
>  #include <cxl/mailbox.h>
>  
>  /**
> @@ -23,7 +25,44 @@ enum cxl_devtype {
>  	CXL_DEVTYPE_CLASSMEM,
>  };
>  
> -struct device;
> +struct cxl_region;
> +
> +enum cxl_decoder_type {
> +	CXL_DECODER_DEVMEM = 2,
> +	CXL_DECODER_HOSTONLYMEM = 3,
> +};
> +
> +#define CXL_DECODER_MAX_INTERLEAVE 16
> +
> +/**
> + * struct cxl_decoder - Common CXL HDM Decoder Attributes
> + * @dev: this decoder's device
> + * @id: kernel device name id
> + * @hpa_range: Host physical address range mapped by this decoder
> + * @interleave_ways: number of cxl_dports in this decode
> + * @interleave_granularity: data stride per dport
> + * @target_type: accelerator vs expander (type2 vs type3) selector
> + * @region: currently assigned region for this decoder
> + * @flags: memory type capabilities and locking
> + * @target_map: cached copy of hardware port-id list, available at init
> + *              before all @dport objects have been instantiated. While
> + *              dport id is 8bit, CFMWS interleave targets are 32bits.
> + * @commit: device/decoder-type specific callback to commit settings to hw
> + * @reset: device/decoder-type specific callback to reset hw settings
> +*/
> +struct cxl_decoder {
> +	struct device dev;
> +	int id;
> +	struct range hpa_range;
> +	int interleave_ways;
> +	int interleave_granularity;
> +	enum cxl_decoder_type target_type;
> +	struct cxl_region *region;
> +	unsigned long flags;
> +	u32 target_map[CXL_DECODER_MAX_INTERLEAVE];
> +	int (*commit)(struct cxl_decoder *cxld);
> +	void (*reset)(struct cxl_decoder *cxld);
> +};
>  
>  /*
>   * Using struct_group() allows for per register-block-type helper routines,

