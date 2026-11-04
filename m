Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836509;
	b=wub5WxBRJhxj3NUnBNAFQszPK/lmm7Z2ZIszWPgxGKn+pSEDsz4+2+/xgTRe44Z0N5gR
	 fzFhGOwgUc3wW+22QQv2q0xPn2/R5DcdVBiTIFHcxkkL7mpfWsCFhN9YR3iMMK//Gxaoi
	 H1SoLkedT+BDcK96n7bvHPnuNln5U/Yjh8vwOHnpkBTZPY8MxLlrCemnsqW6pj0KTTm/f
	 +n8lX0zdYz0O++5mSQyQUCaUpD3/GWAZMGUyX9w36ULkIuHxAJtEfDwkucl4MARmVEQKG
	 GwxLpp3awLjqmb3ljvdq3PwXUm4zBH6ju7Gs6mcAVfT5AqFuupmT+bHMojCrAjYOleQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836509;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=66HAmcjm61KlBHZ1ai2pj7fj2H6IVPJsxsxVZkqPIko=;
	b=HwNG7Eca8N/vYyf3kaThhlHxQoC/8GgH//srdkXGV7jNOMbO+qtRbjhRcVsOgdfXFnd0
	 TLoQkIMYowA+r2wNu2jaZsSRJcJPWResDW2Anhi2SUpcfUt/aPtVfqvQn556Es4ORA46g
	 4W9+poxP4H1ooOx44Hq8xCQi8Rmkb4Y+cR3Mv6y7FsMKzZEphbynqSTHxw0RgSQpPNrN0
	 838KgcgdXCs7hInLNZQYfITYx2qFWEr2TmfdMfjySUFdMSzKP7m6Royo00wz+sAsjiLgU
	 4suDvbFl7CJqfjps1CC8IZxEbhAwPVajxBArs/i6jxo52Pq4nUhts8L9rnWZ4Owd2kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=T5A2jWbP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lZjcmoFi;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E03606A33D
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 23:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5E03606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=T5A2jWbP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lZjcmoFi
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0F60E14001D0
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 18:55:08 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 04 Nov 2026 18:55:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793836507;
	 x=1793922907; bh=66HAmcjm61KlBHZ1ai2pj7fj2H6IVPJsxsxVZkqPIko=; b=
	T5A2jWbPWxl1lhbv32cmhILFdkUju8r/nrlpeFHVCVMFc9sdcN9aX5giN24i7CdL
	kYME6gExVwjrQ636Szu1lvN2nu6giIEBiQM+Ai2ponsE85xrXfB+4t/1UcxnU69P
	ZxIci707rmaePQcgc6Go8wY3DTjvyLEdlLEjrID10DF2sNjc2bL7CSE+Tz2uW2KS
	rbCts8oU+znTiJ9OVIX7XQCkqpu6Fvij94YYhZTOGZwK3GKyOny097D+gonfLCnx
	eTmIq3bgE5h7uFS3nc13Jo8zTKqKzUToMoOd94MkBC14DuVUYR89icWa5cQWSY6D
	Jzm8vFCtWlqcePDC7w3uHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793836507; x=
	1793922907; bh=66HAmcjm61KlBHZ1ai2pj7fj2H6IVPJsxsxVZkqPIko=; b=l
	ZjcmoFi6xNq27AkG3IKOKHO3+LBKOFQ+o/7zs8930WxWBAQm15W0JlpO1Dp77ZfY
	IjCI8sbSP3ks3i+DPvEFtS7ru6w6y9dUuGRlYqwYtv4P5+hS0X+i6DUtrmX8OIc/
	gWKOaI2VUjJCcZ7J5nJxZRq9/YWmO2FG6Hsbrx6QzM7jqP45+6Jd76uLz1YGqoXA
	SKcL0ADr9CnB4ht245rqUlPvMOBENhcm7ACY/q0rE+Q6RN8h6WM8SbkhzR7EWraG
	MLTYq4fAcSbvwjJjNxKxWY4Vh/oohuBcOJpeYe+h5lFVxg3+CAGXP9jDyKE1x/I3
	UUxmuPxeqcpxObAypYYJA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793836507; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:JaLVJkw/ypdFDoeRC2iXlKeLGYBmJXSKYEAJNBi3yjJ3PCD
	rOryEAtxUBUPbhgLozZ3Jnb54Chf0zMj1b8YUVl+wij76PmbiaPv9ZE0uY6RKBHl
	w8LB36miVzEDEJ6wPiTTrcRQq9KF02BoA770hIwWpVAzQjSCDtIH6H+lpjNbKZT2
	PDWmoRhKDWTDdEXK/+mVMZqN1mwyZhxXFePVYbn9D0Zv4209vE1+ZctjlPr8rFlX
	+B3txfDr7nYeKXT+FsTSWxPT2hriPcvqBGW/XvGqR8u277ICMaxd4ADxGKvgQI1Y
	pvJr51sdDOr8X/PgDR3SDA6Fti/s5vCv/2Oyj0Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:TaSBnqbZbFLM+Lcqo9/30tsl6PtBjEh1Y44sA86R2VU=:GAg/5X0ELH1fFkpwU6TyWBYPUjHgBmFWX4gfN3/zjf0=;
