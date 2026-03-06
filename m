Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF19382386;
	Fri,  6 Mar 2026 23:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772840099; cv=none; b=Em00ZV6uOXPho8WnvdHZldwyocP5kw5FtSGou0LEBOfQbEA7EMrecwkJqgx0CIHP2NhqYVpaFGVRCX8pbkXGlRd1U/DBdqrDE8EByNdl24MUgwQycqqUy7AbbB3AYuH4PIf4VPETW2rD/1dBgqzvCRkwEipGy+a0mOgIeZ9VtmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772840099; c=relaxed/simple;
	bh=s2nskTlQdWo3LKw6YLtDtOO/yNHnk0Gu8LCjaZ6yGPo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Um2Oj9gpyI5B/WBbaTumtvfeoLhBQI9y5edH80wRL5uMTKFH1hJr9/yHR1G31+MARaxyRIBv47z+rNOjaMFkaM7yeFcv1WXC8Ys5SlXd1EyyX452LygM1fd5EFAVpFmBJ+HV0jHwCmmkTlLx2Kox91QapJZjS2GoAFddgtPVxzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=uJnV5kiB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HpRevaMU; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="uJnV5kiB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HpRevaMU"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0577E7A0155;
	Fri,  6 Mar 2026 18:34:55 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 06 Mar 2026 18:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772840095;
	 x=1772926495; bh=5GQ6MLbXQIBCrhdy8xTOE8qptIqPEfLGFpCwvebhNs4=; b=
	uJnV5kiBh9CcormYaTuv8yJEuruJchFeiw02uKj6+ngDh+7oVj8Qleyme5EjYeba
	aWeSaDsswZS3GhgwHAJ21Axr6MUtSDtNuAI7GxjWQh8hlAYG4ojCVFfdBsfDs88z
	lAASe2slJ7fzYJWD96PWv06hzOUPxhNjy6fgQK9S0od3EYS32x5yxUQTuGX6SpI2
	mDXPnkUJoBTJiIKynKvU5vZdIbHPoZt2YochlE4ifhJ8KQCfKyS8VsNjoB5xzBm2
	U0gfiK1nrNjjvreVtc6tdZmmp6x9WzdzoGySbKTzlXwTXwyicfJqJ3iaI0BgXuIz
	v5tUZB8aCUKjBoAYnEhV4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772840095; x=
	1772926495; bh=5GQ6MLbXQIBCrhdy8xTOE8qptIqPEfLGFpCwvebhNs4=; b=H
	pRevaMUD/N9/Dk8b57g3LwOlO5E5b8k3qBn1SqrObo4AhgovoA8bVAaY8jrRvaKg
	sUPz+Iz84S7fsoHgElNm+tis+l12UoKiG1o7vLDAn652G9tjXKbLOZ8rnX50hu42
	j9j0nou/9MTQBAbk/jD1hZKVj9P0yOuNUj3+W3E/r9QSppKt4LWF1XOzzARslr3d
	Bla+l7RfP2jEHLkdGHX8T8K0bNiMrXzJhqNPE+7Gl0qr9FtFeTKSylX16m1/O07f
	ixpzE5/WlKTwRIpRwDS6Bw2IxTwRKupcIjxF0ueQTtIrRq83m0u5eHMjKuHCbBYj
	oO0KsRuLxKlkRTrvA8ozg==
X-ME-Sender: <xms:n2Srac6r60MOhiM2FyRoTHkHdDYFE0dEgmtBscqyjJx_hiegs7h2mg>
    <xme:n2SrafhBZMPPV4iRo_oXv-tgXYzpwCnwyZcnpz95tN6h3SETgqxZz4nBvdMpGnTsD
    5rWmo1X_AR7j-bTIuckL4pnJ9PvX6On1U_CWTQiD_Hb-HRM_H5LUg>
X-ME-Received: <xmr:n2SrafjLVoyNtRuFwbvOSirKAvEGRjwJitmms4Kl6D0WuwWnWeD3SC_jQ_c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfesthejre
    dtredtvdenucfhrhhomheptehlvgigucghihhllhhirghmshhonhcuoegrlhgvgiesshhh
    rgiisghothdrohhrgheqnecuggftrfgrthhtvghrnhepvdekfeejkedvudfhudfhteekud
    fgudeiteetvdeukedvheetvdekgfdugeevueeunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhgpdhnsg
    gprhgtphhtthhopedvfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlvgig
    sehshhgriigsohhtrdhorhhgpdhrtghpthhtohepshhmrgguhhgrvhgrnhesnhhvihguih
    grrdgtohhmpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgt
    phhtthhopegurghnrdhjrdifihhllhhirghmshesihhnthgvlhdrtghomhdprhgtphhtth
    hopegurghvvgdrjhhirghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehjohhnrght
    hhgrnhdrtggrmhgvrhhonheshhhurgifvghirdgtohhmpdhrtghpthhtohepihhrrgdrfi
    gvihhnhiesihhnthgvlhdrtghomhdprhgtphhtthhopehvihhshhgrlhdrlhdrvhgvrhhm
    rgesihhnthgvlhdrtghomhdprhgtphhtthhopegrlhhishhonhdrshgthhhofhhivghlug
    esihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:n2SraXlP55p1mhbi5NF3rT0rYbiKsA9yyNH5BIt3_nhdl5N9tYwKAg>
    <xmx:n2SrafEoasVfqvUcBIdtSRVFP--nGbYBZv3pathw_ioBCODJ7QvJMw>
    <xmx:n2SraRPoeC0vKZgNwyafWgS5A6mwCL5yV-9wuSOX6SzE5FVMUynSpg>
    <xmx:n2Sraevyq8BybpQKw6ZodHhM35SQEjdMP1bffu7Yt8JyKc7GNaxOmg>
    <xmx:n2SrabwNAyGi55XzLv06zvXrm2gygTBRcV6lvKEgtsar1kORm1onVzD7>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 18:34:54 -0500 (EST)
