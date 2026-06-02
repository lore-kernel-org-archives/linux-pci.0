Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B773955F2;
	Tue,  2 Jun 2026 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425125; cv=none; b=Yu5Fg+weIwIPlNDNvRxtitjhZUm4WOAGbVCgwDCr0Sv/diT26SOHgF7IrnR+R3mGGB+Fq8Ls0Nm1ypgprfvuv05PYkzcAvWAQ4OPUvk/fDHHT0unSaHRK3nZcyz0eVcHwhdvV4y/cat1iVteuzHaLiOkVscuxSht8memUhQRZyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425125; c=relaxed/simple;
	bh=ckDltD99hiH6/2b5m3xzTBZ3i5VDV7A5nmljNBd8Hso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PceF4iTK1kvlQ/FyhNsAsnIk8kIjfRxP0dOGP+d9w3LrCg0U+0lpwbMsOTaenZdCS1I3DbJBNyPRKyOVSqkOTilepjrsxRfbFSR7JqSsjKeXtfiNsI5E2vb0i11VT7X7VBHI4hmz9eDD+chiP7DB/m2e93RMwzyCgoADnw387P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xmee9lt9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xmee9lt9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780425123; x=1811961123;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ckDltD99hiH6/2b5m3xzTBZ3i5VDV7A5nmljNBd8Hso=;
  b=Xmee9lt94T4s68qzLgRaacHwlgk+LFk+iA9QVe0FZmi8aFBrVlfQFvTn
   kenWUqFu/lwk1G9/jV2dGIrOY0KAb54nAPMnNmGJ0Ug+qqLGQR8FPk3kl
   azsTJb3MfXRHn4Swy+PGECOVllEWwHs6gDyyWMXg4L6m9o/YROR5s88MR
   mHNIfKTNc7ooWdnFIcNRYq2JNgk5a8wqtAP51GeFq8+5oY9QWO1IVvM/I
   tGZvOp/os/XPmimG9Vv8TeQvKDKDs/PNuu59qRuCu9i4iObrYjAfxgEQx
   QPe+CUOwYmiDiDcHastn4Pe4aLGXJvrwOEf764QXZ8hOKK4fm8nXQ8kvB
   Q==;
X-CSE-ConnectionGUID: Bw+Ztn/7S+GV8bp7juMcyg==
X-CSE-MsgGUID: 8cL9xg3hReaksYgs7m6gaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81349042"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="81349042"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 11:32:02 -0700
X-CSE-ConnectionGUID: vLkkYk6iQYm7qCnYu5eHlw==
X-CSE-MsgGUID: yWxFmiUgS9i16x0Cg/1SEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="237635966"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.56]) ([10.125.108.56])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 11:32:01 -0700
Message-ID: <929b5fc8-bd4b-4a12-9ba5-ddb5eea14106@intel.com>
Date: Tue, 2 Jun 2026 11:31:59 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/9] cxl/hdm: Add helpers to restore and commit memdev
 decoders
To: Srirangan Madhavan <smadhavan@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: vsethi@nvidia.com, alwilliamson@nvidia.com,
 Dan Williams <danwilliams@nvidia.com>,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260528083154.137979-1-smadhavan@nvidia.com>
 <20260528083154.137979-2-smadhavan@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260528083154.137979-2-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/28/26 1:31 AM, Srirangan Madhavan wrote:
> Add helpers to restore endpoint decoder programming for a CXL memdev from
> CXL core's cached decoder objects, then commit it as a distinct step.
> Callers are expected to have established reset safety and to hold
> cxl_rwsem.region for write.
> 
> cxl_restore_memdev_decoders() restores programmable decoder state while
> keeping traffic disabled. For HDM-backed endpoints it programs enabled
> endpoint decoder fields without COMMIT, keeps the HDM Decoder Capability
> disabled, and mirrors matching endpoint DVSEC ranges where possible. For
> endpoints without HDM decoder registers, it restores the legacy DVSEC
> ranges that model endpoint decode.
> 
> cxl_commit_memdev_decoders() enables the HDM Decoder Capability and
> commits enabled, unlocked endpoint decoders after safety checks pass. It
> sets COMMIT only after decoder fields have been restored, does not
> re-lock decoders, and does not set DVSEC MEM_ENABLE.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

