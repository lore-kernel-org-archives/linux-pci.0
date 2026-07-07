Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DCA3D8121;
	Tue,  7 Jul 2026 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783463440; cv=none; b=Mn6uN88IlWXo4jGW8QSj7iWbMLIbAJkXRmJvtTtO/hvVMIFq+Jej9P4SR/ksBQksysI4LU4BkB9KOuRon5g2MyaueMce1p2Or7lfyNI7z4ggZGVaJXCxeMbUyCRqEjCZopIrM4E2DT14XsnbOxNsGfYl9MaZ0MJIrVL9mqlSF5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783463440; c=relaxed/simple;
	bh=ctIp7nal3+LWwg7TTItYzHxv6pa3ryvJOE980Ejradw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eC8+fTRK0tlhS0Fg6JWbsFIBaNxwsWktoB5TGBtcaxLnEnLbylrvW4pY05/gO8hiKKiV29C2W4KGgv9U76vk4D4lwIlVCNdwkZMT97LjtH594IkHxkNZXoP+848977XCJgWG6gM/2GJtnrBGopotrubHOkdbMY4E/k6SRRa/SeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ClSXTrFB; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ClSXTrFB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783463437; x=1814999437;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ctIp7nal3+LWwg7TTItYzHxv6pa3ryvJOE980Ejradw=;
  b=ClSXTrFBr98mVE5co3nPZmxxuri/yaznwIPASB4taEox99f43851IsZb
   vf4pwbeQtcAR49AAVa44Fk+2STB1kJhsRqQOd9z43Bc2SwkNF1QgfycS7
   wrQyxO+gM4Cretb/gj/VQ/rtyMZIEhjiWzfaQPg9isMr+T1JAeslYogH0
   TfVKPpWnjHVNAv7qRXhMdY/o3VBgV1tyLKCMb2Ss/ybh57pHPQjte4Hcy
   ofg1AWjsceEWd/th1BGK3orYnZ88NdwFP1mHY5A6ODXfZHhnpcw5rrf9y
   Qjb5h4jJb02zbTTDS//xnpqDIOCo+QvoVqHMrIkbxs4zdmmkXaK3xtIbt
   g==;
X-CSE-ConnectionGUID: Jf9maOUpTWKMA+BfU6upFg==
X-CSE-MsgGUID: YOZrlH1OS4CSDjgUYiqsJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="87943703"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="87943703"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 15:30:36 -0700
X-CSE-ConnectionGUID: pss9qukjSMemsjTw4AdnSA==
X-CSE-MsgGUID: 1oDP9+hvTX66VzZsWczwwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="277321109"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.111.8]) ([10.125.111.8])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 15:30:35 -0700
Message-ID: <5b8a5abf-e63b-43ee-afec-c8cb7a616d03@intel.com>
Date: Tue, 7 Jul 2026 15:30:33 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/10] cxl: Restore CXL HDM state after PCI reset
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com, Dan Williams <danwilliams@nvidia.com>,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260703220508.546528-1-smadhavan@nvidia.com>
 <20260703220508.546528-9-smadhavan@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260703220508.546528-9-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/3/26 3:05 PM, Srirangan Madhavan wrote:
