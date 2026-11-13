Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592938;
	b=F1CvxMI4dk6onbIzX4Jno4CZlkRLai9IjY1gQyVDylL6U9XldB0nXzEozbvacX9B5PQi
	 K1Ti81OK3/UU0fHbp5jDx8QU59hLHyKWCCA1jXb0cdltOfJuexMugmUS/miU2SqxFvs0W
	 dvhgxj/ax3id96GJ0gsh5SlOLQSM6qWa4/v+RnWBQzkjSsFtEe8/5DNR/vkJopLujffJA
	 IewIzzlHs/lyz/+HQqaVIx63Ov81KczYo4eKGchcQVy9qCbG/s9RUVBFgK5526Rci3PJ2
	 tVYmR91/j7lC3AJ9dprXrLW/ejUPnHqhLvRzExw/yJZSxPwdTc222kUaSmuGQq1bqdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592938;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=FLDB5pDlTBVxUsUsGFkW1bI/BY3fQv1VTeioFmQJmvE=;
	b=s9rLc/ePNXyQtsMYws2yRJ6pxb1J7aWv2LFTVv/0ZyYndysaqZMU8AlK2gabxvW5ypU6
	 yJy57CVjsgA5b5TS3Ivc+RnPwbPz/60O2uqKvezNtCuNwCs3+LV554Ul1apIbmf2a/tMm
	 RoBnmOZglHRrRhaHx0kdvFDoYFHxeRX/1wuouIR3jPTz2lz//dCvX+VegHaLz8MrfhIPx
	 bP2fAej1V8RpaKQbnxubje01SkC1bxKRCjwJ4HMmjjP8qen7IS0NgWqrOnylN+pDmWUFA
	 dm1z13cU1VkAlwcjSkh+wRQx2SAJwFFhlx+ln+fYX4WhqFgX58QcrJMkuG3/BFT2jTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i9CWb5xc;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9421606A33D;
	Fri, 13 Nov 2026 18:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9421606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i9CWb5xc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794592937; x=1826128937;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JU8v7QLVsxSJAm5rcv+VDpYojpjJMkR+WhiIM3lQ4dA=;
  b=i9CWb5xcHNDQEHOj+nV0r8IC12zbTkI627pUEC4tOpHvEFA2Q3WAvroc
   mBgkhOyB2F2nLr5NfLUjWBTOduC/MCriBkb6lz83SMTC8Ul+BpRoWKzdj
   sseH5zNYiWNSwqztaqbfNceGxNMPPsaWG7o9gfLb//bv+XrP92Ns+KHgV
   h7nPYvyoIS9fmR3HZLbwZZbLHkSCmrM+XQicQ7Kpd8t3qq7UQB5sUpiJB
   WwsNuBO9m7yqzuzTwIGold7Nj1Cj9srN6mNYN1/kcgI0XqNUaGWBvxZZc
   aOlTQLaJgtPFDjCc5L46auqpvRSN70MSwDeAe+B19WZP5+cUebGbK81+w
   w==;
X-CSE-ConnectionGUID: 6QX7wfpCQIixH/9VbiQdlA==
X-CSE-MsgGUID: JxqdI3lDQ/KjHnVIv9mPvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3436608"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3436608"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 10:02:17 -0800
X-CSE-ConnectionGUID: jvWr4LadS/CRmZ4F+1IJbw==
X-CSE-MsgGUID: 8dWcEGPXT0yxBSfNzxGwfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="10760617"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.108.6]) ([10.125.108.6])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 10:02:15 -0800
Message-ID: <8f06ddfa-1c8d-4421-a830-8429b9e5ee88@intel.com>
Date: Fri, 13 Nov 2026 11:02:13 -0700
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 10/19] cxl: Build register block helpers into the
 kernel
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <iweiny@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Li Ming <ming.li@zohomail.com>, Joshua Machauer <machaujo@amazon.de>,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-11-smadhavan@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261105185917.2667656-11-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/5/26 11:59 AM, Srirangan Madhavan wrote:
> Build register discovery with the built-in HDM helpers so PCI enumeration
> can use it even when cxl_core is modular. Export the interfaces used by
> cxl_core and preserve the BAR and offset in the register map.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Reviewed-by: Richard Cheng <icheng@nvidia.com>

This patch does what the first sentence claims, but then a bunch of misc stuff tagged along with it. Please keep commits to one logical change per commit.

Move the bar and bar_offset changes to when they are needed.

Move cxl_dvsec_hdm_count_valid() to where it's being used.

the 'struct pci_dev' forward declare, is this needed?

Also the exports can use EXPORT_SYMBOL_FOR_MODULES(..., "cxl_core") I think?

DJ

