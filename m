Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ADC31BCAE;
	Thu, 20 Aug 2026 22:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787264474; cv=none; b=dGjNfmH2Sylf5G1UaYhwerB65vkB3D1ZLtRxZHijUPhuM0bBq2KN0aB1g+idv7dnMosQVbJJyPgbWSHDrlFsXp+lQVNSrT/zN9nGt+Fya83ohRuVHAdEZqMoWVVWId1h+57Ye1HBHbfaXMOCQAFPlnsQ2cdVhuKmjFW0tODnCYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787264474; c=relaxed/simple;
	bh=bNJRUFLSCXmY/WWSDUzKbbA/nKoOSrsnnZ0uWqSSkuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LeyYJE7YJjgZl7jwK82eRUCGdvgY3jCQODiWmhXs4YPvQQk8so8xVtS63QYeCCqVXR+mhcOV8TnZgYcSGXMYcRO/7Yp+zzMxLORqKTfRAsWinRsABZSWc35WptQHsDVUcF+5qlEYM3Hj7kKTlUAcdrXVb74BZohWivBXUHW1Hmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m5z0a78D; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m5z0a78D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787264472; x=1818800472;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bNJRUFLSCXmY/WWSDUzKbbA/nKoOSrsnnZ0uWqSSkuA=;
  b=m5z0a78DsWiIev9tJ7CuY9I9pxlvjeDoAY2JT+RVT+u9UfmKB9RUrEIq
   xrYPlh4OSNuTBNIGY8+F2pHGMYPU3fTDA9LP21Iyuj4wNCOPLyM4VrOAg
   8GuLJ78HcPvxleaYBp7/+9ks5PkZDDtoFQNSueim4lmPyVT4WI9y+GzRO
   VAXm/EiSbGvs9KET7Tu5wNsQ0d7wq5wREKoCaFlZJuHQcY/plHtHLlhje
   vs7FwD/FSu6YlG0GHzza4jeLKnOgUS8/AOo3sx8q1WRIyYbM1Xpk1twz6
   W+K5nuFyzBUEifCymPe7wKFe6usnz78ETrX8DNmAbWg7d7bzX6YZcpEfE
   g==;
X-CSE-ConnectionGUID: Jt4/zyMpTkOdudWhx+jETA==
X-CSE-MsgGUID: G+g74aUXQPS0SxB6dXI1xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="113351438"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="113351438"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 15:21:11 -0700
X-CSE-ConnectionGUID: 6IKcspNuSKGeO6EpfQ9AOw==
X-CSE-MsgGUID: mMus8ol7QuK+9XrMy9d6WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="264858042"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.108.63]) ([10.125.108.63])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 15:21:10 -0700
Message-ID: <c7a5ef2b-e107-4bbb-a1cb-fbe7625e4962@intel.com>
Date: Thu, 20 Aug 2026 15:21:08 -0700
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
 Bjorn Helgaas <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
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
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260804192958.1823952-3-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/4/26 12:29 PM, Srirangan Madhavan wrote:
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

This function made a round trip from hdm.c to resource.c back to hdm.c between patch 1 and 2.
I think there's some code duplication here with this function. What do you think of something like:

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index b47701fc5315..f1e5f06ef807 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -789,43 +789,12 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
-static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
-{
-	struct cxl_dport **t = &cxlsd->target[0];
-	int ways = cxlsd->cxld.interleave_ways;
-
-	*tgt = FIELD_PREP(GENMASK(7, 0), t[0]->port_id);
-	if (ways > 1)
-		*tgt |= FIELD_PREP(GENMASK(15, 8), t[1]->port_id);
-	if (ways > 2)
-		*tgt |= FIELD_PREP(GENMASK(23, 16), t[2]->port_id);
-	if (ways > 3)
-		*tgt |= FIELD_PREP(GENMASK(31, 24), t[3]->port_id);
-	if (ways > 4)
-		*tgt |= FIELD_PREP(GENMASK_ULL(39, 32), t[4]->port_id);
-	if (ways > 5)
-		*tgt |= FIELD_PREP(GENMASK_ULL(47, 40), t[5]->port_id);
-	if (ways > 6)
-		*tgt |= FIELD_PREP(GENMASK_ULL(55, 48), t[6]->port_id);
-	if (ways > 7)
-		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
-}
-
 static int cxl_decoder_commit(struct cxl_decoder *cxld)
 {
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
 	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
-	struct cxl_endpoint_decoder *cxled = NULL;
-	struct cxl_switch_decoder *cxlsd = NULL;
-	struct cxl_decoder_settings settings = {
-		.id = cxld->id,
-		.hpa_range = cxld->hpa_range,
-		.interleave_ways = cxld->interleave_ways,
-		.interleave_granularity = cxld->interleave_granularity,
-		.target_type = cxld->target_type,
-		.flags = cxld->flags,
-	};
+	struct cxl_decoder_settings settings;
 	int id = cxld->id, rc = 0;
 
 	if (cxld->flags & CXL_DECODER_F_ENABLE)
@@ -839,33 +808,27 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 		return -EBUSY;
 	}
 
+	/*
+	 * For endpoint decoders hosted on CXL memory devices that
+	 * support the sanitize operation, make sure sanitize is not in-flight.
+	 */
 	if (is_endpoint_decoder(&cxld->dev)) {
-		struct cxl_memdev *cxlmd;
-		struct cxl_memdev_state *mds;
+		struct cxl_endpoint_decoder *cxled =
+			to_cxl_endpoint_decoder(&cxld->dev);
+		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+		struct cxl_memdev_state *mds =
+			to_cxl_memdev_state(cxlmd->cxlds);
 
-		cxled = to_cxl_endpoint_decoder(&cxld->dev);
-		cxlmd = cxled_to_memdev(cxled);
-		mds = to_cxl_memdev_state(cxlmd->cxlds);
-		/*
-		 * For endpoint decoders hosted on CXL memory devices that
-		 * support the sanitize operation, make sure sanitize is not in-flight.
-		 */
 		if (mds && mds->security.sanitize_active) {
 			dev_dbg(&cxlmd->dev,
 				"attempted to commit %s during sanitize\n",
 				dev_name(&cxld->dev));
 			return -EBUSY;
 		}
-	} else if (is_switch_decoder(&cxld->dev)) {
-		cxlsd = to_cxl_switch_decoder(&cxld->dev);
 	}
 
 	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
-		if (cxled)
-			settings.target_or_skip = cxled->skip;
-		else if (cxlsd)
-			cxlsd_set_targets(cxlsd, &settings.target_or_skip);
-
+		cxl_decoder_snapshot(cxld, &settings);
 		rc = cxl_commit_start(&settings, hdm);
 	}
 	if (rc) {
-- 
2.54.0


DJ

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