X-ME-Sender: <xms:28Xrar1vcGz5hoWdK6WSGM_BjyIpAKV-WCMEbuLzfAmZKahcMTAlXQ>
    <xme:28XranscH2bLu1DdyOx4EU5v0YeM5uP92IDcFtxf_6qCw3TYz0zNrHvOJlhmDtRTR
    aMLKAVM09GKB9_fk_tRmvWiEHmo5GvhoOrEf8AZGtDn1JrjmJpsrQ>
X-ME-Received: <xmr:28XrajQ0cimyNjhnUZjMktQOErZM-A9YWdptd3a9Jbk1rF4mEf8aOKONXnBVeA>
X-ME-Proxy-Cause: dmFkZTFU/kbVOsWxOTPcCpe6x61hsj1WNmmGso+RiYOPL9PXBn0IITeBo+AW6SFW+G4ekC
    /hzYoF162vC7PC2Mtt2USNZ/eCRzPfnSvLH4GpnZYykCQlv/g/2dfaxUihNQ2PdVnmznVt
    eyzTFpFT8ROSV9PpSF+vkXBd8GjUZhM6/FJB6rHUdJL+IEmDIn9qqg8D9AaoFAEgqB3zaI
    LQuuKEKLXGp7sIkYnu8IYt8f4dndp/+v360R0jn1bNCYEbWntuZR9TDLjZCVdVdTAj6SKy
    IHj9Y41QEBh5Iv1k5SCIJDAY7TVRfrnmdQbz1lqnEzzeOazcj9kVYNjTrGiFbntAEPcYl6
    TKBbrTXANfvWTMkaMpvDouK0nzivONDFKOWARUqEboCnjjVdCMk0QyhDc4UUCvxFdNStFg
    Vo6LEu54fLMLt9c0n2ZHRvjwLiOSNH4p6jVHDo/NV0Faa9C0UsBdgZn8CqgJJu/Hszj3V8
    /5yLo17S+fbLb5dKziy4uV16Co+sdK4wpCVw3G06D76G2djKZu9Hqri38F97xkpVW4EBOL
    Rg/VDUMD7hVhR4+/l6Fplv+0GCDa1sX3N1EpkJ7L2k6T7rX0JXaRstLFQszvI2v/3beYtM
    D3MH2O82NCghIHq8TgN2f5PAVJev24JlCJur5Ym48kxNWbsPRk8k8qlhVd/g
