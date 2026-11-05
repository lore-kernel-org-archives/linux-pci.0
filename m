Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907868;
	b=ygE8oAOnmBiNwByS9LOn8trAFHFR+1i0QpK+X86TEPe75TYX+nFdLtz6x/rUFB92SqSb
	 lsE11o6S0juRg9Fwd8Iz7X/glkiQqrZ2NtG211uF6pcU0zjUedxAl1m2XdPXQNAsABwBx
	 649dNF7oJGectd+MYt6T5hzfnvbqbMb954QlGo8TEp31jLe+/lM8AIZLqFviziz1nXe3k
	 2KTPXNm3zOLKELoH0S8Dctm4saZFoBk+xa0//9G5y7jzwdZvjqOLAncBm2fLkMxwFVpt/
	 1rwgk4g7FnW/8e+noOv4WtyRky5b4a+qiFBOrAhvuVuJAecct37mM88zrmu7nAQC/ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907868;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j+PSg/NPJdY8EDKgsd8bUduaizm0cD9hK9qmcUntT28=;
	b=Dsnj695ZJcoBZYMFWxtSlUjZCiiSrH876uX28mpkT5Iu/MK/mKcykgYYlYf/ewZ5imcX
	 vG2xh3TzxVo5Kp8vaIvzbiLMglFUg01aK50DkebJOT6N1t8TBEZXt7NMFBuM3G9sLZ3ep
	 USuvfbdOzunszQdkCn6lP90EBFHacvytSEhppq+neIox802vAYGmXMrHK3I70DQL30HxV
	 k8/HoMaNzARNb3O8xRCHQG97Z/ndfE/yinUSWnTgc9EsB8b6M3Xnuw7se0AEz97N2cdib
	 H44rZVjgdTaUmx5OBMSRdA7vrwbdLCVZRkxEYy+Dr2zAoOH6P++M/RFtHH3Ptd76Atg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cqo93qVs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F432606C8A0;
	Thu,  5 Nov 2026 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cqo93qVs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911EF1F0089F;
	Thu,  5 Nov 2026 19:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907867;
	bh=j+PSg/NPJdY8EDKgsd8bUduaizm0cD9hK9qmcUntT28=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Cqo93qVsY/ZBSV7qPLQH5wa838XYPoWgH6m4nigi/v9OKUQPBldEDhtVhiy1lLMOT
	 bjOOgXPeZq6W3A7vuXoaS3K94YVh52a3+1LCYwzJzdYciiwTPZcTG6U1F6jZYDqf7N
	 c7mzN2hMRUElGqtnK6Ajad0ZgS0p/qmV5IvPMDbkK2QPmF4PeJoNFJV5A9p/2LkTht
	 2ij9mLvzWOnJLMCAnn6gObxep4iwGPve6wbVVcDs2ds0k7+WCRhZxAQxKjXfismSCQ
	 y4K0JphpYyDzFco0IgNKkkon/UJWZtwBcZpqTKY0tVVeCPUXxljeQBC8VWIaRSGi2t
	 tIZKKWia+3ZzQ==
Message-ID: <sashiko-outbox-199975@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 13/19] cxl: Validate and synchronize HDM ranges
 around reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261105185917.2667656-14-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-14-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:44:27 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] cxl: missed or cleared CXL_DECODER_F_NORMALIZED_ADDRESSING in HDM =
cache
- [High] PCI/CXL: cxl_reset_function() returns -ENOTTY on !probe safety che=
ck failures
- [High] cxl: stale global_ctrl cache and unserialized check in cxl_reset_f=
unction()
- [Low] PCI/CXL: split declaration and assignment of __free() in cxl_reset_=
quiesced()
--

commit 5c4d959ed1ab8877ba7835557e27e40030bf5a45
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl: Validate and synchronize HDM ranges around reset

This commit validates and reserves enabled system-physical HDM ranges
around CXL reset, invalidating CPU caches before reset and again before
ending IOMMU exclusion while holding the global cxl_rwsem.region write
lock. It also rejects normalized-addressing and DVSEC-decoded memory
configurations and records Normalized Addressing in the HDM cache during
region discovery.

> diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
> index 9def4a7439c93..51df56377f7a9 100644
> --- a/drivers/cxl/core/hdm_state.c
> +++ b/drivers/cxl/core/hdm_state.c
[ ... ]
> +/**
> + * cxl_hdm_cache_dvsec_decode() - check for memory decoded by DVSEC rang=
es
> + * @slot: cache pointer owned by the device
> + *
> + * Return: true if the published state shows CXL.mem enabled while HDM
> + * decoders are globally disabled, so that the device decodes memory thr=
ough
> + * its DVSEC ranges, which the cache does not describe.
> + */
> +bool cxl_hdm_cache_dvsec_decode(struct cxl_hdm_info *const *slot)
> +{
> +	struct cxl_hdm_info *info;
> +
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	info =3D *slot;
> +	return info && (info->dvsec_ctrl & PCI_DVSEC_CXL_MEM_ENABLE) &&
> +	       !(info->global_ctrl & CXL_HDM_DECODER_ENABLE);
> +}

[Severity: High]
As reported by Sashiko on v16 [1], can info->global_ctrl become out of sync
with hardware across devm_cxl_enable_hdm() and disable_hdm(), and can
checking cxl_hdm_cache_dvsec_decode() outside cxl_region_quiesce_lock()
race with concurrent endpoint probe or unbind?

In drivers/cxl/core/pci.c, neither devm_cxl_enable_hdm() nor its devres
teardown callback disable_hdm() updates pdev->hdm->global_ctrl:

drivers/cxl/core/pci.c:disable_hdm() {
	...
	global_ctrl =3D readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
	writel(global_ctrl & ~CXL_HDM_DECODER_ENABLE,
	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
}

During cxl_endpoint_port_probe(), when firmware left
PCI_DVSEC_CXL_MEM_ENABLE clear at boot, cxl_hdm_decode_init() calls
devm_cxl_enable_hdm() (setting CXL_HDM_DECODER_ENABLE in MMIO without
updating pdev->hdm->global_ctrl) and then devm_cxl_enable_mem() (setting
PCI_DVSEC_CXL_MEM_ENABLE in pdev->hdm->dvsec_ctrl). Next,
devm_cxl_enumerate_decoders() calls cxl_settle_decoders(), which sleeps
for 20 ms before cxl_hdm_refresh_decoder() refreshes
pdev->hdm->global_ctrl. Throughout that 20 ms window, pdev->hdm has
PCI_DVSEC_CXL_MEM_ENABLE set in dvsec_ctrl and CXL_HDM_DECODER_ENABLE
clear in global_ctrl, so cxl_hdm_cache_dvsec_decode() falsely reports
DVSEC range decode mode.

Conversely, when the endpoint port or CXL driver unbinds, devres runs
clear_mem_enable() followed by disable_hdm(), which clears
CXL_HDM_DECODER_ENABLE in CXL_HDM_DECODER_CTRL_OFFSET without updating
pdev->hdm->global_ctrl. When a subsequent reset restores state from
pdev->hdm (in the later commits "PCI/CXL: Restore CXL state after PCI
reset" and "PCI/CXL: Flush host and device caches for CXL bus reset"),
cxl_hdm_restore_state() will write the stale snapshot->global_ctrl with
CXL_HDM_DECODER_ENABLE set back into hardware.

Additionally, cxl_reset_function() evaluates
cxl_hdm_cache_dvsec_decode(&pdev->hdm) in a standalone cxl_rwsem.dpa read
section before cxl_reset_execute() acquires cxl_region_quiesce_lock() and
calls cxl_hdm_cache_snapshot(&pdev->hdm) in cxl_reset_quiesced(), while
cxl_hdm_quiesce_prepare() never checks the captured snapshot for DVSEC
decode. Because endpoint port probe and unbind run under
device_lock(&port->dev) rather than device_lock(&pdev->dev) and modify
PCI_DVSEC_CXL_CTRL, CXL_HDM_DECODER_CTRL_OFFSET, and pdev->hdm without
holding cxl_rwsem.region, can the cached state change between
cxl_hdm_cache_dvsec_decode() and cxl_hdm_cache_snapshot()?

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 8cfc06df31340..b06dd9b901f0c 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3840,6 +3841,19 @@ int cxl_add_to_region(struct cxl_endpoint_decoder =
*cxled)
>  	if (IS_ERR(cxlrd))
>  		return PTR_ERR(cxlrd);
> =20
> +	/*
> +	 * Translation setup may have marked the decoder as Normalized
> +	 * Addressing, after the PCI cache was filled. Record it for reset.
> +	 */
> +	if (cxled->cxld.config.flags & CXL_DECODER_F_NORMALIZED_ADDRESSING) {
> +		struct pci_dev *pdev __free(pci_dev_put) =3D
> +			cxl_port_get_uport_pci_dev(cxled_to_port(cxled));
> +
> +		if (pdev)
> +			cxl_hdm_cache_set_normalized(pdev,
> +						     cxled->cxld.config.id);
> +	}

[Severity: High]
As reported by Sashiko on v16 [1], can CXL_DECODER_F_NORMALIZED_ADDRESSING
still be missed or cleared in pdev->hdm, causing cxl_hdm_ranges_collect()
to treat a device-local normalized address range as a system physical
address range during reset?

There appear to be two paths where the cached decoder loses this flag:

1. In cxl_add_to_region(), get_cxl_root_decoder(cxled, &ctx) runs before
the check above. Inside get_cxl_root_decoder():

drivers/cxl/core/region.c:get_cxl_root_decoder() {
	...
	rc =3D cxl_root_setup_translation(cxl_root, ctx);
	if (rc) {
		...
		return ERR_PTR(rc);
	}

	cxlrd_dev =3D device_find_child(&cxl_root->port.dev, &ctx->hpa_range,
				      match_root_decoder);
	if (!cxlrd_dev) {
		...
		return ERR_PTR(-ENXIO);
	}
}

cxl_root_setup_translation() -> cxl_prm_setup_root() sets
CXL_DECODER_F_NORMALIZED_ADDRESSING on cxled->cxld.config.flags before
device_find_child(..., match_root_decoder) runs. If no root decoder window
matches (!cxlrd_dev), get_cxl_root_decoder() returns ERR_PTR(-ENXIO).
(Similarly, if cxl_prm_setup_root() detects Normalized Addressing via
hpa_range.start =3D=3D cxled->dpa_res->start but fails translation before
setting the flag, get_cxl_root_decoder() returns ERR_PTR(-ENXIO).) Because
discover_region() treats errors from cxl_add_to_region() as non-fatal and
cxl_add_to_region() returns early on IS_ERR(cxlrd),
cxl_hdm_cache_set_normalized() is never called.

2. In devm_cxl_enumerate_decoders() -> init_hdm_decoder() ->
cxl_hdm_refresh_decoder() -> cxl_hdm_cache_refresh_decoder():

drivers/cxl/core/hdm_state.c:cxl_hdm_cache_refresh_decoder() {
	...
	*settings =3D (struct cxl_endpoint_decoder_settings) {
		.config.id =3D id,
	};
	if (cxld->config.flags & CXL_DECODER_F_ENABLE) {
		settings->config =3D cxld->config;
		settings->skip =3D cxled->skip;
	}
}

Because hardware registers do not have a Normalized Addressing bit,
overwriting settings->config from cxld->config clears any previously
recorded CXL_DECODER_F_NORMALIZED_ADDRESSING bit when the endpoint port
driver is rebound or if enumeration fails on a later decoder before
discover_region() runs.

If a CXL reset then runs, will cxl_hdm_ranges_collect() fail to reject the
decoder with -EOPNOTSUPP and pass the untranslated normalized DPA range to
request_mem_region() and cpu_cache_invalidate_memregion()?

> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> index 9ac5948f595b1..af8ec8db20f12 100644
> --- a/drivers/pci/cxl.c
> +++ b/drivers/pci/cxl.c
[ ... ]
> -static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
> +static int cxl_reset_quiesced(struct pci_dev *pdev, int dvsec, u16 cap)
> +	__must_hold(cxl_region_quiesce)
>  {
> -	u16 saved_ctrl2;
> +	struct cxl_hdm_info *snapshot __free(kfree) =3D NULL;
> +	struct cxl_pci_cache cache =3D {};
>  	int rc, rc2;
> =20
> -	rc =3D pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &saved_c=
trl2);
> +	rc =3D pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2,
> +				  &cache.saved_ctrl2);
>  	if (rc)
>  		return pcibios_err_to_errno(rc);
> -	if (PCI_POSSIBLE_ERROR(saved_ctrl2))
> +	if (PCI_POSSIBLE_ERROR(cache.saved_ctrl2))
>  		return -ENODEV;
> =20
> -	rc =3D cxl_reset_disable_cache(pdev, dvsec, cap);
> +	snapshot =3D cxl_hdm_cache_snapshot(&pdev->hdm);

[Severity: Low]
This isn't a bug, but per the Cleanup API conventions, should snapshot be
defined and initialized in a single statement at its point of assignment:

	struct cxl_hdm_info *snapshot __free(kfree) =3D
		cxl_hdm_cache_snapshot(&pdev->hdm);

rather than being declared with =3D NULL at the top of cxl_reset_quiesced()?

[ ... ]
> @@ -463,5 +522,17 @@ int cxl_reset_function(struct pci_dev *pdev, bool pr=
obe)
>  	if (probe)
>  		return 0;
> =20
> +	/* The cache is owned by @pdev and does not require a bound CXL driver.=
 */
> +	if (!pdev->hdm)
> +		return -ENOTTY;
> +
> +	/* Memory decoded through DVSEC ranges has no HPA ranges to quiesce. */
> +	if (cxl_hdm_cache_dvsec_decode(&pdev->hdm))
> +		return -ENOTTY;
> +
> +	if (!cpu_cache_has_invalidate_memregion() &&
> +	    !IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST))
> +		return -ENOTTY;
> +
>  	return cxl_reset_execute(pdev, dvsec, cap);
>  }

