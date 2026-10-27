Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793082731;
	b=mW1rLXQpcn5A+cunSBOY2/JtchK+kzUO3DcyllFzw293dt1X3VFdE6QqhmOdP2NzsgaP
	 DwXFj8PuGKX39WI1Xu3mSvQH/7GRcVnMo+nhPdVwUAp1oZLVZ5KcQfcsnOCbjT3n2D2VK
	 oXHwqf775/mEPCxBUWK/i0AzeFr1P1CZO7aApj8Nzcsx96tjdQjzt2NndvFoIYMQsmXSi
	 au+O5YVABFwVc/hknHNKBQ0O2rhZFpAaKcV4zpw8kpmsm3SHwrsq7c7zRdI/HKZ8glcIR
	 BdBTmLfoBECpB2Jeqh52WL6DY1HjcAnw0/6J45Y8dwZ3hqSd+bWu7t8HuqV6wFwOVqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793082731;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=Egai3x/F/sMJ/8jM65XynOMt9tUM5sKIeF7VYes9mmI=;
	b=ydx7L13ISg+b0cKNBYaHqAQHU3MEAIYHsptpOt5mNRY2S2tBpBbRefxfc9u23QCmiVuh
	 1KHr2wq5cdRGdCgWl+qRC7JeSKAm3PxCKSTUFLqj5j5CRt6yDh2Dxztxb17HG9hDhZND4
	 Xwr9FoIGlsJwDgaMEw0YBljxaXlY0RQ6utx0T/IG4zEg1/VPh0ShLLLqzohCP8t90DaHG
	 BCI9FTjanz819qpTzyEj/jEqv5D/eicL5IMRivDvzbw/OfRqHPZeaZugUtsFkLYLvmYtg
	 SC4cUpZZi44b8UkyqsKf0oDHffgZSlKzvuov5ax8rcOf10z4x6JqiCmpECjaro3V6tQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=ming.li@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=GSiBFv1P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1173606A326;
	Tue, 27 Oct 2026 06:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1173606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=ming.li@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=GSiBFv1P
ARC-Seal: i=1; a=rsa-sha256; t=1793082717; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jXuFPMEzh2ddB3+/mwTJYRv2A/TPU7+31BNVatYYOQmxmidxZKQ8m/24sFofrpG64CLslzJ9acFf5GwbFjhJxQwYXTIjkO2BrAVUJlwy2ihW+a7jof4cpatoMaZDXazYhfq+f47PpyT2BVSLpeGMaK8fYIa4O2ksC7TCgrC7CFE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793082717; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Egai3x/F/sMJ/8jM65XynOMt9tUM5sKIeF7VYes9mmI=; 
	b=QlKin/mVgtey+2JlAtwnCZcoOkd6GvyPiOtPq1Lih9A2wKvEDXFTbj0jGT82TOIMXoWU+Qs8YG7EZ5eGK7160r50/fHttgHV13va9UBhksAdr8MfEcc/QyC5CbxDwx43mFvH9Dx2rLhBlYDiy66Iiv80Y9z9FgIREWFTEknjbew=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793082717;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=Egai3x/F/sMJ/8jM65XynOMt9tUM5sKIeF7VYes9mmI=;
	b=GSiBFv1PCbv8zCyDopKRLBLW1duZxXZDoYuqqsim/jlcEAwSviAjYXLs41yq9cDj
	yDOEkGYk6t2ki0vXM+dVADCKM/TdSDODe1lp0aIlUyJ9LjQxvWgfzWiNzp04sE6g3bM
	j5cM8OBBaV05YnT8ubejjX6KtAMSdaaGtb6rVZ8I=
Received: by smtp.zohomail.com with SMTPS id 1793082714953204.26967948806123;
	Mon, 26 Oct 2026 23:31:54 -0700 (PDT)
