Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D4C48F836;
	Tue, 25 Aug 2026 23:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787699520; cv=none; b=bCUotl+qUw7kydUK5DFYcIjHS4yw+J3OYu8zQ6TJbJqfajypMPNpdRxJcCoqYzcOmDNSvTEXIZExoWQoSxpxjVmns5XlEJmuYDnbP33zQjm8X50YK+RX+4Zt1LLYvo2Zc5tAQZ5WXjNf/+EaDpqEVWcD7VDwg5yrVx6VVTYUNuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787699520; c=relaxed/simple;
	bh=0C4YVCEjxcLad+BKcLfu8kXX2dWpU1P3toibe4J1y5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKQ2RUj28f+tKUYLQkxyY4oKfCK0bzSbfcgMg3oK1wi3vPlBnozwLlhQL7/bh0cWXIbulQJOG8HqWjz8Ub3QXFuAuEJlMkn8KJtsjTmlkrPU52uqdh5PGFMbZNJr8BSgq7d9A08kYNJNgP/QhUX9KtQaLaR1FIOanMlyA8k5+lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Ma/SKC1r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DlRDOIhQ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Ma/SKC1r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DlRDOIhQ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4739F140006B;
	Tue, 25 Aug 2026 19:11:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 25 Aug 2026 19:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787699516;
	 x=1787785916; bh=s5X5r711sNi76uzB6suJO1vtp6P/krCgOqxtBND7le0=; b=
	Ma/SKC1rpPa30Xa6WPQLtk6pGQHPQXoodHtqLja/3eANyLHlFpV0PWdn9SBx4FEn
	A7PvjDgVdnAClY4NLFYUXQ2vCZ48ApjxU/peB1+soNLUXWGO4W6ZtQn/++ZKkmdG
	R/v5tsCUpXGN4y7zcSv+MgtOD/0pFHbX8T3HwJ92XplPJ6qvmpDaCTsDFkMKLzQ3
	fWaIbtOEt66ClCkw63il8mRjqx46JLFWQQSpCtj5xt8vDRhI0HVjqvJyqvDEiXZ9
	0qbAEuskM47q9YUEVxNSX141fXNXNhq2KqEYcff7VjJuzPj17fHGCCQTEVeAnTx5
	CTIS7jKUaub6zrdC4KnghA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787699516; x=
	1787785916; bh=s5X5r711sNi76uzB6suJO1vtp6P/krCgOqxtBND7le0=; b=D
	lRDOIhQh/TfwgHzD/Zh09/8m59q/VAVzL8yS8jEmdP3l7XR41bDA2og/KbIGw9rk
	qA7+WWtGU3NaWODayQVDDSVVnZW+qOVLYwtaYvwx02nD4nqHUuyRI5sLD1sG/Tej
	xT49WC2fk+iAJ8ibc/TzP3WZOT8h/Hz3GJ8e+x0t1acqKtiahzy7gANG87Ao2bMK
	2RclDKa83BS19jtBcTSvMQOXhtHiImAOhsL8RPR+gmCFaNO31ysHAIEMTteyvNGB
	buWj0YLE98BP4irnG1NIbnB8AkcActomVDRSDyLfgxBCC+XEFeaqNloM3eekCVkN
	BC1sISMtls7ZFrYRkp4pQ==
X-ME-Sender: <xms:OyGOaq3FCc4zMnlDKKGyjR23pKByUmeCAke4dXQhBmLiEUspsqV4rw>
    <xme:OyGOaqtT3hCXXUErl9LaLEcOESN3IiXhyk1pAcfOfrlxSysCX-c9z9M1dxdpy-21A
    Gd_FVrg3Pk74Ao-yLoSjtSHsmeRMQbL7rOLNRfxsY8hvqGB984hRA>
