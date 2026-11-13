Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591480;
	b=29FGiSj7T0n5I/Xaf/bDi1zmx8rBqKf42dS2q5KAZgL2RtuRZaDXWnXkxpGWIEYIt4q+
	 /RtSDZHjIojYvdZDDSobUPpcP9IJH23tF0TUMU+YPnwqTqjURLktnETusBBHjQ55f1X7B
	 GPGiAVX9cYPD3fZoWnPnjrzrhUBfSx41cshZFOzY/ZMnxWYozjlOih8c5pdBBekzIjh1t
	 euhgjeP5ExYoENCrLX6eEM9hWjGFXA4rDj9d8tR+Z8yfKPD+QjxOftO84RYwi8n0bbVP0
	 l391PNdF9AEVF9y9AHXMfMlhOFLkeqWqK4K5T7jcxkMvrm48oSkZbH/x5aBmbV/yKdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591480;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ZKXGnrW3aWfsUdx2w/eX9rDnT5l6t0l9BEQYAFEJBiE=;
	b=TptcGG+WOu8IO9OMCiujyadJRY3//JHTLsCFw4i8Wz1IbmKzr6E2GGa0vDvWw/u6S2jk
	 zje8v6rHhcqlAIlMrYIA8rVzNc1nxqcohOw2CIfuj9OS3wislspAzj0kwufFdKbiV6UXw
	 M9QLAluoo9/U5je6dyIer10BJL/mCKiGaawop5mSY9+esu5/vDp7n1dmh8Qb+n95v1ZrF
	 Kko1ij2FA9Ydn/Vd2tlzs7QTxcGxi4TvpIidCIzuoBFlfR9KozqnbzPNj9dpEz0uEbxUo
	 jdCep03zDyRaRdcizLiDYysroxMvGXWBCApzCESFXYDb3U26adlfs5Z99RRg4ODDnHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="iz+fI/ox";
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19293607D2E5;
	Fri, 13 Nov 2026 17:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19293607D2E5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iz+fI/ox
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794591480; x=1826127480;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/8MOizMtEu6uZNHrFzA1rjLrkjmkNJIiQtwChz4Oly4=;
  b=iz+fI/oxP/lsE6XmNLoHWBFnpfhARvFGpzAMEhgb1sDanQBYRlEwdZjc
   MYpRFh9OwJgs2BeL3UL508d60sx7W3CfWfQwfp8YWWyac67JWt0ZlFscm
   HJqO4z//gkWwTc63Ffm+5VUtlPhK243WKXgMnV4NgVoFu8LSBcOr/N8rV
   EFc5hallvCz/q+W6h3k9lnhoGMihVsS4wQqmG1YGlO0LVQeDdkaN+B85f
   t0deKqrrt3YvWds5yh/MERbkoHD51kyi+o1xzSHKvCpEj8n8y/YvYLnfI
   ufOGMcoP06R7+oYXYMQXeyFe/4MOmD5fPxmxOOWN1HFXPrFnPhbvL03fO
   g==;
X-CSE-ConnectionGUID: IGTM4LaDQsW8W/LSYiQKFA==
X-CSE-MsgGUID: uoE2MDo1TcSaI5KgLrzDNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3291774"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3291774"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 09:37:59 -0800
X-CSE-ConnectionGUID: z/CZKOFYT3qUB03JF/aT+A==
X-CSE-MsgGUID: nEs/tNrkTb28yxMcVCWdOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="10693270"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.108.6]) ([10.125.108.6])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 09:37:57 -0800
Message-ID: <937131df-ac6e-4503-b495-27664a9421de@intel.com>
Date: Fri, 13 Nov 2026 10:37:56 -0700
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
Subject: Re: [PATCH v17 17/19] PCI/CXL: Restore CXL state after CXL bus reset
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
 <20261105185917.2667656-18-smadhavan@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261105185917.2667656-18-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/5/26 11:59 AM, Srirangan Madhavan wrote:
