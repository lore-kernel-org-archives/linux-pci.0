Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FDB387566;
	Tue,  2 Jun 2026 22:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780438257; cv=none; b=X5oUIe0wg53xsclaFo3MPkVQeRCH77llfSpC37miVFH13Pj/loWXQH/AZvo/qS9wL05J/oTrwp0JVoH7NqSJ1XZm+86lsLY7XSwDtJvpeswQGhJaJa4Mcylz14QIytYMsj+O5dKBf/+1Z1qt1PMgbwNHyh7jZSiEgoSTOvCOGM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780438257; c=relaxed/simple;
	bh=Uq+vN5govkehHLvBwr0MpcwboOqfdHLYWbgkEji+IsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ktXP3Q74GzQuzxMFeZ2YR/hWwEdZk4uf4Xc2fTKRSe+wqIuacBp2wLyQxsXBXJy8E8T0XUbKDR1amO+n7211T+UAtfEXpgD1QSKX6/ggQ0cCuPCkhgpXoTnIZsJsQaq7Z5gLKe48muNQZ8Ji+Qm+SC9fEKprUGsIX/yG6ZlW2ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FYj+1kX5; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FYj+1kX5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780438256; x=1811974256;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Uq+vN5govkehHLvBwr0MpcwboOqfdHLYWbgkEji+IsE=;
  b=FYj+1kX5lRvjXwEKXhKARi1GceAhiLOWRio1yJPgdjYtOn8e/gDPJV5K
   YY7gKcoRlbnSzkyNQHBFmkEwRKjo08h3HT6THuFcxeomBqkjry/Xd4VAk
   SdEPHk14SeXF73z+hl6/zh1gz2MEYaI4zKq2WFqkbqbzVLTKpbaLdtldu
   maKvTc6PaU0+osq3A/ORXyivygynxA//ZrsrZL1tYuCiCIEEfJXRhR8BP
   UWtdUjrTHcG4Qm8N0n4jgl7oWzxjwGqvUxIqBzJQV6EjQMZbgCzpndck2
   /pKETipdVI/Uay8jFQN8QAGXtMzduAEHgv6XDkUmPX9q3oHo9/xxhQYUa
   w==;
X-CSE-ConnectionGUID: DFMtHhqJRdeZhEeucMCWiQ==
X-CSE-MsgGUID: 8U+T64s8TdugnJO/D1mILQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81418626"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81418626"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 15:10:56 -0700
X-CSE-ConnectionGUID: a5zdfxwYS2ekStnqgOuGQg==
X-CSE-MsgGUID: EhwZebTJTIiNVYeBGUNJ7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="247983312"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.56]) ([10.125.108.56])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 15:10:55 -0700
Message-ID: <b26107b2-a722-4c28-9df8-6e11eec3c7d4@intel.com>
Date: Tue, 2 Jun 2026 15:10:54 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] PCI/CXL: Add sibling function coordination for
 reset
To: Srirangan Madhavan <smadhavan@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: vsethi@nvidia.com, alwilliamson@nvidia.com,
 Dan Williams <danwilliams@nvidia.com>,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260528083154.137979-1-smadhavan@nvidia.com>
 <20260528083154.137979-5-smadhavan@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260528083154.137979-5-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/28/26 1:31 AM, Srirangan Madhavan wrote:
> Add helpers to collect CXL sibling PCI functions affected by a CXL reset
> and prepare them for reset by saving and disabling them. Restore those
> siblings and drop their references when reset coordination completes.
> 
> Use the Non-CXL Function Map DVSEC to exclude non-CXL functions, and
> filter remaining siblings to functions that advertise CXL.cache or
> CXL.mem capability.
> 
> Use pci_dev_trylock() for sibling locking and unwind on contention or
> allocation failure, so competing reset paths fail with an errno.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/pci.c        | 207 ++++++++++++++++++++++++++++++++++
>  include/uapi/linux/pci_regs.h |   2 +
>  2 files changed, 209 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 318744695f62..01effbb4e7cd 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1,9 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
>  #include <linux/units.h>
> +#include <linux/bitmap.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
> +#include <linux/iommu.h>
>  #include <linux/memregion.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
> @@ -15,6 +17,10 @@
>  #include "core.h"
>  #include "trace.h"
>  
> +#define CXL_RESET_MAX_FUNCTIONS		256

Can use MAX_NR_DEVFNS defined by PCI

