Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793082312;
	b=qsh70Q6ayfQzms7wbaCfP3G463p2E74st4aWhBAPtvI544ss1pj/dIeGvdfGQIsH/1S/
	 boDh5l1MXSJPos9CFoe3FoMwdxzYtWiovlnjO9AjOorGWRGXP0tH5zlCGlr6KAtf02GqX
	 IY+jAPechi9F5bvTOYnskKpLRnXpNl7/vi2Nwtw1fJoWqa9wW1fMKdgTvn64GhMkC2Upq
	 jN6OZxUR678olVv2mfBjl2lpGmZ1wfYpL/RsOXZohER3ZdxXMqwXlYLXs4c3MjvhEMcq7
	 puzEJkroFbaRh2LSWAXlEWJ/nxVGBXGBSTIZZZB0O/anW4ZuaBF619YSa/Iz8KPl/Qw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793082312;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=doDzdi26jBnHFq4dpTwYQK+HFfWbmPXdDrj7Pa91p9w=;
	b=PrDeVZJJwpI/ZJgcYoTIaE5AzE0UhSrSOpUpeztcJE6fJ5dwEWqXUMu7wOs/H+lFDwxE
	 7axzDKt6L+V4pK9aYXD4gGPaezVLX5RjMH7WkOIylJoe4CTe0vs5a0rb/5dsMT6cVyk7D
	 xm6zGKOkNrRlcAtvsk0vmrDkDUOJy0pXHolZvZ+c/A0JeY2OYE7BBs7unzWci5RJ3mZoS
	 rxvXBIBcEoeDhB7tVTCxtqoscWQmto1LFE0lQc/bTPxb+bNMcn0CQwrU6mQWpOmtVPcfM
	 VPZWCjKNpKE3L6KO2uCyMGC1mLxHOfkbVnTOW5oYdnGPNXZOce00MHX3DlA5ZJVqQZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=ming.li@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=B14mXVex;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
