Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACA127A91D;
	Mon, 24 Aug 2026 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787556804; cv=pass; b=ECjmtR2Tq61WG/sFq51/pKnbU0YCwR5Tc+rbjNpFcBJ8upAqEuWLrrRSDcynp7Umv1SUs3t177f9dA2t51leaHRfdul+7JwN/mfW67EetWRurLJL6Q/u+dA7Cps1UFWTNyqxkvF9sCqKDMIsmZAwbyq6p9HUjim+hmXOculKsgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787556804; c=relaxed/simple;
	bh=m9kSzQwpLsuJfs55p/HtGrpmRcGHX5fKPUCQYrc33pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLu4S4Cj/QpbCMc9eZ8Lo/4j/bGRlMj5ntxxtRqru/g6J5UIsNu9TYfR8Bnt9z3IJWcrBn0SeZVf2u1GKuSKb7n211LSmSUibbzFMrpC6d+9XSASdAR/VZhvMthExGKN1WlEv56TBVLFGI2Xd1fbCfgCmd49v5ldKvktP66PCf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=UyK8r36O; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="UyK8r36O"
ARC-Seal: i=1; a=rsa-sha256; t=1787556792; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=d0USUg/tT7I7DKHPyffsDOPfMHG8GNMp7kfp9IyP30bOtt5tXrDUPgJzcvRDh0eE3nqlAqR6ykExngX2Rac2Lwrh06LBcd/gGbBlhgqrdErvpsecZJTCKYo4PpKvnvMtUbtA1lLjZmxXUdQEvF2KL4zkUSgknkhI8+ncSvpuQs0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1787556792; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=h19KGrYA1h4sd6itjP+OYOMZs4F0XLMo3KwjAr+20jI=; 
	b=Wq6P9gbLW2prX4Rxn6JmGlp9JhVtKj61nvHI4foVqhGJL03HU2JvAg9d+I2Tq1VI5Jft+4QQvc3Br2ikKzaN/nuBgmnxIunK8+k49PZjQ3JMB1gumWdCwtLKDhaEhzXMPqGs53ZgGX0zGcIwswqzIxOTAKKVUx/ls/mfMCUQw3A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787556792;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=h19KGrYA1h4sd6itjP+OYOMZs4F0XLMo3KwjAr+20jI=;
	b=UyK8r36O+Pw2OOsdKySSmXzWpfq13KLc+tDJSATaV5rE9TEUdd2QwZb0tOfFQECx
	mQAY/sZ2WWmLnhsd8Q6gnFixo/6sBLa1yNthFcS5QfKXADcMbgJ8BAwTeaO4XrE833W
	ZF6nUxhOwnCX3l2L6y8n1U2KGuOHTNQucvkSY8cc=
Received: by mx.zohomail.com with SMTPS id 1787556790851931.1219613168062;
	Mon, 24 Aug 2026 00:33:10 -0700 (PDT)
Message-ID: <86133d66-2718-4ffb-baa3-ddf0009d53a3@zohomail.com>
Date: Mon, 24 Aug 2026 15:33:05 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/12] cxl: Pass decoder settings to HDM commit
 helpers
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-3-smadhavan@nvidia.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260804192958.1823952-3-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: zu080112274f048c13fb7babe365e8d2a9000088468c6971e7eecabaf0ea797a0fa6c23de002e26f64d69a6b:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

On 8/5/2026 3:29 AM, Srirangan Madhavan wrote:
> Introduce struct cxl_decoder_settings as a plain snapshot of HDM decoder
> programming state and pass it to the shared commit helpers. Keep endpoint
> skip and switch target-list handling in hdm.c, where the endpoint and
> switch decoder types are available.
>
> Split the helper entry points into cxl_commit_start() and
> cxl_commit_wait() so hdm.c keeps the existing DPA-lock and commit policy
> flow while later reset restore code can reuse the register programming
> sequence.
>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/core.h     |   5 +-
>  drivers/cxl/core/hdm.c      |  72 +++++++++++++++++-----
>  drivers/cxl/core/resource.c | 115 ++++++++++++++++--------------------
>  include/cxl/cxl.h           |  20 +++++++
>  4 files changed, 133 insertions(+), 79 deletions(-)
>
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index cb6853a92a93..1426254e6657 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -211,10 +211,11 @@ static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
>  int cxl_gpf_port_setup(struct cxl_dport *dport);
>  
>  struct cxl_hdm;
> +struct cxl_decoder_settings;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  			struct cxl_endpoint_dvsec_info *info);
> -void cxl_setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm);
> -int cxld_await_commit(void __iomem *hdm, int id);
> +int cxl_commit_start(struct cxl_decoder_settings *settings, void __iomem *hdm);
> +int cxl_commit_wait(struct cxl_decoder_settings *settings, void __iomem *hdm);

