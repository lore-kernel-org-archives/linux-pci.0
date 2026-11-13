Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530335;
	b=Yw+ShyTRkkcnkUeFkKky381KU+jyfkvlZxPQpRZ7LqvtvbGhYFgyTXLT/YzvLtU2qaOF
	 hotCAeHCLGk2+6B4/39uWqVitN/oWmmMR88MWCGEHcHZanYVshQBrCGz3DjwTNQVjjAbS
	 GkpfMb2EN7yJIfXtUdtvITh/IMBTkySBcLKcMw0G+33RVaT7FM5CAWQaXGylJ9O5g4Pa2
	 NzzCUZsG80jgAsBvNBlz4js651nrhrzVd4Egsw5jSvLPMjVmV8ydx0jRtDskODcAePFR9
	 R5L9md0IXJZLku13gmXFYC4TPBmROY5oIEjI8TLzrn64w0pHQKgaHl8T06z90Kru2rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530335;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=canG37aXR5mJ6g5b5cttvc/Do4ZF3im4aNWYzqLWQXA=;
	b=JgVv7T83BOFzibJ5WVaATrt7+xxYSUnk5FaR3PHVHL+6X3fsxOZNI709Y22iQ3zmsIJ8
	 fIKehbNDHN1ddh4Q9jN1ItFawD2J0yafTwIvrzCmTyeBemuAJ7LEFfMfUZ1yg3UPB3Lz6
	 Mgl/3dIa2CXQUFTVDCSIpNstLm/hEwXDe/R79GJXQz17wT1LSuvZXoOJxIHui8+CGb/LD
	 w4DvYeI8v3w6iP4rwk0SvMCyrqnkQ6for71qrMTPMpJr1O7Q35Khht6blrmI4/yJe78gE
	 62c8DyqL5eDqjUeQy7X1z7NvNsRE6iuRazjfwzZGYeoBWG3TppKgFq0tK2k8/y+btdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c00IwH8z;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA530606B7C8;
	Fri, 13 Nov 2026 00:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA530606B7C8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c00IwH8z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794530335; x=1826066335;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M1TWvgEtRHxXH+HX2eeBzztaslUSiVAUKNjFskSfCH4=;
  b=c00IwH8z5DDgqUE25ROR4dqx596dTGte5NLOH38nnrTqiuxVBi6D3tTg
   IkWPTgbhNcOzlr4VxOMdhqZOm64u3PFupW2r5EY6ZrZds/Rt2xFO5jjfo
   SFKMCnns4eoOiObEwy/xF+rb1nSnKMU1lQd1nWb1Mb1q/SxzSGG2nHgMg
   xlWcXpeyuIkPlwGzEHAXiJTOyIpGbnWvA/8/HF9lSLokfQNfzrS5BtfqN
   p5EyFmcaUGq4Rb1LCMBT0JDTEt6vIUbCoDX6l2xMTrRhV98hCstmBqzhE
   cGQZdI4NfQaC593un9jvcIGNgvigz36n310aTgQaBAUuHb7sGIqC9ZXlZ
   w==;
X-CSE-ConnectionGUID: q4y6hcGuTFqRBAxnZ+Nr/A==
X-CSE-MsgGUID: fN4uGcVxRBucAKi1lZTtHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3317360"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3317360"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 16:38:54 -0800
X-CSE-ConnectionGUID: C7LLPPGbSSau07vLky1Fgw==
X-CSE-MsgGUID: s8E7UBIMTeqW99TaqSmMcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="8783891"
Received: from jjgreens-desk24.amr.corp.intel.com (HELO [10.125.111.216]) ([10.125.111.216])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 16:38:52 -0800
Message-ID: <6e795d77-081e-4c32-87ab-931d031a419c@intel.com>
Date: Thu, 12 Nov 2026 17:38:51 -0700
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
Subject: Re: [PATCH v17 09/19] cxl: Refresh cached PCI HDM decoder settings
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
 <20261105185917.2667656-10-smadhavan@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261105185917.2667656-10-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/5/26 11:59 AM, Srirangan Madhavan wrote:
