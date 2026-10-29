Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297358;
	b=mEl2FbKL+hjktKedMglSEAI+1QTU1HRD470/ItviGKy9/jy16wW378MfJfvBcU6l4vll
	 mXUQykLbDXEkb/y9xw7jLKdQLihUqqE0FMpO7DKMuHdkkOWSeZ+4KMgBvwtvRdzRVJGlF
	 nZ1EcRrqidrd++R9w/lAQiTPq7EV++qrogKltWvB/NVf5/BiG/JUPhdqqsUkDd6QM0DcK
	 Ki8ldhXsa3wfb2KCyYMrU497W/kj8QvXzRr4PDaFdryWjAz9HAM6Pa4YYlbE0wwoxG3q/
	 aQP/l9FOBDdubaDHbLArLGgGvx2X30Brp/ULmwQNROQwgM0/fU5iKrDOdUd0wzCY2cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297358;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=cQaKWas6iH6vOE4J+nEY7KWpXg7PwhsvoYg/iqx6lvQ=;
	b=pSo9OTIBzx94lRh9xPLj789ps8ySbRQljihwzHWsGOWHGE3VM2ochHmcoukkun61Rbyj
	 8hDedGhubVCggMEBLC9RQFzJ1GXQooa8R0CFi9iJc6JOWKtJCfBP49UNgpNt5AwCP5JIb
	 xoUlXzVQlNjH5+UN2hpkJlt6qjxCJ+eWNqx/OJzt34PvgKrvb5Gb+JSMOMMAFPZS4rUH1
	 ZfeLTPQgbBhcCiwKi67cHJTR1q1hVK+RypDLbsfdsuqh5Py+0xUJC7cx69xF/2kSMWf7P
	 EIDtGB5MbfbFxD+UwD50pu6LT13a2CQ+1Hsa4YtnseX+7urKdpCbyvTu2rhJftNpURQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fjijG53d;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D050606A31A;
	Thu, 29 Oct 2026 18:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D050606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fjijG53d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793297357; x=1824833357;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lGffUvnnnz7wPyorONboV1Kt1/6anxNbCYvs4xbkAaE=;
  b=fjijG53dCC3mVIbY4AoAvskO0IkLoiKop9p/2A7OznaWXBMXZWfAio8r
   YiVoayoQi+J74GQ1AVgOduwWagzGqKzzwFPTg/6WQ5BLzyB4Z7EniZ5OL
   9DH/vV1ckbQIdK1xUEDg0Jpj9Tpkoc1UcWPIyoO3Mi/Bu+KS+ijVCWUjB
   qjwESxxB4qH4U6HOMH9mOql1FJIRLqwKBPCsEnusdtbCRR+mk4sWi2GXw
   z7I9YsHgb6zE/8neWFAKyLyffg4sL9RKtQ2PgmetsoqcE6qnjFUM9Ovmo
   vmNYerlqdKOv2ZqpvHWcErg4GFSbDhPM6uKofS8ls1vLStne2KBHCDwBk
   w==;
X-CSE-ConnectionGUID: SKN3PHNuT2a5wdiYpfu2kA==
X-CSE-MsgGUID: HW0GBlHqSOm5gvNlbEDJ4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2063748"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2063748"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 11:09:17 -0700
X-CSE-ConnectionGUID: /r3wHdg9Qn67zSPuRTybqw==
X-CSE-MsgGUID: EQFcErw7SbS9Hbrf0qwAZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5141207"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.28]) ([10.125.109.28])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 11:09:13 -0700
Message-ID: <3dc7cc2f-b226-47f6-a538-169ca95b5472@intel.com>
Date: Thu, 29 Oct 2026 11:09:11 -0700
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
Subject: Re: [PATCH] PCI/CXL: Flush host and device caches for CXL bus reset
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Li Ming <ming.li@zohomail.com>,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261029155836.2253844-1-smadhavan@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261029155836.2253844-1-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/29/26 8:58 AM, Srirangan Madhavan wrote:
> CXL bus reset can reset a Type 2 device while its host and device caches
> still contain data for the device's HDM ranges. Flush the host caches,
> disable device caching, and trigger device cache writeback and
> invalidation when supported before reset. Invalidate the host caches
> again before ending IOMMU exclusion.
> 
> Hold the CXL region quiesce from snapshot through restoration so region
> commit and teardown cannot change the decoder state while the reset is
> in progress. Reserve the affected HPA ranges and preserve the device's
> cache policy across the operation.
> 
> If reset was not attempted, undo preparation without changing the saved
> PCI command unless cleanup fails. After an attempted reset, keep the
> device disabled on recovery failure and do not re-enable caching against
> unrestored HDM state.
> 
> If no cached HDM state exists, retain the existing CXL bus reset path.
> For a device with cached state, reject the reset if its cache-maintenance
> state cannot be safely prepared or restored. An invalidation provider is
> required unless the existing test-only CXL_REGION_INVALIDATION_TEST bypass
> is enabled.
> 
> This builds on the v16 CXL reset series. The global region lock is held
> through bus reset and restoration.

