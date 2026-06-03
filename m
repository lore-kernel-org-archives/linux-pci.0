Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AEE4D990A;
	Wed,  3 Jun 2026 22:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780526111; cv=none; b=Vz2avh/ga/kWbsGGkU+tODhfm6vJ+KidliOh1C6h9rfsDMfBLYKTCwm0o8EDJKY/cODhextXSF0/8jGItsRP81tZD78rVokdufVXMjeKFSIteaeVpdBJuo66fZOSpyV+fIR4kwRyb/92ZyUWoOndbeUn6XGdvAqzuhtZjRroskc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780526111; c=relaxed/simple;
	bh=R4Y+8SNHLKoJpj52gg66m46z0ZQGfnBFSR58yqc2y/M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=T+RIftJt80v3OtVBRttup6rFBH8xunb+Nuk+YxEodDUBJW9EjjcqqfdjPLazhHs+NCN/CKIJcTyEUrfwsXzS846LJjbSQe113WhbKFrSaSuao1GFQyxvHcL1XvSbMmUb6U3+83xwl8PxCUJwUtJj5BwXbFVjTe36nUVzAfNbVYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgStjOlr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgStjOlr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEF51F00893;
	Wed,  3 Jun 2026 22:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780526107;
	bh=OcOdae9aW3iLF8mIid4aYhtVq0pp0FWKSQgXqyu7sgY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=EgStjOlr7dek1SQsLibL0h82UgYUsq+BzI1LNM0Furk5gcuhF31o2c6E4cI5H9KUt
	 hU23okPULS+bUQ/zZ6axjCKeJIoaGZLFrdumy5MTXo+widPZYTS+plk0nIo9LzlPnK
	 GC89xuHJJqhJ/i4oL3/lcOsUBLPgj69szT8qY5ValTaBnEJV7rTOrI7rLlA2FMBQ/q
	 KvVQzfVdRsISZKTC01lpXBwdL+abKlPmkcZfNjCldW1g/vgt/GEIWugPvmyzWs/8Vq
	 9oEJ0OS8D2yiTeKY9zo9EZb24OFr9bSRjvPd9H0Utx0BbzTohpoc5W9EC3oW6gw06O
	 PMAxpHUjxszgw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 04F9AF4007A;
	Wed,  3 Jun 2026 18:35:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 03 Jun 2026 18:35:06 -0400
X-ME-Sender: <xms:Gawgah8nXtIAPGGAGPiF8ERwSlzGIlyWD0MQlDyU5-tpzVCdNfwGKQ>
    <xme:GawgaiECsVyJlbZbs12LgL9dApVJ1LJOcg-76_vLe-a-uwCOidhdfTraDGsqsZmPb
    ugeM7UWcnbqhBSfbceRrUfBK2C6LfaWM8eWIFSSwziA1134Y0ZY-3A>
X-ME-Received: <xmr:Gawgajcfb1Z1Ss-xUUFtpohKa4N-tQQw9hxhyyN2I8tZllJSMoVc3y2_k9-J5xj9rS1pUgt6XuVFYkIE94WDwx7khXrpjVI0Cc0>
X-ME-Proxy-Cause: dmFkZTFX0j9sA6Wn6+0SHbB+uAnsGUuUTkIQ/IG92bQ8SWXL+2nOfGVQYN3SuFpcuyraSy
    gwilbXDO2FeldZhYaMLbp/icLYg2aI/62Vz1d6pgPJHELN04Hz3biMknEMug0aTN0YKs17
    6OVgLgH1oXPT49MIJL83dUy7zwS2LqADZczGc+s6oFiY893y36qw3Nw4WxVeNfy5fdNHxE
    1NReFr7YSnTLG1+7Fka8iFyXEVQuzfuk5/D5SSn3UamAFriCIPaBrMa6tx0rksq4zxZREQ
    7O5cjH8ayu5kLs+O7WmRQdQWmYYzMFq9AnD1HvJQbGOL5L71Yt2K9Kq3WcRFI7b6U73mZM
    AwQ7pFB7B43Vw42HhZKuqT/iYqKJCnW3ndhv8fJIdnPjvzoweDNxg8bXmnhRGHfGoIK0ev
    KDpmBmmKLhyz5PaNQYmzfdenbYSPFVdm5C4cPfWbOp52IR3h/PVbBBcuDKlgCtsT/kFCBP
    iQl5W/kXrKRr/KamjnNI28YqfGP44c1rm4qtVh1ONjzdq4bxfmFoYTAgyC+w0maJkhL7ui
    UU3usNIb5t0ABX9rNBB5k0KORX6c1KBnaht8QlAMW3ZAecyuqCYLXHDmVZUn6zKd3fj9LK
    t9lN3rnRAelX7u62eXwDF5RFv5iY8PpSYd1v0xZ97xg1/qHDDay5Ic1CJdHg
