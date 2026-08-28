Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71213537FF;
	Fri, 28 Aug 2026 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787930866; cv=none; b=HNQNNn46Z15S15zeqq2HbBNzYs0szBvDa4PHsUE+sYhLD2Bkln1vgLjxDaVw0sBR3dJqtEFnK+x1aJyMaEpLVVBNCqO9CITvTkdXDiRmGtorPJCMa8Lj3aVv3PbT3aLejkh8kZBbEFrxHeZEMri9XeYUtlNC32xpJKuKwZ7ie+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787930866; c=relaxed/simple;
	bh=3/ZZ3bUMiEBf1scPmq6mLeIyrw/RQLKQvaN/jOlBdDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SRpprqtlrKZzE4DvkYJr8gMUzRn8DpQ+rW+nrp6P7ZvGqdrd7Q65XUquck+GLoi1dqR3oYO2KDJz7PCwmi9c7juwTrttIksVoTHQaXKXePSL6pZ67PmNgekeGqRfHPDtJLz7pUYd1/JC87aF30E668kJOgVyAOHSnZ8XZ97+cQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BvyQ7yED; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BvyQ7yED"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787930865; x=1819466865;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3/ZZ3bUMiEBf1scPmq6mLeIyrw/RQLKQvaN/jOlBdDM=;
  b=BvyQ7yEDe47mnYiHSCjibNl/2MiIULw36+kn/MjaXA0dQ7m5GCzGtuMm
   zT2xbUyIIBbPKjcWpw8QzFG0q41/+7zLcHCAYoW6Jve2W/60X88qmdQcF
   vyimNUEDccnQyruBZPqI7JYhXfY0KLCkFanqdkI24F0q0RP+GGqg/yXsW
   6tx4MZN1pQzhZYqcI3f5PHD5C1nHcT9dflieWFISfQMj8dHAFloCGhi0Y
   j1syG6XEHpyPFLWpMkjKAQ3YjDMkz1c8E14RCJHh8sfg1YDMwyzheBDf7
   JBj01ltaWaixXtwaSNHXMCjIL9jY9EWzhl4G0fabo4Okyv30yA+ebvhoN
   g==;
X-CSE-ConnectionGUID: +MlSf7vETJ25WeoKlMDqUA==
X-CSE-MsgGUID: hqEsfnj0S8KrwEBCDjTZwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="88204483"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="88204483"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 08:27:44 -0700
X-CSE-ConnectionGUID: bw6iaKFDSvauQKaCnC/TjA==
X-CSE-MsgGUID: RcmBlYWZTt2fmqyki3lzAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="293000248"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.180]) ([10.125.109.180])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 08:27:41 -0700
Message-ID: <601b7283-c80b-4a4f-911d-de572e8b7744@intel.com>
Date: Fri, 28 Aug 2026 08:27:40 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/27] cxl: Move component register defines to
 uapi/cxl/cxl_regs.h
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
 <20260813093631.2288172-4-mhonap@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260813093631.2288172-4-mhonap@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/13/26 2:36 AM, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> The CXL component and HDM decoder register layout is spec-defined and is
> needed by consumers outside the CXL subsystem such as vfio-cxl, which
> cannot include the private drivers/cxl/cxl.h. Move those defines to a new
> uapi header, the way PCI register offsets live in uapi pci_regs.h, and
> include it from drivers/cxl/cxl.h so existing users are unchanged.

Wouldn't the proper location be include/cxl/cxl.h instead if it's only being shared by vfio-cxl kernel component? Unless there are expectation of user side usage for those definitions? If so then should say so here.