X-ME-Received: <xmr:OyGOaqTTsShHyA6fVyYFnDS5tyfYn078_SCzL3J2HfKZEPQqL0ULEy-uF5vFZA>
X-ME-Proxy-Cause: dmFkZTFZoGsgch79u4aY93SSL6BKHBNgXu/W+inpepofDrQZPSAF4WxXBg4kEq+dw+BHoW
    +861ZP3bfsY0rJD/xWoRrLWtNui0fe9ILm54nmDjg8Q6vwRes57TxLysC2ja7bqi7XwwRD
    i1f9D2HOjPUS5QIJrGLotqMxlQGGfvWpvQABxWwvNGAQEEi3mRlL/wjHaepjENE3K2Mr5x
    ALL3B+ElkR21o4Xm4l52oihFpSfuieDdTyTbDHHZCVKfqL4npNya7SpOOfrbkhS8qxF/Ze
    sA+uosYNLm9XcD8mSGbf0oFYtyk9c4jQOV8jM9uSPYi/9/zKOfBSEq0kgTvL2edJrh4tK7
    cXUFiVbdlDelFsCxVLcOa87nb9+a82OlRHvkons6ayKcXrLEZfmQV3uZNeCK4V6VudKLJW
    8x1N8bNZY+O5Zc3V8AYGqhotTpbvqt4w3rOD/hGwdYxQyrR7Qn4Eb0GO5z6MLQX1gtN0dI
    ZAVw1kYi2K5R0RBHQ5lvN5W6wMc2tNIdvwmHBhOf2dj/erGdJSy/BzkUrZpBj71PolRx6U
    0nBZzFrX2juo9MRdIC2icy/UY9BiYO/GlI+N4YeNEJz0ojYwLjPzk3oUbM+rKuFL2ALdg0
    K5dW05sNK4549X/oDwg1bDBnVqtQdCIXduDf95IdxQlDg9JJPoE/VesGDIUw
X-ME-Proxy: <xmx:OyGOakBBND2K0X806LL3vcyqvj6Xo7VwsyRjPPgVP_DJtf3BIskYfA>
    <xmx:OyGOakwAx7IO4048c1qKa29H_lmOOrBCSzgYPP0aHcA94g7WveLo_Q>
    <xmx:OyGOakvpnvooXh7W-LXH_WCT9Yu08M_BrV0XtGVpeeFLs0r2Rr19Sg>
    <xmx:OyGOatkBRaF11Vnip9jc7YTRnsLmQxk8GYqAbj1hmTTHxVMr-UzNZA>
    <xmx:PCGOajAolUVrUz0_O5Ig6NZjPbJ212BqJfByhoOG5jb590fQyI3ht70w>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Aug 2026 19:11:53 -0400 (EDT)
Date: Tue, 25 Aug 2026 17:11:51 -0600
From: Alex Williamson <alex@shazbot.org>
To: <mhonap@nvidia.com>
Cc: <jgg@ziepe.ca>, <ankita@nvidia.com>, <jic23@kernel.org>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <dave@stgolabs.net>, <alison.schofield@intel.com>,
 <vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
 <gustavoars@kernel.org>, <cjia@nvidia.com>, <kjaju@nvidia.com>,
 <vsethi@nvidia.com>, <zhiw@nvidia.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v4 05/27] cxl: Add a function-scoped reset entry for
 vfio-pci
Message-ID: <20260825171151.2f707b93@shazbot.org>
In-Reply-To: <20260813093631.2288172-6-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-6-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 15:06:09 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> vfio-pci needs to run a CXL reset on a passthroughed Type-2 device
> without the host-memory handling in cxl_reset_function(): the memory
> behind the decoder belongs to the guest.
> 
> Add cxl_reset_dvsec_sequence(), which runs the DVSEC reset and HDM decoder
> restore under pci_dev_lock and cxl_rwsem, and cxl_reset_capable() to gate
> it on a function-scoped reset.
> 
> Parameterize Memory Clear in cxl_reset_execute() so the guest owns the
> choice; the host path keeps it disabled.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/cxl/core/resource.c | 69 ++++++++++++++++++++++++++++++++++---
>  include/cxl/cxl.h           | 12 +++++++
>  2 files changed, 76 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 492ffe8e3576..cd15bd9171e6 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -1164,7 +1164,7 @@ static int cxl_reset_enable_cache(struct pci_dev *pdev, int dvsec)
>  				     PCI_DVSEC_CXL_DISABLE_CACHING);
>  }
>  
> -static int cxl_reset_initiate(struct pci_dev *pdev, int dvsec)
> +static int cxl_reset_initiate(struct pci_dev *pdev, int dvsec, bool mem_clr_en)
>  {
>  	u16 ctrl2;
>  	int rc;
> @@ -1173,7 +1173,10 @@ static int cxl_reset_initiate(struct pci_dev *pdev, int dvsec)
>  	if (rc)
>  		return rc;
>  
> -	ctrl2 &= ~PCI_DVSEC_CXL_RST_MEM_CLR_EN;
> +	if (mem_clr_en)
> +		ctrl2 |= PCI_DVSEC_CXL_RST_MEM_CLR_EN;
> +	else
> +		ctrl2 &= ~PCI_DVSEC_CXL_RST_MEM_CLR_EN;
>  	ctrl2 |= PCI_DVSEC_CXL_INIT_CXL_RST;
>  	return cxl_reset_write_ctrl2(pdev, dvsec, ctrl2);
>  }

I'd again avoid a bool arg here, an enum type might be a better option.

I see in the spec though that CXL Reset Mem Clr Enable is only
supported when the DVSEC CXL Capability register reports CXL Reset Mem
Clr Capable though.  Should this return -ENOTTY if memory clearing is
requested when the device is not capable?