X-ME-Proxy: <xmx:GawgajnJRKPBuQxHHlSbQxoVBXF77oxwUBs08hNYkCa3YEBPXX81lw>
    <xmx:GawgaiqDZewJTZ3ESejfybqg0AaLjreBaG-Pvh68hqlR_VIYrAiBwQ>
    <xmx:GawgagG5L02g7zRfsheBtapaDON15iJWvFysqYb7CWFhsSY4dAecGw>
    <xmx:GawgaoSwn7zKuKTdOvw-RFsb8Va2l1gjQCW1Pb-nWB2-xRg4hlTkbQ>
    <xmx:GqwgamMz7y2YWcRcMvw3qD7_RrwWEhw4XweldNdFUL7uTWLuDuKZ5DLk>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 18:35:05 -0400 (EDT)
Date: Wed, 03 Jun 2026 15:35:03 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Srirangan Madhavan <smadhavan@nvidia.com>, 
 linux-cxl@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: vsethi@nvidia.com, 
 alwilliamson@nvidia.com, 
 Dan Williams <danwilliams@nvidia.com>, 
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, 
 Vishal Aslot <vaslot@nvidia.com>, 
 Manish Honap <mhonap@nvidia.com>, 
 Jiandi An <jan@nvidia.com>, 
 Richard Cheng <icheng@nvidia.com>, 
 linux-tegra@vger.kernel.org, 
 Srirangan Madhavan <smadhavan@nvidia.com>
Message-ID: <6a20ac17906d8_42b91004f@djbw-dev.notmuch>
In-Reply-To: <20260528083154.137979-2-smadhavan@nvidia.com>
References: <20260528083154.137979-1-smadhavan@nvidia.com>
 <20260528083154.137979-2-smadhavan@nvidia.com>
Subject: Re: [PATCH v6 1/9] cxl/hdm: Add helpers to restore and commit memdev
 decoders
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Srirangan Madhavan wrote:
> Add helpers to restore endpoint decoder programming for a CXL memdev from
> CXL core's cached decoder objects, then commit it as a distinct step.
> Callers are expected to have established reset safety and to hold
> cxl_rwsem.region for write.

In the /sys/bus/.../reset path the PCI device only has cached HDM state,
no 'struct cxl_region' objects. So this needs a simpler method to
determine that HDM is unmapped. It probably also needs account for
userspace mappings. The closest approximation to "this phys addr is not
mapped anywhere, even /dev/mem" is a successful __request_region().

> cxl_restore_memdev_decoders() restores programmable decoder state while
> keeping traffic disabled. For HDM-backed endpoints it programs enabled
> endpoint decoder fields without COMMIT, keeps the HDM Decoder Capability
> disabled, and mirrors matching endpoint DVSEC ranges where possible. For
> endpoints without HDM decoder registers, it restores the legacy DVSEC
> ranges that model endpoint decode.

Ideally just use the same helper for restoring the configuration as
writing the configuration. I.e. I am not sure that writing all the
address ranges first is required since per decoder commit is still
required. Effectively trying to maximize identical flows for the reset
and dynamic configuration paths.

> cxl_commit_memdev_decoders() enables the HDM Decoder Capability and
> commits enabled, unlocked endpoint decoders after safety checks pass. It
> sets COMMIT only after decoder fields have been restored, does not
> re-lock decoders, and does not set DVSEC MEM_ENABLE.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
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

It is awkward to get all the way down to restoring the interleave to
find that the original interleave settings were invalid to start.

I think it is also impossible. These warnings have never provided any
value and should probably be deleted rather than honored and reflected
up the stack.

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

No need for lower_32_bits() with the mask.

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

After reset, global control should not require re-disabling.

> +	}
> +
> +	return device_for_each_child(&port->dev, &ctx, cxl_restore_decoder);

This gets cleaner when being able to skip the device_for_each_child()
and just walk the array of cached HDM info in the device.