> CXL bus reset can clear HDM decoder programming and CXL Device DVSEC
> control state. Restore the cached state after a successful cxl_bus reset
> while IOMMU exclusion remains active.
> 
> Restore PCI configuration first so HDM MMIO is accessible, and preserve a
> disabled state if restoration fails.
> 
> Copy the cached state before the reset, then refresh its decoder settings
> from the cache under the CXL region quiesce once the reset completes. A
> region decommit during the reset updates the cache, and restoring the
> earlier decoders would leave the endpoint decoding an HPA range that the
> CXL core considers free. Keep global and DVSEC control from before the
> reset, since a refresh during the reset can read them as all-ones.
> 
> The prepare/restore interface and decoder-refresh structure follow Dave
> Jiang's cxl-type2-reset reference branch.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com> # pci/pci.c
> Assisted-by: LLM
> 
> ---
> Changes in v17:
> - Enable bus mastering only after the IOMMU is restored, via a separate
>   cxl_restore_command_after_pci_reset() step (Richard)
>   https://lore.kernel.org/linux-cxl/auRhJa-nzR0CnKf3@MWDK4CY14F/
> 
> Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=b93f0c8e67b198a63786fd3721b7177ab9df60be
> ---
>  drivers/cxl/core/hdm_state.c | 31 +++++++++++++
>  drivers/pci/cxl.c            | 85 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.c            | 14 ++++++
>  drivers/pci/pci.h            | 24 ++++++++++
>  include/cxl/hdm.h            |  2 +
>  5 files changed, 156 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
> index 51df56377f7a..7e0903ce0b78 100644
> --- a/drivers/cxl/core/hdm_state.c
> +++ b/drivers/cxl/core/hdm_state.c
> @@ -182,6 +182,37 @@ struct cxl_hdm_info *cxl_hdm_cache_snapshot(struct cxl_hdm_info *const *slot)
>  	return copy;
>  }
>  
> +/**
> + * cxl_hdm_cache_copy_decoders() - refresh the decoders of a snapshot
> + * @slot: cache pointer owned by the device
> + * @dst: snapshot of the same device from cxl_hdm_cache_snapshot()
> + *
> + * Copy only the per-decoder settings, which region commit and teardown keep
> + * current. Leave the rest of @dst, including global and DVSEC control, as
> + * captured: a refresh during a reset may have read those registers from a
> + * device that returned all-ones.
> + *
> + * Return: 0 on success, -ENXIO when nothing is published, or -EINVAL when
> + * @dst holds a different number of decoders.
> + */
> +int cxl_hdm_cache_copy_decoders(struct cxl_hdm_info *const *slot,
> +				struct cxl_hdm_info *dst)

I think this function is a dead function for the series. By the end, nothing calls it.

DJ

