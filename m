Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E027B17B418;
	Sat, 12 Sep 2026 00:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789171632; cv=none; b=h1Oq9Z2wz79fHiwFdtLLTq3anY5LBwir0zm2nvuDkyIzpyJdewNcrPSLAxOsCsuiPPlI8pyJ14fg7mGnjmNyo1d6HBi10Bk0XdE9xjlJrWI6nzCYVkkTf14slsFQhjaQWPwTQY4BpOOv/GMKgY79rxSozMKJsCtsCTu6YiM1PAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789171632; c=relaxed/simple;
	bh=5F/PDBa/xfp2HSqWv7kHA9kmxnoKSYmXpQ0mDwabj2U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8OMhmN35RmvqfQdk7T50pnzw1YMPFMuxUKG+RIYpPz3TWW9dkZpHGNC9F1hZ1xB68EQGqLQ3sY3b5NMUWUorI2pEk5G9cPkfZi3mjVl1DFMG/LWEDR74QA3QHLrIu5FJkxpMZNVyE5dPmJM/oAp3apjQXi4szQudmrv+uJ6jKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVL0p+ka; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVL0p+ka"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416F81F000FF;
	Sat, 12 Sep 2026 00:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789171627;
	bh=coCWbsam9/JgvkfNHdvGpfZVCPda9ULr326XZ/IDe3c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oVL0p+kaqytKD/CheyEskfDnhONbqw5+feRcYkOFLmaIgLs8Q4BHLxVNsWiHPhyU/
	 iqcN4m6pYT5ivViGurpS2w3xr8NZO6HXL3OYtojNzdeYuzhzOaot1PdaMB8ez429KN
	 x/GrVZ/tgFc/SbkTOsgNjWBxM3URYBQ9cyvCdzKuAxcn7OycSNHlw4tRl31EvKDONn
	 dJy63Di0D0NIM6UghLW1qPZHZooxQ1mNhNbzYfncVDLAs4zspvcYgpvP8ytXPzD74b
	 E/SJyFHzVR1SQhY5Yfu8m0CWEQOvBgL2MjY+ILzaa0aO7qSLaaYowQBqEyQ6McGw0C
	 lF5oI79akdlOw==
Date: Sat, 12 Sep 2026 01:07:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Alex Williamson
 <alex.williamson@redhat.com>, vsethi@nvidia.com, alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, Vishal Aslot
 <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v12 03/12] cxl: Share HDM decoder decode logic
Message-ID: <20260912010700.43844d3b@jic23-hlaptop>
In-Reply-To: <20260910070808.1444264-4-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
	<20260910070808.1444264-4-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 07:07:59 +0000
Srirangan Madhavan <smadhavan@nvidia.com> wrote:

> Move HDM decoder register decoding into a helper shared by normal CXL
> core enumeration and early PCI HDM cache setup. This keeps validation of
> base, range overflow, interleave, target type, and enable state in one
> place before adding another HDM parser.
> 
Hi Srirangan,


> Keep caller-owned policy out of the decode helper. A committed zero-size
> decoder now decodes successfully, while init_hdm_decoder() retains its

I'd not use decodes for that second bit given it's a decoder.  Choose
another word - it definitely isn't doing any decoding.

> existing zero-size rejection.
> 
> Preserve endpoint DPA state ownership by using the decoded skip value as
> a local input to devm_cxl_dpa_reserve(). The reservation helper updates
> cxled->skip under cxl_rwsem.dpa.
> 
> Reported-by: Fenghua Yu <fenghua.yu@intel.com>

Add a of Closes tag for the report so we can see exactly what it is
referring to. I'm guessing the zero length decoders?

> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Quite a bit of feedback on how this is done.  Maybe I'll get
convinced in later patches but as it stands this is making the
code less readable.  If it is useable in the cxl_decoder
and we can lose the local structure than it becomes more
convincing.

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 70ffebd3e213..d621d827f59f 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -907,14 +907,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  {
>  	struct cxl_endpoint_decoder *cxled = NULL;
>  	u64 size, base, skip, dpa_size, lo, hi;
> +	struct cxl_decoder_settings settings;
>  	bool committed;
>  	u32 remainder;
>  	int i, rc;
> -	u32 ctrl;
> -	union {
> -		u64 value;
> -		unsigned char target_id[8];
> -	} target_list;
> +	u32 ctrl, tl_low, tl_high;
>  
>  	if (should_emulate_decoders(info))
>  		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, dpa_base,
> @@ -927,35 +924,33 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
>  	hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(which));
>  	size = (hi << 32) + lo;
> -	committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
> +	tl_low = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
> +	tl_high = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));