> Early PCI discovery creates the HDM cache, while later CXL enumeration and
> decoder operations provide updated programming state.
> 
> Refresh the PCI snapshot when decoders are enumerated, committed, or reset
> so reset recovery need not walk the CXL topology. Keep cache access and
> locking in the built-in HDM state helpers. Ignore updates when no cache
> exists and reject decoder-count mismatches.
> 
> Use CXL_RESET for the PCI HDM cache. Shared HDM register helpers do not
> require it.
> 
> Skip cache checks and updates for DVSEC-emulated decoders, which do not
> use HDM registers. Keep cached global control when MMIO reads return all
> ones.
> 
> Non-PCI mock ports have no upstream PCI device, so the cache helpers
> ignore them. This avoids test wrappers and a circular dependency between
> cxl_core and cxl_mock.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Assisted-by: LLM
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> 
> ---
> Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=50a88f5194e5df38590d413f925d8d5afa8a8488
> ---
>  drivers/cxl/Kconfig          |  5 ++++
>  drivers/cxl/core/core.h      |  1 +
>  drivers/cxl/core/hdm.c       | 34 +++++++++++++++++++--
>  drivers/cxl/core/hdm_state.c | 57 ++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/pci.c       | 24 +++++++++++++++
>  include/cxl/cxl.h            |  1 +
>  include/cxl/hdm.h            | 32 ++++++++++++++++++++
>  include/linux/pci.h          |  6 ++++
>  8 files changed, 158 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 80aeb0d556bd..8b08bfdc4982 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -6,6 +6,7 @@ menuconfig CXL_BUS
>  	select FW_UPLOAD
>  	select PCI_DOE
>  	select FIRMWARE_TABLE
> +	select CXL_RESET
>  	select NUMA_KEEP_MEMINFO if NUMA_MEMBLKS
>  	select FWCTL if CXL_FEATURES
>  	help
> @@ -244,3 +245,7 @@ config CXL_ATL
>  	depends on ACPI_PRMT && AMD_NB
>  
>  endif
> +
> +# CXL_BUS requires the PCI HDM cache and built-in state helpers, even when modular.
> +config CXL_RESET
> +	bool
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index ea539f00e55d..e34d574f6594 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -224,6 +224,7 @@ static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
>  int cxl_gpf_port_setup(struct cxl_dport *dport);
>  
>  struct cxl_hdm;
> +int cxl_hdm_check_decoder_count(struct cxl_hdm *cxlhdm);
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  			struct cxl_endpoint_dvsec_info *info);
>  int cxl_port_get_possible_dports(struct cxl_port *port);
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 85f9abf58a42..ec387070d7ad 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -725,6 +725,24 @@ static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
>  		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
>  }
>  
> +static void cxl_hdm_refresh_decoder(struct cxl_hdm *cxlhdm,
> +				    struct cxl_decoder *cxld)
> +{
> +	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> +	struct pci_dev *pdev __free(pci_dev_put) = NULL;

Move the declaration to before you use the variable. This is an exception when it comes to var declarations in the kernel. The pattern above is discouraged.
> +
> +	if (!hdm)
> +		return;
> +	if (!is_endpoint_decoder(&cxld->dev))
> +		return;
> +
> +	pdev = cxl_port_get_uport_pci_dev(cxlhdm->port);

As mentioned above,
struct pci_dev *pdev __free(pci_dev_put) = cxl_port_get_uport_pci_dev(cxlhdm->port);

> +	if (!pdev)
> +		return;
> +	cxl_hdm_cache_refresh_decoder(pdev, hdm,
> +				      to_cxl_endpoint_decoder(&cxld->dev));
> +}
> +
>  static void
>  cxl_endpoint_decoder_snapshot(struct cxl_endpoint_decoder *cxled,
>  			      struct cxl_endpoint_decoder_settings *settings)
> @@ -805,6 +823,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  	}
>  	port->commit_end++;
>  	cxld->config.flags |= CXL_DECODER_F_ENABLE;
> +	cxl_hdm_refresh_decoder(cxlhdm, cxld);
>  
>  	return 0;
>  }
> @@ -877,6 +896,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
>  	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
>  
>  	cxld->config.flags &= ~CXL_DECODER_F_ENABLE;
> +	cxl_hdm_refresh_decoder(cxlhdm, cxld);
>  
>  	/* Userspace is now responsible for reconfiguring this decoder */
>  	if (is_endpoint_decoder(&cxld->dev)) {
> @@ -1079,13 +1099,21 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  {
>  	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>  	struct cxl_port *port = cxlhdm->port;
> -	int i;
> +	/* DVSEC-emulated decoders do not describe the cached HDM registers. */
> +	bool emulated = should_emulate_decoders(info);
>  	u64 dpa_base = 0;
> +	int i, rc;
> +
> +	if (is_cxl_endpoint(port) && hdm && !emulated) {
> +		rc = cxl_hdm_check_decoder_count(cxlhdm);
> +		if (rc)
> +			return rc;
> +	}
>  
>  	cxl_settle_decoders(cxlhdm);
>  
>  	for (i = 0; i < cxlhdm->decoder_count; i++) {
> -		int rc, target_count = cxlhdm->target_count;
> +		int target_count = cxlhdm->target_count;
>  		struct cxl_decoder *cxld;
>  
>  		if (is_cxl_endpoint(port)) {
> @@ -1120,6 +1148,8 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  			put_device(&cxld->dev);
>  			return rc;
>  		}
> +		if (!emulated)
> +			cxl_hdm_refresh_decoder(cxlhdm, cxld);
>  		rc = add_hdm_decoder(port, cxld);
>  		if (rc) {
>  			dev_warn(&port->dev,
> diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
> index c9cc019902ef..d4c2be1ef833 100644
> --- a/drivers/cxl/core/hdm_state.c
> +++ b/drivers/cxl/core/hdm_state.c
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
>  #include <linux/export.h>
> +#include <linux/io.h>
> +#include <linux/pci.h>
>  #include <linux/rwsem.h>
>  
>  #include <cxl/hdm.h>
> @@ -13,3 +15,58 @@ struct cxl_rwsem cxl_rwsem = {
>  	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
>  };
>  EXPORT_SYMBOL_FOR_MODULES(cxl_rwsem, "cxl_core");
> +
> +void cxl_hdm_cache_refresh_decoder(struct pci_dev *pdev, void __iomem *hdm,
> +				   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_endpoint_decoder_settings *settings;
> +	struct cxl_decoder *cxld = &cxled->cxld;
> +	struct cxl_hdm_info *info;
> +	u32 global_ctrl;
> +	int id;
> +
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	id = cxld->config.id;
> +	info = pdev->hdm;
> +	if (!info)
> +		return;
> +	if (id < 0 || id >= info->decoder_count) {
> +		pci_warn(pdev, "CXL HDM decoder %d exceeds cached count %d\n",
> +			 id, info->decoder_count);
> +		return;
> +	}
> +
> +	/* Preserve the last good value when the device does not respond. */
> +	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +	if (global_ctrl != U32_MAX)
> +		info->global_ctrl = global_ctrl;
> +	settings = &info->settings[id];
> +
> +	/*
> +	 * A disabled decoder's software object may retain its old range and
> +	 * skip state. Leave only the decoder id in the cached settings so stale
> +	 * state is not restored as an enabled decode.
> +	 */
> +	*settings = (struct cxl_endpoint_decoder_settings) {
> +		.config.id = id,
> +	};
> +	if (cxld->config.flags & CXL_DECODER_F_ENABLE) {
> +		settings->config = cxld->config;
> +		settings->skip = cxled->skip;
> +	}
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_cache_refresh_decoder, "cxl_core");

kdoc header for exported symbol

> +
> +int cxl_hdm_cache_check_decoder_count(struct pci_dev *pdev, int count)

In the end we are just looking to see if there's a match right? I think returning a bool and changing the function name to be more obvious.

bool cxl_hdm_cache_decoder_count_match() maybe?

> +{
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	if (pdev->hdm && pdev->hdm->decoder_count != count) {
> +		pci_warn(pdev,
> +			 "CXL HDM cache decoder count mismatch: cached=%d hdm=%d\n",
> +			 pdev->hdm->decoder_count, count);
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_cache_check_decoder_count, "cxl_core");

kdoc header for exported symbol. Also are you sure this symbol needs to be exported?

DJ

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index f72cd8f50e77..5272013548c7 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -6,6 +6,7 @@
>  #include <linux/delay.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
> +#include <cxl/hdm.h>
>  #include <cxl/pci.h>
>  #include <linux/aer.h>
>  #include <cxlpci.h>
> @@ -180,6 +181,29 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, "CXL");
>  
> +/**
> + * cxl_hdm_check_decoder_count() - check enumeration against the PCI HDM cache
> + * @cxlhdm: HDM capability containing the decoder count to check
> + *
> + * Take cxl_rwsem.dpa for read while comparing the cached count. Call only
> + * for hardware HDM decoders, since DVSEC-emulated ranges do not describe
> + * the HDM registers represented by the cache.
> + *
> + * Return: 0 if the counts match or no upstream PCI device or cache exists,
> + * or -ENXIO if the cached and enumerated decoder counts differ.
> + */
> +int cxl_hdm_check_decoder_count(struct cxl_hdm *cxlhdm)
> +{
> +	struct pci_dev *pdev __free(pci_dev_put) =
> +		cxl_port_get_uport_pci_dev(cxlhdm->port);
> +
> +	if (!pdev)
> +		return 0;
> +
> +	return cxl_hdm_cache_check_decoder_count(pdev, cxlhdm->decoder_count);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_hdm_check_decoder_count, "CXL");
> +
>  static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
>  {
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 6d6e564be27a..341a7c52894a 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -26,6 +26,7 @@ enum cxl_devtype {
>  };
>  
>  struct cxl_region;
> +struct cxl_hdm_info;
>  
>  enum cxl_decoder_type {
>  	CXL_DECODER_DEVMEM = 2,
> diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
> index 219b9bb67440..06e9aa4479c2 100644
> --- a/include/cxl/hdm.h
> +++ b/include/cxl/hdm.h
> @@ -6,6 +6,9 @@
>  #include <linux/types.h>
>  #include <cxl/cxl.h>
>  
> +struct pci_dev;
> +struct cxl_endpoint_decoder;
> +
>  /**
>   * struct cxl_endpoint_decoder_settings - endpoint HDM decoder programming
>   * @config: common decoder configuration
> @@ -16,4 +19,33 @@ struct cxl_endpoint_decoder_settings {
>  	u64 skip;
>  };
>  
> +/**
> + * struct cxl_hdm_info - cached CXL HDM state for a PCI device
> + * @decoder_count: number of entries in @settings
> + * @hdm_bar: PCI BAR containing the HDM decoder capability
> + * @hdm_offset: offset of the HDM decoder capability in @hdm_bar
> + * @hdm_size: size of the HDM decoder register block
> + * @global_ctrl: HDM decoder global control register
> + * @dvsec_ctrl: CXL DVSEC control register
> + * @dvsec_ctrl_valid: whether @dvsec_ctrl contains valid state
> + * @settings: per-endpoint-decoder programming state
> + *
> + * Publication through pci_dev.hdm and all mutable fields are protected by
> + * cxl_rwsem.dpa.
> + */
> +struct cxl_hdm_info {
> +	int decoder_count;
> +	int hdm_bar;
> +	resource_size_t hdm_offset;
> +	resource_size_t hdm_size;
> +	u32 global_ctrl;
> +	u16 dvsec_ctrl;
> +	bool dvsec_ctrl_valid;
> +	struct cxl_endpoint_decoder_settings settings[] __counted_by(decoder_count);
> +};
> +
> +void cxl_hdm_cache_refresh_decoder(struct pci_dev *pdev, void __iomem *hdm,
> +				   struct cxl_endpoint_decoder *cxled);
> +int cxl_hdm_cache_check_decoder_count(struct pci_dev *pdev, int count);
> +
>  #endif /* __CXL_HDM_H__ */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d31a8d107b1e..7bb37fcb556d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -339,6 +339,9 @@ struct pcie_link_state;
>  struct pci_sriov;
>  struct pci_p2pdma;
>  struct rcec_ea;
> +#ifdef CONFIG_CXL_RESET
> +struct cxl_hdm_info;
> +#endif
>  
>  /* struct pci_dev - describes a PCI device
>   *
> @@ -566,6 +569,9 @@ struct pci_dev {
>  #ifdef CONFIG_PCI_DOE
>  	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
>  #endif
> +#ifdef CONFIG_CXL_RESET
> +	struct cxl_hdm_info *hdm;	/* CXL HDM decoder state */
> +#endif
>  #ifdef CONFIG_PCI_NPEM
>  	struct npem	*npem;		/* Native PCIe Enclosure Management */
>  #endif