> +{
> +	struct cxl_hdm_info *info;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	info = *slot;
> +	if (!info)
> +		return -ENXIO;
> +	if (info->decoder_count != dst->decoder_count)
> +		return -EINVAL;
> +
> +	memcpy(dst->settings, info->settings,
> +	       flex_array_size(info, settings, info->decoder_count));
> +	return 0;
> +}
> +
>  void cxl_region_quiesce_lock(void)
>  	__acquires(cxl_region_quiesce)
>  	__context_unsafe(token maps to cxl_rwsem.region)
> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> index c68b08f7f95b..a9aa2e1c631d 100644
> --- a/drivers/pci/cxl.c
> +++ b/drivers/pci/cxl.c
> @@ -393,6 +393,91 @@ static int pci_cxl_restore_state(struct pci_dev *pdev,
>  	return cxl_restore_state(pdev, snapshot);
>  }
>  
> +/**
> + * pci_cxl_reset_prepare() - allocate HDM state storage ahead of a bus reset
> + * @pdev: device about to be reset
> + *
> + * Copy the cached HDM state before the reset, so that restoring cannot fail
> + * for lack of memory. The decoder settings are refreshed when the state is
> + * restored.
> + *
> + * Return: storage for cxl_restore_state_after_pci_reset(), to be freed with
> + * kfree(); NULL when @pdev has no cached HDM state; or an ERR_PTR() on
> + * failure.
> + */
> +struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_info *snapshot;
> +
> +	device_lock_assert(&pdev->dev);
> +	snapshot = cxl_hdm_cache_snapshot(&pdev->hdm);
> +	if (IS_ERR(snapshot))
> +		return PTR_ERR(snapshot) == -ENXIO ? NULL : snapshot;
> +
> +	/* Raw reset callers may not have saved the PCI state needed for restore. */
> +	if (!pdev->state_saved) {
> +		pci_err(pdev, "CXL bus reset requires saved PCI state\n");
> +		kfree(snapshot);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	return snapshot;
> +}
> +
> +/**
> + * cxl_restore_state_after_pci_reset() - restore CXL state after a bus reset
> + * @pdev: device that was reset
> + * @snapshot: storage from pci_cxl_reset_prepare()
> + * @command: returns the saved PCI_COMMAND value to apply once the IOMMU is
> + *	     restored
> + *
> + * Under the region quiesce, refresh the decoder settings in @snapshot from the
> + * cache and restore: first the PCI configuration needed to reach HDM MMIO,
> + * then the HDM decoder and CXL Device DVSEC state. Leave @pdev disabled on
> + * failure.
> + *
> + * Bus mastering stays off, because the caller has not yet restored IOMMU
> + * translation and a DMA request now would hit the blocking domain. The caller
> + * calls cxl_restore_command_after_pci_reset() once the IOMMU is restored.
> + *
> + * Refresh the decoders now rather than rely on the copy taken before the
> + * reset: a region commit or teardown during the reset has updated the cache,
> + * and restoring older decoders would leave the device decoding ranges the
> + * CXL core considers free.
> + */
> +int cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
> +				      struct cxl_hdm_info *snapshot,
> +				      u16 *command)
> +{
> +	int rc;
> +
> +	device_lock_assert(&pdev->dev);
> +	cxl_region_quiesce_lock();
> +
> +	rc = cxl_hdm_cache_copy_decoders(&pdev->hdm, snapshot);
> +	if (!rc)
> +		rc = pci_cxl_restore_state(pdev, snapshot, command);
> +	if (rc)
> +		cxl_reset_save_disabled_state(pdev);
> +
> +	cxl_region_quiesce_unlock();
> +	return rc;
> +}
> +
> +/**
> + * cxl_restore_command_after_pci_reset() - re-enable the device after a bus reset
> + * @pdev: device that was reset
> + * @command: PCI_COMMAND value from cxl_restore_state_after_pci_reset()
> + *
> + * Call after the IOMMU is restored: this can enable bus mastering. Save the
> + * restored PCI state, and leave @pdev disabled on failure.
> + */
> +int cxl_restore_command_after_pci_reset(struct pci_dev *pdev, u16 command)
> +{
> +	device_lock_assert(&pdev->dev);
> +	return cxl_reset_save_restored_state(pdev, command);
> +}
> +
>  /*
>   * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
>   * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 426b5ee38d04..1d4ba90a6976 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5014,8 +5014,10 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>  
>  static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  {
> +	struct cxl_hdm_info *snapshot __free(kfree) = NULL;
>  	struct pci_dev *bridge;
>  	u16 dvsec, reg, val;
> +	u16 command;
>  	int rc;
>  
>  	/*
> @@ -5040,6 +5042,10 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  	if (rc)
>  		return -ENOTTY;
>  
> +	snapshot = pci_cxl_reset_prepare(dev);
> +	if (IS_ERR(snapshot))
> +		return PTR_ERR(snapshot);
> +
>  	rc = pci_dev_reset_iommu_prepare(dev);
>  	if (rc) {
>  		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", rc);
> @@ -5060,7 +5066,15 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
>  				      reg);
>  
> +	if (!rc && snapshot)
> +		rc = cxl_restore_state_after_pci_reset(dev, snapshot, &command);
> +
>  	pci_dev_reset_iommu_done(dev);
> +
> +	/* Enable bus mastering only once the IOMMU translates again. */
> +	if (!rc && snapshot)
> +		rc = cxl_restore_command_after_pci_reset(dev, command);
> +
>  	return rc;
>  }
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 743e65abd758..2f819e1fbead 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -730,10 +730,16 @@ static inline void pci_doe_destroy(struct pci_dev *pdev) { }
>  static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
>  #endif
>  
> +struct cxl_hdm_info;
>  #ifdef CONFIG_CXL_RESET
>  void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
>  void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
>  int cxl_reset_function(struct pci_dev *pdev, bool probe);
> +struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev);
> +int cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
> +				      struct cxl_hdm_info *snapshot,
> +				      u16 *command);
> +int cxl_restore_command_after_pci_reset(struct pci_dev *pdev, u16 command);
>  #else
>  static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev) { }
>  static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev) { }
> @@ -741,6 +747,24 @@ static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  {
>  	return -ENOTTY;
>  }
> +
> +static inline struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev)
> +{
> +	return NULL;
> +}
> +
> +static inline int
> +cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
> +				  struct cxl_hdm_info *snapshot, u16 *command)
> +{
> +	return 0;
> +}
> +
> +static inline int cxl_restore_command_after_pci_reset(struct pci_dev *pdev,
> +						      u16 command)
> +{
> +	return 0;
> +}
>  #endif
>  
>  #ifdef CONFIG_PCI_NPEM
> diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
> index 94a8f8a1a65a..81767f21052a 100644
> --- a/include/cxl/hdm.h
> +++ b/include/cxl/hdm.h
> @@ -64,6 +64,8 @@ void cxl_hdm_cache_set_normalized(struct pci_dev *pdev, int id);
>  void cxl_hdm_cache_release(struct cxl_hdm_info **slot);
>  bool cxl_hdm_cache_dvsec_decode(struct cxl_hdm_info *const *slot);
>  struct cxl_hdm_info *cxl_hdm_cache_snapshot(struct cxl_hdm_info *const *slot);
> +int cxl_hdm_cache_copy_decoders(struct cxl_hdm_info *const *slot,
> +				struct cxl_hdm_info *dst);
>  
>  /*
>   * Region quiesce blocks CXL region commit and teardown, and with them decoder

