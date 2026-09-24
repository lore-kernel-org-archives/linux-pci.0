Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75932227EBC;
	Thu, 24 Sep 2026 02:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790217939; cv=none; b=TURx14mv1HrO8dcMyheyIrliNtCbs9a4YPYanPutqltodducpz+CC1iZE6LQZKlsz/nNLv0URwB6LUosGtC/W9bWka5lFZLdJJQHfTnNnUqtEPDdu4MLFLTQ7U9+V9DSa3OYCuOPtEmHxTVuQO2JBCygRnes4hFnl7mZEC+y7V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790217939; c=relaxed/simple;
	bh=zL1yq7hU8lj4076zQUtnEM5DA5kq8YV2Z1K9B0FYS0c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ne2IeTuU7gHromqTjaNV3hnx3mHGcVz9wwPNw9pOhGYpce3a2qWoOu6Cc8UP6ZGt9wrOrV7/xp0rwaP3sYDN/pqKJlpKQSk6XhAXZVwLvTZoSY+N2ZQ0wKdcqvHyJAJpcPbTlHhu5grRrfANl1JQ97omNBEJIuLAzHfiTuAN9/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5c6KDz6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5c6KDz6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDEDC1F000FF;
	Thu, 24 Sep 2026 02:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790217938;
	bh=ZrDYZ4GF77lP0V1I5YcIUUSOV/11KelVnT9Rob6lO/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=P5c6KDz6/lcRa6KC40sPXoTuQrdD/TS4r5VS3/C/BVSpkYOJOUihi0r8n5sKlpdP2
	 RD5Om9xK/FqIZg6TyaF2qXiLg6Ztm5bTVCgq1cpQ+Dhajx2W9j5ETmVIco+1L+Pqan
	 2wBzef5PopjiJBtn+B43eUHlfTTDn8nRDpqAe7g4xPbm5sSAS74EFI5tSZA6wtrRJX
	 nECqhNJXl4pfYTkZJOiCsPkkeJS8kpc4uFC+ltf7DYjLHaBXMdrrAb2kALTZx1KzdF
	 ncO4fRGZSMYl0sWkNgBl/tje7P4kHFTTiKKs1fHXuVrq8tIvuoOsEgPr7kzubhVKWt
	 H7J2LjV8Rk6fw==
Date: Thu, 24 Sep 2026 03:45:31 +0100
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
Subject: Re: [PATCH v13 05/15] cxl: Introduce reusable HDM decoder settings
Message-ID: <20260924034531.0210cafd@jic23-hlaptop>
In-Reply-To: <20260922083924.2451158-6-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
	<20260922083924.2451158-6-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 08:39:14 +0000
Srirangan Madhavan <smadhavan@nvidia.com> wrote:

> Represent HDM programming state with struct cxl_decoder_settings and pass
> it to the commit helpers. Keep endpoint skip and switch targets at their
> call sites, place flags with the programming state, and leave runtime
> region ownership outside the snapshot.
> 
> Separate commit initiation from completion waiting so reset restoration
> can reuse register programming without changing normal DPA-lock policy.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Hi Srirangan,

I'm not sure if others will agree, but my inclination here
would not be to use the struct_group_tagged machine because
of the structure then being embedded in two places.

I'd just define the structure independently and pay the price
in churn to access the version in cxl_decoder.  The point being
to say 'these are the bits of cxl_decoder that we need
to store for reset purposes'.

Jonathan

> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 69941f7fdb76..1acdf537e4e9 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -42,8 +42,8 @@ enum cxl_decoder_type {
>   * @interleave_ways: number of cxl_dports in this decode
>   * @interleave_granularity: data stride per dport
>   * @target_type: accelerator vs expander (type2 vs type3) selector
> - * @region: currently assigned region for this decoder
>   * @flags: memory type capabilities and locking
> + * @region: currently assigned region for this decoder
>   * @target_map: cached copy of hardware port-id list, available at init
>   *              before all @dport objects have been instantiated. While
>   *              dport id is 8bit, CFMWS interleave targets are 32bits.
> @@ -52,18 +52,31 @@ enum cxl_decoder_type {
>  */
>  struct cxl_decoder {
>  	struct device dev;
> -	int id;
> -	struct range hpa_range;
> -	int interleave_ways;
> -	int interleave_granularity;
> -	enum cxl_decoder_type target_type;
> +
> +	struct_group_tagged(cxl_decoder_config, config,

Whilst strictly speaking correct, to me struct_group_tagged()
should only really be used when there is only one place that
the structure appears.  Otherwise it is just a bit obscure
to read.  It does give us the option of accessing the elements
in here without the extra jump, but I'm not sure that is
a good idea in this case.  So I'd just make this a normal
structure.  After all what is special about it being
defined here that isn't equally true of the cxl_decoder_settings
structure below?

> +		int id;
> +		struct range hpa_range;
> +		int interleave_ways;
> +		int interleave_granularity;
> +		enum cxl_decoder_type target_type;
> +		unsigned long flags;
> +	);
>  	struct cxl_region *region;
> -	unsigned long flags;
>  	u32 target_map[CXL_DECODER_MAX_INTERLEAVE];
>  	int (*commit)(struct cxl_decoder *cxld);
>  	void (*reset)(struct cxl_decoder *cxld);
>  };
>  
> +/**
> + * struct cxl_decoder_settings - CXL HDM decoder programming snapshot
> + * @config: common decoder configuration
> + * @target_or_skip_reg_val: switch target list or endpoint skip register value
> + */
> +struct cxl_decoder_settings {
> +	struct cxl_decoder_config config;
> +	u64 target_or_skip_reg_val;
> +};
> +
>  /*
>   * Using struct_group() allows for per register-block-type helper routines,
>   * without requiring block-type agnostic code to include the prefix.

