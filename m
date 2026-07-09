Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9179218B0F;
	Thu,  9 Jul 2026 01:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783560484; cv=none; b=p/t7Z1Y+Fhtn4ju4a2zj0RZD1SYy6aLWDYJb/Uc6WlUco5nTtgl7T4z2UbuNWhwQ+AHUrzpmsojcPEnbr2kcGPKqh1cMD522+/SwMpsgl6Z7WEMzP8Sc80311lItjZ3eAhwRonQPj6DMVAFiHZy7LZxmZdDMCU8ARdTXLub0gKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783560484; c=relaxed/simple;
	bh=qZGn94SJbmuTfmHoT5lwC/s/0B+7vbRxTuDZGczgD9o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f+7WiCOj2AYSWcm56iKrgWU5J4udhsjs5PUK5YZsg9ctHEY80aFGv8PrlWwkcWIpbXASWNEUglAe+2fMrHQomJejCIy9piyZ6O6LnkdL11S9GqfAiqBPZHsRKvOV7CeKKZrn5+1VqZ0wxkie4/7N60x3Fm0YmzpCm04Y9xjaINE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+cZrIi9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+cZrIi9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A1E1F000E9;
	Thu,  9 Jul 2026 01:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783560483;
	bh=fCnlOT2QuhZGtFI6euQfG8A/hbINpCwJ8imUzu9iWlY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B+cZrIi9mfFUjb1sZosLYSjOxvoqc5MJ9KXZXDH60Le7ObUhU0UgzFmsJcfH/yKm0
	 1hLUdRmUHIAM7AL4QldsGczFwJ4gI/yJ/BoBVXt/vLUNwC/Q34drEyeVQyWNe11m0P
	 l7Eo6C6C1TPEwgoEpwLgBkWLB1dZjrV+TmtaEsDHUSFVJy6SQ5lKI6ftAVd/x7Bo4z
	 o/Qm9PFbd93l8iwGHfwe7LI5GcDqrtczLrW64cMuQ19zFFSZeHTiRiDDQnAKpUJcKP
	 mEhV0jEmdQGUPX+1DoQMHY3egkRSJQqcWOYs0euk1U62ygkCKd53Tv46r9LuyKlE+5
	 26gVHoOfN8CVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 06/11] cxl: Validate HDM ranges before CXL reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260709010304.680422-7-smadhavan@nvidia.com>
References: <20260709010304.680422-1-smadhavan@nvidia.com>
 <20260709010304.680422-7-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 01:28:02 +0000
Message-Id: <20260709012803.03A1E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] cxl_hdm_ranges_collect() reads HDM decoder settings without holdin=
g the required cxl_rwsem.dpa lock, leading to data races with concurrent mo=
difications.
- [High] cxl_hdm_range_context_destroy() releases memory regions outside th=
e cxl_rwsem.region lock, causing spurious -EBUSY errors for concurrent rese=
ts.
- [Medium] Functions contain both goto-based error handling and scope-based=
 cleanup (__free() / scoped_guard()), violating subsystem guidelines.
--

--- Patch [6]: [PATCH v9 06/11] cxl: Validate HDM ranges before CXL reset -=
--
commit c90294fef588f0141e340a7198edc3285f1a401d
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl: Validate HDM ranges before CXL reset

Before reset, collect enabled cached HDM decoder ranges and reserve them
with request_mem_region(). This rejects reset while affected CXL memory is
busy and keeps the validation stable through reset.

[Severity: Medium]
Is it expected that cxl_restore_hdm() and __pci_cxl_hdm_init() mix
goto-based error handling with scope-based cleanup (__free() and
scoped_guard())?

The cleanup subsystem guidelines strictly mandate converting all resources
to scope-based cleanup or none of them to avoid LIFO ordering mistakes.
Mixing these paradigms increases the risk of double-free or resource leak
bugs due to confusing ownership semantics.

> diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
> index 7a9b1ecfadcf9..fb741b66e5022 100644
> --- a/drivers/cxl/core/reset.c
> +++ b/drivers/cxl/core/reset.c
[ ... ]
> @@ -467,6 +469,231 @@ static const u32 cxl_reset_timeout_ms[] =3D {
[ ... ]
> +static int cxl_hdm_ranges_collect(struct cxl_hdm_range_context *ctx,
> +				  struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_info *info =3D READ_ONCE(pdev->hdm);
> +	int rc;
> +
> +	if (!info) {
> +		pci_err(pdev, "CXL HDM decoder state unavailable\n");
> +		return -ENXIO;
> +	}
> +
> +	for (int i =3D 0; i < info->decoder_count; i++) {
> +		struct cxl_decoder_settings *settings =3D &info->settings[i];

[Severity: High]
Is it safe to read info->settings[i] here without holding the
cxl_rwsem.dpa lock?

If a concurrent userspace PCI reset via sysfs triggers
cxl_reset_function() and calls cxl_hdm_ranges_collect(), this code
iterates over info->settings holding only cxl_rwsem.region.

Concurrently, an asynchronous device probe calling
cxl_hdm_info_set_decoder() could modify info->settings holding only
cxl_rwsem.dpa for write.

Could this lead to a torn read of settings->hpa_range, which is then
passed to request_mem_region(), potentially causing memory corruption or
a kernel panic by requesting a garbage memory region?

> +
> +		if (!(settings->flags & CXL_DECODER_F_ENABLE))
> +			continue;
[ ... ]
> @@ -662,7 +889,9 @@ static int cxl_reset_execute(struct pci_dev *pdev, in=
t dvsec)
[ ... ]
>  int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  {
> +	struct cxl_hdm_range_context range_ctx;
>  	int dvsec;
> +	int rc;
> =20
>  	dvsec =3D cxl_reset_dvsec(pdev);
>  	if (dvsec < 0)
> @@ -671,5 +900,14 @@ int cxl_reset_function(struct pci_dev *pdev, bool pr=
obe)
>  	if (probe)
>  		return 0;
> =20
> -	return cxl_reset_execute(pdev, dvsec);
> +	cxl_hdm_range_context_init(&range_ctx);
> +
> +	scoped_guard(rwsem_write, &cxl_rwsem.region) {
> +		rc =3D cxl_hdm_ranges_prepare(&range_ctx, pdev);
> +		if (!rc)
> +			rc =3D cxl_reset_execute(pdev, dvsec);
> +	}
> +
> +	cxl_hdm_range_context_destroy(&range_ctx);

[Severity: High]
Could this cause spurious -EBUSY errors for concurrent resets?

When two endpoints of an interleaved CXL region are reset concurrently,
they both attempt to lock the same hpa_range.

If thread A acquires cxl_rwsem.region, calls request_mem_region(), and
finishes the reset block, it then releases cxl_rwsem.region before calling
cxl_hdm_range_context_destroy() to release the memory region.

If thread B immediately acquires cxl_rwsem.region and calls
request_mem_region() on the same hpa_range, it seems thread B would fail
with -EBUSY because thread A still holds the global iomem_resource for
this range.

Would it be safer to place the context destruction inside the lock scope
to ensure proper serialization?

> +	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709010304.6804=
22-1-smadhavan@nvidia.com?part=3D6