Be consistent on either combining these into local variables or not. Right now
this is the only one handled in the parameters for the next call.

> +	rc = cxl_hdm_decode_decoder(&settings, which, ctrl, base, size,
> +				    ((u64)tl_high << 32) | tl_low, &committed);
> +	if (rc) {
> +		dev_warn(&port->dev,
> +			 "decoder%d.%d: Invalid decoder configuration (ctrl: %#x): %d\n",
> +			 port->id, cxld->id, ctrl, rc);
> +		return rc;
> +	}
> +
>  	cxld->commit = cxl_decoder_commit;
>  	cxld->reset = cxl_decoder_reset;
> -
> -	if (!committed)
> -		size = 0;
> -	if (base == U64_MAX || size == U64_MAX) {
> -		dev_warn(&port->dev, "decoder%d.%d: Invalid resource range\n",
> -			 port->id, cxld->id);
> -		return -ENXIO;
> -	}
> +	cxld->hpa_range = settings.hpa_range;
> +	cxld->interleave_ways = settings.interleave_ways;
> +	cxld->interleave_granularity = settings.interleave_granularity;
> +	cxld->target_type = settings.target_type;
> +	cxld->flags = settings.flags;
> +	size = range_len(&cxld->hpa_range);

If this settings field matches cxld fields so well, why not embed one in
there and write to that directly?  Without that I'm seeing little benefit
in using the settings structure in here.  It is complicating the
code and the only deduplication is a tiny number of checks.


