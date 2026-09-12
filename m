Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ED64BEE3C;
	Sat, 12 Sep 2026 01:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176830; cv=none; b=Hn8BNMf2yorI2bwVB50hSF2Yy4HqwHsEcfOXcDSFuh5ncOIver5K+nLuCl8jb9gYZ5e+PpG9yBSm9DBbabOZ9AnAxHBg2n/e1Qc69Uk5jDblod2mXl8Iohwp6spHiRmkArlSihrefYMLXXhdx9WQTHKQ5Rra443BhQPGVO/8iBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176830; c=relaxed/simple;
	bh=jxnnJfIHdlB9O/rEFwbgFUFJf3iCLF3oOFfuCrhbP68=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YA/rh5xB+rURUzsjH/zlXFi2FSgiidfNduGzFSei2IxpOCk/MoTNZhbbLoCL99tFVC1Yrr/MqduakneM5P6BZAqLJNRqNdYjybtiXtD4kDDRd78w0f1wH6IQWv/4Eekxp8mMnSxcPjCDdmeoQmlNFWlKieXtSf62NI52zHkjKVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oh6JVxC8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oh6JVxC8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988331F000FF;
	Sat, 12 Sep 2026 01:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789176828;
	bh=7PzucTU+WUw2me/i9+ENTxqo4Sf5UyZNFXbff9i/G3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oh6JVxC8tYfONB01HLVThVRiJlhjQSG8SCUvOmlnrI938ZfsdWuw3EOrcQQglYJvy
	 IEIPXrL3sOZi98PO6kAjlnt6BnBS36HbTmz4Nbx5aBahosixrEHaBZiRb5diVe7XkO
	 RmB3BJKjsmmaXG74qOg5RLCQRAPJc0DwIV9ee0YMdq6wotk9YTCzU1fNFdgZlQptGw
	 WJBEohH5cDJ+uzW8euaLmsRJGKxzc8WP5VcbQw7kXp+8TvfaCkqVppZ5jhTMsbunTK
	 oagg4YBUyGiF+/NwQNmSc2GiNhoopSemnKwUc4yp0zagZqed6y9zCPRSijOHllwgX7
	 5+paNM5xudNTA==
Date: Sat, 12 Sep 2026 02:33:44 +0100
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
Subject: Re: [PATCH v12 07/12] cxl: Validate HDM ranges before CXL reset
Message-ID: <20260912023344.4cdeaf7a@jic23-hlaptop>
In-Reply-To: <20260910070808.1444264-8-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
	<20260910070808.1444264-8-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 07:08:03 +0000
Srirangan Madhavan <smadhavan@nvidia.com> wrote:

> Before reset, require cached HDM decoder state, collect enabled decoder
> ranges, and reserve them with request_mem_region(). This rejects reset
> while affected CXL memory is busy and keeps the validation stable
> through reset.
> 
> If CPU cache invalidation support is available, invalidate the affected
> ranges before reset.

If it is not what happens? I'm thinking dead system as coherency just broke
but maybe not. My gut is no reset without cache invalidation support.

In general document your cache invalidation flow in this commit message. I'd
suspicious you don't have a pair of invalidations, one before to ensure
all caches are clean and one after to evict prefetched lines if your
device was mean enough to serve garbage during the reset
(which many will do!) 

If more comes in later patches, but a breadcrumb in here to say so.

> If the runtime backend is unavailable, continue
> after the range reservation succeeds.
> 
> Reject CXL Reset when no cached HDM decoder state is available. The reset
> path needs the cached address map to validate affected ranges and perform
> CPU cache invalidation. Also reject normalized-addressing decoders for
> now because the cached decoder range is not a system physical address.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>



> +static int cxl_hdm_range_flush_cache(struct cxl_hdm_range *range)
> +{
> +	struct pci_dev *pdev = range->pdev;
> +	const struct range *hpa_range = &range->hpa_range;
> +	int rc;
> +
> +	rc = cpu_cache_invalidate_memregion(hpa_range->start, range->len);
> +	if (rc)
> +		pci_err(pdev,
> +			"failed to invalidate CPU cache [%#llx-%#llx]: %d\n",
> +			hpa_range->start, hpa_range->end, rc);
What does the wrapper really bring?

> +
> +	return rc;
> +}
> +
> +static int cxl_hdm_ranges_flush_cpu_caches(struct cxl_hdm_range_context *ctx,
> +					   struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_range *range;
> +	int rc;
> +
> +	if (list_empty(&ctx->ranges))
> +		return 0;
> +
> +	if (!cpu_cache_has_invalidate_memregion()) {
> +		pci_warn(pdev,
> +			 "CPU cache synchronization unavailable; continuing without cache invalidation\n");

boom.  Unless you have very strong reasonsing for me this is a no.
This introduces extremely subtle cache coherency corruption into your
system and no one wants to debug results of that.

> +		return 0;
> +	}
> +
> +	list_for_each_entry(range, &ctx->ranges, list) {
> +		rc = cxl_hdm_range_flush_cache(range);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}