A few minor things below besides what Richard raised...

> ---
>  drivers/cxl/core/hdm.c | 318 ++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/cxl.h      |   2 +
>  2 files changed, 317 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..f7af1041a9fc 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -679,7 +679,7 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>  	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>  }
>  
> -static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
> +static int cxld_set_interleave_fields(struct cxl_decoder *cxld, u32 *ctrl)
>  {
>  	u16 eig;
>  	u8 eiw;
> @@ -690,14 +690,22 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>  	 */
>  	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
>  		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
> -		return;
> +		return -EINVAL;
>  	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
>  		      "invalid interleave_granularity: %d\n",
>  		      cxld->interleave_granularity))
> -		return;
> +		return -EINVAL;
>  
>  	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
>  	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
> +	return 0;
> +}
> +
> +static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
> +{
> +	if (cxld_set_interleave_fields(cxld, ctrl))
> +		return;
> +
>  	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
>  }
>  
> @@ -927,6 +935,310 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
>  	}
>  }
>  
> +static int cxl_restore_dvsec_range(struct cxl_memdev *cxlmd,
> +				   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_decoder *cxld = &cxled->cxld;
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	u64 base = cxld->hpa_range.start;
> +	u64 size = range_len(&cxld->hpa_range);
> +	u32 lo;
> +	int dvsec = cxlds->cxl_dvsec;
> +	int id = cxld->id;
> +	int rc;

Just a nit. Please arrange in reverse xmas tree when possible throughout the code.

> +
> +	if (!dvsec)
> +		return 0;
> +
> +	if (id >= CXL_DVSEC_RANGE_MAX)
> +		return 0;
> +
> +	rc = pci_write_config_dword(pdev, dvsec + PCI_DVSEC_CXL_RANGE_BASE_HIGH(id),
> +				    upper_32_bits(base));
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_read_config_dword(pdev, dvsec + PCI_DVSEC_CXL_RANGE_BASE_LOW(id),
> +				   &lo);
> +	if (rc)
> +		return rc;

Can use a blank line here

> +	lo &= ~PCI_DVSEC_CXL_MEM_BASE_LOW;
> +	lo |= lower_32_bits(base) & PCI_DVSEC_CXL_MEM_BASE_LOW;
> +
> +	rc = pci_write_config_dword(pdev, dvsec + PCI_DVSEC_CXL_RANGE_BASE_LOW(id),
> +				    lo);
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_write_config_dword(pdev, dvsec + PCI_DVSEC_CXL_RANGE_SIZE_HIGH(id),
> +				    upper_32_bits(size));
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_read_config_dword(pdev, dvsec + PCI_DVSEC_CXL_RANGE_SIZE_LOW(id),
> +				   &lo);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Preserve MEM_INFO_VALID / MEM_ACTIVE and any reserved bits while
> +	 * restoring only the programmable size bits.
> +	 */
> +	lo &= ~PCI_DVSEC_CXL_MEM_SIZE_LOW;
> +	lo |= lower_32_bits(size) & PCI_DVSEC_CXL_MEM_SIZE_LOW;
> +
> +	return pci_write_config_dword(pdev,
> +				      dvsec + PCI_DVSEC_CXL_RANGE_SIZE_LOW(id),
> +				      lo);
> +}
> +
> +static int cxl_restore_hdm_decoder(struct cxl_hdm *cxlhdm,
> +				   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_decoder *cxld = &cxled->cxld;
> +	void __iomem *hdm;
> +	u64 base, size, skip;
> +	u32 ctrl;
> +	int id;
> +
> +	id = cxld->id;
> +	hdm = cxlhdm->regs.hdm_decoder;
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> +		return 0;
> +
> +	base = cxld->hpa_range.start;
> +	size = range_len(&cxld->hpa_range);
> +	skip = cxled->skip;
> +
> +	ctrl &= ~(CXL_HDM_DECODER0_CTRL_LOCK |
> +		  CXL_HDM_DECODER0_CTRL_COMMIT |
> +		  CXL_HDM_DECODER0_CTRL_COMMITTED |
> +		  CXL_HDM_DECODER0_CTRL_COMMIT_ERROR);
> +	if (cxld_set_interleave_fields(cxld, &ctrl))
> +		return -EINVAL;
> +	cxld_set_type(cxld, &ctrl);
> +
> +	/* Preserve setup_hw_decoder() programming order, without COMMIT. */
> +	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> +	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> +	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	writel(upper_32_bits(skip), hdm + CXL_HDM_DECODER0_SKIP_HIGH(id));
> +	writel(lower_32_bits(skip), hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
> +	wmb();

The wmb() is unnessary. See Documentation/driver-api/device-io.rst. readX()/writeX() accesses to the same device are ordered.

DJ

> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +
> +	return 0;
> +}
> +
> +struct cxl_restore_ctx {
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_hdm *cxlhdm;
> +};
> +
> +static int cxl_restore_decoder(struct device *dev, void *data)
> +{
> +	struct cxl_restore_ctx *ctx = data;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_decoder *cxld;
> +	int rc;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	cxld = &cxled->cxld;
> +	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
> +		return 0;
> +
> +	if (ctx->cxlhdm->regs.hdm_decoder) {
> +		if (cxld->id >= ctx->cxlhdm->decoder_count)
> +			return -EINVAL;
> +
> +		rc = cxl_restore_hdm_decoder(ctx->cxlhdm, cxled);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return cxl_restore_dvsec_range(ctx->cxlmd, cxled);
> +}
> +
> +static int cxl_restore_decoders(struct cxl_memdev *cxlmd, struct cxl_hdm *cxlhdm)
> +{
> +	struct cxl_port *port = cxlhdm->port;
> +	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> +	struct cxl_restore_ctx ctx = {
> +		.cxlmd = cxlmd,
> +		.cxlhdm = cxlhdm,
> +	};
> +	u32 global_ctrl;
> +
> +	if (hdm) {
> +		global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +		writel(global_ctrl & ~CXL_HDM_DECODER_ENABLE,
> +		       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +	}
> +
> +	return device_for_each_child(&port->dev, &ctx, cxl_restore_decoder);
> +}
> +
> +/**
> + * cxl_restore_memdev_decoders - Restore endpoint decoder programming
> + * @cxlmd: CXL memdev whose endpoint decoders need to be restored
> + *
> + * Restore only programmable decoder state from CXL core's cached decoder
> + * objects. For endpoints with HDM decoder registers, program the HDM decoder
> + * fields and mirror decoder ids representable by CXL_DVSEC_RANGE_MAX into the
> + * DVSEC range registers when present. For endpoints without HDM decoder
> + * registers, restore DVSEC range registers only.
> + *
> + * This helper leaves CXL.mem disabled: it does not commit HDM decoders, enable
> + * the HDM Decoder Capability, set PCI_DVSEC_CXL_MEM_ENABLE, or restore
> + * unrelated DVSEC CTRL, CTRL2, LOCK, MEM_ENABLE, or other control state.
> + * Callers must perform final commit/resume steps only after reset safety checks
> + * pass.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int cxl_restore_memdev_decoders(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_hdm *cxlhdm;
> +	int rc;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +
> +	if (!endpoint)
> +		return -ENODEV;
> +
> +	cxlhdm = dev_get_drvdata(&endpoint->dev);
> +	if (!cxlhdm)
> +		return -ENODEV;
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
> +		rc = cxl_restore_decoders(cxlmd, cxlhdm);
> +	return rc;
> +}
> +
> +static int cxl_commit_restored_hdm_decoder(struct cxl_hdm *cxlhdm,
> +					   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_decoder *cxld = &cxled->cxld;
> +	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> +	u32 ctrl;
> +	int id;
> +
> +	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
> +		return 0;
> +
> +	if (!hdm)
> +		return 0;
> +
> +	id = cxld->id;
> +	if (id >= cxlhdm->decoder_count)
> +		return -EINVAL;
> +
> +	/*
> +	 * cxl_restore_hdm_decoder() programmed the decoder fields first. This
> +	 * control register write sets COMMIT as the final programming step.
> +	 */
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> +		return 0;
> +
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED)
> +		return 0;
> +
> +	ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +
> +	return cxld_await_commit(hdm, id);
> +}
> +
> +struct cxl_commit_decoder_ctx {
> +	struct cxl_hdm *cxlhdm;
> +	int id;
> +};
> +
> +static int cxl_commit_restored_decoder_by_id(struct device *dev, void *data)
> +{
> +	struct cxl_commit_decoder_ctx *ctx = data;
> +	struct cxl_endpoint_decoder *cxled;
> +	int rc;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	if (cxled->cxld.id != ctx->id)
> +		return 0;
> +
> +	rc = cxl_commit_restored_hdm_decoder(ctx->cxlhdm, cxled);
> +	return rc ?: 1;
> +}
> +
> +/**
> + * cxl_commit_memdev_decoders - Commit restored endpoint decoder programming
> + * @cxlmd: CXL memdev whose endpoint decoders need to be committed
> + *
> + * Resume endpoint decoding after cxl_restore_memdev_decoders() has restored
> + * programmable decoder fields. For endpoints with HDM decoder registers, enable
> + * the HDM Decoder Capability and commit enabled, unlocked endpoint decoders.
> + * Locked decoders are left to their current hardware/firmware-owned state.
> + *
> + * This helper does not set PCI_DVSEC_CXL_MEM_ENABLE. Callers must enable
> + * CXL.mem only after all reset safety checks and decoder restore/commit steps
> + * have completed.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int cxl_commit_memdev_decoders(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_hdm *cxlhdm;
> +	void __iomem *hdm;
> +	u32 global_ctrl;
> +	int i, rc;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +
> +	if (!endpoint)
> +		return -ENODEV;
> +
> +	cxlhdm = dev_get_drvdata(&endpoint->dev);
> +	if (!cxlhdm)
> +		return -ENODEV;
> +
> +	hdm = cxlhdm->regs.hdm_decoder;
> +	if (!hdm)
> +		return 0;
> +
> +	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +	writel(global_ctrl | CXL_HDM_DECODER_ENABLE,
> +	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +
> +	for (i = 0; i < cxlhdm->decoder_count; i++) {
> +		struct cxl_commit_decoder_ctx ctx = {
> +			.cxlhdm = cxlhdm,
> +			.id = i,
> +		};
> +
> +		/*
> +		 * Per CXL Spec 3.1 8.2.4.20.12 software must commit decoders
> +		 * in HPA order. Region setup already enforces that ordering by
> +		 * decoder id, so restore commits follow ascending id order.
> +		 */
> +		rc = device_for_each_child(&endpoint->dev, &ctx,
> +					   cxl_commit_restored_decoder_by_id);
> +		if (rc < 0)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
>  static int cxl_setup_hdm_decoder_from_dvsec(
>  	struct cxl_port *port, struct cxl_decoder *cxld, u64 *dpa_base,
>  	int which, struct cxl_endpoint_dvsec_info *info)
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1297594beaec..b51b1e9d6400 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -794,6 +794,8 @@ int cxl_port_setup_regs(struct cxl_port *port,
>  struct cxl_dev_state;
>  int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  			struct cxl_endpoint_dvsec_info *info);
> +int cxl_restore_memdev_decoders(struct cxl_memdev *cxlmd);
> +int cxl_commit_memdev_decoders(struct cxl_memdev *cxlmd);
>  
>  bool is_cxl_region(struct device *dev);
>  