X-ME-Proxy: <xmx:28XrapC-nkreJMq4NBOiyw4aFyn48dxFw5ud_Viq9v8EVSn7b7ATSg>
    <xmx:28Xralw7dPudntJ-jeqi6r5HJYZQm7bSsqRUVI_Har0BcG2wI1XJlA>
    <xmx:28XrahtvMeIb26vgGA4r8WpzXjHzjrgoPrk-3ah1iuSLwjK2A-QQIA>
    <xmx:28XramnboJoFtpuAQJ4Bpo3EjxPIfYkKwag4mnzgt0CzaCkJ1ytflg>
    <xmx:28XraoCa0Avt3ySiAMG8D60JgtMYFNcmfHHBNnjOw1BT-DLJXJkTHrRu>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 18:55:05 -0500 (EST)
Date: Wed, 4 Nov 2026 16:54:22 -0700
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
Subject: Re: [PATCH v6 04/31] PCI/CXL: Let the driver that owns the HDM
 range run CXL Reset
Message-ID: <20261104165422.64b53bc4@shazbot.org>
In-Reply-To: <20261016161839.2765592-5-mhonap@nvidia.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
	<20261016161839.2765592-5-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 21:48:11 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> vfio-cxl passes a CXL Type-2 device to a guest and must run CXL Reset at
