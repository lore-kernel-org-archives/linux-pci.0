Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EF26FC5;
	Thu, 24 Sep 2026 03:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219309; cv=none; b=ltXn/pj/9X1JLrMJJXP4FNylD1SPLq6G+8iVuU9/6Qw7ta6nq+gww2vyD4kbmijFemMAKE8osZJ//YFCCOoWbTNkIJm/ZSuQUzE2+NTVXXkDTRhuc7OC7pPZF4Iw0dqj82SLA5vgUzHwmoLfFVAm6hEb7ZnwhExhI+qVKsX9+qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219309; c=relaxed/simple;
	bh=aHLCe9GDgquO1jNNuuddxO+BhU/C056D/lCl3Kik9tU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TaQPuGA0tKjBVtwLarE1dPLuvWLbm5KFOyxWg1BjwuIV0TJa5uSlQI7oMNGNgC4hRmdHgsYks6ysq2/hRMa1qbOKpMeJ7SUnOj5YpSsEojIhUTqt8zkIYP8gkFekQWGAVj7UwkxsCmCoxFuY3WNcSBesETGmAVoxH50S21INB6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iH+hNAo+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iH+hNAo+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14351F000FF;
	Thu, 24 Sep 2026 03:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790219307;
	bh=1lHst4u39cEHlmK22+WdrxAU3AZESZfSCznVC/vLCt8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iH+hNAo+xsg9gfUAIikUxs+FivNswNf5PRtiEj8JL1Pd/zodG9/ihecXbd8ZOgfaL
	 ab42G8RMepYPUD3CETsG5XDDhJ9eTJTyDL2Y/pWeXBvCLRwP+MWi+YK5d5A4pLFNVv
	 PnyZDXwdhIBRrTxPdz/x64vxMt1JC/2zL9TfIsfdPZLSX/u7ywLE1Yf+BgrmcniZUa
	 LlJrv3knzsCeCMFcvRWDcvlLtmM06jSQAJnWPE/iMx3DA7XWuTHZOEOCFajDoMI3dt
	 kELZPEawyh/Ft75tMMokIrjjcRcrF+sD8KBmbhCbB1Yd0/O9LXDwUJKDXiO0OBRY+n
	 nfmJdCd4Z2wIw==
Date: Thu, 24 Sep 2026 04:08:20 +0100
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
Subject: Re: [PATCH v13 08/15] cxl: Refresh cached PCI HDM decoder settings
Message-ID: <20260924040820.008a2575@jic23-hlaptop>
In-Reply-To: <20260922083924.2451158-9-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
	<20260922083924.2451158-9-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 08:39:17 +0000
Srirangan Madhavan <smadhavan@nvidia.com> wrote:

> Early PCI discovery creates the HDM cache, while later CXL enumeration and
> decoder operations provide updated programming state.
> 
> Refresh the PCI snapshot when decoders are enumerated, committed, or reset
> so reset recovery need not walk the CXL topology. Ignore updates when no
> cache exists and reject decoder-count mismatches.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 1acdf537e4e9..005259e38f4b 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -77,6 +77,28 @@ struct cxl_decoder_settings {
>  	u64 target_or_skip_reg_val;
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
> + * @settings: per-decoder programming state
> + */
> +struct cxl_hdm_info {
> +	int decoder_count;
> +	int hdm_bar;
> +	resource_size_t hdm_offset;
> +	resource_size_t hdm_size;
> +	u32 global_ctrl;
> +	u16 dvsec_ctrl;
> +	bool dvsec_ctrl_valid;
> +	struct cxl_decoder_settings settings[];

Can we use __counted_by(decoder_count) for this?

> +};


