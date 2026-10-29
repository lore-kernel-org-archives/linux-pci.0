Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793287543;
	b=rM5enyApDdu/98Ib3kGCDzjFTumCUMLT6e6X6yXOwdQppB14X2qcYymVcwoozpAFgHky
	 7Sx6P7ik2KrN68nUUPredd9cIVcyO/4mkEz9EHiCMo1KycGPcwZqexkLjcuFU+Dv/5kzX
	 7oxkHiWD1sN9E+sinj6HPgHy+nY6RNJ9GGCVSGhtF0co1/A4scPDWJ2kSRFlPqeSBQc7d
	 B1hZsFPmNqFa78YFmTDQiLQp5wugEVbLfh/eRiTInkjBwm6XArYUX2gvAK1ngJi8Ukt4m
	 CRsUb5+8PsuoAnLqcOpPlC3jr1rkzu6UIw5RJpLbUYtpqcB8aru5elB7aRUKWQAg36w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793287543;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iq3SDgtYy2kEN3rvhAeP9GPbbHzk2V92ozhBX5q1wc0=;
	b=M0Y/tnoirALOQQvwJt//7dL7Zkbdj8yoi2G+GZsMRkB/BZ/QJBjf9nq6BzZoxDXNTMTz
	 27N2NOzeU2WyJdJDJYbSNa4MO0Ja+E1gzpGz/531fd1FVZ1SlVI5EMWR/DZXtuhewfYdm
	 UX8VFVZXwXUs1HgAO4oaZWaM5+tU4HPiDDVhSobySF6ILwJfKdMD2TEb2Q335mkLPKpjN
	 JymgSB60DEqtzqC10+J6tM+UWYLsUTH5RUrVMeCtrniPHZntki5BFcSHtGehYP3Lh+uSm
	 jFR8GKjUO4ZAye+dvTsmivk/yvRPe2/GEX4HqFj/xx+Zq6Gjkq7d97ev72BvtpziIxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HxrdHkHu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95079606A31C;
	Thu, 29 Oct 2026 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HxrdHkHu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C64D1F01816;
	Thu, 29 Oct 2026 15:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793287543;
	bh=iq3SDgtYy2kEN3rvhAeP9GPbbHzk2V92ozhBX5q1wc0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=HxrdHkHure6qjp1MJ/rgn75ZsBntFObVZlUgRBYrl4vLDssiik1Y0Rk52Ct9qYxNP
	 LNPwBQhloAHLjM5TvHO2OdYcwuIEuGsbe6LoW1+mvOIy53g1ajZrNrMve7e7I0vcq1
	 tZa1U++wT8z2nNYUdOGPBB6xQS6NY9ymuwXwq5vGMpGomnfbd6bmSl+9FR3lBt1Qxx
	 JVa1dz2yNAEr1tPJ1vwI8kwlTbL5z4jbN3AIivM1+RQLgsWFJ7aigjn4aoJBAEJwqW
	 IpxVXX9dPY0iz3HRPXta8vf32UkRJVlhjnN7uBVjS/TV4s/IkIgsRSNNoO4fFAj5rb
	 E01Ufa74SklyA==
Message-ID: <sashiko-outbox-189602@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 13/18] cxl: Validate and synchronize HDM ranges
 around reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261029145703.2185231-14-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-14-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:25:42 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] cxl: unpropagated normalized addressing flag in cxl_hdm_ranges_col=
lect()
- [High] cxl: stale cache state and unlocked pre-checks in cxl_reset_functi=
on()
- [Low] cxl: missing context lock annotations on cxl_region_quiesce_lock()
--

commit 2ab2ba1a8c9580e8171daa685fd9f57270c18ea2
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl: Validate and synchronize HDM ranges around reset

This commit validates and reserves enabled system-physical HDM ranges and
invalidates CPU caches before and after a CXL reset. It also holds
cxl_rwsem.region across snapshot, reset, and restoration while rejecting
resets on devices using normalized addressing or DVSEC range decoding.

> diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
> index 1140006de50d9..cb7ec0f86ab15 100644
> --- a/drivers/cxl/core/hdm_state.c
> +++ b/drivers/cxl/core/hdm_state.c

[ ... ]

> @@ -132,3 +139,239 @@ void cxl_hdm_cache_release(struct cxl_hdm_info **sl=
ot)
>  	}
>  	kfree(info);
>  }
> +
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
Can info->dvsec_ctrl and info->global_ctrl be stale relative to the hardware
state when cxl_reset_function() calls cxl_hdm_cache_dvsec_decode()?

First, cxl_reset_function() reads the live PCI_DVSEC_CXL_CTRL register into
ctrl and confirms PCI_DVSEC_CXL_MEM_ENABLE is set, but
cxl_hdm_cache_dvsec_decode() checks the cached info->dvsec_ctrl instead.
info->dvsec_ctrl is only populated during PCI enumeration in
pci_cxl_hdm_cache_init() or updated via cxl_set_mem_enable(). If
PCI_DVSEC_CXL_MEM_ENABLE was clear at enumeration and later enabled without
cxl_set_mem_enable(), or if cxl_hdm_decode_init() takes the active DVSEC
range return path without calling devm_cxl_enable_mem() (where
devm_cxl_enumerate_decoders() also skips cxl_hdm_refresh_decoder() because
emulated is true):

drivers/cxl/core/pci.c:cxl_hdm_decode_init() {
	...
	if (allowed && info->mem_enabled)
		return 0;
	...
}

then info->dvsec_ctrl remains 0 while the device actively decodes memory
through DVSEC ranges, causing cxl_hdm_cache_dvsec_decode() to return false
and allowing the reset to proceed without quiescing those ranges.