Received: from sender6-pp-o94.zoho.com (sender6-pp-o94.zoho.com [165.173.180.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88255606A320;
	Tue, 27 Oct 2026 06:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88255606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=ming.li@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=B14mXVex
ARC-Seal: i=1; a=rsa-sha256; t=1793082299; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mmDBTSNhUlvTEs9r1HnqcyPFy1kzi0uUU3xZlLEbgOYzQG5YoJdwo6nAE9U740KQ9Ttcxt2KZrEJhE5LXlxsqtMhv90uvni+kTPQZ5fK7LU8ehhH9gXDkxx56tvkOQw0kiNUJPz7Ho3bpJpFwaZbJ1LuPiYZGiVlzvjPyuU2nws=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793082299; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=doDzdi26jBnHFq4dpTwYQK+HFfWbmPXdDrj7Pa91p9w=; 
	b=LvEGVJH05UyqrLO3Vv8tv6N399Hv6sZx/MUupkzQzko9TEzd+5jjXSFSKSsiJj9Qr5H5onJpFQ3SXMMQ2KBsoi9slDdKDf0pDOYelrxIQMfgUJYlW06kHXoOxiwbQTXWaWI+Exts4KVKTzZ48zYzgBHKFCLEzpjyNeuZ8zcUVRc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793082299;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=doDzdi26jBnHFq4dpTwYQK+HFfWbmPXdDrj7Pa91p9w=;
	b=B14mXVex9gqTofJRIITbB4KJiAGLYoD9knqYKlnVGNsm0ugpMAU/pRGa4qo7sgPD
	sQJS5f57RF+Mz0UxJkAIMhmSJVN69vwX513Ipry2JpwWHnIXU+yXY3/XcUzh9derJeN
	ZLeJfAsYazZ0Ldr3/BPiFtYph3jJJ76y/jZvqsOg=
Received: by smtp.zohomail.com with SMTPS id 1793082297748697.7650174671242;
	Mon, 26 Oct 2026 23:24:57 -0700 (PDT)
Message-ID: <fdce3af1-848c-4fe9-983c-ee7f974e2042@zohomail.com>
Date: Tue, 27 Oct 2026 14:24:52 +0800
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
Subject: Re: [PATCH v15 06/16] cxl: Move HDM decoder helpers to built-in code
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
 <20261011021422.3428136-7-smadhavan@nvidia.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20261011021422.3428136-7-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227dd798705a3ead4506f5ed0a0000040c91e672e3677c011833933a347e2b19734aa6b3a10384399:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/10/11 10:14, Srirangan Madhavan 写道:
> The PCI core will restore HDM decoders after a reset, possibly while no
> CXL driver is loaded, so it cannot call into cxl_core.
>
> Move the HDM register programming helpers from hdm.c to hdm_regs.c and
> build that file into the kernel whenever CXL_BUS is enabled, including
> when CXL_BUS is modular. Export only the symbols that cxl_core uses.
>
> Keep the DPA lock assertion in the normal decoder programming caller so
> the register helpers do not depend on cxl_rwsem. Leave cxl_rwsem in
> cxl_core until built-in cache management needs it.
>
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=e0b476ea99567fb5aa416eac0cf61bca20724880
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>

> ---
>   drivers/cxl/core/Makefile   |   1 +
>   drivers/cxl/core/hdm.c      | 102 +------------------------------
>   drivers/cxl/core/hdm_regs.c | 118 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 121 insertions(+), 100 deletions(-)
>   create mode 100644 drivers/cxl/core/hdm_regs.c
>
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index ce7213818d3c..6703c1729396 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -1,5 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_CXL_BUS) += cxl_core.o
> +obj-$(subst m,y,$(CONFIG_CXL_BUS)) += hdm_regs.o
>   obj-$(CONFIG_CXL_SUSPEND) += suspend.o
>   
>   ccflags-y += -I$(srctree)/drivers/cxl
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7d3254a712e4..47cf49bcd2e5 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -708,35 +708,6 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>   	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>   }
>   
> -static void cxld_set_interleave(const struct cxl_decoder_config *config, u32 *ctrl)
> -{
> -	u16 eig;
> -	u8 eiw;
> -
> -	/*
> -	 * Input validation ensures these warns never fire, but otherwise
> -	 * suppress unititalized variable usage warnings.
> -	 */
> -	if (WARN_ONCE(ways_to_eiw(config->interleave_ways, &eiw),
> -		      "invalid interleave_ways: %d\n", config->interleave_ways))
> -		return;
> -	if (WARN_ONCE(granularity_to_eig(config->interleave_granularity, &eig),
> -		      "invalid interleave_granularity: %d\n",
> -		      config->interleave_granularity))
> -		return;
> -
> -	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
> -	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
> -	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
> -}
> -
> -static void cxld_set_type(const struct cxl_decoder_config *config, u32 *ctrl)
> -{
> -	u32p_replace_bits(ctrl,
> -			  !!(config->target_type == CXL_DECODER_HOSTONLYMEM),
> -			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
> -}
> -
>   static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
>   {
>   	struct cxl_dport **t = &cxlsd->target[0];
> @@ -759,77 +730,6 @@ static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
>   		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
>   }
>   
> -/*
> - * Per CXL 2.0 8.2.5.12.20 Committing Decoder Programming, hardware must set
> - * committed or error within 10ms, but just be generous with 20ms to account for
> - * clock skew and other marginal behavior
> - */
> -#define COMMIT_TIMEOUT_MS 20
> -int cxld_await_commit(void __iomem *hdm, int id)
> -{
> -	u32 ctrl;
> -	int i;
> -
> -	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
> -		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMIT_ERROR, ctrl)) {
> -			ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
> -			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> -			return -EIO;
> -		}
> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> -			return 0;
> -		fsleep(1000);
> -	}
> -
> -	return -ETIMEDOUT;
> -}
> -
> -static u32 cxl_hdm_write_range(void __iomem *hdm,
> -			       const struct cxl_decoder_config *config)
> -{
> -	u64 size = range_len(&config->hpa_range);
> -	u64 base = config->hpa_range.start;
> -	int id = config->id;
> -	u32 ctrl;
> -
> -	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> -	cxld_set_interleave(config, &ctrl);
> -	cxld_set_type(config, &ctrl);
> -
> -	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> -	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> -	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> -	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> -	return ctrl;
> -}
> -
> -void cxl_commit_start_endpoint(const struct cxl_endpoint_decoder_settings *settings,
> -			       void __iomem *hdm)
> -{
> -	int id = settings->config.id;
> -	u32 ctrl;
> -
> -	lockdep_assert_held(&cxl_rwsem.dpa);
> -	ctrl = cxl_hdm_write_range(hdm, &settings->config);
> -	writel(upper_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_HIGH(id));
> -	writel(lower_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
> -	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> -}
> -
> -void cxl_commit_start_switch(const struct cxl_decoder_config *config,
> -			     u64 targets, void __iomem *hdm)
> -{
> -	int id = config->id;
> -	u32 ctrl;
> -
> -	lockdep_assert_held(&cxl_rwsem.dpa);
> -	ctrl = cxl_hdm_write_range(hdm, config);
> -	writel(upper_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_HIGH(id));
> -	writel(lower_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_LOW(id));
> -	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> -}
> -
>   static void
>   cxl_endpoint_decoder_snapshot(struct cxl_endpoint_decoder *cxled,
>   			      struct cxl_endpoint_decoder_settings *settings)
> @@ -846,6 +746,8 @@ static void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
>   {
>   	struct cxl_endpoint_decoder_settings settings;
>   
> +	lockdep_assert_held(&cxl_rwsem.dpa);
> +
>   	if (is_switch_decoder(&cxld->dev)) {
>   		struct cxl_switch_decoder *cxlsd =
>   			to_cxl_switch_decoder(&cxld->dev);
> diff --git a/drivers/cxl/core/hdm_regs.c b/drivers/cxl/core/hdm_regs.c
> new file mode 100644
> index 000000000000..53d2f236e49c
> --- /dev/null
> +++ b/drivers/cxl/core/hdm_regs.c
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
> +#include <linux/delay.h>
> +#include <linux/bug.h>
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/kernel.h>
> +
> +#include <cxl/hdm.h>
> +
> +#include "cxl.h"
> +#include "core.h"
> +
> +/*
> + * HDM decoder register helpers are built in whenever CXL_BUS is enabled,
> + * including when cxl_core is modular. Callers provide any required locking.
> + */
> +
> +static void cxld_set_interleave(const struct cxl_decoder_config *config, u32 *ctrl)
> +{
> +	u16 eig;
> +	u8 eiw;
> +
> +	/*
> +	 * Input validation ensures these warns never fire, but otherwise
> +	 * suppress unititalized variable usage warnings.
> +	 */
> +	if (WARN_ONCE(ways_to_eiw(config->interleave_ways, &eiw),
> +		      "invalid interleave_ways: %d\n", config->interleave_ways))
> +		return;
> +	if (WARN_ONCE(granularity_to_eig(config->interleave_granularity, &eig),
> +		      "invalid interleave_granularity: %d\n",
> +		      config->interleave_granularity))
> +		return;
> +
> +	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
> +	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
> +	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
> +}
> +
> +static void cxld_set_type(const struct cxl_decoder_config *config, u32 *ctrl)
> +{
> +	u32p_replace_bits(ctrl,
> +			  !!(config->target_type == CXL_DECODER_HOSTONLYMEM),
> +			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
> +}
> +
> +/*
> + * Per CXL 2.0 8.2.5.12.20 Committing Decoder Programming, hardware must set
> + * committed or error within 10ms, but just be generous with 20ms to account for
> + * clock skew and other marginal behavior
> + */
> +#define COMMIT_TIMEOUT_MS 20
> +int cxld_await_commit(void __iomem *hdm, int id)
> +{
> +	u32 ctrl;
> +	int i;
> +
> +	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
> +		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMIT_ERROR, ctrl)) {
> +			ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
> +			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +			return -EIO;
> +		}
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> +			return 0;
> +		fsleep(1000);
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxld_await_commit, "cxl_core");
> +
> +static u32 cxl_hdm_write_range(void __iomem *hdm,
> +			       const struct cxl_decoder_config *config)
> +{
> +	u64 size = range_len(&config->hpa_range);
> +	u64 base = config->hpa_range.start;
> +	int id = config->id;
> +	u32 ctrl;
> +
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	cxld_set_interleave(config, &ctrl);
> +	cxld_set_type(config, &ctrl);
> +
> +	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> +	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> +	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	return ctrl;
> +}
> +
> +void cxl_commit_start_endpoint(const struct cxl_endpoint_decoder_settings *settings,
> +			       void __iomem *hdm)
> +{
> +	int id = settings->config.id;
> +	u32 ctrl;
> +
> +	ctrl = cxl_hdm_write_range(hdm, &settings->config);
> +	writel(upper_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_HIGH(id));
> +	writel(lower_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_commit_start_endpoint, "cxl_core");
> +
> +void cxl_commit_start_switch(const struct cxl_decoder_config *config,
> +			     u64 targets, void __iomem *hdm)
> +{
> +	int id = config->id;
> +	u32 ctrl;
> +
> +	ctrl = cxl_hdm_write_range(hdm, config);
> +	writel(upper_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_HIGH(id));
> +	writel(lower_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_LOW(id));
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_commit_start_switch, "cxl_core");
