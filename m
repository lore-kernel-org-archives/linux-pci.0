Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055381;
	b=JgE0zo9lXApUN19RbRYS+rUrPmic4gYJKv+A/Pfu0Y9YjBNFrv8alrWkHzt5URqTR4qy
	 K/TvdTiAxJA3bxCeReV6iEkrBRzF+qwzKpluvn0Zp7UujIcve+gBuJM+kjcbfPOF+yzWi
	 /bvgyNSHHYsk3Rt4pgNUm9f7c91kUm8O+E5UZMlW9XT5+WE1YcgRGpVkc1QiyMvAmJJMR
	 eIu9L2vqBpczN2Ii8ZG0UENp6DIDmfoWtYIVAEFB/NKniVkQYrLfXl/lE2GXoK60oUxw6
	 q3BnF52H/YQ2HAYgsp2S4eW/BKuv+RnLnTJ+0fIRgIOk4HZ7lRgk8CujtzvJ05rTd8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055381;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=5KXWNpM3l7eZ2uuYNviWQ+utc8EtZYeR0hwdFT7B3zw=;
	b=nLTTEHe0jza0EJE9HmI0M1zBzM9whJevRSfs6HU6SxBeixQLuz9AbGPvOQnAFuuEZPMG
	 2IXg6J3OrfPUIL4YWGbrGk9n5EjGO7ho+LYMQmTTiBSgtGuDFS7A6iOweVxG83/lHymrI
	 I+JGaEzUgMhvY90zJuzVRuGp+Bq6yQFySgbP+T7LfVxejVbweL7McFUoIdMl2k8Ruux64
	 YdXU18nFQWcNediq6+TFbgXZEIMoU5kHAvTT2jLJCRIGTkXC+2VIo2MpEgaTYZM5R/Xz0
	 yUbN94YHUi+YJOb5G9bMG+am+NYdoQG/cLRfYC7TllcLfkM19x3T3yxJpkKdINHCZZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gdIm4kfc;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C34606A32E;
	Mon, 26 Oct 2026 22:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5C34606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gdIm4kfc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793055380; x=1824591380;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=apTiQPMdtSAB4IiLfrFTkXgfQZZauBljipfkSL7Abtg=;
  b=gdIm4kfcJvJzqAH0PVLO2fqIN6hDHJ2viAERhHd8uzaL+YI9qijHb/ai
   KZCqeQHcpYGQM9PN8BtcDqRBzlkYKc2oBre9u1FXdZc86+Fpi32XBp0PO
   V/ZejUe1ClwzgoIoC9fP7HMiQTPbfFZG9sbxayfCmtBkW55CTof0rrKyd
   Ft9AinrMiScc3DvAPepPy5JKwwMJLlHQH81OKCX0dtLTkKT8OBU1fLR0h
   51aLIMMJChqrEXxReDsm8bn5N4aPrehdLbWXA20QeA2z/+ZTCP6DphrCR
   tDIBVHznmNLgVkyWztPKgr4DeqrifKHlI4a/K9EjWEPhMQBJLP3lZziGl
   w==;
X-CSE-ConnectionGUID: j/HSNaLdTzGiOT15YPxA/g==
X-CSE-MsgGUID: JIAnUqjaSTaiV+iZB9fw+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1618040"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1618040"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 15:56:19 -0700
X-CSE-ConnectionGUID: RuzZhOdOTYC81FUNd8B7jw==
X-CSE-MsgGUID: +xBgjqEhSImIh2fNbmnBdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="6218976"
Received: from smithj1-mobl2.amr.corp.intel.com (HELO [10.125.108.112]) ([10.125.108.112])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 15:56:18 -0700
Message-ID: <db212bda-9642-4b78-9bb0-c75aa60df401@intel.com>
Date: Mon, 26 Oct 2026 15:56:16 -0700
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
Subject: Re: [PATCH v15 08/16] cxl: Refresh cached PCI HDM decoder settings
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-9-smadhavan@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261011021422.3428136-9-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/10/26 7:14 PM, Srirangan Madhavan wrote:
> Early PCI discovery creates the HDM cache, while later CXL enumeration and
> decoder operations provide updated programming state.
> 
> Refresh the PCI snapshot when decoders are enumerated, committed, or reset
> so reset recovery need not walk the CXL topology. Ignore updates when no
> cache exists and reject decoder-count mismatches.
> 
> Use CXL_RESET for the PCI HDM cache. Shared HDM register helpers do not
> require it.
> 
> Skip cache checks and updates for DVSEC-emulated decoders, which do not
> use HDM registers. Keep cached global control when MMIO reads return all
> ones.
> 
> Skip non-PCI mock ports to avoid test wrappers and a circular dependency
> between cxl_core and cxl_mock.