> the vfio reset points. The cxl_reset PCI reset method does not fit that
> caller:
> 
> - It requests every HPA range the device decodes. vfio-cxl holds that
>   range with request_mem_region_exclusive() while it exposes the memory,
>   so the request fails with -EBUSY.
> - When the reset cannot run, the method returns -ENOTTY and the PCI core
>   moves on to the next method. That is FLR, which leaves device memory
>   intact for the next user.
> - The snapshot and restore helpers that vfio-cxl needs after a bus reset
>   and on return from low power are not exported.
> 
> Let cxl_hdm_quiesce_prepare() take the resource the caller already holds
> and skip the request for ranges inside it. pci_cxl_reset_owned() accepts
> only a resource marked busy and exclusive, as
> request_mem_region_exclusive() leaves it. The CPU caches are still
> written back and invalidated for every range before and after the reset,
> as the reset method does.
> 
> Add:
> - pci_cxl_reset_owned(): runs the reset method's sequence for a caller that
>   holds the device lock and returns any failure to that caller
> 
> - pci_cxl_reset_capable(): checks the cached HDM state and the CPU cache
>   invalidation that the reset-method probe skips.
> 
> - pci_cxl_hdm_snapshot(): copies the HDM state cached at enumeration
>   without requiring the device lock. A driver needs this copy in probe,
>   which the PCI core may run in a worker on the device's NUMA node, where
>   device_lock_assert() would warn although the binding task holds the
>   lock. pci_cxl_reset_prepare() becomes that copy plus the lock assertion.
> 
> Export:
> - pci_cxl_reset_owned()
> - pci_cxl_reset_capable()
> - pci_cxl_hdm_snapshot()
> - cxl_restore_state_after_pci_reset()
> 
> to the vfio-cxl module only, and declare them in include/cxl/pci.h.
> 
> CXL Reset always clears memory, so there is no caller Memory Clear choice.
> 
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/cxl/core/hdm_state.c |  22 ++++--
>  drivers/pci/cxl.c            | 136 ++++++++++++++++++++++++++++-------
>  drivers/pci/pci.h            |  18 +----
>  include/cxl/hdm.h            |   3 +-
>  include/cxl/pci.h            |  39 ++++++++++
>  5 files changed, 171 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
> index 95daeda0ef80..9452047e3b97 100644
> --- a/drivers/cxl/core/hdm_state.c
> +++ b/drivers/cxl/core/hdm_state.c
> @@ -267,7 +267,8 @@ static int cxl_hdm_ranges_collect(struct cxl_hdm_quiesce *q, struct device *dev,
>  	return 0;
>  }
>  
> -static int cxl_hdm_ranges_request(struct cxl_hdm_quiesce *q)
> +static int cxl_hdm_ranges_request(struct cxl_hdm_quiesce *q,
> +				  const struct resource *owned)
>  {
>  	struct cxl_hdm_range *range;
>  
> @@ -275,6 +276,12 @@ static int cxl_hdm_ranges_request(struct cxl_hdm_quiesce *q)
>  
>  	list_for_each_entry(range, &q->ranges, list) {
>  		const struct range *hpa_range = &range->hpa_range;
> +		struct resource res = DEFINE_RES_MEM(hpa_range->start,
> +						     range->len);
> +
> +		/* The caller already holds this range exclusively. */
> +		if (owned && resource_contains(owned, &res))
> +			continue;
>  
>  		range->res = request_mem_region(hpa_range->start, range->len,
>  						"cxl_reset");
> @@ -316,15 +323,20 @@ static int cxl_hdm_ranges_invalidate(struct cxl_hdm_quiesce *q)
>   * @dev: device for error messages
>   * @q: quiesce state to initialize
>   * @snapshot: HDM state from cxl_hdm_cache_snapshot()
> + * @owned: resource the caller holds exclusively over the ranges, or NULL
>   *
>   * Reserve every enabled system-physical range in @snapshot exclusively, then
> - * write back and invalidate CPU caches for them. Call
> - * cxl_hdm_quiesce_destroy() afterwards whether or not this succeeds.
> + * write back and invalidate CPU caches for them. A range inside @owned is
> + * not requested again; the caller's reservation already excludes other
> + * users.
> + *
> + * Call cxl_hdm_quiesce_destroy() afterwards whether or not this succeeds.
>   *
>   * Return: 0 on success, or a negative errno.
>   */
>  int cxl_hdm_quiesce_prepare(struct device *dev, struct cxl_hdm_quiesce *q,
> -			    const struct cxl_hdm_info *snapshot)
> +			    const struct cxl_hdm_info *snapshot,
> +			    const struct resource *owned)
>  {
>  	int rc;
>  
> @@ -340,7 +352,7 @@ int cxl_hdm_quiesce_prepare(struct device *dev, struct cxl_hdm_quiesce *q,
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_hdm_ranges_request(q);
> +	rc = cxl_hdm_ranges_request(q, owned);
>  	if (rc)
>  		return rc;
>  
> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> index ed0b6f619c70..b4d467506c54 100644
> --- a/drivers/pci/cxl.c
> +++ b/drivers/pci/cxl.c
> @@ -372,9 +372,32 @@ static int cxl_reset_save_restored_state(struct pci_dev *pdev, u16 command)
>  	return rc;
>  }
>  
> +/**
> + * pci_cxl_hdm_snapshot() - copy the HDM state cached at enumeration
> + * @pdev: CXL device
> + *
> + * The cache is read under cxl_rwsem.dpa, so the caller needs no device
> + * lock. A driver can call this from probe, which the PCI core may run in a
> + * worker on the device's NUMA node while the binding task holds the lock.
> + *
> + * Return: a copy to free with kfree(); NULL when @pdev has no cached HDM
> + * state; or an ERR_PTR() on failure.
> + */
> +struct cxl_hdm_info *pci_cxl_hdm_snapshot(struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_info *snapshot;
> +
> +	snapshot = cxl_hdm_cache_snapshot(&pdev->hdm);
> +	if (IS_ERR(snapshot) && PTR_ERR(snapshot) == -ENXIO)
> +		return NULL;
> +
> +	return snapshot;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(pci_cxl_hdm_snapshot, "vfio-cxl");

Why are any of these module locked?  What great risk do they expose
that only vfio-cxl should have access to versus just a NS export?

We shouldn't set a precedent for vfio specific APIs and I certainly
don't want to be defending such a thing down the road.

It's unfortunate that we're intermixing "snapshot" from CXL but using
it like a "save state" from PCI.  Maybe we could bridge the gap at the
PCI API?

> +
>  /**
>   * pci_cxl_reset_prepare() - allocate HDM state storage ahead of a bus reset
> - * @pdev: device about to be reset
> + * @pdev: device about to be reset, with its device lock held
>   *
>   * Copy the cached HDM state before the reset, so that restoring cannot fail
>   * for lack of memory. The decoder settings are refreshed when the state is
> @@ -386,14 +409,8 @@ static int cxl_reset_save_restored_state(struct pci_dev *pdev, u16 command)
>   */
>  struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev)
>  {
> -	struct cxl_hdm_info *snapshot;
> -
>  	device_lock_assert(&pdev->dev);
> -	snapshot = cxl_hdm_cache_snapshot(&pdev->hdm);
> -	if (IS_ERR(snapshot) && PTR_ERR(snapshot) == -ENXIO)
> -		return NULL;
> -
> -	return snapshot;
> +	return pci_cxl_hdm_snapshot(pdev);
>  }
>  
>  /**
> @@ -433,6 +450,7 @@ int cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
>  	cxl_region_quiesce_unlock();
>  	return rc;
>  }
> +EXPORT_SYMBOL_FOR_MODULES(cxl_restore_state_after_pci_reset, "vfio-cxl");
>  
>  /*
>   * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
> @@ -642,7 +660,8 @@ static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
>  	return rc;
>  }
>  
> -static int cxl_reset_quiesced(struct pci_dev *pdev, int dvsec, u16 cap)
> +static int cxl_reset_quiesced(struct pci_dev *pdev, int dvsec, u16 cap,
> +			      const struct resource *owned)
>  	__must_hold(cxl_region_quiesce)
>  {
>  	struct cxl_hdm_info *snapshot __free(kfree) = NULL;
> @@ -663,7 +682,7 @@ static int cxl_reset_quiesced(struct pci_dev *pdev, int dvsec, u16 cap)
>  		return PTR_ERR(snapshot);
>  	}
>  
> -	rc = cxl_hdm_quiesce_prepare(&pdev->dev, &q, snapshot);
> +	rc = cxl_hdm_quiesce_prepare(&pdev->dev, &q, snapshot, owned);
>  	if (rc) {
>  		cxl_hdm_quiesce_destroy(&q);
>  		return rc;
> @@ -686,32 +705,40 @@ static int cxl_reset_quiesced(struct pci_dev *pdev, int dvsec, u16 cap)
>  	return cxl_reset_save_restored_state(pdev, command);
>  }
>  
> -static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
> +static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
> +			     const struct resource *owned)
>  {
>  	int rc;
>  
> +	/* Raw reset callers may not have saved the PCI state needed for restore. */
> +	if (!pdev->state_saved) {
> +		pci_err(pdev, "CXL reset requires saved PCI state\n");
> +		return -EINVAL;
> +	}
> +
>  	cxl_region_quiesce_lock();
> -	rc = cxl_reset_quiesced(pdev, dvsec, cap);
> +	rc = cxl_reset_quiesced(pdev, dvsec, cap, owned);
>  	cxl_region_quiesce_unlock();
>  
>  	return rc;
>  }
>  
> -int cxl_reset_function(struct pci_dev *pdev, bool probe)
> +static int cxl_reset_check(struct pci_dev *pdev, bool probe, u16 *dvsec,
> +			   u16 *cap)
>  {
> -	u16 dvsec, cap, ctrl;
> +	u16 ctrl;
>  	int rc;
>  
> -	rc = cxl_pci_device_dvsec(pdev, &dvsec, &cap);
> +	rc = cxl_pci_device_dvsec(pdev, dvsec, cap);
>  	if (rc)
>  		return probe ? -ENOTTY : rc;
> -	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
> -	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
> -	    !(cap & PCI_DVSEC_CXL_RST_CAPABLE) ||
> -	    !(cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE))
> +	if (!(*cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
> +	    !(*cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
> +	    !(*cap & PCI_DVSEC_CXL_RST_CAPABLE) ||
> +	    !(*cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE))
>  		return -ENOTTY;
>  
> -	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
> +	rc = pci_read_config_word(pdev, *dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
>  	if (rc)
>  		return probe ? -ENOTTY : pcibios_err_to_errno(rc);
>  	if (PCI_POSSIBLE_ERROR(ctrl))
> @@ -737,11 +764,70 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  	if (!cpu_cache_has_invalidate_memregion())
>  		return -ENOTTY;
>  
> -	/* Raw reset callers may not have saved the PCI state needed for restore. */
> -	if (!pdev->state_saved) {
> -		pci_err(pdev, "CXL reset requires saved PCI state\n");
> +	return 0;
> +}
> +
> +int cxl_reset_function(struct pci_dev *pdev, bool probe)
> +{
> +	u16 dvsec, cap;
> +	int rc;
> +
> +	rc = cxl_reset_check(pdev, probe, &dvsec, &cap);
> +	if (rc || probe)
> +		return rc;
> +
> +	return cxl_reset_execute(pdev, dvsec, cap, NULL);
> +}
> +
> +/**
> + * pci_cxl_reset_capable() - check whether CXL Reset can run on a device now
> + * @pdev: CXL device
> + *
> + * Unlike the reset-method probe, this also checks the cached HDM state and
> + * the CPU cache invalidation that the reset needs.
> + *
> + * Return: true when pci_cxl_reset_owned() can attempt the reset.
> + */
> +bool pci_cxl_reset_capable(struct pci_dev *pdev)
> +{
> +	u16 dvsec, cap;
> +
> +	return !cxl_reset_check(pdev, false, &dvsec, &cap);
> +}
> +EXPORT_SYMBOL_FOR_MODULES(pci_cxl_reset_capable, "vfio-cxl");
> +
> +/**
> + * pci_cxl_reset_owned() - CXL Reset for the driver that owns the HDM range
> + * @pdev: CXL device, with its device lock held and PCI state saved
> + * @owned: resource the caller reserved over the device's HPA range with
> + *	   request_mem_region_exclusive(), or NULL
> + *
> + * Run the same sequence as the cxl_reset method. Ranges inside @owned are not
> + * requested again, so a driver that keeps the HPA range reserved while it
> + * exposes the memory can reset the device. The CPU caches are still
> + * invalidated for every range before and after the reset.
> + *
> + * Return: 0 on success, or a negative errno. Unlike the reset method, a
> + * device that cannot be reset returns an error to the caller instead of
> + * falling through to another reset method. -EINVAL if @owned is not a busy,
> + * exclusive reservation.
> + */
> +int pci_cxl_reset_owned(struct pci_dev *pdev, const struct resource *owned)
> +{
> +	const unsigned long held = IORESOURCE_BUSY | IORESOURCE_EXCLUSIVE;
> +	u16 dvsec, cap;
> +	int rc;
> +
> +	device_lock_assert(&pdev->dev);
> +
> +	/* Only a busy, exclusive reservation keeps other users off the range. */
> +	if (owned && WARN_ON_ONCE((owned->flags & held) != held))
>  		return -EINVAL;
> -	}
>  
> -	return cxl_reset_execute(pdev, dvsec, cap);
> +	rc = cxl_reset_check(pdev, false, &dvsec, &cap);
> +	if (rc)
> +		return rc;
> +
> +	return cxl_reset_execute(pdev, dvsec, cap, owned);
>  }

There's a lot of asymmetric sketchiness through this path.
pdev->state_saved is required to be set by the caller, but the state
gets restored and state_saved invalided deep inside
cxl_restore_pci_state_for_hdm_restore() on this path. That's not at all
symmetric to the PCI conventions and the split ownership model is poor.
Even worse, it's vfio-pci-core doing the pci_save_state() on behalf of
the cxl_ops.reset callback.

Where does bus-master get cleared?  Seems we've only got half of
pci_dev_save_and_disable() implemented here and the save has become the
caller's responsibility.  Thanks,

Alex
