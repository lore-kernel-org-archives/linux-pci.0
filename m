Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793082237;
	b=3jDyYCwiycZVvkYlv3QJWL1kl16jt9xPb82I/G9ClPgchIOjvTFUwaihdKpBsZmCYMh9
	 pregiWWey7dK+pdbNtV2H87Qtm4cxoHi2GIo36evTY0y9iCwzY8rP36jtIjJs/jUJ1xBJ
	 Hb/Vq44u02JxiSyJBWKHho1KZhlm4fGlUN/C7BkzVSEkWGc3VhNWclk4+SyUtGVv9jyOB
	 +wBEizUKqb5HMCfhwp6F8dTBZ2lhzAd7wf5llt7H1pWE8Kq3Xqbt8WRkJ6Qp5tFhALiqK
	 R1GHZzk67Dn3LjfWsiTsQgcwoUnTRbQYNhhtYAdsp9qp9AuFl2qPYQTKn+91QmSm0BA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793082237;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=ony/t3FzVQIfp32uUoV1L1kvWthbv1P2YPi5ZVyWWjA=;
	b=Ong8W+Pk9d0pdAV8XIjYd1tOOLI67hzS0GRbwEU+ZfZez4gyvjFwfHYLCXv2ZKM1h1ii
	 Ap6GlukfDP4T+gRWBjTmXACgOMw+abVr4si9Ch+zHab/BRMPJ/ybbmdOrJ0wLdi0CLn9e
	 WybVAGwjNVHdXSLMEjWDDQMNiSsfw8bXacqA3PAY6BoTYdtoZ/IPDEma3NjzRRzc8YUec
	 Vc0Rht6XHmNwYb3m0SmyeDT3djIkObD90jlz+3g5WI3QxW3531bPae0rUKB7ZjQ0zXfs6
	 aNbyUmm/LzgYIESvEXbLmZS0zAS/WbdSf2ciMB/leEpVfM0xy9OVUfrQXp1vrP6mXCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=ming.li@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=agRyqMhw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