Message-ID: <339935ef-17d8-4467-80bc-3f1856f591b9@zohomail.com>
Date: Tue, 27 Oct 2026 14:31:45 +0800
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
Subject: Re: [PATCH v15 07/16] cxl: Share HDM decoder register unpacking
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
 <20261011021422.3428136-8-smadhavan@nvidia.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20261011021422.3428136-8-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227f1712e42a7d8af411be461f1000072a9dacb306c184067b7a0b62b376af06e9c33af381a3bb525:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/10/11 10:14, Srirangan Madhavan 写道:
> Factor common HDM register parsing into cxl_hdm_unpack_decoder().
> Validate range and interleave parameters in locals before publishing the
> decoder configuration, including enable and lock flags. Reject nonzero
> ranges whose end overflows the address space while preserving the
> zero-size range representation.
>
> Read switch target lists and endpoint DPA skip in their respective
> branches of init_hdm_decoder().
>
> Preserve the decoder ID allocated by cxl_decoder_init() when publishing
> the parsed configuration.
>
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=7d6ed7faf7d8e14abce8ae23902d5323738868d2
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Assisted-by: LLM
Reviewed-by: Li Ming <ming.li@zohomail.com>
Minor comments below.
> ---
>   drivers/cxl/core/core.h     |  3 ++
>   drivers/cxl/core/hdm.c      | 54 +++++++++-------------------------
>   drivers/cxl/core/hdm_regs.c | 58 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 74 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index fb14b222f3ca..d69864b25656 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -147,6 +147,9 @@ void cxl_commit_start_switch(const struct cxl_decoder_config *config,
>   			     u64 targets, void __iomem *hdm);
>   int cxld_await_commit(void __iomem *hdm, int id);
>   
> +int cxl_hdm_unpack_decoder(struct cxl_decoder_config *config, int id,
> +			   u32 ctrl, u64 base, u64 size);
> +
>   int cxl_memdev_init(void);
>   void cxl_memdev_exit(void);
>   void cxl_mbox_init(void);
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 47cf49bcd2e5..1a19078e6c6c 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -939,8 +939,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
>   {
>   	struct cxl_endpoint_decoder *cxled = NULL;
> +	struct cxl_decoder_config config;
>   	u64 size, base, skip, dpa_size, lo, hi;
> -	bool committed;
>   	u32 remainder;
>   	int i, rc;
>   	u32 ctrl;
Should arrange these variables in a reverse xmas tree order.
> @@ -960,35 +960,24 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   	lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
>   	hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(which));
>   	size = (hi << 32) + lo;
> -	committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
> +	rc = cxl_hdm_unpack_decoder(&config, cxld->config.id, ctrl, base, size);
> +	if (rc) {
> +		dev_warn(&port->dev,
> +			 "decoder%d.%d: Invalid decoder configuration (ctrl: %#x): %d\n",
> +			 port->id, cxld->config.id, ctrl, rc);
> +		return rc;
> +	}
> +
>   	cxld->commit = cxl_decoder_commit;
>   	cxld->reset = cxl_decoder_reset;
> -
> -	if (!committed)
> -		size = 0;
> -	if (base == U64_MAX || size == U64_MAX) {
> -		dev_warn(&port->dev, "decoder%d.%d: Invalid resource range\n",
> -			 port->id, cxld->config.id);
> -		return -ENXIO;
> -	}
> +	cxld->config = config;
> +	size = range_len(&cxld->config.hpa_range);
>   
>   	if (info)
>   		cxled = to_cxl_endpoint_decoder(&cxld->dev);
> -	cxld->config.hpa_range = (struct range) {
> -		.start = base,
> -		.end = base + size - 1,
> -	};
>   
>   	/* decoders are enabled if committed */
> -	if (committed) {
> -		cxld->config.flags |= CXL_DECODER_F_ENABLE;
> -		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> -			cxld->config.flags |= CXL_DECODER_F_LOCK;
> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
> -			cxld->config.target_type = CXL_DECODER_HOSTONLYMEM;
> -		else
> -			cxld->config.target_type = CXL_DECODER_DEVMEM;
> -
> +	if (cxld->config.flags & CXL_DECODER_F_ENABLE) {
>   		guard(rwsem_write)(&cxl_rwsem.region);
>   		if (cxld->config.id != cxl_num_decoders_committed(port)) {
>   			dev_warn(&port->dev,
> @@ -1022,23 +1011,6 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
>   		}
>   	}
> -	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
> -			  &cxld->config.interleave_ways);
> -	if (rc) {
> -		dev_warn(&port->dev,
> -			 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
> -			 port->id, cxld->config.id, ctrl);
> -		return rc;
> -	}
> -	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
> -				 &cxld->config.interleave_granularity);
> -	if (rc) {
> -		dev_warn(&port->dev,
> -			 "decoder%d.%d: Invalid interleave granularity (ctrl: %#x)\n",
> -			 port->id, cxld->config.id, ctrl);
> -		return rc;
> -	}
> -
>   	dev_dbg(&port->dev, "decoder%d.%d: range: %#llx-%#llx iw: %d ig: %d\n",
>   		port->id, cxld->config.id, cxld->config.hpa_range.start, cxld->config.hpa_range.end,
>   		cxld->config.interleave_ways, cxld->config.interleave_granularity);
> @@ -1053,7 +1025,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   		return 0;
>   	}
>   
> -	if (!committed)
> +	if (!(cxld->config.flags & CXL_DECODER_F_ENABLE))
>   		return 0;
>   
>   	dpa_size = div_u64_rem(size, cxld->config.interleave_ways, &remainder);
> diff --git a/drivers/cxl/core/hdm_regs.c b/drivers/cxl/core/hdm_regs.c
> index 53d2f236e49c..b6ee4becde8d 100644
> --- a/drivers/cxl/core/hdm_regs.c
> +++ b/drivers/cxl/core/hdm_regs.c
> @@ -116,3 +116,61 @@ void cxl_commit_start_switch(const struct cxl_decoder_config *config,
>   	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
>   }
>   EXPORT_SYMBOL_FOR_MODULES(cxl_commit_start_switch, "cxl_core");
> +
> +int cxl_hdm_unpack_decoder(struct cxl_decoder_config *config, int id,
> +			   u32 ctrl, u64 base, u64 size)
> +{
> +	bool committed = FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
> +	enum cxl_decoder_type target_type = 0;
> +	int interleave_granularity;
> +	int interleave_ways;
> +	unsigned long flags = 0;
> +	struct range hpa_range;
> +	u64 end;
> +	int rc;
Same as above.
> +
> +	if (!committed)
> +		size = 0;
> +	if (base == U64_MAX || size == U64_MAX)
> +		return -ENXIO;
> +	if (size && check_add_overflow(base, size - 1, &end))
> +		return -ENXIO;
> +	if (!size)
> +		end = base - 1;
> +
> +	hpa_range = (struct range) {
> +		.start = base,
> +		.end = end,
> +	};
> +
> +	if (committed) {
> +		flags |= CXL_DECODER_F_ENABLE;
> +		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> +			flags |= CXL_DECODER_F_LOCK;
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
> +			target_type = CXL_DECODER_HOSTONLYMEM;
> +		else
> +			target_type = CXL_DECODER_DEVMEM;
> +	}
> +
> +	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
> +			 &interleave_ways);
> +	if (rc)
> +		return rc;
> +	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
> +				&interleave_granularity);
> +	if (rc)
> +		return rc;
> +
> +	*config = (struct cxl_decoder_config) {
> +		.id = id,
> +		.hpa_range = hpa_range,
> +		.interleave_ways = interleave_ways,
> +		.interleave_granularity = interleave_granularity,
> +		.target_type = target_type,
> +		.flags = flags,
> +	};
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_unpack_decoder, "cxl_core");