Second, neither devm_cxl_enable_hdm() nor its devres teardown callback
disable_hdm() in drivers/cxl/core/pci.c updates pdev->hdm->global_ctrl:

drivers/cxl/core/pci.c:disable_hdm() {
	...
	global_ctrl =3D readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
	writel(global_ctrl & ~CXL_HDM_DECODER_ENABLE,
	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
}

When cxl_port unbinds, disable_hdm() clears CXL_HDM_DECODER_ENABLE in
hardware while info->global_ctrl keeps CXL_HDM_DECODER_ENABLE set in the
cache. Conversely, during cxl_endpoint_port_probe(), devm_cxl_enable_mem()
sets PCI_DVSEC_CXL_MEM_ENABLE in info->dvsec_ctrl before
devm_cxl_enumerate_decoders() refreshes info->global_ctrl.

Finally, cxl_reset_function() calls cxl_hdm_cache_present() and
cxl_hdm_cache_dvsec_decode() in separate cxl_rwsem.dpa read-lock sections
before cxl_reset_execute() acquires cxl_region_quiesce_lock(), and neither
cxl_hdm_cache_snapshot() nor cxl_hdm_quiesce_prepare() re-checks the
captured snapshot for DVSEC decode mode while cxl_endpoint_port_probe() and
port unbind run under device_lock(&port->dev) without holding
cxl_rwsem.region.

[ ... ]

> +static int cxl_hdm_ranges_collect(struct cxl_hdm_quiesce *q,
> +				  const struct cxl_hdm_info *snapshot)
> +{
> +	int rc;
> +
> +	for (int i =3D 0; i < snapshot->decoder_count; i++) {
> +		const struct cxl_decoder_config *config =3D
> +			&snapshot->settings[i].config;
> +
> +		/* A committed zero-size decoder maps no HPA. */
> +		if (!(config->flags & CXL_DECODER_F_ENABLE) ||
> +		    !range_len(&config->hpa_range))
> +			continue;
> +
> +		if (config->flags & CXL_DECODER_F_NORMALIZED_ADDRESSING)
> +			return -EOPNOTSUPP;

[Severity: High]
Can CXL_DECODER_F_NORMALIZED_ADDRESSING ever be set in
snapshot->settings[i].config.flags here?

CXL_DECODER_F_NORMALIZED_ADDRESSING is a software flag rather than a
hardware HDM register bit, so pci_cxl_hdm_cache_init() ->
cxl_hdm_read_state() -> cxl_hdm_unpack_decoder() never sets it during PCI
enumeration.

When the endpoint port driver probes in cxl_endpoint_port_probe(), it first
runs devm_cxl_endpoint_decoders_setup() -> devm_cxl_enumerate_decoders(),
which refreshes pdev->hdm before region discovery runs:

drivers/cxl/port.c:cxl_endpoint_port_probe() {
	...
	rc =3D devm_cxl_endpoint_decoders_setup(port);
	if (rc)
		return rc;
	...
	device_for_each_child(&port->dev, NULL, discover_region);
	...
}

CXL_DECODER_F_NORMALIZED_ADDRESSING is only set later during
discover_region() -> cxl_add_to_region() -> get_cxl_root_decoder() ->
cxl_root_setup_translation() -> cxl_prm_setup_root():

drivers/cxl/core/atl.c:cxl_prm_setup_root() {
	...
	cxld->config.flags |=3D CXL_DECODER_F_LOCK;
	cxld->config.flags |=3D CXL_DECODER_F_NORMALIZED_ADDRESSING;
	...
}

Because nothing calls cxl_hdm_refresh_decoder() after cxl_prm_setup_root()
sets that flag (and the auto-discovered decoder is already enabled and
locked, so cxl_decoder_commit() and cxl_decoder_reset() will not run on it),
pdev->hdm->settings[i].config.flags never receives
CXL_DECODER_F_NORMALIZED_ADDRESSING. Would a reset on a
normalized-addressing endpoint bypass this -EOPNOTSUPP check and instead
reserve and invalidate the untranslated normalized address range?

[ ... ]

> diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
> index cfb55b10f8acf..7919d872a34de 100644
> --- a/include/cxl/hdm.h
> +++ b/include/cxl/hdm.h

[ ... ]

> +void cxl_region_quiesce_lock(void);
> +void cxl_region_quiesce_unlock(void);
> +int cxl_hdm_quiesce_prepare(struct cxl_hdm_quiesce *q,
> +			    const struct cxl_hdm_info *snapshot)
> +	__must_hold(cxl_region_quiesce);
> +int cxl_hdm_quiesce_flush(struct cxl_hdm_quiesce *q)
> +	__must_hold(cxl_region_quiesce);
> +void cxl_hdm_quiesce_destroy(struct cxl_hdm_quiesce *q);

[Severity: Low]
Should the declarations of cxl_region_quiesce_lock() and
cxl_region_quiesce_unlock() in include/cxl/hdm.h carry the
__acquires(cxl_region_quiesce) and __releases(cxl_region_quiesce)
annotations that are present on their definitions in
drivers/cxl/core/hdm_state.c, and should __cxl_reset_execute() in
drivers/pci/cxl.c also be annotated with __must_hold(cxl_region_quiesce)?

Without those annotations visible in drivers/pci/cxl.c, context analysis
(-Wthread-safety) cannot see that cxl_reset_execute() acquires
cxl_region_quiesce before calling cxl_reset_quiesced(), or that
__cxl_reset_execute() holds cxl_region_quiesce when calling
cxl_hdm_quiesce_flush().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029145703.2185=
231-1-smadhavan@nvidia.com?part=3D13
