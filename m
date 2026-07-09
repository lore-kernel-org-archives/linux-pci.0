Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD8CDF6C;
	Thu,  9 Jul 2026 01:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559838; cv=none; b=WVjFTQseItguzis7Q/AN9lgwhxMFQaHBC4BiSK+zY/vUozUF1Q+8xg6xa12PS7CEr1venOgzw2ZB4A1M4PnmPdOACPRiXOo4kGyqbIgu0YolVY0qm7OwQwzkB4WjcUKa27CNJKgEQ46XdjTosrz05nl3BBsNzUBeT8zbfMnE8ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559838; c=relaxed/simple;
	bh=ooDXSPG7iCZrtMF+50d0m6JL4u8xMbFWAgitJbocI34=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KHzj/h1/pP+wHLXjapbRFKGDH2tkQG/8eMANLA9b6Nd817a5wRAbcmn1i/Ml0EkR8F+Wp4IlGShsaUVyuS9sxpOhZ/U+lbVtC0M7KmL8NejQuh9Pzy4HTxPdRpjFRDQ0wec5bUOmeWpLIhYTNI7hbXwrlZOFWxVFZ5EDqTEo5/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBuruB0h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBuruB0h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8A71F000E9;
	Thu,  9 Jul 2026 01:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783559837;
	bh=wb6z6Rc98DYt+ZOD8/WcZ4vLBC3uR6Cg0oLA6gPPhXk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JBuruB0hLDVm/fhXc8YVrbQbmlRb0akfDhP81f27Gvfm6ErIs1UAyAPgcik9uOGnN
	 IILyUj7yc1BTXRitlGDv39Ylj9skC3zfpmvLyV0IgTLvL5qTNCoL6rcJhdi5CcnrHW
	 7hJrioSGkhRq+1bFU93+kqKQ0YdM7caL1e0UG+3ULVZRvsS+9F0A1IFkIpoBRbMQDI
	 m3Kjyg2Hwxn1TRY8P53V7Os1nToZy02wejTY1S4RL3mKNWwB115y2B9AULS0CnOYZI
	 APQzAPQKl660sx8Bi3NLxE8V21sSzSOzKo287Nt9kXZbSvZ7S+SXmIRC+UBhUxn7E5
	 k4WykYuvriAyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 08/11] cxl: Restore CXL HDM state after PCI reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260709010304.680422-9-smadhavan@nvidia.com>
References: <20260709010304.680422-1-smadhavan@nvidia.com>
 <20260709010304.680422-9-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 01:17:16 +0000
Message-Id: <20260709011717.0B8A71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Hardware PCI BARs are not restored before attempting HDM MMIO acce=
ss post-reset, causing the restore to fail silently or trigger bus errors.
- [Medium] Mixing `goto`-based error handling with scope-based cleanups (`_=
_free()` and `scoped_guard()`) in the same function.
--

--- Patch [8]: [PATCH v9 08/11] cxl: Restore CXL HDM state after PCI reset =
---
commit a1cce28cbb5bb68a25127de7ce247a2950193943
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl: Restore CXL HDM state after PCI reset

After CXL reset, restore PCI config state enough to reach HDM MMIO,
restore cached global and per-decoder HDM state, and then run the normal
PCI restore callbacks.

> diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
> --- a/drivers/cxl/core/reset.c
> +++ b/drivers/cxl/core/reset.c
> @@ -455,6 +531,164 @@ void pci_cxl_hdm_init(struct pci_dev *pdev)

[ ... ]

> +static int cxl_restore_hdm(struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_decoder_state *decoder_state __free(kfree) =3D NULL;
> +	struct cxl_decoder_settings *settings __free(kfree) =3D NULL;

[ ... ]

> +	hdm =3D cxl_pci_hdm_ioremap_current(pdev, hdm_bar, hdm_offset, hdm_size=
);
> +	if (IS_ERR(hdm)) {
> +		first_rc =3D PTR_ERR(hdm);
> +		goto out_restore_command;
> +	}

[Severity: Medium]
Is it safe to mix goto-based error handling with scope-based cleanups
like __free() in this function?=20

The kernel cleanup guidelines suggest converting all resources that need a=
=20
goto cleanup to scope-based cleanup, or converting none of them, because=20
mixing them creates confusing ownership semantics.

> +
> +	/*
> +	 * Restore global HDM control before per-decoder commit. PCI config
> +	 * memory decoding is enabled for MMIO access, but IOMMU reset blocks
> +	 * remain active until HDM restore completes.
> +	 */
> +	writel(global_ctrl, hdm + CXL_HDM_DECODER_CTRL_OFFSET);

[Severity: High]
Will this MMIO access fail or trigger bus errors?=20

The CXL reset clears the device's PCI configuration space, which sets the=20
hardware BARs to 0. Although cxl_hdm_enable_mem() sets the=20
PCI_COMMAND_MEMORY bit earlier in this function, it doesn't appear to write=
=20
the physical address back into the hardware BARs before we attempt to acces=
s=20
the MMIO region here.

[ ... ]

>  int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  {

[ ... ]

>  	cxl_hdm_range_context_init(&range_ctx);
> =20
> +	if (!cxl_reset_scope_hdm_available(&ctx)) {
> +		rc =3D -ENOTTY;
> +		goto out;
> +	}
> +
> +	rc =3D cxl_pci_target_reset_prepare(&ctx);
> +	if (rc)
> +		goto out;
> +
>  	scoped_guard(rwsem_write, &cxl_rwsem.region) {

[Severity: Medium]
Could we also avoid mixing the legacy goto error paths with the=20
scoped_guard() block in this function?

> -		rc =3D cxl_hdm_ranges_prepare(&range_ctx, pdev);
> +		rc =3D cxl_hdm_ranges_prepare(&range_ctx, &ctx);
>  		if (!rc)
>  			rc =3D cxl_reset_execute(pdev, dvsec);
> +		if (!rc)
> +			rc =3D cxl_restore_hdm_decoders(&ctx);
>  	}
> +
> +	cxl_pci_target_reset_done(&ctx);
> +out:
>  	cxl_hdm_range_context_destroy(&range_ctx);
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709010304.6804=
22-1-smadhavan@nvidia.com?part=3D8