[Severity: High]
When probe is false and CXL.cache and CXL.mem are enabled on the device,
does returning -ENOTTY from these precondition checks cause
__pci_reset_function_locked() to fall back to other PCI reset methods
(such as FLR or PM reset) instead of refusing the reset?

During PCI enumeration, pci_init_reset_methods() calls cxl_reset_function()
with probe =3D=3D true, which returns 0 before reaching these checks and
records cxl_reset in dev->reset_methods[] ahead of flr and pm (when wired
up by commit "PCI/CXL: Expose CXL Reset as a PCI reset method"). Later,
when __pci_reset_function_locked() runs with PCI_RESET_DO_RESET:

drivers/pci/pci.c:__pci_reset_function_locked() {
	...
	rc =3D method->reset_fn(dev, PCI_RESET_DO_RESET);
	if (!rc)
		return 0;

	pci_dbg(dev, "%s failed with %d\n", method->name, rc);
	if (rc !=3D -ENOTTY)
		return rc;
}

Because -ENOTTY tells __pci_reset_function_locked() to try the next reset
method in dev->reset_methods[], failing any of these checks will proceed to
reset the active CXL.cache / CXL.mem function via FLR or PM reset without
reserving HPA ranges, flushing CPU or device caches, or restoring CXL
state.

Returning -ENOTTY here also makes the locked -ENXIO checks and pci_err()
diagnostics in cxl_hdm_cache_snapshot(), cxl_hdm_quiesce_prepare(), and
cxl_reset_quiesced() unreachable from cxl_reset_function(), while checking
!pdev->hdm without holding cxl_rwsem.dpa. Should these checks run under
cxl_region_quiesce_lock() and return non-ENOTTY errors (such as -ENXIO and
-EOPNOTSUPP, matching cxl_hdm_quiesce_prepare() and pci_cxl_reset_prepare()
in commit "PCI/CXL: Flush host and device caches for CXL bus reset") so the
reset is aborted?

[1] https://lore.kernel.org/r/20261029145703.2185231-14-smadhavan@nvidia.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105185917.2667=
656-1-smadhavan@nvidia.com?part=3D13
