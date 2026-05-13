Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D9C42A9D;
	Wed, 13 May 2026 02:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778640324; cv=none; b=ko6Msz1+ssy9SPKDVtkA54qzRkEXqAY+rouJ9+v5QPTyNKU/gRkKaeTwmTiDJ4Dc9vNmCbX53W06ELbDv3CGAqk2UopTC7MhILhh4ZmUnajT7dWUEk5hXg1gnDZKaZ41FB9FSZcktiCtyXuoX4AE08I6AjbY53/Dx6WUH8Q34dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778640324; c=relaxed/simple;
	bh=UwYemmp61xQRMFa6jBcYjstuhyetmLZIy0nZsYupAwk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=kF0VURnnvDpqotO6WO7L0NdSfcap7ZtjpPLFBAlar4BjFgVbEVBLUtV5tW9blNYhW9Cwnn2QzDuBVxkm+kHQ5ikpshtVwhMzp0yw8VrO+Ibkgtzl7c1B6nTQCHsHcuMiKd4riDSEhOweVx9EjEbxpjpUAL0/tvUYtmpVhH0NsmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOahXm95; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOahXm95"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C08CC2BCF7;
	Wed, 13 May 2026 02:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778640324;
	bh=UwYemmp61xQRMFa6jBcYjstuhyetmLZIy0nZsYupAwk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=HOahXm955JdVByP6APo32i6eNnOG7fSU0bLaiqQZ+hrEXMCAt1oEIz0RIIadUOZ0Y
	 nmaIeI9+Lo0pXZde9v76XKla7wW7TRWlUnoWZ9+hX1q3ytsEw8R+e6cv0vGdnaUkVg
	 S9V+L2a+CFwLR9ZLomDSbVuKfKY0eXg3kZYXXTPkQ81z+3LTqEaHWRDC6ZqGhXIXQZ
	 EOHRp6v/VRIBUu/AW7BrD8zDL3O3cn8I4VKxves7owcXLzzLf99zDr2ZMCqUnoAiEH
	 3ztkSa4032HCV0j9ZEQhCQUVw+xAbSGZBvGHKvcLvFglaVjpssJ2ppOaQCj8f4tAys
	 cJB31Je33TAxg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4B377F40075;
	Tue, 12 May 2026 22:45:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 12 May 2026 22:45:22 -0400
X-ME-Sender: <xms:wuUDajjKKO_O8LlX0OCmKeu6Bq-4zyOWdf_czDjdiAMvldmeAJSP1A>
    <xme:wuUDars5T4LCkVRlCfClti9_p7nakcN3vuFvUc4XFaUASZauin99g56JyGyUaz62B
    KjgxGGUCWZ5f4WaUUOBQJiu79T-K13rx5V50N-bBavbfWhwnwgHsq0>
X-ME-Received: <xmr:wuUDatzvRajzSuvRx4DgD1dqqgrDpSRwGOEf7jChiAlRyDu41Vbny_nPqr8-rWQ-ZJrjE29_DYccT1qQC5gGenj7xXOcGKkhJIs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdefheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevkfgjfhfugggtgfesthejredttddtjeenucfhrhhomhepfdffrghnucgh
    ihhllhhirghmshculdhnvhhiughirgdmfdcuoegujhgsfieskhgvrhhnvghlrdhorhhgqe
    enucggtffrrghtthgvrhhnpedvgeehieekteelueffueehfeejjedvjedvveetfefgffev
    hedvuedvffevffdvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegujhgsfidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudej
    jedvfedtgeehhedqfeeffeelgedtgeejqdgujhgsfieppehkvghrnhgvlhdrohhrghesfh
    grshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvgedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepshhmrgguhhgrvhgrnhesnhhvihguihgrrdgtohhmpdhrtghpth
    htohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopegurghnrdhj
    rdifihhllhhirghmshesihhnthgvlhdrtghomhdprhgtphhtthhopegurghvvgdrjhhirg
    hnghesihhnthgvlhdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhdrtggrmhgvrhho
    nheshhhurgifvghirdgtohhmpdhrtghpthhtohepihhrrgdrfigvihhnhiesihhnthgvlh
    drtghomhdprhgtphhtthhopehvihhshhgrlhdrlhdrvhgvrhhmrgesihhnthgvlhdrtgho
    mhdprhgtphhtthhopegrlhhishhonhdrshgthhhofhhivghlugesihhnthgvlhdrtghomh
    dprhgtphhtthhopegurghvvgesshhtghholhgrsghsrdhnvght
X-ME-Proxy: <xmx:wuUDahMQQTCinQeCGi8yG2YCv9ZChfVAX366Guu3tNNxXO0ktSl15A>
    <xmx:wuUDav0pZpTkXgHeoXpD8J-Al1pSrco8jsHoRM2xIrM_Zu_AP7vWOw>
    <xmx:wuUDapE_UYZ6aYq4ymUjV1ggxM4Wx9Ms6VZDDt-k_K1pyFi5HJCI0Q>
    <xmx:wuUDamipKFaPmyJBV_4dYMAUHd_gFMN9OhF0_OBeK5mJXGqL9kil6g>
    <xmx:wuUDaiejrJLre83hDihTWwCkZqRB0dJabyAq1S7j4-YkhVU9edxl_qtM>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 22:45:21 -0400 (EDT)
