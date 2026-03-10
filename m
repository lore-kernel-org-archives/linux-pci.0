Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7F91FA859;
	Tue, 10 Mar 2026 00:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773102367; cv=none; b=Z0qQMHNvwEPFsxp4rLaQJvDe4mu0vAUe2aU6Y4TL398pV/LjDgUFrq7IONW3PaIiV6o4igksY8wO3v5q0yhiaY/keJAiow65nxWUcKm2O/rO5/dgn9UjhoUzK1gFLoqPRxfnyWluRdiDRF07sf8p4cN5gMC6ZaEc62tTQtDMkb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773102367; c=relaxed/simple;
	bh=Ot4Ths1ZUlOPzNRXng73+zkBmnQ6AD7rpy+04OogOcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBekrWnh+UG3c3w5iEeaeTv6MHn+OQwxHNU0ZejEAspU8unRXWgxVeV+UuYV3Az+k//7huGjEWpA7kDJfCXKk4nHR/hPAJ8cEIjnq5hIDU+X1W7ZXqSwjnc2j6SN6chQOz3QGXfe7CEtcP+sDV0CAON6UKDfcHcCjUZVW1lYG0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FrdJEi+C; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FrdJEi+C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773102364; x=1804638364;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ot4Ths1ZUlOPzNRXng73+zkBmnQ6AD7rpy+04OogOcs=;
  b=FrdJEi+CITTA30dNDc5olY50f6bqTsZ+lOcRL4jBGQGSET29/oW1WO2s
   m+/0vj2RiwxFre5tuVt1ntbJ+UZQLHl4LyCco4cvGuzTTjTG6f9KnqgNf
   w4c6kkuCUvF1je0/FFn8ikznL0IGTNvTJ04FJon68WJt/VJ2ENuqPVVe2
   gXReYEALjqJGG8fyL7ETa1CcamaASLDVyY1+4SScQxJKX1K+3J52VwVK6
   VvFNADTCO3OQ6AZvaqehJsUz1pVTgIb94yHXtBQ5W9zClWtdSdRBnS/3V
   9YRlxyM3ia1gCgQNQqRzNbyIK1HFi9uzgLoXn+wqvZ3J6xF0Oeymbp1eS
   A==;
X-CSE-ConnectionGUID: mNLcV3u0TbWdc0tLeg+9zA==
X-CSE-MsgGUID: xXPk9DGXQi2qlWdQFKJ8Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74216279"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="74216279"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 17:26:03 -0700
X-CSE-ConnectionGUID: yfGGs7XHQwCCLE0UROaAgA==
X-CSE-MsgGUID: u4UezD0eQ8OgCoN+KXGvNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="257842049"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.109.205]) ([10.125.109.205])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 17:26:02 -0700
Message-ID: <a2b170b4-785d-466a-bab8-bf33252299bc@intel.com>
Date: Mon, 9 Mar 2026 17:26:00 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] cxl: Add CXL DVSEC reset sequence and flow
 orchestration
To: smadhavan@nvidia.com, bhelgaas@google.com, dan.j.williams@intel.com,
 jonathan.cameron@huawei.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, dave@stgolabs.net
Cc: alwilliamson@nvidia.com, jeshuas@nvidia.com, vsethi@nvidia.com,
 skancherla@nvidia.com, vaslot@nvidia.com, sdonthineni@nvidia.com,
 mhonap@nvidia.com, vidyas@nvidia.com, jan@nvidia.com, mochs@nvidia.com,
 dschumacher@nvidia.com, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260306092322.148765-1-smadhavan@nvidia.com>
 <20260306092322.148765-6-smadhavan@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260306092322.148765-6-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/6/26 2:23 AM, smadhavan@nvidia.com wrote:
> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> cxl_dev_reset() implements the hardware reset sequence:
> optionally enable memory clear, initiate reset via
> CTRL2, wait for completion, and re-enable caching.
> 
> cxl_do_reset() orchestrates the full reset flow:
>   1. CXL pre-reset: mem offlining and cache flush (when memdev present)
>   2. PCI save/disable: pci_dev_save_and_disable() automatically saves
>      CXL DVSEC and HDM decoder state via PCI core hooks
>   3. Sibling coordination: save/disable CXL.cachemem sibling functions
>   4. Execute CXL DVSEC reset
>   5. Sibling restore: always runs to re-enable sibling functions
>   6. PCI restore: pci_dev_restore() automatically restores CXL state
> 
> The CXL-specific DVSEC and HDM save/restore is handled
> by the PCI core's CXL save/restore infrastructure (drivers/pci/cxl.c).
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/pci.c | 181 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 179 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index b6f10a2cb404..c758b3f1b3f9 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1078,7 +1078,7 @@ static int cxl_reset_collect_sibling(struct pci_dev *func, void *data)
>  	return 0;
>  }
> 
> -static void __maybe_unused cxl_pci_functions_reset_prepare(struct cxl_reset_context *ctx)
> +static void cxl_pci_functions_reset_prepare(struct cxl_reset_context *ctx)
>  {
>  	struct pci_dev *pdev = ctx->target;
>  	struct cxl_reset_walk_ctx wctx;
> @@ -1103,7 +1103,7 @@ static void __maybe_unused cxl_pci_functions_reset_prepare(struct cxl_reset_cont
>  	}
>  }
> 
> -static void __maybe_unused cxl_pci_functions_reset_done(struct cxl_reset_context *ctx)
> +static void cxl_pci_functions_reset_done(struct cxl_reset_context *ctx)
>  {
>  	int i;
> 
> @@ -1116,3 +1116,180 @@ static void __maybe_unused cxl_pci_functions_reset_done(struct cxl_reset_context
>  	ctx->pci_functions = NULL;
>  	ctx->pci_func_count = 0;
>  }
> +
> +/*
> + * CXL device reset execution
> + */
> +static int cxl_dev_reset(struct pci_dev *pdev, int dvsec)
> +{
> +	static const u32 reset_timeout_ms[] = { 10, 100, 1000, 10000, 100000 };
> +	u16 cap, ctrl2, status2;
> +	u32 timeout_ms;
> +	int rc, idx;
> +
> +	if (!pci_wait_for_pending_transaction(pdev))
> +		pci_err(pdev, "timed out waiting for pending transactions\n");
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &ctrl2);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Disable caching and initiate cache writeback+invalidation if the
> +	 * device supports it. Poll for completion.
> +	 * Per CXL r3.2 section 9.6, software may use the cache size from
> +	 * DVSEC CXL Capability2 to compute a suitable timeout; we use a
> +	 * default of 10ms.
> +	 */
> +	if (cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE) {
> +		u32 wbi_poll_us = 100;
> +		s32 wbi_remaining_us = 10000;
> +
> +		ctrl2 |= PCI_DVSEC_CXL_DISABLE_CACHING;
> +		rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2,
> +					   ctrl2);
> +		if (rc)
> +			return rc;
> +
> +		ctrl2 |= PCI_DVSEC_CXL_INIT_CACHE_WBI;
> +		rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2,
> +					   ctrl2);
> +		if (rc)
> +			return rc;
> +
> +		do {
> +			usleep_range(wbi_poll_us, wbi_poll_us + 1);
> +			wbi_remaining_us -= wbi_poll_us;
> +			rc = pci_read_config_word(pdev,
> +						  dvsec + PCI_DVSEC_CXL_STATUS2,
> +						  &status2);
> +			if (rc)
> +				return rc;
> +		} while (!(status2 & PCI_DVSEC_CXL_CACHE_INV) &&
> +			 wbi_remaining_us > 0);
> +
> +		if (!(status2 & PCI_DVSEC_CXL_CACHE_INV)) {
> +			pci_err(pdev, "CXL cache WB+I timed out\n");
> +			return -ETIMEDOUT;
> +		}
> +	} else if (cap & PCI_DVSEC_CXL_CACHE_CAPABLE) {
> +		ctrl2 |= PCI_DVSEC_CXL_DISABLE_CACHING;
> +		rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2,
> +					   ctrl2);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	if (cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE) {
> +		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2,
> +					  &ctrl2);
> +		if (rc)
> +			return rc;
> +
> +		ctrl2 |= PCI_DVSEC_CXL_RST_MEM_CLR_EN;
> +		rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2,
> +					   ctrl2);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	idx = FIELD_GET(PCI_DVSEC_CXL_RST_TIMEOUT, cap);
> +	if (idx >= ARRAY_SIZE(reset_timeout_ms))
> +		idx = ARRAY_SIZE(reset_timeout_ms) - 1;
> +	timeout_ms = reset_timeout_ms[idx];
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &ctrl2);
> +	if (rc)
> +		return rc;
> +
> +	ctrl2 |= PCI_DVSEC_CXL_INIT_CXL_RST;
> +	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
> +	if (rc)
> +		return rc;
> +
> +	msleep(timeout_ms);
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
> +				  &status2);
> +	if (rc)
> +		return rc;
> +
> +	if (status2 & PCI_DVSEC_CXL_RST_ERR) {
> +		pci_err(pdev, "CXL reset error\n");
> +		return -EIO;
> +	}
> +
> +	if (!(status2 & PCI_DVSEC_CXL_RST_DONE)) {
> +		pci_err(pdev, "CXL reset timeout\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &ctrl2);
> +	if (rc)
> +		return rc;
> +
> +	ctrl2 &= ~PCI_DVSEC_CXL_DISABLE_CACHING;
> +	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
> +	if (rc)
> +		return rc;
> +
> +	return 0;
> +}
> +
> +static int match_memdev_by_parent(struct device *dev, const void *parent)
> +{
> +	return is_cxl_memdev(dev) && dev->parent == parent;
> +}
> +
> +static int cxl_do_reset(struct pci_dev *pdev)
> +{
> +	struct cxl_reset_context ctx = { .target = pdev };
> +	struct cxl_memdev *cxlmd = NULL;
> +	struct device *memdev = NULL;
> +	int dvsec, rc;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return -ENODEV;
> +
> +	memdev = bus_find_device(&cxl_bus_type, NULL, &pdev->dev,
> +				 match_memdev_by_parent);

You can create a custom __free() function here with memdev.

> +	if (memdev) {
> +		cxlmd = to_cxl_memdev(memdev);
> +		guard(device)(&cxlmd->dev);
> +	}
> +
> +	mutex_lock(&cxl_reset_mutex);

guard(mutex)(&cxl_reset_mutex)?

> +	pci_dev_lock(pdev);
> +
> +	if (cxlmd) {
> +		rc = cxl_reset_prepare_memdev(cxlmd);
> +		if (rc)
> +			goto out_unlock;
> +
> +		cxl_reset_flush_cpu_caches(cxlmd);
> +	}

Can you move the discovery and touching of cxlmd to a helper function? Would that clean things up a bit here?

DJ

> +
> +	pci_dev_save_and_disable(pdev);
> +	cxl_pci_functions_reset_prepare(&ctx);
> +
> +	rc = cxl_dev_reset(pdev, dvsec);
> +
> +	cxl_pci_functions_reset_done(&ctx);
> +
> +	pci_dev_restore(pdev);
> +
> +out_unlock:
> +	pci_dev_unlock(pdev);
> +	mutex_unlock(&cxl_reset_mutex);
> +
> +	if (memdev)
> +		put_device(memdev);
> +
> +	return rc;
> +}
> --
> 2.43.0
> 