> @@ -1273,7 +1276,7 @@ static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
>  }
>  
>  static int cxl_reset_execute(struct pci_dev *pdev, bool *target_prepared,
> -			     int dvsec, u16 cap)
> +			     int dvsec, u16 cap, bool mem_clr_en)
>  {
>  	int rc, rc2;
>  
> @@ -1283,7 +1286,7 @@ static int cxl_reset_execute(struct pci_dev *pdev, bool *target_prepared,
>  
>  	rc = cxl_pci_target_reset_prepare(pdev, target_prepared);
>  	if (!rc)
> -		rc = cxl_reset_initiate(pdev, dvsec);
> +		rc = cxl_reset_initiate(pdev, dvsec, mem_clr_en);
>  	if (!rc)
>  		rc = cxl_reset_wait_done(pdev, dvsec, cap);
>  
> @@ -1322,7 +1325,8 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  	scoped_guard(rwsem_write, &cxl_rwsem.region) {
>  		rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
>  		if (!rc)
> -			rc = cxl_reset_execute(pdev, &target_prepared, dvsec, cap);
> +			rc = cxl_reset_execute(pdev, &target_prepared, dvsec,
> +					       cap, false);
>  		if (!rc) {
>  			u16 command;
>  
> @@ -1340,3 +1344,58 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  	cxl_pci_target_reset_done(pdev, &target_prepared);
>  	return rc;
>  }
> +
> +/* True when a function-scoped CXL reset is available for @pdev. */
> +bool cxl_reset_capable(struct pci_dev *pdev)
> +{
> +	u16 cap;
> +
> +	if (cxl_reset_dvsec(pdev, &cap) < 0)
> +		return false;
> +
> +	if (pdev->multifunction)
> +		return false;
> +
> +	return cxl_reset_hdm_available(pdev);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_reset_capable, "CXL");
> +
> +/*
> + * Run the DVSEC reset sequence and restore HDM state for a caller that owns
> + * device quiesce and PCI config save/restore, such as vfio-pci. The HDM range
> + * collection and CPU cache flush that cxl_reset_function() does for host-owned
> + * memory are skipped; that memory belongs to the guest here.

It's worth noting in the comment that a device memory clear without a
preceding cache invalidation risks that the cache writes back some of
the memory we just cleared.  The use case later in the series does that
cache invalidation, but the requirement is a bit subtle here.  Thanks,

Alex


> + */
> +int cxl_reset_dvsec_sequence(struct pci_dev *pdev, bool mem_clr_en)
> +{
> +	bool target_prepared = false;
> +	int dvsec;
> +	int rc;
> +	u16 cap;
> +
> +	dvsec = cxl_reset_dvsec(pdev, &cap);
> +	if (dvsec < 0)
> +		return dvsec;
> +
> +	if (pdev->multifunction)
> +		return -ENOTTY;
> +
> +	/*
> +	 * Trylock rather than block: This follows the trylock convention of
> +	 * pci_reset_bus().
> +	 */
> +	if (!pci_dev_trylock(pdev))
> +		return -EBUSY;
> +
> +	scoped_guard(rwsem_write, &cxl_rwsem.region) {
> +		rc = cxl_reset_execute(pdev, &target_prepared, dvsec, cap,
> +				       mem_clr_en);
> +		if (!rc)
> +			rc = cxl_restore_hdm_after_pci_reset(pdev);
> +	}
> +
> +	cxl_pci_target_reset_done(pdev, &target_prepared);
> +	pci_dev_unlock(pdev);
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_reset_dvsec_sequence, "CXL");
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index f8e8fddba152..541ed6de75a6 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -164,6 +164,8 @@ void pci_cxl_hdm_init(struct pci_dev *pdev);
>  void pci_cxl_hdm_release(struct pci_dev *pdev);
>  int cxl_restore_hdm_after_pci_reset(struct pci_dev *pdev);
>  int cxl_reset_function(struct pci_dev *pdev, bool probe);
> +bool cxl_reset_capable(struct pci_dev *pdev);
> +int cxl_reset_dvsec_sequence(struct pci_dev *pdev, bool mem_clr_en);
>  #else
>  static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
>  {
> @@ -182,6 +184,16 @@ static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  {
>  	return -ENOTTY;
>  }
> +
> +static inline bool cxl_reset_capable(struct pci_dev *pdev)
> +{
> +	return false;
> +}
> +
> +static inline int cxl_reset_dvsec_sequence(struct pci_dev *pdev, bool mem_clr_en)
> +{
> +	return -ENOTTY;
> +}
>  #endif
>  
>  struct cxl_reg_map {

