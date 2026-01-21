Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C9531771B;
	Wed, 21 Jan 2026 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768995733; cv=none; b=dN7NLkuDZMNycCUzvuQrvdb9jv3EgKRxpLtZ8DMg0lG+FAuq3T3ASkbP+17XeMuNR5RgWsMhvZjWrpI1/x1wFKPivLivHfK/29/yWXM+BAonpXDsf2PBid2FgONqCbDFuZtb2vCK5IrS3Y0cY6bHvrFvW+S7P+6qqYwCSGE2YM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768995733; c=relaxed/simple;
	bh=R5h/qe7C9ZhpNVB0wnfJezOgTApyDNovbHytOlk6nds=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nhwJ3iRo6UaMowNkidtnMDD8YHy5qV/v+ZmDedAAtd8ARpXdBwywTiU2fBlnVvkRmuKa+msf4H0fGL2zw7upFLoHz+irImlWbzHbnzgbli+kk12fbp6AAtCTgYshjeO8OZHH3xq/Oatk3CoblLsZtsNnsR+oZQQWFoOa81UG7Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dx2N51bJ2zJ46Bs;
	Wed, 21 Jan 2026 19:41:41 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C37D40563;
	Wed, 21 Jan 2026 19:42:07 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 21 Jan
 2026 11:42:06 +0000
Date: Wed, 21 Jan 2026 11:42:04 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <smadhavan@nvidia.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <ming.li@zohomail.com>,
	<rrichter@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vaslot@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <vidyas@nvidia.com>, <mochs@nvidia.com>,
	<jsequeira@nvidia.com>
Subject: Re: [PATCH v4 10/10] cxl: add HDM decoder and IDE save/restore
Message-ID: <20260121114204.00005d4f@huawei.com>
In-Reply-To: <20260120222610.2227109-11-smadhavan@nvidia.com>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
	<20260120222610.2227109-11-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Tue, 20 Jan 2026 22:26:10 +0000
smadhavan@nvidia.com wrote:

> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> Extend state save/restore to HDM decoder and IDE registers for Type 2
> devices. The HDM/IDE blocks are located via the component register map,
> then preserved across reset to retain decoder configuration and IDE
> policy. This avoids losing HDM/IDE programming when cxl_reset is issued.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Split the two up. One patch for HDM, one for IDE.

Been a while since I read the IDE stuff.

Isn't reset going to trip up the encryption to the extent that we need
to redo the key exchange etc?

> ---
>  drivers/cxl/core/regs.c |   7 ++
>  drivers/cxl/cxl.h       |   4 ++
>  drivers/cxl/pci.c       | 153 ++++++++++++++++++++++++++++++++++++++--
>  include/cxl/pci.h       |  43 +++++++++++
>  4 files changed, 201 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index ecdb22ae6952..76d6869d82ea 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -93,6 +93,12 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  			length = CXL_RAS_CAPABILITY_LENGTH;
>  			rmap = &map->ras;
>  			break;
> +		case CXL_CM_CAP_CAP_ID_IDE:
> +			dev_dbg(dev, "found IDE capability (0x%x)\n",
> +				offset);

Trivial: Fits on one line under 80 chars.

> +			length = CXL_IDE_CAPABILITY_LENGTH;
> +			rmap = &map->ide;
> +			break;

> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 7d6a0ef70b2d..eb735d0ae175 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c

> +/*
> + * CXL HDM Decoder register save/restore
> + */
> +static int cxl_save_hdm_state(struct cxl_dev_state *cxlds,
> +			      struct cxl_type2_saved_state *state)
> +{
> +	void __iomem *hdm = cxlds->regs.hdm_decoder;
> +	u32 cap, ctrl;
> +	int i, count;
> +
> +	if (!hdm)
> +		return 0;
> +
> +	cap = readl(hdm + CXL_HDM_DECODER_CAP_OFFSET);
> +	count = cap & CXL_HDM_DECODER_COUNT_MASK;

Use FIELD_GET() for this so we don't need to go check the definition to be
sure there isn't a shift.

> +	count = min(count, CXL_MAX_DECODERS);
> +
> +	state->hdm_decoder_count = count;
> +	state->hdm_global_ctrl = readl(hdm + CXL_HDM_DECODER_GLOBAL_CTRL_OFFSET);
> +
> +	for (i = 0; i < count; i++) {
> +		struct cxl_hdm_decoder_state *d = &state->decoders[i];
> +		u32 base_low, base_high, size_low, size_high;
> +		u32 dpa_skip_low, dpa_skip_high;
> +
> +		base_low = readl(hdm + CXL_HDM_DECODER_BASE_LOW(i));
> +		base_high = readl(hdm + CXL_HDM_DECODER_BASE_HIGH(i));
> +		size_low = readl(hdm + CXL_HDM_DECODER_SIZE_LOW(i));
> +		size_high = readl(hdm + CXL_HDM_DECODER_SIZE_HIGH(i));
> +		ctrl = readl(hdm + CXL_HDM_DECODER_CTRL(i));
> +		dpa_skip_low = readl(hdm + CXL_HDM_DECODER_DPA_SKIP_LOW(i));
> +		dpa_skip_high = readl(hdm + CXL_HDM_DECODER_DPA_SKIP_HIGH(i));
> +
> +		d->base = ((u64)base_high << 32) | base_low;
> +		d->size = ((u64)size_high << 32) | size_low;
> +		d->ctrl = ctrl;
> +		d->dpa_skip = ((u64)dpa_skip_high << 32) | dpa_skip_low;
> +		d->enabled = !!(ctrl & CXL_HDM_DECODER_ENABLE);

I'm lazy. Why not just stash the register values as a raw block and
put them back? Do we want to put them back if they aren't locked?
We ripped down the region so I'd be kind of expecting the type 2
driver for the specific hardware to need to put this stuff back
as part of it's own reinit.


> +	}
> +
> +	return 0;
> +}



