Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793287760;
	b=j6bPtK4lPRCXRY4TRGM0Ew2gBGQIFx8EvW1yeb0uP80ObJc9J2DA0XwdymMAMpTwoCSY
	 KJWKsY9xB9zglcUOWj2sk6TtyU788BDCLa2PPv9PTsnQ2N0fyNjQYv3re+iYEoSgVrAo0
	 HI/tW8ytTYvgpiZHKqJnO6+/aBQJQ1X7AvT7irP0QeSEpsfEHYH2LN/3Jvy68N6BFSvQK
	 XGe/BgpRohX8zAxEVPIcnCniSUnp8DH8d3shZI56JSZX1PyZF0t0b2p6aTGkODpFH924l
	 PQpx0+ayNBL0eAXvC19dUadu8yEyeQCzWtyWe3URvwa+ltzWunXPkLfLzU+EuhYZyLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793287760;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YToyvZk34yrk+TaQWFeLoYWs0xKK8iCkFtinElmzF+8=;
	b=LNWj7RqlS0UVj5dOpAKQ5T7Kp6YfpjX1pSMA11elhjH6TTYzkaEC4V/zf9KuVO2y9euU
	 BWZquEJuFRtzAcmzbTrn5iKzrYDvPbw4yURtamLTF/D58geTGd+9sGK7j9ivTs6Cb7Byi
	 w4KhLT9AUd3VA98WpY+pRld37FOeLaXjuCLWSSh+363eptJ/NiMA6FKbioOJNtgPZyfkC
	 huA6s0NOay6yom46K4uZjgsveo6yrqPvftzhmfWBqmdzBq9VPmkSmhOQ0ncHcBk+ionjF
	 SiIjCKtIqRC3vDSjUyzojEo14DVxnsv/2xmjxxP6TM0V3giMlGxGNM0zI9ERymQakkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BO0c6qDo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF57606A31A;
	Thu, 29 Oct 2026 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BO0c6qDo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790661F01816;
	Thu, 29 Oct 2026 15:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793287759;
	bh=YToyvZk34yrk+TaQWFeLoYWs0xKK8iCkFtinElmzF+8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=BO0c6qDojjdakwinkAlHGGs04tJRm82CeXV4hZ8j+F6BnTR0wgC2BH5pk1RJAHMrT
	 UOEZywlbXd5zTuO9mz+MwypwB8Viz+hNwi9e+OJCMlGMIlHX3cHy+hYlzlkPjuWZ0A
	 DdCCy2Hbg+l4z2N1DrQ05Mmt6Dor7cqHfnq0YR95LLYPy4knQrMWv7UWf6FpDEsOcS
	 iR3Aqam7z19u3juC1izWaRIJL2momj9aH0K3RwGPeo/F2cZk1XWHsLiydu7m+iThRj
	 fcSy2kirRXH69KCSYbGdFoxUTGyzGyEH/85s3lpJX6DZPGa36TQBV5lHm8uNFMqpvi
	 7W9f9m9QYlU+g==
Message-ID: <sashiko-outbox-189605@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 15/18] PCI/CXL: Restore CXL state after PCI reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261029145703.2185231-16-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-16-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:29:19 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] PCI/CXL: missing __must_hold(cxl_region_quiesce) on __cxl_reset_exe=
cute()
--

commit da830bbfe7ea5fbc66b29d8fb48ea9c9acd0a112
Author: Srirangan Madhavan <smadhavan@nvidia.com>

PCI/CXL: Restore CXL state after PCI reset

This commit restores the PCI configuration needed for HDM access, cached HDM
decoder settings, and CXL Device DVSEC state after a CXL device reset. It a=
lso
handles restoration failures by disabling the device in the saved PCI comma=
nd
state.

> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> index 9a298e90586da..58bbd5b47539f 100644
> --- a/drivers/pci/cxl.c
> +++ b/drivers/pci/cxl.c

[ ... ]

> @@ -232,6 +233,162 @@ void pci_cxl_hdm_cache_release(struct pci_dev *pdev)

[ ... ]

> +/* Caller holds the region lock and keeps device traffic isolated. */
> +static int pci_cxl_restore_state(struct pci_dev *pdev,
> +			  const struct cxl_hdm_info *snapshot, u16 *command)
> +	__must_hold(cxl_region_quiesce)
> +{
> +	device_lock_assert(&pdev->dev);
> +	cxl_restore_pci_state_for_hdm_restore(pdev, command);
> +	return cxl_restore_state(pdev, snapshot);
> +}
> +
>  /*
>   * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
>   * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms af=
ter
> @@ -412,7 +569,9 @@ static int cxl_clear_memory(struct pci_dev *pdev, int=
 dvsec, bool initiate)
>  }
> =20
>  static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
> -			      struct cxl_hdm_quiesce *q)
> +			      const struct cxl_hdm_info *snapshot,
> +			      struct cxl_hdm_quiesce *q,
> +			      u16 *command)
>  {
>  	int rc, rc2;
> =20
> @@ -437,10 +596,15 @@ static int __cxl_reset_execute(struct pci_dev *pdev=
, int dvsec, u16 cap,
>  		pci_err(pdev, "failed to clear CXL Reset Memory Clear: %d\n", rc2);
>  	rc =3D rc ?: rc2;
> =20
> +	if (!rc)
> +		rc =3D pci_cxl_restore_state(pdev, snapshot, command);
> +
>  	rc2 =3D cxl_hdm_quiesce_flush(q);

[Severity: Low]
Does __cxl_reset_execute() also need the __must_hold(cxl_region_quiesce)
annotation to avoid compiler context-analysis (-Wthread-safety) warnings wh=
en
context analysis is enabled?

Both its caller cxl_reset_quiesced() and its callees pci_cxl_restore_state()
and cxl_hdm_quiesce_flush() are annotated with
__must_hold(cxl_region_quiesce), while __cxl_reset_execute() itself is not:

  cxl_reset_execute()
    cxl_region_quiesce_lock()
    cxl_reset_quiesced()                [__must_hold(cxl_region_quiesce)]
      __cxl_reset_execute()             [unannotated]
        pci_cxl_restore_state()         [__must_hold(cxl_region_quiesce)]
        cxl_hdm_quiesce_flush()         [__must_hold(cxl_region_quiesce)]
    cxl_region_quiesce_unlock()

Relatedly, in include/cxl/hdm.h:

  void cxl_region_quiesce_lock(void);
  void cxl_region_quiesce_unlock(void);

the prototypes omit the __acquires(cxl_region_quiesce) and
__releases(cxl_region_quiesce) annotations that are present on the definiti=
ons
in drivers/cxl/core/hdm_state.c, which also prevents context analysis from
seeing the lock acquisition in cxl_reset_execute().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029145703.2185=
231-1-smadhavan@nvidia.com?part=3D15