> After CXL reset, restore PCI config state enough to reach HDM MMIO,
> restore cached global and per-decoder HDM state, and then run the normal
> PCI restore callbacks.
> 
> Keep the target IOMMU reset block active until HDM restore completes so
> Bus Master Enable cannot reopen DMA before decoder state is valid.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/hdm.c   |   4 +
>  drivers/cxl/core/reset.c | 320 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 310 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7a1ade846c9c..96f0de889073 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -137,6 +137,10 @@ static void cxl_hdm_info_set_decoder(struct cxl_hdm *cxlhdm,
>  	if (!info || cxld->id >= info->decoder_count)
>  		return;
>  
> +	if (cxlhdm->regs.hdm_decoder)
> +		info->global_ctrl = readl(cxlhdm->regs.hdm_decoder +
> +					  CXL_HDM_DECODER_CTRL_OFFSET);
> +
>  	if (cxld->flags & CXL_DECODER_F_ENABLE)
>  		info->settings[cxld->id] = cxld->settings;
>  	else
> diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
> index 8e80e7588046..cfb9b5101c28 100644
> --- a/drivers/cxl/core/reset.c
> +++ b/drivers/cxl/core/reset.c
> @@ -83,6 +83,21 @@ static int cxld_await_commit(void __iomem *hdm, int id)
>  	return -ETIMEDOUT;
>  }
>  
> +static int cxld_await_uncommit(void __iomem *hdm, int id)
> +{
> +	u32 ctrl;
> +	int i;
> +
> +	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
> +		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +		if (!FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> +			return 0;
> +		fsleep(1000);
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
>  static void setup_hw_decoder(struct cxl_decoder_settings *settings,
>  			     void __iomem *hdm)
>  {
> @@ -92,6 +107,8 @@ static void setup_hw_decoder(struct cxl_decoder_settings *settings,
>  	u32 ctrl;
>  
>  	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	ctrl &= ~(CXL_HDM_DECODER0_CTRL_COMMIT |
> +		  CXL_HDM_DECODER0_CTRL_COMMIT_ERROR);
>  	cxld_set_interleave(settings, &ctrl);
>  	cxld_set_type(settings, &ctrl);
>  	base = settings->hpa_range.start;
> @@ -249,6 +266,31 @@ static void __iomem *cxl_pci_hdm_map(struct pci_dev *pdev,
>  	return hdm;
>  }
>  
> +static void __iomem *cxl_pci_hdm_ioremap_current(struct pci_dev *pdev,
> +						 int bar,
> +						 resource_size_t offset,
> +						 resource_size_t size)
> +{
> +	resource_size_t hdm_start, bar_len;
> +	void __iomem *hdm;
> +
> +	if (bar < 0 || bar >= PCI_STD_NUM_BARS || !size)
> +		return ERR_PTR(-EINVAL);
> +
> +	bar_len = pci_resource_len(pdev, bar);
> +	if (!bar_len || offset > bar_len || size > bar_len - offset)
> +		return ERR_PTR(-ENODEV);
> +
> +	hdm_start = pci_resource_start(pdev, bar) + offset;
> +	hdm = ioremap(hdm_start, size);
> +	if (!hdm) {
> +		pci_err(pdev, "failed to remap CXL HDM decoder registers\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	return hdm;
> +}
> +
>  static void cxl_pci_hdm_read_decoder_state(struct cxl_hdm_decoder_state *state,
>  					   void __iomem *hdm, int id)
>  {
> @@ -261,6 +303,40 @@ static void cxl_pci_hdm_read_decoder_state(struct cxl_hdm_decoder_state *state,
>  	state->target_high = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(id));
>  }
>  
> +static int cxl_hdm_enable_mem(struct pci_dev *pdev, u16 *command,
> +			      bool *restore_command)
> +{
> +	int rc;
> +
> +	*restore_command = false;
> +
> +	rc = pci_read_config_word(pdev, PCI_COMMAND, command);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	if (*command & PCI_COMMAND_MEMORY)
> +		return 0;
> +
> +	rc = pci_write_config_word(pdev, PCI_COMMAND,
> +				   *command | PCI_COMMAND_MEMORY);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	*restore_command = true;
> +	return 0;
> +}
> +
> +static int cxl_hdm_restore_command(struct pci_dev *pdev, u16 command)
> +{
> +	int rc;
> +
> +	rc = pci_write_config_word(pdev, PCI_COMMAND, command);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	return 0;
> +}
> +
>  static int cxl_pci_hdm_read_decoder(struct pci_dev *pdev,
>  				    struct cxl_hdm_decoder_state *state,
>  				    struct cxl_decoder_settings *settings,
> @@ -455,6 +531,164 @@ void pci_cxl_hdm_init(struct pci_dev *pdev)
>  		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
>  }
>  
> +static int cxl_hdm_decoder_uncommit(struct pci_dev *pdev, void __iomem *hdm,
> +				    int id, bool *locked_committed)
> +{
> +	u32 ctrl;
> +	int rc;
> +
> +	*locked_committed = false;
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK) {
> +		if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED) {
> +			pci_dbg(pdev,
> +				"CXL HDM decoder %d retained locked committed state\n",
> +				id);
> +			*locked_committed = true;
> +			return 0;
> +		}
> +
> +		pci_err(pdev, "CXL HDM decoder %d is locked\n", id);
> +		return -EBUSY;

Isn't return value of -EBUSY sufficient rather than also needing locked_committed writeback parameter?

> +	}
> +
> +	if (!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
> +		return 0;
> +
> +	ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +
> +	rc = cxld_await_uncommit(hdm, id);
> +	if (rc)
> +		pci_err(pdev, "CXL HDM decoder %d uncommit failed: %d\n",
> +			id, rc);
> +
> +	return rc;
> +}
> +
> +static void cxl_restore_hdm_decoder_state(struct cxl_hdm_decoder_state *state,
> +					  void __iomem *hdm, int id)
> +{
> +	u32 ctrl = state->ctrl;
> +
> +	ctrl &= ~(CXL_HDM_DECODER0_CTRL_COMMIT |
> +		  CXL_HDM_DECODER0_CTRL_COMMITTED |
> +		  CXL_HDM_DECODER0_CTRL_COMMIT_ERROR);
> +
> +	writel(state->base_high, hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> +	writel(state->base_low, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	writel(state->size_high, hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> +	writel(state->size_low, hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	writel(state->target_high, hdm + CXL_HDM_DECODER0_TL_HIGH(id));
> +	writel(state->target_low, hdm + CXL_HDM_DECODER0_TL_LOW(id));
> +	/* Ensure raw decoder fields are visible before restoring control. */
> +	wmb();

Not needed for writel() calls on the same device. See Documentation/memory-barriers.txt:2568


> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +}
> +
> +static int cxl_restore_hdm_decoder(struct pci_dev *pdev,
> +				   struct cxl_hdm_decoder_state *state,
> +				   struct cxl_decoder_settings *settings,
> +				   void __iomem *hdm)
> +{
> +	bool locked_committed;
> +	int rc;
> +
> +	rc = cxl_hdm_decoder_uncommit(pdev, hdm, settings->id,
> +				      &locked_committed);
> +	if (rc)
> +		return rc;
> +	if (locked_committed)
> +		return 0;
> +
> +	cxl_restore_hdm_decoder_state(state, hdm, settings->id);
> +
> +	if (!(settings->flags & CXL_DECODER_F_ENABLE))
> +		return 0;
> +
> +	rc = cxl_commit(settings, hdm);
> +	if (rc)
> +		pci_err(pdev, "CXL HDM decoder %d restore failed: %d\n",
> +			settings->id, rc);
> +
> +	return rc;
> +}
> +
> +static int cxl_restore_hdm(struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_decoder_state *decoder_state __free(kfree) = NULL;
> +	struct cxl_decoder_settings *settings __free(kfree) = NULL;
> +	struct cxl_hdm_info *info;
> +	resource_size_t hdm_offset;
> +	resource_size_t hdm_size;
> +	void __iomem *hdm;
> +	int decoder_count;
> +	int first_rc = 0;
> +	u32 global_ctrl;
> +	bool restore_command = false;
> +	u16 command;
> +	int hdm_bar;
> +	int rc;
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
> +		info = pdev->hdm;
> +		if (!info)
> +			return 0;
> +
> +		decoder_count = info->decoder_count;
> +		hdm_bar = info->hdm_bar;
> +		hdm_offset = info->hdm_offset;
> +		hdm_size = info->hdm_size;
> +		global_ctrl = info->global_ctrl;
> +		settings = kmemdup_array(info->settings, decoder_count,
> +					 sizeof(*settings), GFP_KERNEL);
> +		if (!settings)
> +			return -ENOMEM;
> +		decoder_state = kmemdup_array(info->decoder_state,
> +					      decoder_count,
> +					      sizeof(*decoder_state),
> +					      GFP_KERNEL);
> +		if (!decoder_state)
> +			return -ENOMEM;
> +	}
> +
> +	rc = cxl_hdm_enable_mem(pdev, &command, &restore_command);
> +	if (rc)
> +		return rc;
> +
> +	hdm = cxl_pci_hdm_ioremap_current(pdev, hdm_bar, hdm_offset, hdm_size);
> +	if (IS_ERR(hdm)) {
> +		first_rc = PTR_ERR(hdm);
> +		goto out_restore_command;
> +	}
> +
> +	/*
> +	 * Restore global HDM control before per-decoder commit. PCI config
> +	 * memory decoding is enabled for MMIO access, but IOMMU reset blocks
> +	 * remain active until HDM restore completes.
> +	 */
> +	writel(global_ctrl, hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +
> +	for (int i = 0; i < decoder_count; i++) {
> +		int rc;
> +
> +		rc = cxl_restore_hdm_decoder(pdev, &decoder_state[i],
> +					     &settings[i], hdm);
> +		if (rc && !first_rc)
> +			first_rc = rc;
> +	}
> +
> +	iounmap(hdm);
> +out_restore_command:
> +	if (restore_command) {
> +		rc = cxl_hdm_restore_command(pdev, command);
> +		if (rc && !first_rc)
> +			first_rc = rc;
> +	}
> +
> +	return first_rc;
> +}

Is this a cleaner version?

static struct cxl_hdm_info *cxl_snapshot_hdm(struct pci_dev *pdev)
{
	guard(rwsem_read)(&cxl_rwsem.dpa);

	struct cxl_hdm_info *info = pdev->hdm;

	if (!info)
		return NULL;

	size_t state_sz = array_size(info->decoder_count,
				     sizeof(*info->decoder_state));
	struct cxl_hdm_info *snap __free(kfree) =
		kzalloc(size_add(sizeof(*info), state_sz), GFP_KERNEL);
	if (!snap)
		return ERR_PTR(-ENOMEM);

	*snap = *info;
	snap->decoder_state = (void *)(snap + 1);
	memcpy(snap->decoder_state, info->decoder_state, state_sz);

	return_ptr(snap);
}

static int cxl_restore_hdm(struct pci_dev *pdev)
{
	bool restore_command = false;
	void __iomem *hdm;
	int first_rc = 0;
	u16 command;
	int rc;

	struct cxl_hdm_info *snap __free(kfree) = cxl_snapshot_hdm(pdev);
	if (!snap)
		return 0;
	if (IS_ERR(snap))
		return PTR_ERR(snap);

	rc = cxl_hdm_enable_mem(pdev, &command, &restore_command);
	if (rc)
		return rc;

	hdm = cxl_pci_hdm_ioremap_current(pdev, snap->hdm_bar, snap->hdm_offset,
					  snap->hdm_size);
	if (IS_ERR(hdm)) {
		first_rc = PTR_ERR(hdm);
	} else {
		/*
		 * Restore global HDM control before per-decoder commit. PCI
		 * config memory decoding is enabled for MMIO access, but IOMMU
		 * reset blocks remain active until HDM restore completes.
		 */
		writel(snap->global_ctrl, hdm + CXL_HDM_DECODER_CTRL_OFFSET);

		for (int i = 0; i < snap->decoder_count; i++) {
			rc = cxl_restore_hdm_decoder(pdev, &snap->decoder_state[i],
						     &snap->settings[i], hdm);
			if (rc && !first_rc)
				first_rc = rc;
		}

		iounmap(hdm);
	}

	if (restore_command) {
		rc = cxl_hdm_restore_command(pdev, command);
		if (rc && !first_rc)
			first_rc = rc;
	}

	return first_rc;
}

DJ

> +
>  /*
>   * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
>   * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
> @@ -476,6 +710,7 @@ static const u32 cxl_reset_timeout_ms[] = {
>  
>  struct cxl_reset_context {
>  	struct pci_dev *target;
> +	bool target_prepared;
>  };
>  
>  struct cxl_reset_walk_context {
> @@ -627,6 +862,38 @@ static int cxl_reset_validate_function_scoped(struct cxl_reset_context *ctx)
>  	return wctx.rc;
>  }
>  
> +static void cxl_pci_target_reset_done(struct cxl_reset_context *ctx)
> +{
> +	if (!ctx->target_prepared)
> +		return;
> +
> +	pci_dev_reset_iommu_done(ctx->target);
> +	ctx->target_prepared = false;
> +}
> +
> +static int cxl_pci_target_reset_prepare(struct cxl_reset_context *ctx)
> +{
> +	struct pci_dev *pdev = ctx->target;
> +	int rc;
> +
> +	if (!pci_wait_for_pending_transaction(pdev))
> +		pci_err(pdev, "timed out waiting for pending transactions\n");
> +
> +	rc = pci_dev_reset_iommu_prepare(pdev);
> +	if (rc) {
> +		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
> +		return rc;
> +	}
> +
> +	ctx->target_prepared = true;
> +	return 0;
> +}
> +
> +static int cxl_restore_hdm_decoders(struct cxl_reset_context *ctx)
> +{
> +	return cxl_restore_hdm(ctx->target);
> +}
> +
>  static void cxl_hdm_range_context_init(struct cxl_hdm_range_context *ctx)
>  {
>  	INIT_LIST_HEAD(&ctx->ranges);
> @@ -672,9 +939,11 @@ static int cxl_hdm_range_add(struct cxl_hdm_range_context *ctx,
>  static int cxl_hdm_ranges_collect(struct cxl_hdm_range_context *ctx,
>  				  struct pci_dev *pdev)
>  {
> -	struct cxl_hdm_info *info = READ_ONCE(pdev->hdm);
> +	struct cxl_hdm_info *info;
>  	int rc;
>  
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	info = pdev->hdm;
>  	if (!info) {
>  		pci_err(pdev, "CXL HDM decoder state unavailable\n");
>  		return -ENXIO;
> @@ -824,8 +1093,9 @@ static int cxl_hdm_ranges_flush_cpu_caches(struct cxl_hdm_range_context *ctx,
>  }
>  
>  static int cxl_hdm_ranges_prepare(struct cxl_hdm_range_context *ctx,
> -				  struct pci_dev *pdev)
> +				  struct cxl_reset_context *reset_ctx)
>  {
> +	struct pci_dev *pdev = reset_ctx->target;
>  	int rc;
>  
>  	lockdep_assert_held_write(&cxl_rwsem.region);
> @@ -866,6 +1136,25 @@ static int cxl_reset_dvsec(struct pci_dev *pdev)
>  	return dvsec;
>  }
>  
> +static bool cxl_reset_hdm_available(struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_info *info;
> +
> +	/*
> +	 * pdev->hdm is owned by the PCI device and released with pci_dev, so
> +	 * reset-method probes and reset requests can test availability without
> +	 * a CXL driver bound to the device.
> +	 */
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	info = pdev->hdm;
> +	return info && info->hdm_size;
> +}
> +
> +static bool cxl_reset_scope_hdm_available(struct cxl_reset_context *ctx)
> +{
> +	return cxl_reset_hdm_available(ctx->target);
> +}
> +
>  static int cxl_reset_update_ctrl2(struct pci_dev *pdev, int dvsec, u16 set,
>  				  u16 clear)
>  {
> @@ -995,18 +1284,9 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec)
>  	if (rc)
>  		return pcibios_err_to_errno(rc);
>  
> -	if (!pci_wait_for_pending_transaction(pdev))
> -		pci_err(pdev, "timed out waiting for pending transactions\n");
> -
> -	rc = pci_dev_reset_iommu_prepare(pdev);
> -	if (rc) {
> -		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
> -		return rc;
> -	}
> -
>  	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
>  	if (rc)
> -		goto out;
> +		return rc;
>  	cache_disabled = true;
>  
>  	rc = cxl_reset_update_ctrl2(pdev, dvsec, PCI_DVSEC_CXL_INIT_CXL_RST,
> @@ -1030,7 +1310,6 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec)
>  			rc = rc2;
>  	}
>  
> -	pci_dev_reset_iommu_done(pdev);
>  	return rc;
>  }
>  
> @@ -1051,11 +1330,24 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  
>  	cxl_hdm_range_context_init(&range_ctx);
>  
> +	if (!cxl_reset_scope_hdm_available(&ctx)) {
> +		rc = -ENOTTY;
> +		goto out;
> +	}
> +
> +	rc = cxl_pci_target_reset_prepare(&ctx);
> +	if (rc)
> +		goto out;
> +
>  	scoped_guard(rwsem_write, &cxl_rwsem.region) {
> -		rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
> +		rc = cxl_hdm_ranges_prepare(&range_ctx, &ctx);
>  		if (!rc)
>  			rc = cxl_reset_execute(pdev, dvsec);
> +		if (!rc)
> +			rc = cxl_restore_hdm_decoders(&ctx);
>  	}
> +
> +	cxl_pci_target_reset_done(&ctx);
>  out:
>  	cxl_hdm_range_context_destroy(&range_ctx);
>  	return rc;