This information should go under --- as it is meaningless once the commit is merged.

Also why not integrate this commit into your reset series? Odd to be a stand alone post.

DJ

> 
> Link: https://lore.kernel.org/linux-cxl/20261029145703.2185231-1-smadhavan@nvidia.com/
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> --->  drivers/pci/cxl.c | 168 ++++++++++++++++++++++++++++++++++++----------
>  drivers/pci/pci.c |   9 +--
>  drivers/pci/pci.h |  18 +++--
>  3 files changed, 152 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> index 5aa97705a669..60e9e45f80b9 100644
> --- a/drivers/pci/cxl.c
> +++ b/drivers/pci/cxl.c
> @@ -389,71 +389,169 @@ static int pci_cxl_restore_state(struct pci_dev *pdev,
>  	return cxl_restore_state(pdev, snapshot);
>  }
>  
> +static int cxl_reset_restore_cache_policy(struct pci_dev *pdev, int dvsec,
> +					  u16 saved_ctrl2);
> +static int cxl_reset_cache_prepare(struct pci_dev *pdev, int dvsec, u16 cap,
> +				   const struct cxl_hdm_info *snapshot,
> +				   struct cxl_pci_cache *cache);
> +
>  /**
> - * pci_cxl_reset_prepare() - allocate HDM state storage ahead of a bus reset
> + * pci_cxl_reset_prepare() - prepare HDM state and caches before a bus reset
>   * @pdev: device about to be reset
> + * @cachep: receives cache state owning the region quiesce on success
>   *
> - * Copy the cached HDM state before the reset, so that restoring cannot fail
> - * for lack of memory. The decoder settings are refreshed when the state is
> - * restored.
> + * Capture HDM state under the region quiesce, reserve its ranges, and complete
> + * host and device cache maintenance. Hold the quiesce through reset and
> + * cxl_restore_state_after_pci_reset(), which consumes *@cachep.
>   *
> - * Return: storage for cxl_restore_state_after_pci_reset(), to be freed with
> - * kfree(); NULL when @pdev has no cached HDM state; or an ERR_PTR() on
> - * failure.
> + * Return: snapshot to be freed with kfree(), NULL when no cached HDM state is
> + * present, or an ERR_PTR() on failure. A cached device without a valid DVSEC
> + * snapshot is rejected because its cache-maintenance scope is unknown.
> + * Only a successful non-NULL snapshot returns with the region quiesce held
> + * and *@cachep set. The caller must pass both to
> + * cxl_restore_state_after_pci_reset() even if reset is never attempted.
> + * The snapshot remains caller-owned. All other returns leave the quiesce
> + * unheld and *@cachep NULL.
>   */
> -struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev)
> +struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev,
> +					struct cxl_pci_cache **cachep)
>  {
>  	struct cxl_hdm_info *snapshot;
> +	struct cxl_pci_cache *cache;
> +	u16 dvsec, cap;
> +	int rc;
>  
>  	device_lock_assert(&pdev->dev);
> -	snapshot = cxl_hdm_cache_snapshot(&pdev->hdm);
> -	if (IS_ERR(snapshot))
> -		return PTR_ERR(snapshot) == -ENXIO ? NULL : snapshot;
> +	*cachep = NULL;
> +	if (!cxl_hdm_cache_present(&pdev->hdm))
> +		return NULL;
>  
> +	rc = cxl_pci_device_dvsec(pdev, &dvsec, &cap);
> +	if (rc == -ENOTTY)
> +		return ERR_PTR(-ENODEV);
> +	if (rc)
> +		return ERR_PTR(rc);
>  	/* Raw reset callers may not have saved the PCI state needed for restore. */
>  	if (!pdev->state_saved) {
>  		pci_err(pdev, "CXL bus reset requires saved PCI state\n");
> -		kfree(snapshot);
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> +	cache = kzalloc_obj(*cache);
> +	if (!cache)
> +		return ERR_PTR(-ENOMEM);
> +	cxl_region_quiesce_lock();
> +	snapshot = cxl_hdm_cache_snapshot(&pdev->hdm);
> +	if (IS_ERR(snapshot)) {
> +		rc = PTR_ERR(snapshot);
> +		goto unlock;
> +	}
> +	if (!snapshot->dvsec_ctrl_valid) {
> +		rc = -ENXIO;
> +		goto free_snapshot;
> +	}
> +	if (cxl_hdm_cache_dvsec_decode(&pdev->hdm) ||
> +	    (snapshot->dvsec_ctrl & PCI_DVSEC_CXL_CACHE_ENABLE &&
> +	     !(cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE))) {
> +		rc = -EOPNOTSUPP;
> +		goto free_snapshot;
> +	}
> +
> +	if (cap & PCI_DVSEC_CXL_CACHE_CAPABLE) {
> +		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2,
> +					  &cache->saved_ctrl2);
> +		if (rc || PCI_POSSIBLE_ERROR(cache->saved_ctrl2)) {
> +			rc = rc ? pcibios_err_to_errno(rc) : -ENODEV;
> +			goto free_snapshot;
> +		}
> +	}
> +
> +	rc = cxl_reset_cache_prepare(pdev, dvsec, cap, snapshot, cache);
> +	if (rc) {
> +		if (cache->cache_disabled)
> +			goto finish;
> +		pci_err(pdev, "failed to prepare CXL bus reset ranges: %d\n", rc);
> +		cxl_hdm_quiesce_destroy(&cache->quiesce);
> +		goto free_snapshot;
> +	}
> +	if (!pci_wait_for_pending_transaction(pdev)) {
> +		rc = -ETIMEDOUT;
> +		goto finish;
> +	}
> +	*cachep = cache;
>  	return snapshot;
> +
> +finish:
> +	rc = cxl_restore_state_after_pci_reset(pdev, snapshot, cache, false, rc);
> +	kfree(snapshot);
> +	return ERR_PTR(rc);
> +free_snapshot:
> +	kfree(snapshot);
> +unlock:
> +	cxl_region_quiesce_unlock();
> +	kfree(cache);
> +	return ERR_PTR(rc);
>  }
>  
>  /**
> - * cxl_restore_state_after_pci_reset() - restore CXL state after a bus reset
> + * cxl_restore_state_after_pci_reset() - finish a prepared reset and release its quiesce
>   * @pdev: device that was reset
>   * @snapshot: storage from pci_cxl_reset_prepare()
> + * @cache: quiesce state from pci_cxl_reset_prepare()
> + * @reset_attempted: reset helper was invoked and may have affected hardware
> + * @rc: preparation or PCI reset result
>   *
> - * Under the region quiesce, refresh the decoder settings in @snapshot from the
> - * cache and restore: first the PCI configuration needed to reach HDM MMIO,
> - * then the HDM decoder and CXL Device DVSEC state. Leave @pdev disabled on
> - * failure.
> + * Restore state through pci_cxl_restore_state(), complete host invalidation,
> + * and restore the cache policy changed by planned-reset preparation. When
> + * @reset_attempted is false, undo preparation without changing the saved PCI
> + * command, unless cleanup itself fails. After an attempted reset, keep caching
> + * and the device disabled if state restoration or host invalidation fails.
> + * A reset-helper error does not prove that hardware was untouched.
> + * Unplanned recovery uses pci_cxl_restore_state() directly and owns its own
> + * quiesce and cache-maintenance sequencing.
>   *
> - * Refresh the decoders now rather than rely on the copy taken before the
> - * reset: a region commit or teardown during the reset has updated the cache,
> - * and restoring older decoders would leave the device decoding ranges the
> - * CXL core considers free.
> + * The quiesce blocks region commit and teardown throughout reset. Complete
> + * host cache invalidation before PCI operation resumes, then release the
> + * quiesce and free @cache on every exit. @snapshot remains caller-owned.
>   */
>  int cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
> -				      struct cxl_hdm_info *snapshot)
> +				      const struct cxl_hdm_info *snapshot,
> +				      struct cxl_pci_cache *cache,
> +				      bool reset_attempted, int rc)
>  {
> -	u16 command;
> -	int rc;
> +	u16 command = 0;
> +	int rc2, policy_rc = 0;
>  
> +	if (!cache)
> +		return rc;
>  	device_lock_assert(&pdev->dev);
> -	cxl_region_quiesce_lock();
> -
> -	rc = cxl_hdm_cache_copy_decoders(&pdev->hdm, snapshot);
> -	if (!rc) {
> +	if (reset_attempted && !rc)
>  		rc = pci_cxl_restore_state(pdev, snapshot, &command);
> +
> +	/* Complete host invalidation before ending IOMMU exclusion. */
> +	rc2 = cxl_hdm_quiesce_flush(&cache->quiesce);
> +	if (rc2)
> +		pci_err(pdev, "failed to invalidate CPU cache after CXL bus reset: %d\n", rc2);
> +	/* Undo preparation on abort; enable caching after reset only if safe. */
> +	if (cache->cache_disabled && (!reset_attempted || (!rc && !rc2)))
> +		policy_rc = cxl_reset_restore_cache_policy(pdev, snapshot->dvsec,
> +							  cache->saved_ctrl2);
> +	if (reset_attempted) {
> +		rc = rc ?: rc2 ?: policy_rc;
> +		if (rc)
> +			cxl_reset_save_disabled_state(pdev);
> +		else
> +			rc = cxl_reset_save_restored_state(pdev, command);
> +	} else {
> +		/* An aborted reset alone must not poison the saved PCI command. */
> +		if (rc2 || policy_rc)
> +			cxl_reset_save_disabled_state(pdev);
> +		rc = rc ?: rc2 ?: policy_rc;
>  	}
> -	if (rc)
> -		cxl_reset_save_disabled_state(pdev);
> -	else
> -		rc = cxl_reset_save_restored_state(pdev, command);
>  
> +	cxl_hdm_quiesce_destroy(&cache->quiesce);
>  	cxl_region_quiesce_unlock();
> +	kfree(cache);
>  	return rc;
>  }
>  
> @@ -573,7 +671,7 @@ static int cxl_reset_cache_prepare(struct pci_dev *pdev, int dvsec, u16 cap,
>  	int rc;
>  
>  	rc = cxl_hdm_quiesce_prepare(&cache->quiesce, snapshot);
> -	if (rc)
> +	if (rc || !(cap & PCI_DVSEC_CXL_CACHE_CAPABLE))
>  		return rc;
>  
>  	/* Track an attempted change so partial failures still restore policy. */
> @@ -710,7 +808,9 @@ static int cxl_reset_quiesced(struct pci_dev *pdev, int dvsec, u16 cap)
>  		rc = __cxl_reset_execute(pdev, dvsec, cap, snapshot, &cache.quiesce,
>  					 &command);
>  	/* Restore cache policy after any attempt to disable caching. */
> -	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, cache.saved_ctrl2);
> +	rc2 = 0;
> +	if (cache.cache_disabled)
> +		rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, cache.saved_ctrl2);
>  	cxl_hdm_quiesce_destroy(&cache.quiesce);
>  	if (rc)
>  		return rc;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 22f740417673..351a0f0500c1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5015,6 +5015,7 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>  static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  {
>  	struct cxl_hdm_info *snapshot __free(kfree) = NULL;
> +	struct cxl_pci_cache *cache;
>  	struct pci_dev *bridge;
>  	u16 dvsec, reg, val;
>  	int rc;
> @@ -5037,14 +5038,14 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  	if (rc)
>  		return -ENOTTY;
>  
> -	snapshot = pci_cxl_reset_prepare(dev);
> +	snapshot = pci_cxl_reset_prepare(dev, &cache);
>  	if (IS_ERR(snapshot))
>  		return PTR_ERR(snapshot);
>  
>  	rc = pci_dev_reset_iommu_prepare(dev);
>  	if (rc) {
>  		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", rc);
> -		return rc;
> +		return cxl_restore_state_after_pci_reset(dev, snapshot, cache, false, rc);
>  	}
>  
>  	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR) {
> @@ -5061,8 +5062,8 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
>  				      reg);
>  
> -	if (!rc && snapshot)
> -		rc = cxl_restore_state_after_pci_reset(dev, snapshot);
> +	/* Reset-helper failure does not prove that no hardware reset occurred. */
> +	rc = cxl_restore_state_after_pci_reset(dev, snapshot, cache, true, rc);
>  
>  	pci_dev_reset_iommu_done(dev);
>  	return rc;
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 476e8eefafb2..f0ebfd408f8b 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -731,13 +731,17 @@ static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
>  #endif
>  
>  struct cxl_hdm_info;
> +struct cxl_pci_cache;
>  #ifdef CONFIG_CXL_RESET
>  void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
>  void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
>  int cxl_reset_function(struct pci_dev *pdev, bool probe);
> -struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev);
> +struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev,
> +					struct cxl_pci_cache **cachep);
>  int cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
> -				      struct cxl_hdm_info *snapshot);
> +				      const struct cxl_hdm_info *snapshot,
> +				      struct cxl_pci_cache *cache,
> +				      bool reset_attempted, int rc);
>  #else
>  static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev) { }
>  static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev) { }
> @@ -746,16 +750,20 @@ static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  	return -ENOTTY;
>  }
>  
> -static inline struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev)
> +static inline struct cxl_hdm_info *
> +pci_cxl_reset_prepare(struct pci_dev *pdev, struct cxl_pci_cache **cachep)
>  {
> +	*cachep = NULL;
>  	return NULL;
>  }
>  
>  static inline int
>  cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
> -				  struct cxl_hdm_info *snapshot)
> +				  const struct cxl_hdm_info *snapshot,
> +				  struct cxl_pci_cache *cache,
> +				  bool reset_attempted, int rc)
>  {
> -	return 0;
> +	return rc;
>  }
>  #endif
>  