DJ

> +#define CXL_RESET_FUNCTION_MAP_REGS	(CXL_RESET_MAX_FUNCTIONS / 32)
> +#define CXL_RESET_SIBLINGS_INIT		8
> +
>  /**
>   * DOC: cxl core pci
>   *
> @@ -1096,3 +1102,204 @@ cxl_reset_flush_cpu_caches(struct cxl_reset_region_context *ctx)
>  
>  	return 0;
>  }
> +
> +struct cxl_reset_context {
> +	struct pci_dev *target;
> +	struct pci_dev **siblings;
> +	int nr_siblings;
> +	int sibling_capacity;
> +	int nr_siblings_prepared;
> +};
> +
> +struct cxl_reset_walk_ctx {
> +	struct cxl_reset_context *ctx;
> +	unsigned long *non_cxl_func_map;
> +	int rc;
> +};
> +
> +static void
> +cxl_reset_read_non_cxl_func_map(struct pci_dev *pdev,
> +				unsigned long *non_cxl_func_map)
> +{
> +	u32 map[CXL_RESET_FUNCTION_MAP_REGS] = {};
> +	u16 dvsec;
> +	int rc, i;
> +
> +	bitmap_zero(non_cxl_func_map, CXL_RESET_MAX_FUNCTIONS);
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_FUNCTION_MAP);
> +	if (!dvsec)
> +		return;
> +
> +	for (i = 0; i < CXL_RESET_FUNCTION_MAP_REGS; i++) {
> +		rc = pci_read_config_dword(pdev,
> +					   dvsec + PCI_DVSEC_CXL_FUNCTION_MAP_REG +
> +					   i * sizeof(map[i]), &map[i]);
> +		if (rc) {
> +			pci_warn(pdev,
> +				 "failed to read CXL Function Map; treating all siblings as CXL: %d\n",
> +				 rc);
> +			bitmap_zero(non_cxl_func_map, CXL_RESET_MAX_FUNCTIONS);
> +			return;
> +		}
> +	}
> +
> +	bitmap_from_arr32(non_cxl_func_map, map, CXL_RESET_MAX_FUNCTIONS);
> +}
> +
> +static bool cxl_reset_is_cxl_sibling(struct pci_dev *pdev,
> +				     struct pci_dev *sibling,
> +				     unsigned long *non_cxl_func_map)
> +{
> +	if (sibling == pdev || sibling->bus != pdev->bus)
> +		return false;
> +
> +	if (pci_ari_enabled(pdev->bus))
> +		return !test_bit(sibling->devfn, non_cxl_func_map);
> +
> +	if (PCI_SLOT(sibling->devfn) != PCI_SLOT(pdev->devfn))
> +		return false;
> +
> +	return !test_bit(PCI_FUNC(sibling->devfn) * 32 +
> +			 PCI_SLOT(sibling->devfn), non_cxl_func_map);
> +}
> +
> +static bool cxl_reset_has_cache_or_mem(struct pci_dev *pdev)
> +{
> +	u16 dvsec, cap;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return false;
> +
> +	if (pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap))
> +		return false;
> +
> +	return cap & (PCI_DVSEC_CXL_CACHE_CAPABLE | PCI_DVSEC_CXL_MEM_CAPABLE);
> +}
> +
> +static int cxl_reset_add_sibling(struct cxl_reset_context *ctx,
> +				 struct pci_dev *sibling)
> +{
> +	struct pci_dev **siblings;
> +	int capacity;
> +
> +	if (ctx->nr_siblings < ctx->sibling_capacity)
> +		goto add;
> +
> +	capacity = ctx->sibling_capacity ? ctx->sibling_capacity * 2 :
> +		   CXL_RESET_SIBLINGS_INIT;
> +	siblings = krealloc(ctx->siblings, capacity * sizeof(*siblings),
> +			    GFP_KERNEL);
> +	if (!siblings)
> +		return -ENOMEM;
> +
> +	ctx->siblings = siblings;
> +	ctx->sibling_capacity = capacity;
> +
> +add:
> +	pci_dev_get(sibling);
> +	ctx->siblings[ctx->nr_siblings++] = sibling;
> +	return 0;
> +}
> +
> +static int cxl_reset_collect_sibling(struct pci_dev *sibling, void *data)
> +{
> +	struct cxl_reset_walk_ctx *wctx = data;
> +	struct cxl_reset_context *ctx = wctx->ctx;
> +	struct pci_dev *pdev = ctx->target;
> +
> +	if (!cxl_reset_is_cxl_sibling(pdev, sibling, wctx->non_cxl_func_map))
> +		return 0;
> +
> +	if (!cxl_reset_has_cache_or_mem(sibling))
> +		return 0;
> +
> +	wctx->rc = cxl_reset_add_sibling(ctx, sibling);
> +	return wctx->rc;
> +}
> +
> +static int cxl_reset_collect_siblings(struct cxl_reset_context *ctx)
> +{
> +	DECLARE_BITMAP(non_cxl_func_map, CXL_RESET_MAX_FUNCTIONS);
> +	struct cxl_reset_walk_ctx wctx = {
> +		.ctx = ctx,
> +		.non_cxl_func_map = non_cxl_func_map,
> +	};
> +
> +	cxl_reset_read_non_cxl_func_map(ctx->target, non_cxl_func_map);
> +	pci_walk_bus(ctx->target->bus, cxl_reset_collect_sibling, &wctx);
> +	return wctx.rc;
> +}
> +
> +static void cxl_pci_functions_reset_done(struct cxl_reset_context *ctx)
> +{
> +	int i;
> +
> +	for (i = ctx->nr_siblings_prepared - 1; i >= 0; i--) {
> +		struct pci_dev *sibling = ctx->siblings[i];
> +
> +		pci_dev_reset_iommu_done(sibling);
> +		pci_dev_restore(sibling);
> +		pci_dev_unlock(sibling);
> +	}
> +
> +	for (i = 0; i < ctx->nr_siblings; i++)
> +		pci_dev_put(ctx->siblings[i]);
> +
> +	kfree(ctx->siblings);
> +	ctx->siblings = NULL;
> +	ctx->nr_siblings = 0;
> +	ctx->sibling_capacity = 0;
> +	ctx->nr_siblings_prepared = 0;
> +}
> +
> +static int __maybe_unused
> +cxl_pci_functions_reset_prepare(struct cxl_reset_context *ctx)
> +{
> +	int rc, i;
> +
> +	ctx->siblings = NULL;
> +	ctx->nr_siblings = 0;
> +	ctx->sibling_capacity = 0;
> +	ctx->nr_siblings_prepared = 0;
> +
> +	rc = cxl_reset_collect_siblings(ctx);
> +	if (rc)
> +		goto err;
> +
> +	for (i = 0; i < ctx->nr_siblings; i++) {
> +		struct pci_dev *sibling = ctx->siblings[i];
> +
> +		if (!pci_dev_trylock(sibling)) {
> +			rc = -EAGAIN;
> +			goto err;
> +		}
> +
> +		pci_dev_save_and_disable(sibling);
> +		rc = pci_dev_reset_iommu_prepare(sibling);
> +		if (rc) {
> +			pci_err(sibling,
> +				"failed to block IOMMU for CXL reset: %d\n",
> +				rc);
> +			/*
> +			 * Undo save_and_disable() for this sibling. IOMMU
> +			 * prepare failed, so this sibling is not counted in
> +			 * nr_siblings_prepared and must not get iommu_done().
> +			 */
> +			pci_dev_restore(sibling);
> +			pci_dev_unlock(sibling);
> +			goto err;
> +		}
> +
> +		ctx->nr_siblings_prepared++;
> +	}
> +
> +	return 0;
> +
> +err:
> +	cxl_pci_functions_reset_done(ctx);
> +	return rc;
> +}
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 14f634ab9350..fa1fcd26af01 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1349,6 +1349,7 @@
>  /* CXL r4.0, 8.1.3: PCIe DVSEC for CXL Device */
>  #define PCI_DVSEC_CXL_DEVICE				0
>  #define  PCI_DVSEC_CXL_CAP				0xA
> +#define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
>  #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
>  #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
>  #define  PCI_DVSEC_CXL_CTRL				0xC
> @@ -1366,6 +1367,7 @@
>  
>  /* CXL r4.0, 8.1.4: Non-CXL Function Map DVSEC */
>  #define PCI_DVSEC_CXL_FUNCTION_MAP			2
> +#define  PCI_DVSEC_CXL_FUNCTION_MAP_REG			0x0C
>  
>  /* CXL r4.0, 8.1.5: Extensions DVSEC for Ports */
>  #define PCI_DVSEC_CXL_PORT				3

