Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4332D522697;
	Tue, 22 Sep 2026 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067777; cv=none; b=jsv0jSXXp7YSxeYA5GTZBqao5BXVzKa3vkr3wR2U7rIwKnlkdMXfVbGhZK4IBZNLK5/ZYFHOSIUgNeOWFZXgdBrto0HnS2TAf5Xnk/EroWhsOdXby59fxVIF8V7wfh1V0Tr5i+atXufDbJzYK1y1Q9eHUzymgW9Aj2c8jy6rznw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067777; c=relaxed/simple;
	bh=6QLL8kOEYVPBDvn/KHSNGhNSQVVLFtJN0wo7aXs5cn8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WMF9xZIujLK3D9YC7MwYcAnmEQCszEZq8eN82z3Ywxous4WEx+5puLSEnFyw0l+T2La1JfVxOWaGz+tGAVG42VcvcRtMN/BxcupOkM7ukHskJNoaCaqWWiU0+CSkOFyuxCEoNAM/xrmEEgjC5uqWHkRUupk9C5FCitXuNJMTJuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Um7rVY0r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Um7rVY0r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805311F00893;
	Tue, 22 Sep 2026 09:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790067775;
	bh=C65iB7eiH4BwABEcK8uVSpTqKN/IKsmkTblMzp6fi9k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Um7rVY0rhXDfDYFke390OceZxaMAqk/0mejHSif6mMtsBMZKDSXFAGK7Gapl88yRs
	 w76k/0CiZViKQxxIy3sVnk0VCqI0K7JIlWi8bIjmt3agpC0xj1yIuzlkoKaW0Q3fcq
	 SqXZKIJBo6P56vOGbbTykj33rTZW4+CXQ2HUtwNWtIYM8ufqtox5RNA5jGQA8Hfvpk
	 ItdvPAzwOa92d5YVJsmKZOW8WuiHeNNqU540or9CmXUqGO1tr2VdJRGrqh1TnoCe6T
	 OGlbAtaboSn4JOIGOorT1q0KmcmSWEjIstRowXPlajcItDaR2DKuIryw1O/QwvwuJi
	 J2xzxMrVf/1aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 14/15] PCI/CXL: Expose CXL Reset as a PCI reset
 method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260922083924.2451158-15-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-15-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 09:02:55 +0000
Message-Id: <20260922090255.805311F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] PCI/CXL: unsafe fallback to FLR on cxl_reset safety check failure
- [High] PCI/CXL: cxl_reset rejected during probe if features disabled
--

commit a3dd9319808c6b4394c9a465a0ccd99ba52161a2
Author: Srirangan Madhavan <smadhavan@nvidia.com>

PCI/CXL: Expose CXL Reset as a PCI reset method

This commit registers cxl_reset with the PCI reset-method interface, placing
it before FLR. It adds capability and state checks to ensure the device
supports and is configured for CXL cache and memory protocols. It also
returns -ENOTTY when the device capabilities or required cache
synchronization do not permit a safe reset.

> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ ... @@
>  int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  {
>  	int dvsec, rc;
>  	u16 cap, ctrl;
>=20
> [ ... ]
>=20
>  	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
>  	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
>  	    !(cap & PCI_DVSEC_CXL_RST_CAPABLE) ||
>  	    !(cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE))
>  		return -ENOTTY;

[Severity: High]
Does returning -ENOTTY here cause the PCI core to silently fall back to FLR
during an actual reset request?=20

Type 3 devices (memory expanders) lack CXL.cache capabilities, so they would
fail this check. If they fall back to FLR, it resets the PCIe state but not
the CXL protocol state. For devices with active CXL memory, this might lead
to Machine Check Exceptions or memory corruption when the CPU interacts with
the reset device.=20

Would returning a hard error like -EOPNOTSUPP during execution safely abort
the unsafe reset?

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

[Severity: High]
Does evaluating this dynamic state during probe permanently exclude the
reset method before the driver can enable the features?

When pci_init_reset_methods() calls cxl_reset_function() with probe =3D=3D =
true
during early device discovery, returning -ENOTTY causes the PCI core to omit
this method entirely from the supported reset methods.

If this check evaluates dynamic state before the early-return for probe, it
might cause hot-plugged devices to silently fall back to FLR when a reset
is later requested. Could this check be moved after the if (probe)
early-return?

>=20
> [ ... ]
>=20
>  	if (probe)
>  		return 0;
>=20
> [ ... ]
>=20
>  	if (!cpu_cache_has_invalidate_memregion())
>  		return -ENOTTY;

[Severity: High]
Similar to the capability check above, does returning -ENOTTY here fail to
safely abort the reset?=20

Since the PCI framework interprets -ENOTTY as "method not applicable, try
next", this causes a fallback to the unsafe FLR method. Would returning a
hard error prevent this unsafe fallback?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922083924.2451=
158-1-smadhavan@nvidia.com?part=3D14