My first feeling is "hdm" should be the first parameter, "settings" should be the second one. Because these two function are related to HDM decoder programming.

>  int cxl_port_get_possible_dports(struct cxl_port *port);
>  
>  #ifdef CONFIG_CXL_FEATURES
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 6ae0b9f46ac0..9047b190c35a 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -16,7 +16,6 @@
>   * for enumerating these registers and capabilities.
>   */
>  
> -
>  static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld)
>  {
>  	int rc;
> @@ -675,12 +674,44 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>  	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>  }
>  
> +static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
> +{
> +	struct cxl_dport **t = &cxlsd->target[0];
> +	int ways = cxlsd->cxld.interleave_ways;
> +
> +	*tgt = FIELD_PREP(GENMASK(7, 0), t[0]->port_id);
> +	if (ways > 1)
> +		*tgt |= FIELD_PREP(GENMASK(15, 8), t[1]->port_id);
> +	if (ways > 2)
> +		*tgt |= FIELD_PREP(GENMASK(23, 16), t[2]->port_id);
> +	if (ways > 3)
> +		*tgt |= FIELD_PREP(GENMASK(31, 24), t[3]->port_id);
> +	if (ways > 4)
> +		*tgt |= FIELD_PREP(GENMASK_ULL(39, 32), t[4]->port_id);
> +	if (ways > 5)
> +		*tgt |= FIELD_PREP(GENMASK_ULL(47, 40), t[5]->port_id);
> +	if (ways > 6)
> +		*tgt |= FIELD_PREP(GENMASK_ULL(55, 48), t[6]->port_id);
> +	if (ways > 7)
> +		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
> +}
> +
>  static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  {
>  	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
>  	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
>  	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> -	int id = cxld->id, rc;
> +	struct cxl_endpoint_decoder *cxled = NULL;
> +	struct cxl_switch_decoder *cxlsd = NULL;
> +	struct cxl_decoder_settings settings = {
> +		.id = cxld->id,
> +		.hpa_range = cxld->hpa_range,
> +		.interleave_ways = cxld->interleave_ways,
> +		.interleave_granularity = cxld->interleave_granularity,
> +		.target_type = cxld->target_type,
> +		.flags = cxld->flags,
> +	};
> +	int id = cxld->id, rc = 0;
>  
>  	if (cxld->flags & CXL_DECODER_F_ENABLE)
>  		return 0;
> @@ -693,29 +724,42 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  		return -EBUSY;
>  	}
>  
> -	/*
> -	 * For endpoint decoders hosted on CXL memory devices that
> -	 * support the sanitize operation, make sure sanitize is not in-flight.
> -	 */
>  	if (is_endpoint_decoder(&cxld->dev)) {
> -		struct cxl_endpoint_decoder *cxled =
> -			to_cxl_endpoint_decoder(&cxld->dev);
> -		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -		struct cxl_memdev_state *mds =
> -			to_cxl_memdev_state(cxlmd->cxlds);
> +		struct cxl_memdev *cxlmd;
> +		struct cxl_memdev_state *mds;
>  
> +		cxled = to_cxl_endpoint_decoder(&cxld->dev);
> +		cxlmd = cxled_to_memdev(cxled);
> +		mds = to_cxl_memdev_state(cxlmd->cxlds);
> +		/*
> +		 * For endpoint decoders hosted on CXL memory devices that
> +		 * support the sanitize operation, make sure sanitize is not in-flight.
> +		 */
>  		if (mds && mds->security.sanitize_active) {
>  			dev_dbg(&cxlmd->dev,
>  				"attempted to commit %s during sanitize\n",
>  				dev_name(&cxld->dev));
>  			return -EBUSY;
>  		}
> +	} else if (is_switch_decoder(&cxld->dev)) {
> +		cxlsd = to_cxl_switch_decoder(&cxld->dev);
>  	}
>  
> -	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
> -		cxl_setup_hw_decoder(cxld, hdm);
> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
> +		if (cxled)
> +			settings.target_or_skip = cxled->skip;
> +		else if (cxlsd)
> +			cxlsd_set_targets(cxlsd, &settings.target_or_skip);
> +
> +		rc = cxl_commit_start(&settings, hdm);
> +	}
> +	if (rc) {
> +		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
> +			dev_name(&cxld->dev), rc);
> +		return rc;
> +	}
>  
> -	rc = cxld_await_commit(hdm, cxld->id);
> +	rc = cxl_commit_wait(&settings, hdm);
>  	if (rc) {
>  		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
>  			dev_name(&cxld->dev), rc);
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index dd8bed3d3ff0..dd5e0cc82da4 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -15,21 +15,22 @@ struct cxl_rwsem cxl_rwsem = {
>  };
>  EXPORT_SYMBOL_FOR_MODULES(cxl_rwsem, "cxl_core");
>  
> -static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
> +static void cxld_set_interleave(struct cxl_decoder_settings *settings, u32 *ctrl)
>  {
>  	u16 eig;
>  	u8 eiw;
>  
>  	/*
>  	 * Input validation ensures these warns never fire, but otherwise
> -	 * suppress unititalized variable usage warnings.
> +	 * suppress uninitialized variable usage warnings.
>  	 */
> -	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
> -		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
> +	if (WARN_ONCE(ways_to_eiw(settings->interleave_ways, &eiw),
> +		      "invalid interleave_ways: %d\n",
> +		      settings->interleave_ways))
>  		return;
> -	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
> +	if (WARN_ONCE(granularity_to_eig(settings->interleave_granularity, &eig),
>  		      "invalid interleave_granularity: %d\n",
> -		      cxld->interleave_granularity))
> +		      settings->interleave_granularity))
>  		return;
>  
>  	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
> @@ -37,42 +38,20 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>  	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
>  }
>  
> -static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
> +static void cxld_set_type(struct cxl_decoder_settings *settings, u32 *ctrl)
>  {
>  	u32p_replace_bits(ctrl,
> -			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
> +			  !!(settings->target_type == CXL_DECODER_HOSTONLYMEM),
>  			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
>  }
>  
> -static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
> -{
> -	struct cxl_dport **t = &cxlsd->target[0];
> -	int ways = cxlsd->cxld.interleave_ways;
> -
> -	*tgt = FIELD_PREP(GENMASK(7, 0), t[0]->port_id);
> -	if (ways > 1)
> -		*tgt |= FIELD_PREP(GENMASK(15, 8), t[1]->port_id);
> -	if (ways > 2)
> -		*tgt |= FIELD_PREP(GENMASK(23, 16), t[2]->port_id);
> -	if (ways > 3)
> -		*tgt |= FIELD_PREP(GENMASK(31, 24), t[3]->port_id);
> -	if (ways > 4)
> -		*tgt |= FIELD_PREP(GENMASK_ULL(39, 32), t[4]->port_id);
> -	if (ways > 5)
> -		*tgt |= FIELD_PREP(GENMASK_ULL(47, 40), t[5]->port_id);
> -	if (ways > 6)
> -		*tgt |= FIELD_PREP(GENMASK_ULL(55, 48), t[6]->port_id);
> -	if (ways > 7)
> -		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
> -}
> -
>  /*
>   * Per CXL 2.0 8.2.5.12.20 Committing Decoder Programming, hardware must set
>   * committed or error within 10ms, but just be generous with 20ms to account for
> - * clock skew and other marginal behavior
> + * clock skew and other marginal behavior.
>   */
>  #define COMMIT_TIMEOUT_MS 20
> -int cxld_await_commit(void __iomem *hdm, int id)
> +static int cxld_await_commit(void __iomem *hdm, int id)
>  {
>  	u32 ctrl;
>  	int i;
> @@ -92,47 +71,57 @@ int cxld_await_commit(void __iomem *hdm, int id)
>  	return -ETIMEDOUT;
>  }
>  
> -EXPORT_SYMBOL_FOR_MODULES(cxld_await_commit, "cxl_core");
> -
> -void cxl_setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
> +static int setup_hw_decoder(struct cxl_decoder_settings *settings,
> +			    void __iomem *hdm)
Same as above, I think "hdm" should be the first parameter.
>  {
> -	int id = cxld->id;
> +	int id = settings->id;
> +	u64 target_or_skip;
>  	u64 base, size;
>  	u32 ctrl;
>  
> -	/* common decoder settings */
> -	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> -	cxld_set_interleave(cxld, &ctrl);
> -	cxld_set_type(cxld, &ctrl);
> -	base = cxld->hpa_range.start;
> -	size = range_len(&cxld->hpa_range);
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED)
> +		return -EBUSY;
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_COMMIT)
> +		return -ETIMEDOUT;
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_COMMIT_ERROR)
> +		return -EIO;
> +	cxld_set_interleave(settings, &ctrl);
> +	cxld_set_type(settings, &ctrl);
> +	base = settings->hpa_range.start;
> +	size = range_len(&settings->hpa_range);
> +	target_or_skip = settings->target_or_skip;
>  
>  	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
>  	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
>  	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
>  	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> -
> -	if (is_switch_decoder(&cxld->dev)) {
> -		struct cxl_switch_decoder *cxlsd =
> -			to_cxl_switch_decoder(&cxld->dev);
> -		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
> -		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
> -		u64 targets;
> -
> -		cxlsd_set_targets(cxlsd, &targets);
> -		writel(upper_32_bits(targets), tl_hi);
> -		writel(lower_32_bits(targets), tl_lo);
> -	} else {
> -		struct cxl_endpoint_decoder *cxled =
> -			to_cxl_endpoint_decoder(&cxld->dev);
> -		void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
> -		void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
> -
> -		writel(upper_32_bits(cxled->skip), sk_hi);
> -		writel(lower_32_bits(cxled->skip), sk_lo);
> -	}
> +	/* Target-list and endpoint-skip registers alias the same slot. */
> +	writel(upper_32_bits(target_or_skip),
> +	       hdm + CXL_HDM_DECODER0_TL_HIGH(id));
> +	writel(lower_32_bits(target_or_skip),
> +	       hdm + CXL_HDM_DECODER0_TL_LOW(id));
>  
>  	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +
> +	return 0;
>  }
>  
> -EXPORT_SYMBOL_FOR_MODULES(cxl_setup_hw_decoder, "cxl_core");
> +int cxl_commit_start(struct cxl_decoder_settings *settings, void __iomem *hdm)
> +{
> +	lockdep_assert_held(&cxl_rwsem.dpa);
> +	return setup_hw_decoder(settings, hdm);
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_commit_start, "cxl_core");
> +
> +int cxl_commit_wait(struct cxl_decoder_settings *settings, void __iomem *hdm)
> +{
> +	int rc;
> +
> +	rc = cxld_await_commit(hdm, settings->id);
> +	if (rc)
> +		return rc;
> +
> +	return 0;
Can "return cxld_await_commit(hdm, settings->id);" directly.
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_commit_wait, "cxl_core");
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 05a8bc32138c..85e895d9b31c 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -32,6 +32,26 @@ enum cxl_decoder_type {
>  	CXL_DECODER_HOSTONLYMEM = 3,
>  };
>  
> +/**
> + * struct cxl_decoder_settings - CXL HDM decoder programming snapshot
> + * @id: decoder id
> + * @hpa_range: Host physical address range mapped by this decoder
> + * @target_or_skip: switch target list or endpoint skip register value
> + * @interleave_ways: number of cxl_dports in this decode
> + * @interleave_granularity: data stride per dport
> + * @target_type: accelerator vs expander (type2 vs type3) selector
> + * @flags: memory type capabilities and locking
> + */
> +struct cxl_decoder_settings {
> +	int id;
> +	struct range hpa_range;
> +	u64 target_or_skip;
> +	int interleave_ways;
> +	int interleave_granularity;
> +	enum cxl_decoder_type target_type;
> +	unsigned long flags;
> +};
> +
>  /*
>   * Current specification goes up to 8, double that seems a reasonable
>   * software max for the foreseeable future