> ---
>  drivers/cxl/core/Makefile |  3 +--
>  drivers/cxl/core/regs.c   |  9 +++++++++
>  drivers/cxl/cxl.h         |  3 ---
>  include/cxl/cxl.h         |  5 +++++
>  include/cxl/pci.h         | 13 +++++++++++++
>  tools/testing/cxl/Kbuild  |  1 -
>  6 files changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 9971efb237fb..9a77e68d44ce 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += cxl_core.o
> -obj-$(subst m,y,$(CONFIG_CXL_BUS)) += hdm_regs.o hdm_state.o
> +obj-$(subst m,y,$(CONFIG_CXL_BUS)) += hdm_regs.o hdm_state.o regs.o
>  obj-$(CONFIG_CXL_SUSPEND) += suspend.o
>  
>  ccflags-y += -I$(srctree)/drivers/cxl
> @@ -8,7 +8,6 @@ CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
>  
>  cxl_core-y := port.o
>  cxl_core-y += pmem.o
> -cxl_core-y += regs.o
>  cxl_core-y += memdev.o
>  cxl_core-y += mbox.o
>  cxl_core-y += pci.o
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 20c2d9fbcfe7..def3c20d1a7a 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -200,6 +200,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>  
>  	return ret_val;
>  }
> +EXPORT_SYMBOL_FOR_MODULES(devm_cxl_iomap_block, "cxl_core");
>  
>  int cxl_map_component_regs(const struct cxl_register_map *map,
>  			   struct cxl_component_regs *regs,
> @@ -285,6 +286,8 @@ static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
>  	}
>  
>  	map->reg_type = reg_type;
> +	map->bar = bar;
> +	map->bar_offset = offset;
>  	map->resource = pci_resource_start(pdev, bar) + offset;
>  	map->max_size = pci_resource_len(pdev, bar) - offset;
>  	return true;
> @@ -309,6 +312,7 @@ static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_ty
>  	*map = (struct cxl_register_map) {
>  		.host = &pdev->dev,
>  		.resource = CXL_RESOURCE_NONE,
> +		.bar = -1,
>  	};
>  
>  	regloc = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> @@ -339,6 +343,8 @@ static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_ty
>  	}
>  
>  	map->resource = CXL_RESOURCE_NONE;
> +	map->bar = -1;
> +	map->bar_offset = 0;
>  	if (index == CXL_INSTANCES_COUNT)
>  		return instance;
>  
> @@ -518,6 +524,7 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
>  
>  	return offset;
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_aer, "CXL");
>  
>  static resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport)
>  {
> @@ -634,6 +641,7 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
>  
>  	return component_reg_phys;
>  }
> +EXPORT_SYMBOL_NS_GPL(__rcrb_to_component, "CXL");
>  
>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  					   struct cxl_dport *dport)
> @@ -642,3 +650,4 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  		return CXL_RESOURCE_NONE;
>  	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 688350c7c5fb..ad4e80be2bd7 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -239,9 +239,6 @@ enum cxl_regloc_type;
>  int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
>  int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
>  			       struct cxl_register_map *map, unsigned int index);
> -int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> -		      struct cxl_register_map *map);
> -int cxl_setup_regs(struct cxl_register_map *map);
>  struct cxl_dport;
>  int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>  
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 341a7c52894a..ea23bc15d00e 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -27,6 +27,7 @@ enum cxl_devtype {
>  
>  struct cxl_region;
>  struct cxl_hdm_info;
> +struct pci_dev;
>  
>  enum cxl_decoder_type {
>  	CXL_DECODER_DEVMEM = 2,
> @@ -150,6 +151,8 @@ struct cxl_pmu_reg_map {
>   * @base: virtual base of the register-block-BAR + @block_offset
>   * @resource: physical resource base of the register block
>   * @max_size: maximum mapping size to perform register search
> + * @bar: PCI BAR containing the register block
> + * @bar_offset: register block offset relative to @bar
>   * @reg_type: see enum cxl_regloc_type
>   * @component_map: cxl_reg_map for component registers
>   * @device_map: cxl_reg_maps for device registers
> @@ -160,6 +163,8 @@ struct cxl_register_map {
>  	void __iomem *base;
>  	resource_size_t resource;
>  	resource_size_t max_size;
> +	int bar;
> +	resource_size_t bar_offset;
>  	u8 reg_type;
>  	union {
>  		struct cxl_component_reg_map component_map;
> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
> index 3e0000015871..b15d7e415e27 100644
> --- a/include/cxl/pci.h
> +++ b/include/cxl/pci.h
> @@ -4,6 +4,8 @@
>  #ifndef __CXL_CXL_PCI_H__
>  #define __CXL_CXL_PCI_H__
>  
> +#include <linux/types.h>
> +
>  /* Register Block Identifier (RBI) */
>  enum cxl_regloc_type {
>  	CXL_REGLOC_RBI_EMPTY = 0,
> @@ -19,4 +21,15 @@ struct pci_dev;
>  
>  int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  		       struct cxl_register_map *map);
> +int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> +		      struct cxl_register_map *map);
> +int cxl_setup_regs(struct cxl_register_map *map);
> +/*
> + * CXL r4.0 sec 8.1.3.1: a CXL.mem capable device reports one or two HDM
> + * ranges. 00b is illegal when Mem_Capable is set and 11b is reserved.
> + */
> +static inline bool cxl_dvsec_hdm_count_valid(unsigned int hdm_count)
> +{
> +	return hdm_count == 1 || hdm_count == 2;
> +}
>  #endif
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 2be1df80fcc9..e80500f457a9 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -55,7 +55,6 @@ obj-m += cxl_core.o
>  
>  cxl_core-y := $(CXL_CORE_SRC)/port.o
>  cxl_core-y += $(CXL_CORE_SRC)/pmem.o
> -cxl_core-y += $(CXL_CORE_SRC)/regs.o
>  cxl_core-y += $(CXL_CORE_SRC)/memdev.o
>  cxl_core-y += $(CXL_CORE_SRC)/mbox.o
>  cxl_core-y += $(CXL_CORE_SRC)/pci.o