Date: Tue, 12 May 2026 19:45:20 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: smadhavan@nvidia.com, 
 bhelgaas@google.com, 
 dan.j.williams@intel.com, 
 dave.jiang@intel.com, 
 jonathan.cameron@huawei.com, 
 ira.weiny@intel.com, 
 vishal.l.verma@intel.com, 
 alison.schofield@intel.com, 
 dave@stgolabs.net
Cc: alwilliamson@nvidia.com, 
 jeshuas@nvidia.com, 
 vsethi@nvidia.com, 
 skancherla@nvidia.com, 
 vaslot@nvidia.com, 
 sdonthineni@nvidia.com, 
 mhonap@nvidia.com, 
 vidyas@nvidia.com, 
 jan@nvidia.com, 
 mochs@nvidia.com, 
 dschumacher@nvidia.com, 
 linux-cxl@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Srirangan Madhavan <smadhavan@nvidia.com>
Message-ID: <6a03e5c099d98_123a100e3@djbw-dev.notmuch>
In-Reply-To: <20260306092322.148765-6-smadhavan@nvidia.com>
References: <20260306092322.148765-1-smadhavan@nvidia.com>
 <20260306092322.148765-6-smadhavan@nvidia.com>
Subject: Re: [PATCH v5 5/7] cxl: Add CXL DVSEC reset sequence and flow
 orchestration
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

smadhavan@ wrote:
> From: Srirangan Madhavan <smadhavan@nvidia.com>

Hi Srirangan, some comments below:

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

I think the PCI core rules for pci_save_and_disable() really only work
for a device that can be reliably quarantined off the bus simply by
writing to its command register. I am also uncomfortable saving new MMIO
data with new iomap mappings at pci_save_state() time, remapping MMIO
space, and rewriting the command register at pci_restore_state() time.
That feels like it is stretching the PCI state save model, and runs
counter to other MMIO restore scenarios.

Lets start with assuming similar behavior to MSI where restoration of
MMIO is driven from other cached configuration, not PCI state save. For
example, for MSI there is nothing to do at restore time if a driver has
not first enabled interrupts.

The similarity for CXL would be that if nothing has ever registered a
CXL memdev then it is indeterminate whether Linux has ever successfully
parsed the CXL configuration and "enabled CXL".

The downside of this is losing the ability to save firmware initiated
CXL state from PCI reset paths. That loss is mitigated somewhat by SBR
masking and the fact that FLR does not reset CXL state. So those resets
do not destroy CXL HDM state by default.

Otherwise, if cxl_reset moves to a cxl_memdev sysfs attribute then the
PCI ABI stays free of CXL concerns. More below:

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

Should this be msleep(max(100, timeout_ms)) just to honor the
specification note:

"9.7.3 CXL Reset and Request Retry Status (RRS) ...The device behavior
in response to Configuration Space access to the device within 100 ms of
initiating a CXL Reset is undefined"

...not sure why the specification allowed for devices to specify less
than 100ms timeout values.

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

This guard scope ends at this bracket, so it is a nop.

> +	}
> +
> +	mutex_lock(&cxl_reset_mutex);
> +	pci_dev_lock(pdev);

Given that CXL drivers create memdevs the lock ordering needs to be
pci_dev_lock(), then guard(device)(&cxlmd->dev).

> +	if (cxlmd) {
> +		rc = cxl_reset_prepare_memdev(cxlmd);

Ok, so per the lead in comment, a cxl_memdev becomes a requirement, not
a trigger for opportunistic safety.

I do think it ultimately begs the question of whether the PCI core
should one day automatically register cxl devices for this purpose. For
now the assumption is a driver, like vfio-pci, has registered a memdev
to get a memX/cxl_reset interface published in sysfs.

The presence of a cxl_memdev allows coordinating not only region
discovery, but also reconfiguration locking. With the memdev we have a
chance to ask the questions:

1/ are any cacheable mappings of this device established?
2/ is that answer durable for the duration of the reset?
3/ can the HDM configuration be recovered from the cxl_memdev to
   cxl_root decoder association?

In the short term the fastest answers to those questions is just walk
the memdev and cxl root, in the longer term I would be open to building
more CXL awareness into the core so that CXL reset does not need a
driver loaded.

As for the safety guarantees, I do not think cxl_reset_prepare_memdev()
should be trying to hot unplug memory. Either the caller has arranged
for CXL to be idle or the reset fails.

With cxl_acpi and cxl_mem loaded you can pin down the HPA space for the
duration of the reset. It has a chance to be compatible with all CXL
reset use cases.