Maybe consider saying:
Non-PCI mock ports have no upstream PCI device, so the cache helpers ignore them. This avoids test wrappers and a circular dependency between cxl_core and cxl_mock.

> 
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=50a88f5194e5df38590d413f925d8d5afa8a8488
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Assisted-by: LLM

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/Kconfig     |  5 +++
>  drivers/cxl/core/core.h |  3 ++
>  drivers/cxl/core/hdm.c  | 55 +++++++++++++++++++++++++++++++-
>  drivers/cxl/core/pci.c  | 70 +++++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h       |  1 +
>  include/cxl/hdm.h       | 25 +++++++++++++++
>  include/linux/pci.h     |  6 ++++
>  7 files changed, 164 insertions(+), 1 deletion(-)
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
> index d69864b25656..77bc4f7d2e99 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -222,6 +222,9 @@ static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
>  int cxl_gpf_port_setup(struct cxl_dport *dport);
>  
>  struct cxl_hdm;
> +/* Hold cxl_rwsem.dpa for write while using the returned cache. */
> +struct cxl_hdm_info *cxl_hdm_get_cached_info(struct cxl_hdm *cxlhdm, int id);
> +int cxl_hdm_check_decoder_count(struct cxl_hdm *cxlhdm);
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  			struct cxl_endpoint_dvsec_info *info);
>  int cxl_port_get_possible_dports(struct cxl_port *port);
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 1a19078e6c6c..b57257efbf4e 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -730,6 +730,47 @@ static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
>  		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
>  }
>  
> +static void cxl_hdm_refresh_decoder(struct cxl_hdm *cxlhdm,
> +				    struct cxl_decoder *cxld)
> +{
> +	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> +	struct cxl_endpoint_decoder_settings *settings;
> +	struct cxl_hdm_info *info;
> +	u32 global_ctrl;
> +
> +	if (!hdm)
> +		return;
> +	if (!is_endpoint_decoder(&cxld->dev))
> +		return;
> +
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	info = cxl_hdm_get_cached_info(cxlhdm, cxld->config.id);
> +	if (!info)
> +		return;
> +
> +	/* Preserve the last good value when the device does not respond. */
> +	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +	if (global_ctrl != U32_MAX)
> +		info->global_ctrl = global_ctrl;
> +	settings = &info->settings[cxld->config.id];
> +
> +	/*
> +	 * A disabled decoder's software object may retain its old range and
> +	 * skip state. Leave only the decoder id in the cached settings so stale
> +	 * state is not restored as an enabled decode.
> +	 */
> +	*settings = (struct cxl_endpoint_decoder_settings) {
> +		.config.id = cxld->config.id,
> +	};
> +	if (cxld->config.flags & CXL_DECODER_F_ENABLE) {
> +		struct cxl_endpoint_decoder *cxled =
> +			to_cxl_endpoint_decoder(&cxld->dev);
> +
> +		settings->config = cxld->config;
> +		settings->skip = cxled->skip;
> +	}
> +}
> +
>  static void
>  cxl_endpoint_decoder_snapshot(struct cxl_endpoint_decoder *cxled,
>  			      struct cxl_endpoint_decoder_settings *settings)
> @@ -811,6 +852,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  	}
>  	port->commit_end++;
>  	cxld->config.flags |= CXL_DECODER_F_ENABLE;
> +	cxl_hdm_refresh_decoder(cxlhdm, cxld);
>  
>  	return 0;
>  }
> @@ -883,6 +925,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
>  	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
>  
>  	cxld->config.flags &= ~CXL_DECODER_F_ENABLE;
> +	cxl_hdm_refresh_decoder(cxlhdm, cxld);
>  
>  	/* Userspace is now responsible for reconfiguring this decoder */
>  	if (is_endpoint_decoder(&cxld->dev)) {
> @@ -1090,9 +1133,17 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  {
>  	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>  	struct cxl_port *port = cxlhdm->port;
> -	int i;
> +	/* DVSEC-emulated decoders do not describe the cached HDM registers. */
> +	bool emulated = should_emulate_decoders(info);
> +	int check_rc, i;
>  	u64 dpa_base = 0;
>  
> +	if (is_cxl_endpoint(port) && hdm && !emulated) {
> +		check_rc = cxl_hdm_check_decoder_count(cxlhdm);
> +		if (check_rc)
> +			return check_rc;
> +	}
> +
>  	cxl_settle_decoders(cxlhdm);
>  
>  	for (i = 0; i < cxlhdm->decoder_count; i++) {
> @@ -1131,6 +1182,8 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  			put_device(&cxld->dev);
>  			return rc;
>  		}
> +		if (!emulated)
> +			cxl_hdm_refresh_decoder(cxlhdm, cxld);
>  		rc = add_hdm_decoder(port, cxld);
>  		if (rc) {
>  			dev_warn(&port->dev,
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 33b21c8dcb21..2acddb472103 100644
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
> @@ -180,6 +181,75 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, "CXL");
>  
> +/**
> + * cxl_hdm_get_cached_info() - get the PCI-owned HDM cache for a decoder
> + * @cxlhdm: HDM capability whose port identifies the upstream PCI device
> + * @id: decoder ID to validate against the cached decoder count
> + *
> + * The caller must hold cxl_rwsem.dpa for write throughout this call and
> + * all access through the returned pointer. The pointer refers to the live
> + * cache; ownership remains with the PCI device.
> + *
> + * Return: the cache containing @id, or NULL if no upstream PCI device or
> + * cache exists, or @id is outside the cached decoder count.
> + */
> +struct cxl_hdm_info *cxl_hdm_get_cached_info(struct cxl_hdm *cxlhdm, int id)
> +{
> +	struct cxl_hdm_info *info;
> +
> +	struct pci_dev *pdev __free(pci_dev_put) =
> +		cxl_port_get_uport_pci_dev(cxlhdm->port);
> +
> +	if (!pdev)
> +		return NULL;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.dpa);
> +	info = pdev->hdm;
> +	if (!info)
> +		return NULL;
> +
> +	if (id < 0 || id >= info->decoder_count) {
> +		pci_warn(pdev, "CXL HDM decoder %d exceeds cached count %d\n",
> +			 id, info->decoder_count);
> +		return NULL;
> +	}
> +
> +	return info;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_hdm_get_cached_info, "CXL");
> +
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
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	if (pdev->hdm &&
> +	    pdev->hdm->decoder_count != cxlhdm->decoder_count) {
> +		pci_warn(pdev,
> +			 "CXL HDM cache decoder count mismatch: cached=%d hdm=%d\n",
> +			 pdev->hdm->decoder_count, cxlhdm->decoder_count);
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_hdm_check_decoder_count, "CXL");
> +
>  static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
>  {
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 9af01e1f45ba..b29374b34cfa 100644
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
> index 219b9bb67440..d5e7efd2ffc0 100644
> --- a/include/cxl/hdm.h
> +++ b/include/cxl/hdm.h
> @@ -16,4 +16,29 @@ struct cxl_endpoint_decoder_settings {
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

