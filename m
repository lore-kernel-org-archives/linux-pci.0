Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ACC1D4606;
	Sun, 11 Oct 2026 02:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791686082; cv=none; b=MmxFG956crGIN6/KAYLd+DycLDrLizvyGh3X2HrRUzoTmbEDsnJN9fGzO96ghRyHdDEPKq7OOEhdkAroJMpgVw1DMK02lnlX+KLKg0MmIM1VPT3y+2R0V1oAwW4bQP3VtRxJrfG5UEOxxtMfFIySZs6fhG0GnhtZjKiy34R3TJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791686082; c=relaxed/simple;
	bh=0idIBKAdK0cfU1Wg/3E31toev/ZT4wicpDJT4Zbx0Lo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Z+0pUj3ZfNbTwcQ9V/FWM1NR53b6BHH/AgHwqs4fFFKkAokX6/T91qaqCnEw86rh2iiBr2/5IkEueceKVBekACqwNiLy1HDMWG2pka9+spl48oON1L9IyelqjHkvX+GkGzRa1booiYVsHtpGuUwlSGgSqBkVl3ka28zBcX4iAmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F33UsjT6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F33UsjT6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781211F000FF;
	Sun, 11 Oct 2026 02:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791686080;
	bh=Qo/q6YuUrdBvRtJKfmPBfh1c2HOAkt9cLEEFoOis8tY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F33UsjT6NicPijqnHARSaS9p3tMRdgOwnslRRw0Xk+JlqLJa/V8k02Mv93Nt2Sra9
	 UwTLRqJblrArFNn5A8qxbEXZl0SXDGqgkZkGzjXXaCOuWSkF9sQ7pGvyFEvl2vdUIU
	 QSia+OPoZypM/q3vu+/CjRcriuSLthOcMw64e+8DbZ6Ef6XHEIQaeAqUhBpuvywPQ3
	 mbugF65pQE+WxHhRI+JG9F2/vBPpWfUSMT3V/LCy3x/f0bk4/4lFcYphmGap1+hjWh
	 2HZEfwY5rct6hlddwyTxWzchEENhEOrlb0dSrI2x7z8Ivq6VZnS9LBfiXrZw+iw8Ih
	 b1t2tWXKNgd3g==
Message-ID: <sashiko-outbox-166982@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 14/16] PCI/CXL: Expose CXL Reset as a PCI reset
 method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261011021422.3428136-15-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-15-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 02:34:39 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pci/cxl: incorrect capability probing in cxl_reset_function()
--

commit caffe4423e688e1f05bdb2a57599ac06d181265a
Author: Srirangan Madhavan <smadhavan@nvidia.com>

PCI/CXL: Expose CXL Reset as a PCI reset method

Register cxl_reset with the PCI reset-method interface and place it before
FLR, which does not reset CXL.cache or CXL.mem protocol state.

Return -ENOTTY when device capabilities, function scope, cached HDM state,
or required cache synchronization do not permit a safe reset.

> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> index 4c6b712ed4faf..7a225e215ca5c 100644
> --- a/drivers/pci/cxl.c
> +++ b/drivers/pci/cxl.c
[ ... ]
> @@ -651,9 +651,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool pro=
be)
> =20
>  	rc =3D pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
>  	if (rc)
> -		return pcibios_err_to_errno(rc);
> +		return probe ? -ENOTTY : pcibios_err_to_errno(rc);
>  	if (PCI_POSSIBLE_ERROR(ctrl))
> -		return -ENODEV;
> +		return probe ? -ENOTTY : -ENODEV;
>  	if (!(ctrl & PCI_DVSEC_CXL_CACHE_ENABLE) ||
>  	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
>  		return -ENOTTY;

[Severity: Medium]
Will this dynamic state check introduce a regression where the probe incorr=
ectly
fails?

If the BIOS hasn't pre-enabled CXL memory, PCI_DVSEC_CXL_MEM_ENABLE will be=
 0.
Since this dynamic state is checked before the early return for probe furth=
er
down in the function, the method fails probing and isn't registered in sysf=
s,
even though the OS driver will enable CXL memory later.

Additionally, because the early return happens before static capability che=
cks
like this:

    if (probe)
        return 0;

    /* ... */

    if (!cpu_cache_has_invalidate_memregion())
        return -ENOTTY;

Will this cause a regression that falsely advertises the capability in sysf=
s on
architectures lacking cache invalidation since the static check is skipped
during probe?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011021422.3428=
136-1-smadhavan@nvidia.com?part=3D14