>  
>  	if (info)
>  		cxled = to_cxl_endpoint_decoder(&cxld->dev);
> -	cxld->hpa_range = (struct range) {
> -		.start = base,
> -		.end = base + size - 1,
> -	};
> +	if (!cxled && cxld->interleave_ways > 8)
> +		return -ENXIO;
>  
>  	/* decoders are enabled if committed */
>  	if (committed) {
> -		cxld->flags |= CXL_DECODER_F_ENABLE;
> -		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> -			cxld->flags |= CXL_DECODER_F_LOCK;
> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
> -			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> -		else
> -			cxld->target_type = CXL_DECODER_DEVMEM;
> -
>  		guard(rwsem_write)(&cxl_rwsem.region);
>  		if (cxld->id != cxl_num_decoders_committed(port)) {
>  			dev_warn(&port->dev,
> @@ -995,33 +990,15 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
>  		}
>  	}
> -	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
> -			  &cxld->interleave_ways);
> -	if (rc) {
> -		dev_warn(&port->dev,
> -			 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
> -			 port->id, cxld->id, ctrl);
> -		return rc;
> -	}
> -	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
> -				 &cxld->interleave_granularity);
> -	if (rc) {
> -		dev_warn(&port->dev,
> -			 "decoder%d.%d: Invalid interleave granularity (ctrl: %#x)\n",
> -			 port->id, cxld->id, ctrl);
> -		return rc;
> -	}
> -
>  	dev_dbg(&port->dev, "decoder%d.%d: range: %#llx-%#llx iw: %d ig: %d\n",
>  		port->id, cxld->id, cxld->hpa_range.start, cxld->hpa_range.end,
>  		cxld->interleave_ways, cxld->interleave_granularity);
>  
>  	if (!cxled) {
> -		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
> -		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
> -		target_list.value = (hi << 32) + lo;
>  		for (i = 0; i < cxld->interleave_ways; i++)
> -			cxld->target_map[i] = target_list.target_id[i];
> +			cxld->target_map[i] = i < 4 ?
> +				(tl_low >> (i * 8)) & 0xff :
> +				(tl_high >> ((i - 4) * 8)) & 0xff;

Can't we keep the type punning and readability it brings?
Also why is the one thing that is still using the non settings path
to get to values?  I'm not that convinced it makes sense to do any
of this with your new settings structure but it needs to be consistent
at least (like skip is below).


>  
>  		return 0;
>  	}
> @@ -1036,9 +1013,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			port->id, cxld->id, size, cxld->interleave_ways);
>  		return -ENXIO;
>  	}
> -	lo = readl(hdm + CXL_HDM_DECODER0_SKIP_LOW(which));
> -	hi = readl(hdm + CXL_HDM_DECODER0_SKIP_HIGH(which));
> -	skip = (hi << 32) + lo;
> +	skip = settings.target_or_skip;
>  	rc = devm_cxl_dpa_reserve(cxled, *dpa_base + skip, dpa_size, skip);
>  	if (rc) {
>  		dev_err(&port->dev,
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 625e4aa427db..5085574521c6 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -34,6 +34,25 @@
>  static DEFINE_IDA(cxl_port_ida);
>  static DEFINE_XARRAY(cxl_root_buses);
>  
> +struct pci_dev *cxl_port_get_uport_pci_dev(struct cxl_port *port)
> +{
> +	struct device *uport = port->uport_dev;
> +	struct device *host;
> +
> +	if (is_cxl_memdev(uport)) {
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(uport);
> +
> +		host = cxlmd->dev.parent;
> +	} else {
> +		host = uport;
> +	}
> +
> +	if (!host || !dev_is_pci(host))
> +		return NULL;
> +
> +	return pci_dev_get(to_pci_dev(host));

Very nearly same code in read_cdata_data()

If you want this helper here, then introduce if first refactoring that code
to show the helper is useful then use it here as well.  So basically
put that as a precursor with a note that it will get reuse in this patch.


> +}
> +
>  /*
>   * The terminal device in PCI is NULL and @platform_bus
>   * for platform devices (for cxl_test)
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 8d3f43640199..e6aa55079c76 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -113,3 +113,46 @@ int cxl_commit_wait(void __iomem *hdm, struct cxl_decoder_settings *settings)
>  	return cxld_await_commit(hdm, settings->id);
>  }
>  EXPORT_SYMBOL_FOR_MODULES(cxl_commit_wait, "cxl_core");
> +
> +int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,

As in the description, this is too many decode given unrelated things
they are talking about.  cxl_hdm_parse_decoder() maybe or cxl_hdm_unpack_decoder()
or cxl_hdm_decoder_fill_settings() though then you'd need to put committed in there.



> +			   u32 ctrl, u64 base, u64 size, u64 target_or_skip,
> +			   bool *committed)
> +{
> +	bool enabled = FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
> +	int rc;
> +
> +	*settings = (struct cxl_decoder_settings) {
> +		.id = id,
> +		.target_or_skip = target_or_skip,
> +		.target_type = FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl) ?
> +			       CXL_DECODER_HOSTONLYMEM : CXL_DECODER_DEVMEM,

Do we have paths where an early exit needs the partly filled in structure?
I'm assuming not. In which case I'd shunt this down a bit to where you can fill
in more in one go.


> +	};
> +
> +	if (committed)
> +		*committed = enabled;

I'm not sure why committed is special and doesn't go in the settings.

> +	if (!enabled)
> +		size = 0;
> +	if (base == U64_MAX || size == U64_MAX ||
> +	    (size && base > U64_MAX - (size - 1)))
> +		return -ENXIO;
> +
> +	settings->hpa_range = (struct range) {
> +		.start = base,
> +		.end = base + size - 1,
> +	};

With a bit of reorg, this can be filled in along with the stuff above
reducing the zeroing then overwriting that is going on currently.

> +	if (enabled) {
> +		settings->flags = CXL_DECODER_F_ENABLE;
> +		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> +			settings->flags |= CXL_DECODER_F_LOCK;
> +	}
If you used a local for building flags, this could also be rolled
in.
> +
> +	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
> +			 &settings->interleave_ways);
> +	if (rc)
> +		return rc;
> +
> +	return eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK,
> +				    ctrl),
Go long for readability.

> +				  &settings->interleave_granularity);
Locals for these as well and it becomes
... 
	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),	&ig);
	if (rc)
		return rc;

	*settings = (struct cxl_decoder_settings) {
		.id = id,
		.hpa_range = {
			.start = base,
			.end = base + size - 1,
		},
		.target_or_skip = target_or_skip,
		.interleave_ways = iw,
		.interleave_granularity = ig,
		.target_type = FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl) ?
			       CXL_DECODER_HOSTONLYMEM : CXL_DECODER_DEVMEM,

		.flags = flags,
	};

	return 0;
}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_decode_decoder, "cxl_core");

