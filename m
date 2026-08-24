Received: from sender6-pp-o94.zoho.com (sender6-pp-o94.zoho.com [165.173.180.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635C62F6565;
	Mon, 24 Aug 2026 07:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787558010; cv=pass; b=jCliFhVHW2ysywPvW4+so8qKmF0dnVn6qZIXXmK2Kuf44I+e4NHP81OI0OW01dFyWpZIWEtviJ2Cz/ZGY9NIoOXwlmq6UlbtsUkvbeYhB948IIwHf7qI7dGAEEMzSJn6PnIT5NnI8owiFuWoN6ooyRRux8I/JLlEUKd5rIJLZrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787558010; c=relaxed/simple;
	bh=MkampgrpGK2RNmvGey3S6d1t2Ya5/013PoJ6MOd9+dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aU4LuGjVYSwWZbaiNjU33o35S5z+Q3Ab0NWNdkslLKBe92d2MNHE4lvND1L6pUYRe8NxrzA2dqmTghm5AjXMXlahO8Og7793XcbCYOtXBIOWnXyQ76AEbUxyvFaoRI9RfjnehkL5b8QAE6YW3HviZwr6MoSp1Ens8ap9pe/qQOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=TPNMnCdE; arc=pass smtp.client-ip=165.173.180.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="TPNMnCdE"
ARC-Seal: i=1; a=rsa-sha256; t=1787557998; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=h0ekdRNzK+JXSgTbEaVJ5v3B/vEIHonPH49+VZwW8+PtdlYB8fFUM+9TP6fD2NERNqTDkThHfr4OWR4O2SmBeTezaowMNXdMUBm4cA6S4gS22sa3Pf6nTiCIbiMAe9ko1UueSLp4fJwo+mNkqCkhBLfXJO/CURJNmEMxLbPlfsw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1787557998; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LNmoHF/KqY72cRrJkqQazIsWsQhyca+P+7hHMiY6ZYM=; 
	b=ab2ttOAq5CXs9lhttmLXJ7Fp+VPjWCpemyMUmCfVOtngfjpH1fF1jUt0oohzinVkdH/i0aNNR/mULSFe4X5T79gSttJbMzsMliTkFylA2m4r8weL9rnF2QgaDgKEtHRpPeJfYveyJovjCwsF8hSSQ+ZMQF45wlqUgsWGh7CO4fA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787557998;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=LNmoHF/KqY72cRrJkqQazIsWsQhyca+P+7hHMiY6ZYM=;
	b=TPNMnCdEtbxI5hqp3Mm5baZejDb9ikJb6DQPmvPHtYjTMwUe2P4JP9Ag91tApGt3
	VyvYMrpDj556zJfJIwnL8Y5XK2HYPu2waeQSKAnZbixtQpxQdb0EAuyXk9WjKRO44DB
	V1rHD/8pBtpSm/9Hc8g4ewhPcFOXJz+gAJjwRz3g=
Received: by mx.zohomail.com with SMTPS id 1787557997202730.4855151599179;
	Mon, 24 Aug 2026 00:53:17 -0700 (PDT)
Message-ID: <cd115bea-68b4-4b7c-8cad-93f5fedfb6fc@zohomail.com>
Date: Mon, 24 Aug 2026 15:53:11 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/12] cxl: Cache decoder settings on PCI devices
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
 <20260804192958.1823952-5-smadhavan@nvidia.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260804192958.1823952-5-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: zu08011227af36c92431c1f613a752d92e000088fb1d2f244f04e898c19f2e1b244fdfff28ccb470c5da0a6c:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

On 8/5/2026 3:29 AM, Srirangan Madhavan wrote:
> Add CXL core plumbing to refresh a PCI device HDM decoder cache when
> decoders are enumerated, committed, or reset. PCI reset paths can use
> this snapshot to restore HDM programming without walking CXL topology
> during reset recovery.
>
> The cache is populated by PCI-side discovery in a follow-on patch. Until
> then, the CXL core update path is a no-op when no PCI HDM cache is
> present.
>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/hdm.c | 114 ++++++++++++++++++++++++++++++++++++++++-
>  include/cxl/cxl.h      |  12 +++++
>  include/linux/pci.h    |   6 +++
>  3 files changed, 131 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 6e132b4f092b..ec988e7b7c0c 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -84,6 +84,110 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  		cxlhdm->iw_cap_mask |= BIT(16);
>  }
>  
> +static int cxl_pci_hdm_info_match(struct pci_dev *pdev, int decoder_count,
> +				      bool *present)
> +{
> +	struct cxl_hdm_info *info;
> +	int rc = 0;
> +
> +	*present = false;
> +	down_read(&cxl_rwsem.dpa);
> +	info = pdev->hdm;
> +	if (info) {
> +		*present = true;
> +		if (info->decoder_count != decoder_count) {
> +			pci_warn(pdev,
> +				 "CXL HDM cache decoder count mismatch: cached=%d hdm=%d\n",
> +				 info->decoder_count, decoder_count);
> +			rc = -ENXIO;
> +		}
> +	}
> +	up_read(&cxl_rwsem.dpa);
> +
> +	return rc;
> +}
> +
> +static int cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
> +{
> +	struct pci_dev *pdev __free(pci_dev_put) =
> +		cxl_port_get_uport_pci_dev(cxlhdm->port);
> +	bool present;
This 'present' is unused in this patch and used in the follow-on patch, I suggest moving this 'present' related implementation into the follow-on patch.
> +
> +	if (!pdev)
> +		return 0;
> +
> +	return cxl_pci_hdm_info_match(pdev, cxlhdm->decoder_count, &present);
> +}
> +
> +static u64 cxl_switch_target_list(struct cxl_switch_decoder *cxlsd)
> +{
> +	struct cxl_decoder *cxld = &cxlsd->cxld;
> +	u64 targets = 0;
> +	int ways = min(cxld->interleave_ways, cxlsd->nr_targets);
> +
> +	/* target_map[] holds the raw list before target[] is resolved. */
> +	for (int i = 0; i < ways && i < 8; i++) {
> +		u8 port_id;
> +
> +		if (cxlsd->target[i])
> +			port_id = cxlsd->target[i]->port_id;
> +		else
> +			port_id = cxld->target_map[i];
> +
> +		targets |= (u64)port_id << (i * 8);
> +	}
> +
> +	return targets;
> +}
> +
> +static void cxl_decoder_snapshot(struct cxl_decoder *cxld,
> +				 struct cxl_decoder_settings *settings)
> +{
> +	*settings = (struct cxl_decoder_settings) {
> +		.id = cxld->id,
> +		.hpa_range = cxld->hpa_range,
> +		.interleave_ways = cxld->interleave_ways,
> +		.interleave_granularity = cxld->interleave_granularity,
> +		.target_type = cxld->target_type,
> +		.flags = cxld->flags,
> +	};
> +
> +	if (is_endpoint_decoder(&cxld->dev)) {
> +		struct cxl_endpoint_decoder *cxled =
> +			to_cxl_endpoint_decoder(&cxld->dev);
> +
> +		settings->target_or_skip = cxled->skip;
> +	} else if (is_switch_decoder(&cxld->dev)) {
> +		struct cxl_switch_decoder *cxlsd =
> +			to_cxl_switch_decoder(&cxld->dev);
> +
> +		settings->target_or_skip = cxl_switch_target_list(cxlsd);
> +	}
> +}
> +
> +static void cxl_hdm_info_set_decoder(struct cxl_hdm *cxlhdm,
> +				     struct cxl_decoder *cxld)
> +{
> +	struct pci_dev *pdev __free(pci_dev_put) =
> +		cxl_port_get_uport_pci_dev(cxlhdm->port);
> +	struct cxl_hdm_info *info;
> +
> +	if (!pdev)
> +		return;
> +
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	info = pdev->hdm;
> +	if (!info || cxld->id >= info->decoder_count)
> +		return;
> +
> +	if (cxld->flags & CXL_DECODER_F_ENABLE)
> +		cxl_decoder_snapshot(cxld, &info->settings[cxld->id]);
> +	else
> +		info->settings[cxld->id] = (struct cxl_decoder_settings) {
> +			.id = cxld->id,
> +		};
> +}
> +
>  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>  {
>  	struct cxl_hdm *cxlhdm;
> @@ -767,6 +871,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  	}
>  	port->commit_end++;
>  	cxld->flags |= CXL_DECODER_F_ENABLE;
> +	cxl_hdm_info_set_decoder(cxlhdm, cxld);
>  
>  	return 0;
>  }
> @@ -839,6 +944,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
>  	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
>  
>  	cxld->flags &= ~CXL_DECODER_F_ENABLE;
> +	cxl_hdm_info_set_decoder(cxlhdm, cxld);
>  
>  	/* Userspace is now responsible for reconfiguring this decoder */
>  	if (is_endpoint_decoder(&cxld->dev)) {
> @@ -1058,11 +1164,16 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  	struct cxl_port *port = cxlhdm->port;
>  	int i;
>  	u64 dpa_base = 0;
> +	int rc;
>  
>  	cxl_settle_decoders(cxlhdm);
>  
> +	rc = cxl_pci_setup_hdm_info(cxlhdm);
> +	if (rc)
> +		return rc;
> +
>  	for (i = 0; i < cxlhdm->decoder_count; i++) {
> -		int rc, target_count = cxlhdm->target_count;
> +		int target_count = cxlhdm->target_count;
>  		struct cxl_decoder *cxld;
>  
>  		if (is_cxl_endpoint(port)) {
> @@ -1097,6 +1208,7 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  			put_device(&cxld->dev);
>  			return rc;
>  		}
> +		cxl_hdm_info_set_decoder(cxlhdm, cxld);
>  		rc = add_hdm_decoder(port, cxld);
>  		if (rc) {
>  			dev_warn(&port->dev,
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 85e895d9b31c..703285966946 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -133,6 +133,18 @@ struct cxl_regs {
>  	);
>  };
>  
> +#define CXL_HDM_DECODER_MAX_COUNT 32
> +
> +/**
> + * struct cxl_hdm_info - PCI device HDM decoder programming cache
> + * @decoder_count: number of decoder settings entries
> + * @settings: cached per-decoder programming state
> + */
> +struct cxl_hdm_info {
> +	int decoder_count;
> +	struct cxl_decoder_settings settings[CXL_HDM_DECODER_MAX_COUNT];
> +};
> +
>  struct cxl_reg_map {
>  	bool valid;
>  	int id;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 64b308b6e61c..a8e5cec96bae 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -335,6 +335,9 @@ struct pcie_link_state;
>  struct pci_sriov;
>  struct pci_p2pdma;
>  struct rcec_ea;
> +#ifdef CONFIG_CXL_HDM
> +struct cxl_hdm_info;
> +#endif
>  
>  /* struct pci_dev - describes a PCI device
>   *
> @@ -562,6 +565,9 @@ struct pci_dev {
>  #ifdef CONFIG_PCI_DOE
>  	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
>  #endif
> +#ifdef CONFIG_CXL_HDM
> +	struct cxl_hdm_info *hdm;	/* CXL HDM decoder reset state */
> +#endif
>  #ifdef CONFIG_PCI_NPEM
>  	struct npem	*npem;		/* Native PCIe Enclosure Management */
>  #endif