DJ
> 
> No functional change; the GENMASK and BIT forms are written as plain
> values as an uAPI header requirement.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  MAINTAINERS                 |  1 +
>  drivers/cxl/cxl.h           | 47 +-----------------------------
>  include/uapi/cxl/cxl_regs.h | 58 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 60 insertions(+), 46 deletions(-)
>  create mode 100644 include/uapi/cxl/cxl_regs.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5114e6db7307..c665bf8f1a28 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6528,6 +6528,7 @@ F:	Documentation/driver-api/cxl
>  F:	Documentation/userspace-api/fwctl/fwctl-cxl.rst
>  F:	drivers/cxl/
>  F:	include/cxl/
> +F:	include/uapi/cxl/
>  F:	include/uapi/linux/cxl_mem.h
>  F:	tools/testing/cxl/
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index c795cce0fcbc..2893b2427be1 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -13,6 +13,7 @@
>  #include <linux/io.h>
>  #include <linux/range.h>
>  #include <cxl/cxl.h>
> +#include <cxl/cxl_regs.h>
>  
>  extern const struct nvdimm_security_ops *cxl_security_ops;
>  
> @@ -24,52 +25,6 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>   * (port-driver, region-driver, nvdimm object-drivers... etc).
>   */
>  
> -/* CXL 2.0 8.2.4 CXL Component Register Layout and Definition */
> -#define CXL_COMPONENT_REG_BLOCK_SIZE SZ_64K
> -
> -/* CXL 2.0 8.2.5 CXL.cache and CXL.mem Registers*/
> -#define CXL_CM_OFFSET 0x1000
> -#define CXL_CM_CAP_HDR_OFFSET 0x0
> -#define   CXL_CM_CAP_HDR_ID_MASK GENMASK(15, 0)
> -#define     CM_CAP_HDR_CAP_ID 1
> -#define   CXL_CM_CAP_HDR_VERSION_MASK GENMASK(19, 16)
> -#define     CM_CAP_HDR_CAP_VERSION 1
> -#define   CXL_CM_CAP_HDR_CACHE_MEM_VERSION_MASK GENMASK(23, 20)
> -#define     CM_CAP_HDR_CACHE_MEM_VERSION 1
> -#define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
> -#define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
> -
> -#define   CXL_CM_CAP_CAP_ID_RAS 0x2
> -#define   CXL_CM_CAP_CAP_ID_HDM 0x5
> -#define   CXL_CM_CAP_CAP_HDM_VERSION 1
> -
> -/* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
> -#define CXL_HDM_DECODER_CAP_OFFSET 0x0
> -#define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
> -#define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
> -#define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
> -#define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
> -#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
> -#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
> -#define CXL_HDM_DECODER_CTRL_OFFSET 0x4
> -#define   CXL_HDM_DECODER_ENABLE BIT(1)
> -#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> -#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x20 * (i) + 0x14)
> -#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i) (0x20 * (i) + 0x18)
> -#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i) (0x20 * (i) + 0x1c)
> -#define CXL_HDM_DECODER0_CTRL_OFFSET(i) (0x20 * (i) + 0x20)
> -#define   CXL_HDM_DECODER0_CTRL_IG_MASK GENMASK(3, 0)
> -#define   CXL_HDM_DECODER0_CTRL_IW_MASK GENMASK(7, 4)
> -#define   CXL_HDM_DECODER0_CTRL_LOCK BIT(8)
> -#define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
> -#define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
> -#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
> -#define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
> -#define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
> -#define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
> -#define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
> -#define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
> -
>  /* HDM decoder control register constants CXL 3.0 8.2.5.19.7 */
>  #define CXL_DECODER_MIN_GRANULARITY 256
>  #define CXL_DECODER_MAX_ENCODED_IG 6
> diff --git a/include/uapi/cxl/cxl_regs.h b/include/uapi/cxl/cxl_regs.h
> new file mode 100644
> index 000000000000..04bf790f0fdc
> --- /dev/null
> +++ b/include/uapi/cxl/cxl_regs.h
> @@ -0,0 +1,58 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
> +
> +#ifndef _UAPI_CXL_REGS_H_
> +#define _UAPI_CXL_REGS_H_
> +
> +/*
> + * CXL Component Register layout from the CXL specification. Kept in uapi so a
> + * VMM can consume the register offsets without a kernel header dependency.
> + */
> +
> +/* CXL 2.0 8.2.4 CXL Component Register Layout and Definition */
> +#define CXL_COMPONENT_REG_BLOCK_SIZE 0x10000
> +
> +/* CXL 2.0 8.2.5 CXL.cache and CXL.mem Registers */
> +#define CXL_CM_OFFSET 0x1000
> +#define CXL_CM_CAP_HDR_OFFSET 0x0
> +#define   CXL_CM_CAP_HDR_ID_MASK 0xffff
> +#define     CM_CAP_HDR_CAP_ID 1
> +#define   CXL_CM_CAP_HDR_VERSION_MASK 0xf0000
> +#define     CM_CAP_HDR_CAP_VERSION 1
> +#define   CXL_CM_CAP_HDR_CACHE_MEM_VERSION_MASK 0xf00000
> +#define     CM_CAP_HDR_CACHE_MEM_VERSION 1
> +#define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK 0xff000000
> +#define CXL_CM_CAP_PTR_MASK 0xfff00000
> +
> +#define   CXL_CM_CAP_CAP_ID_RAS 0x2
> +#define   CXL_CM_CAP_CAP_ID_HDM 0x5
> +#define   CXL_CM_CAP_CAP_HDM_VERSION 1
> +
> +/* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
> +#define CXL_HDM_DECODER_CAP_OFFSET 0x0
> +#define   CXL_HDM_DECODER_COUNT_MASK 0xf
> +#define   CXL_HDM_DECODER_TARGET_COUNT_MASK 0xf0
> +#define   CXL_HDM_DECODER_INTERLEAVE_11_8 0x100
> +#define   CXL_HDM_DECODER_INTERLEAVE_14_12 0x200
> +#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY 0x800
> +#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY 0x1000
> +#define CXL_HDM_DECODER_CTRL_OFFSET 0x4
> +#define   CXL_HDM_DECODER_ENABLE 0x2
> +#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> +#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x20 * (i) + 0x14)
> +#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i) (0x20 * (i) + 0x18)
> +#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i) (0x20 * (i) + 0x1c)
> +#define CXL_HDM_DECODER0_CTRL_OFFSET(i) (0x20 * (i) + 0x20)
> +#define   CXL_HDM_DECODER0_CTRL_IG_MASK 0xf
> +#define   CXL_HDM_DECODER0_CTRL_IW_MASK 0xf0
> +#define   CXL_HDM_DECODER0_CTRL_LOCK 0x100
> +#define   CXL_HDM_DECODER0_CTRL_COMMIT 0x200
> +#define   CXL_HDM_DECODER0_CTRL_COMMITTED 0x400
> +#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR 0x800
> +#define   CXL_HDM_DECODER0_CTRL_HOSTONLY 0x1000
> +#define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
> +#define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
> +#define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
> +#define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
> +
> +#endif /* _UAPI_CXL_REGS_H_ */

