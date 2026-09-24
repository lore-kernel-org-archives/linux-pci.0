Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE152D592C;
	Thu, 24 Sep 2026 03:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219143; cv=none; b=n03xLreXSHLHnztNrVSIC8o8CvtEqmkM5DmHT8hWK2ZOnBhn+0ug35bEsQViNjzA1noPCemxs6s0MDRFQ0/e+ql1qxUuw3AWq/9VDM3BBAD5nbvJ9+21MwDUj50nnDHbZTnsOGTbJ+wv2izqcxxmzqd33Iu1FhSZZkasKalry20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219143; c=relaxed/simple;
	bh=N7o1SBiCxmcTOIy2sZvk5bDLZ0iHH/HCttDTnZJXU2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jH9b+dLooEkAlr2wxwf7BXjio6ZvfYtvaWRs8beHDTfdrrcCwp5uDvlFdmu6oLsmj5BH86lW8Q0wsXcYs2FHAsjS6WiGjk4YIKez0uJ/6TH4u4PN84xTZ9C4PlelzJRz1uxFs3NOJ520bLoI1tRZPWzX3V4BJ1+PfavHyQMhcrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICbH5liI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICbH5liI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14521F000FF;
	Thu, 24 Sep 2026 03:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790219142;
	bh=ootwroIlykjYrkVWw+LM1eufYfKgXkbBzBFEhkjsq7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ICbH5liIjtkS0JW8KvmiiAqaCfD5gXHWlmuhpp/LO1Ux/KXBNODuCIrzhQbQXPjWG
	 Kzms72rklY7E7Imp2okjcmnpEiDPY+80ioqBbKUok8WfSj2+qfIb6ChnJB3pFOADI0
	 ep6nhUgzvnLRfjNT2k4YCet0dI8fLmsrdWeI1STJewzVwCuF3kiWydViop8DyjMSFB
	 PBApxdumXNWeBMzDBzsOoJ3+b9kh//qvq6rCfcTlZuJrQvkw4FgYilScsjtdNnafDO
	 AgBA57r1fY2it25Rr71IFn+LFAmSRSUM+1M03HJteNli8PfKe5ouW7WoQzW2fHi2DF
	 WqgM6wHKSPFyQ==
Date: Thu, 24 Sep 2026 04:05:34 +0100
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
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH v13 07/15] cxl: Share HDM decoder register unpacking
Message-ID: <20260924040534.4eae3107@jic23-hlaptop>
In-Reply-To: <20260922083924.2451158-8-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
	<20260922083924.2451158-8-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 08:39:16 +0000
Srirangan Madhavan <smadhavan@nvidia.com> wrote:

> Factor HDM register parsing into cxl_hdm_unpack_decoder(). Validate local
> values before publishing complete settings, including committed, locked,
> and target-or-skip state.
> 
> Pass endpoint skip state to the DPA reservation helper instead of
> updating live endpoint state, preserving its ownership.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

A few little things inline as slightly more seems to change
in here than I'd immediately expect.

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index b3ddc02df65e..98268e8e15b2 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -932,8 +932,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
>  {
>  	struct cxl_endpoint_decoder *cxled = NULL;
> -	u64 size, base, skip, dpa_size, lo, hi;
> -	bool committed;
> +	struct cxl_decoder_settings settings;
> +	u64 size, base, skip, dpa_size, lo, hi, target_or_skip_reg_val;
>  	u32 remainder;
>  	int i, rc;
>  	u32 ctrl;
> @@ -953,35 +953,34 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
>  	hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(which));
>  	size = (hi << 32) + lo;
> -	committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
> +	lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
> +	hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
> +	target_or_skip_reg_val = (hi << 32) + lo;
> +	rc = cxl_hdm_unpack_decoder(&settings, which, ctrl, base, size,
> +				    target_or_skip_reg_val);
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
> +	cxld->config = settings.config;
> +	size = range_len(&cxld->hpa_range);
>  
>  	if (info)
>  		cxled = to_cxl_endpoint_decoder(&cxld->dev);
> -	cxld->hpa_range = (struct range) {
> -		.start = base,
> -		.end = base + size - 1,
> -	};
> +	if (!cxled && cxld->interleave_ways > 8) {

Why does this check make sense now when we didn't have it before
(that I can find anyway)?  If it isn't tightly coupled to this
patch and instead is providing some extra checks that are worthwhile
I'd break it out as a separate patch where that usecase can be
well described.

> +		dev_warn(&port->dev,
> +			 "decoder%d.%d: Invalid target count: %d\n",
> +			 port->id, cxld->id, cxld->interleave_ways);
> +		return -ENXIO;
> +	}
>  
>  	/* decoders are enabled if committed */
> -	if (committed) {
> -		cxld->flags |= CXL_DECODER_F_ENABLE;
> -		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> -			cxld->flags |= CXL_DECODER_F_LOCK;
> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
> -			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> -		else
> -			cxld->target_type = CXL_DECODER_DEVMEM;
> -
> +	if (cxld->flags & CXL_DECODER_F_ENABLE) {

> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 1b4742622054..7eea2bc38d94 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -109,3 +109,58 @@ int cxl_commit_wait(void __iomem *hdm, struct cxl_decoder_settings *settings)
>  	return cxld_await_commit(hdm, settings->config.id);
>  }
>  EXPORT_SYMBOL_FOR_MODULES(cxl_commit_wait, "cxl_core");
> +
> +int cxl_hdm_unpack_decoder(struct cxl_decoder_settings *settings, int id,
> +			   u32 ctrl, u64 base, u64 size,
> +			   u64 target_or_skip_reg_val)
> +{
> +	bool committed = FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
> +	enum cxl_decoder_type target_type;
> +	int interleave_granularity;
> +	int interleave_ways;
> +	unsigned long flags = 0;
> +	struct range hpa_range;
> +	int rc;
> +
> +	if (!committed)
> +		size = 0;
> +	if (base == U64_MAX || size == U64_MAX ||
> +	    (size && base > U64_MAX - (size - 1)))
> +		return -ENXIO;

This second block looks like new defences which is fine but I'm not sure
it makes sense in here.  Also given we are just checking overflow
doesn't happen maybe use check_add_overflow(). Saves us thinking too
much the maths.
 
> +
> +	hpa_range = (struct range) {
> +		.start = base,
> +		.end = base + size - 1,
> +	};
> +	target_type = FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl) ?
> +		      CXL_DECODER_HOSTONLYMEM : CXL_DECODER_DEVMEM;

Maybe stick to the if / else of the original? I think that is more readable for
an extra couple of lines.
Also blank line here to give visual separation before the conditional that
follows.

It's a functional change to move the target_type selection out of the
committed check. I'd like to see some discussion of why that is fine to
do which probably means a separate little patch that has that description
on its own.

> +	if (committed) {
> +		flags |= CXL_DECODER_F_ENABLE;
> +		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> +			flags |= CXL_DECODER_F_LOCK;
> +	}
Thanks

Jonathan