Date: Fri, 6 Mar 2026 16:33:24 -0700
From: Alex Williamson <alex@shazbot.org>
To: <smadhavan@nvidia.com>
Cc: alex@shazbot.org, <bhelgaas@google.com>, <dan.j.williams@intel.com>,
 <dave.jiang@intel.com>, <jonathan.cameron@huawei.com>,
 <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
 <alison.schofield@intel.com>, <dave@stgolabs.net>, <jeshuas@nvidia.com>,
 <vsethi@nvidia.com>, <skancherla@nvidia.com>, <vaslot@nvidia.com>,
 <sdonthineni@nvidia.com>, <mhonap@nvidia.com>, <vidyas@nvidia.com>,
 <jan@nvidia.com>, <mochs@nvidia.com>, <dschumacher@nvidia.com>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 5/7] cxl: Add CXL DVSEC reset sequence and flow
 orchestration
Message-ID: <20260306163324.23e90b03@shazbot.org>
In-Reply-To: <20260306092322.148765-6-smadhavan@nvidia.com>
References: <20260306092322.148765-1-smadhavan@nvidia.com>
	<20260306092322.148765-6-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Mar 2026 09:23:20 +0000
<smadhavan@nvidia.com> wrote:

> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> cxl_dev_reset() implements the hardware reset sequence:
> optionally enable memory clear, initiate reset via
> CTRL2, wait for completion, and re-enable caching.
> 
> cxl_do_reset() orchestrates the full reset flow:
>   1. CXL pre-reset: mem offlining and cache flush (when memdev present)
>   2. PCI save/disable: pci_dev_save_and_disable() automatically saves
>      CXL DVSEC and HDM decoder state via PCI core hooks
>   3. Sibling coordination: save/disable CXL.cachemem sibling functions
>   4. Execute CXL DVSEC reset
>   5. Sibling restore: always runs to re-enable sibling functions
>   6. PCI restore: pci_dev_restore() automatically restores CXL state
> 
> The CXL-specific DVSEC and HDM save/restore is handled
> by the PCI core's CXL save/restore infrastructure (drivers/pci/cxl.c).
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/pci.c | 181 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 179 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index b6f10a2cb404..c758b3f1b3f9 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1078,7 +1078,7 @@ static int cxl_reset_collect_sibling(struct pci_dev *func, void *data)
>  	return 0;
>  }
> 
> -static void __maybe_unused cxl_pci_functions_reset_prepare(struct cxl_reset_context *ctx)
> +static void cxl_pci_functions_reset_prepare(struct cxl_reset_context *ctx)
>  {
>  	struct pci_dev *pdev = ctx->target;
>  	struct cxl_reset_walk_ctx wctx;
> @@ -1103,7 +1103,7 @@ static void __maybe_unused cxl_pci_functions_reset_prepare(struct cxl_reset_cont
>  	}
>  }
> 
> -static void __maybe_unused cxl_pci_functions_reset_done(struct cxl_reset_context *ctx)
> +static void cxl_pci_functions_reset_done(struct cxl_reset_context *ctx)
>  {
>  	int i;
> 
> @@ -1116,3 +1116,180 @@ static void __maybe_unused cxl_pci_functions_reset_done(struct cxl_reset_context
>  	ctx->pci_functions = NULL;
>  	ctx->pci_func_count = 0;
>  }
> +
> +/*
> + * CXL device reset execution
> + */
> +static int cxl_dev_reset(struct pci_dev *pdev, int dvsec)
> +{
> +	static const u32 reset_timeout_ms[] = { 10, 100, 1000, 10000, 100000 };
> +	u16 cap, ctrl2, status2;
> +	u32 timeout_ms;
> +	int rc, idx;
> +
> +	if (!pci_wait_for_pending_transaction(pdev))
> +		pci_err(pdev, "timed out waiting for pending transactions\n");
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &ctrl2);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Disable caching and initiate cache writeback+invalidation if the
> +	 * device supports it. Poll for completion.
> +	 * Per CXL r3.2 section 9.6, software may use the cache size from
> +	 * DVSEC CXL Capability2 to compute a suitable timeout; we use a
> +	 * default of 10ms.
> +	 */
> +	if (cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE) {
> +		u32 wbi_poll_us = 100;
> +		s32 wbi_remaining_us = 10000;
> +
> +		ctrl2 |= PCI_DVSEC_CXL_DISABLE_CACHING;
> +		rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2,
> +					   ctrl2);
> +		if (rc)
> +			return rc;
> +
> +		ctrl2 |= PCI_DVSEC_CXL_INIT_CACHE_WBI;
> +		rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2,
> +					   ctrl2);
> +		if (rc)
> +			return rc;
> +
> +		do {
> +			usleep_range(wbi_poll_us, wbi_poll_us + 1);
> +			wbi_remaining_us -= wbi_poll_us;
> +			rc = pci_read_config_word(pdev,
> +						  dvsec + PCI_DVSEC_CXL_STATUS2,
> +						  &status2);
> +			if (rc)
> +				return rc;
> +		} while (!(status2 & PCI_DVSEC_CXL_CACHE_INV) &&
> +			 wbi_remaining_us > 0);
> +
> +		if (!(status2 & PCI_DVSEC_CXL_CACHE_INV)) {
> +			pci_err(pdev, "CXL cache WB+I timed out\n");
> +			return -ETIMEDOUT;
> +		}
> +	} else if (cap & PCI_DVSEC_CXL_CACHE_CAPABLE) {
> +		ctrl2 |= PCI_DVSEC_CXL_DISABLE_CACHING;
> +		rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2,
> +					   ctrl2);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	if (cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE) {
> +		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2,
> +					  &ctrl2);
> +		if (rc)
> +			return rc;
> +
> +		ctrl2 |= PCI_DVSEC_CXL_RST_MEM_CLR_EN;
> +		rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2,
> +					   ctrl2);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	idx = FIELD_GET(PCI_DVSEC_CXL_RST_TIMEOUT, cap);
> +	if (idx >= ARRAY_SIZE(reset_timeout_ms))
> +		idx = ARRAY_SIZE(reset_timeout_ms) - 1;
> +	timeout_ms = reset_timeout_ms[idx];
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &ctrl2);
> +	if (rc)
> +		return rc;
> +
> +	ctrl2 |= PCI_DVSEC_CXL_INIT_CXL_RST;
> +	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
> +	if (rc)
> +		return rc;
> +
> +	msleep(timeout_ms);
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
> +				  &status2);
> +	if (rc)
> +		return rc;
> +
> +	if (status2 & PCI_DVSEC_CXL_RST_ERR) {
> +		pci_err(pdev, "CXL reset error\n");
> +		return -EIO;
> +	}
> +
> +	if (!(status2 & PCI_DVSEC_CXL_RST_DONE)) {
> +		pci_err(pdev, "CXL reset timeout\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &ctrl2);
> +	if (rc)
> +		return rc;
> +
> +	ctrl2 &= ~PCI_DVSEC_CXL_DISABLE_CACHING;
> +	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
> +	if (rc)
> +		return rc;
> +
> +	return 0;
> +}
> +
> +static int match_memdev_by_parent(struct device *dev, const void *parent)
> +{
> +	return is_cxl_memdev(dev) && dev->parent == parent;
> +}
> +
> +static int cxl_do_reset(struct pci_dev *pdev)
> +{
> +	struct cxl_reset_context ctx = { .target = pdev };
> +	struct cxl_memdev *cxlmd = NULL;
> +	struct device *memdev = NULL;
> +	int dvsec, rc;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return -ENODEV;
> +
> +	memdev = bus_find_device(&cxl_bus_type, NULL, &pdev->dev,
> +				 match_memdev_by_parent);
> +	if (memdev) {
> +		cxlmd = to_cxl_memdev(memdev);
> +		guard(device)(&cxlmd->dev);
> +	}

The guard scope ends at the closing brace, aiui.

Also consider whether we could be racing a remove, I think we probably
need trylock and an error return here.

> +
> +	mutex_lock(&cxl_reset_mutex);
> +	pci_dev_lock(pdev);
> +
> +	if (cxlmd) {
> +		rc = cxl_reset_prepare_memdev(cxlmd);
> +		if (rc)
> +			goto out_unlock;
> +
> +		cxl_reset_flush_cpu_caches(cxlmd);
> +	}

We're holding device-lock across memory offline, which could take some
time.  Is the guard above sufficient that we could consolidate the
offline and flush above the mutex and device lock?

What about memdev devices collected as part of the save_and_disable
with restore below?  How do we get to skip offline of that memory?

If we switch to a trylock scheme as noted in 4/, do we still need the
global mutex?  Thanks,

Alex

> +
> +	pci_dev_save_and_disable(pdev);
> +	cxl_pci_functions_reset_prepare(&ctx);
> +
> +	rc = cxl_dev_reset(pdev, dvsec);
> +
> +	cxl_pci_functions_reset_done(&ctx);
> +
> +	pci_dev_restore(pdev);
> +
> +out_unlock:
> +	pci_dev_unlock(pdev);
> +	mutex_unlock(&cxl_reset_mutex);
> +
> +	if (memdev)
> +		put_device(memdev);
> +
> +	return rc;
> +}
> --
> 2.43.0
> 
> 