Received: from sender6-pp-o94.zoho.com (sender6-pp-o94.zoho.com [165.173.180.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ED0606A31A;
	Tue, 27 Oct 2026 06:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98ED0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=ming.li@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=agRyqMhw
ARC-Seal: i=1; a=rsa-sha256; t=1793082219; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NGY3Ixw29i1J1sf+JfJ18Hb0iG4e7NoTP0WPl/XPRVdWGQ2yQmYFM82F3sVKoJDmqr1dMqBPmuNWEzUjMsw8IPatx95I3RtCnXdXcxX3GoVZ7s00ciwbbB6XXWwjZuEw+CCY08zi1bnYYc4+njaJJLfXQNAc8OX90Pdz5dm/r0A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793082219; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ony/t3FzVQIfp32uUoV1L1kvWthbv1P2YPi5ZVyWWjA=; 
	b=gAHUr8Udnp7OI2J9dXWUyXTlqWUZxKO9RZxD+6ZiybtIGeGRDMj07U0BLc999RJqshBEng4LS4s5LS6aN7e9woJbGwcdF3cmc4qyIiUBVf+JGl7uCP2/UKeOXnZtauozZPPpnEip1gkU0PWYecHtEnDupKSeL/6KmyZYAVrfJEQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793082219;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=ony/t3FzVQIfp32uUoV1L1kvWthbv1P2YPi5ZVyWWjA=;
	b=agRyqMhwr+seuykMnHcBaCN1P86adzCkyzYNdi5psf1Njw/5A60BF+T8gWlKVCY4
	k1Ijhn7XmnD/yWae5wyDln2EsA7/Qkj3CxlEqdPCQxggIOddWBo21cadwL8Sbi/yBli
	uidepXkDEPZzBvEjnmAH/5V7mdZze5/b6xdyrZok=
Received: by smtp.zohomail.com with SMTPS id 1793082217987942.7838015861566;
	Mon, 26 Oct 2026 23:23:37 -0700 (PDT)
Message-ID: <ab603034-2700-4556-ab1d-d3de19532882@zohomail.com>
Date: Tue, 27 Oct 2026 14:23:30 +0800
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
Subject: Re: [PATCH v15 05/16] cxl: Introduce endpoint HDM decoder settings
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
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-6-smadhavan@nvidia.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20261011021422.3428136-6-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227d5a5bcf1ea3af5a0e3671a0c0000866b4b3bb602a672a58ebdc37ceab65069b7be1d023b618a57:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/10/11 10:14, Srirangan Madhavan 写道:
> Keep common decoder configuration in cxl_decoder_config and represent
> endpoint DPA skip in cxl_endpoint_decoder_settings. Share range
> programming, but keep endpoint skip and switch target-list writes in
> their respective commit paths.
>
> Separate commit initiation from completion waiting so reset restoration
> can reuse register programming without changing normal DPA-lock policy.
>
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=20f9084b5b763238e2f18f629916bbbb46ec9f7d
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Assisted-by: LLM
Reviewed-by: Li Ming <ming.li@zohomail.com>

Just a minor comment below.

> ---
>   drivers/cxl/core/core.h |  8 ++++
>   drivers/cxl/core/hdm.c  | 96 ++++++++++++++++++++++++++++-------------
>   include/cxl/hdm.h       | 19 ++++++++
>   3 files changed, 93 insertions(+), 30 deletions(-)
>   create mode 100644 include/cxl/hdm.h
>
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 983d7690c3a5..fb14b222f3ca 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -7,6 +7,8 @@
>   #include <cxl/mailbox.h>
>   #include <linux/rwsem.h>
>   
> +struct cxl_endpoint_decoder_settings;
> +
>   extern const struct device_type cxl_nvdimm_bridge_type;
>   extern const struct device_type cxl_nvdimm_type;
>   extern const struct device_type cxl_pmu_type;
> @@ -139,6 +141,12 @@ struct cxl_rwsem {
>   
>   extern struct cxl_rwsem cxl_rwsem;
>   
> +void cxl_commit_start_endpoint(const struct cxl_endpoint_decoder_settings *settings,
> +			       void __iomem *hdm);
> +void cxl_commit_start_switch(const struct cxl_decoder_config *config,
> +			     u64 targets, void __iomem *hdm);
> +int cxld_await_commit(void __iomem *hdm, int id);
> +
>   int cxl_memdev_init(void);
>   void cxl_memdev_exit(void);
>   void cxl_mbox_init(void);
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 9e05032a5426..7d3254a712e4 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -3,6 +3,7 @@
>   #include <linux/seq_file.h>
>   #include <linux/device.h>
>   #include <linux/delay.h>
> +#include <cxl/hdm.h>
>   
>   #include "cxlmem.h"
>   #include "core.h"
> @@ -707,7 +708,7 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>   	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>   }
>   
> -static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
> +static void cxld_set_interleave(const struct cxl_decoder_config *config, u32 *ctrl)
>   {
>   	u16 eig;
>   	u8 eiw;
> @@ -716,12 +717,12 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>   	 * Input validation ensures these warns never fire, but otherwise
>   	 * suppress unititalized variable usage warnings.
>   	 */
> -	if (WARN_ONCE(ways_to_eiw(cxld->config.interleave_ways, &eiw),
> -		      "invalid interleave_ways: %d\n", cxld->config.interleave_ways))
> +	if (WARN_ONCE(ways_to_eiw(config->interleave_ways, &eiw),
> +		      "invalid interleave_ways: %d\n", config->interleave_ways))
>   		return;
> -	if (WARN_ONCE(granularity_to_eig(cxld->config.interleave_granularity, &eig),
> +	if (WARN_ONCE(granularity_to_eig(config->interleave_granularity, &eig),
>   		      "invalid interleave_granularity: %d\n",
> -		      cxld->config.interleave_granularity))
> +		      config->interleave_granularity))
>   		return;
>   
>   	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
> @@ -729,10 +730,10 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>   	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
>   }
>   
> -static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
> +static void cxld_set_type(const struct cxl_decoder_config *config, u32 *ctrl)
>   {
>   	u32p_replace_bits(ctrl,
> -			  !!(cxld->config.target_type == CXL_DECODER_HOSTONLYMEM),
> +			  !!(config->target_type == CXL_DECODER_HOSTONLYMEM),
>   			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
>   }
>   
> @@ -764,7 +765,7 @@ static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
>    * clock skew and other marginal behavior
>    */
>   #define COMMIT_TIMEOUT_MS 20
> -static int cxld_await_commit(void __iomem *hdm, int id)
> +int cxld_await_commit(void __iomem *hdm, int id)
>   {
>   	u32 ctrl;
>   	int i;
> @@ -784,45 +785,80 @@ static int cxld_await_commit(void __iomem *hdm, int id)
>   	return -ETIMEDOUT;
>   }
>   
> -static void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
> +static u32 cxl_hdm_write_range(void __iomem *hdm,
> +			       const struct cxl_decoder_config *config)
>   {
> -	int id = cxld->config.id;
> -	u64 base, size;
> +	u64 size = range_len(&config->hpa_range);
> +	u64 base = config->hpa_range.start;
> +	int id = config->id;
>   	u32 ctrl;
>   
> -	/* common decoder settings */
> -	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->config.id));
> -	cxld_set_interleave(cxld, &ctrl);
> -	cxld_set_type(cxld, &ctrl);
> -	base = cxld->config.hpa_range.start;
> -	size = range_len(&cxld->config.hpa_range);
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	cxld_set_interleave(config, &ctrl);
> +	cxld_set_type(config, &ctrl);
>   
>   	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
>   	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
>   	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
>   	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	return ctrl;
> +}
> +
> +void cxl_commit_start_endpoint(const struct cxl_endpoint_decoder_settings *settings,
> +			       void __iomem *hdm)
> +{
> +	int id = settings->config.id;
> +	u32 ctrl;
> +
> +	lockdep_assert_held(&cxl_rwsem.dpa);
> +	ctrl = cxl_hdm_write_range(hdm, &settings->config);
> +	writel(upper_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_HIGH(id));
> +	writel(lower_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +}
> +
> +void cxl_commit_start_switch(const struct cxl_decoder_config *config,
> +			     u64 targets, void __iomem *hdm)
> +{
> +	int id = config->id;
> +	u32 ctrl;
> +
> +	lockdep_assert_held(&cxl_rwsem.dpa);
> +	ctrl = cxl_hdm_write_range(hdm, config);
> +	writel(upper_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_HIGH(id));
> +	writel(lower_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_LOW(id));
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +}
> +
> +static void
> +cxl_endpoint_decoder_snapshot(struct cxl_endpoint_decoder *cxled,
> +			      struct cxl_endpoint_decoder_settings *settings)
> +{
> +	lockdep_assert_held(&cxl_rwsem.dpa);
> +
> +	*settings = (struct cxl_endpoint_decoder_settings) {
> +		.config = cxled->cxld.config,
> +		.skip = cxled->skip,
> +	};
> +}
> +
> +static void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
> +{
> +	struct cxl_endpoint_decoder_settings settings;
>   
>   	if (is_switch_decoder(&cxld->dev)) {
>   		struct cxl_switch_decoder *cxlsd =
>   			to_cxl_switch_decoder(&cxld->dev);
> -		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
> -		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
>   		u64 targets;
>   
>   		cxlsd_set_targets(cxlsd, &targets);
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
> +		cxl_commit_start_switch(&cxld->config, targets, hdm);
> +		return;
>   	}
>   
> -	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	cxl_endpoint_decoder_snapshot(to_cxl_endpoint_decoder(&cxld->dev),
> +				      &settings);
> +	cxl_commit_start_endpoint(&settings, hdm);
I think if-else block is clearer, maybe we can keep the if-else block 
here to remove the return statement.
>   }
>   
>   static int cxl_decoder_commit(struct cxl_decoder *cxld)
> diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
> new file mode 100644
> index 000000000000..219b9bb67440
> --- /dev/null
> +++ b/include/cxl/hdm.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
> +#ifndef __CXL_HDM_H__
> +#define __CXL_HDM_H__
> +
> +#include <linux/types.h>
> +#include <cxl/cxl.h>
> +
> +/**
> + * struct cxl_endpoint_decoder_settings - endpoint HDM decoder programming
> + * @config: common decoder configuration
> + * @skip: length of DPA space skipped before this decoder's DPA mapping
> + */
> +struct cxl_endpoint_decoder_settings {
> +	struct cxl_decoder_config config;
> +	u64 skip;
> +};
> +
> +#endif /* __CXL_HDM_H__ */
