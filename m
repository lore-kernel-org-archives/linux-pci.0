Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990A243F4AF;
	Thu,  1 Oct 2026 11:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790852547; cv=none; b=sGxuYOaUiW8Gzk0ZmAQrwybuG/NUqP2+CPuVaa2/IENOS9yucHPAGpOg/ME8Z1ru2dabAC/dV3f0JEQKGh2MHdcAuDfWjlaRktBQLJ9a+X2VHMaSGKMTBDUr+MGj2B9UcBlU8s0Bx0TJ+MkZXUg8+lywJN8czWbTbeyY7dk6e+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790852547; c=relaxed/simple;
	bh=jWzFToFkYqd49Tg2PsBuC0dH6Nal6PobB/wR0OeY1wU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hqw1847OTOvX17kW/vVzjrpipgTKVVK3zDi6IyZQLUaml/msZJ7vQsV49u6sQPhDDT0m5ELfZk7bB8GB6LgqCcPvl1NcH8q3JJe8zyc97XcsHWeAZ+22wFIzzfUm+pFsFfGL1oB4NBZk0B5M+0Nc4JzhYItEdP6bvnxOVRU8NL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVlar4jC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVlar4jC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB281F000FF;
	Thu,  1 Oct 2026 11:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790852544;
	bh=N9rxjYNj6KK0Hu8wGG8UwwEWKosfVpnJi93I7dbuiuM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LVlar4jCsYwkL2bnTFpJkF3tomDBxqKYvLGtoPz43H0WjEdvM7Cn5Bzkm1lkc9NRv
	 2A9j58pPH5PoL8HLmmqk76GBA+sdsOL75yGhPFGGopKBpUaV10JtQbXFMh4BW9Gz3j
	 YD50p27Hg1/TnKs5T1gi7wgaSf8/bLsHGPuLk4HizdBNi3wKy5c5olrxUeZO0rgA37
	 IYlg2y55X1/8DZFpaVccbjX/byA7M5X1vwH8dBFsnMejPXj7WayGwKECSdqS61sGvU
	 DZ8n+35Yun8R2LwnyOnONwmBbvTk2YLtL8SY4NTRlYGQWqvBVi1nunpnFnfAjq741N
	 CAV5r2UdHn4wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 15/16] PCI/CXL: Expose CXL Reset as a PCI reset
 method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261001092227.3004747-16-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-16-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 11:02:24 +0000
Message-Id: <20261001110224.AEB281F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] cxl: cxl_reset_function() incorrectly skips CXL reset for Type 3 d=
evices
- [Medium] cxl: cxl_reset_function() incorrectly evaluates probe condition =
preventing registration
--

commit 75de83aed9edbce7d35622dfb455ec27e90edf7c
Author: Srirangan Madhavan <smadhavan@nvidia.com>

PCI/CXL: Expose CXL Reset as a PCI reset method

Register cxl_reset with the PCI reset-method interface and place it before
FLR, which does not reset CXL.cache or CXL.mem protocol state. Return
-ENOTTY when device capabilities, function scope, cached HDM state, or
required cache synchronization do not permit a safe reset.

> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 0acc471d0d7e2..efbab341b30f6 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -1264,9 +1264,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool p=
robe)
> =20
>  	rc =3D pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
>  	if (rc)
> -		return pcibios_err_to_errno(rc);
> +		return probe ? -ENOTTY : pcibios_err_to_errno(rc);
>  	if (PCI_POSSIBLE_ERROR(cap))
> -		return -ENODEV;
> +		return probe ? -ENOTTY : -ENODEV;
>  	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
>  	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
>  	    !(cap & PCI_DVSEC_CXL_RST_CAPABLE) ||

[Severity: High]
Does this logic correctly handle CXL Type 1 and Type 3 devices?

Type 3 devices (memory expanders) only use the CXL.mem protocol and do not
use CXL.cache. The bitwise AND requirements force the device to support BOTH
protocols. This causes standard Type 3 devices to fail the capability check
and fall back to standard FLR, which leaves the CXL.mem protocol state
un-reset.

> @@ -1275,9 +1275,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool p=
robe)
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
Similarly, does this incorrectly require both CXL.cache and CXL.mem to be
actively enabled? This will again exclude Type 1 and Type 3 CXL devices
which only enable one protocol.

[Severity: Medium]
Will this reset method fail to register at boot due to the evaluation of
the transient control state before the probe check?

PCI enumeration calls pci_init_reset_methods(), which evaluates the reset
methods with probe=3Dtrue. Because PCI_DVSEC_CXL_CTRL enable bits are a
transient state typically set later by the CXL driver, the ctrl check here
fails and returns -ENOTTY during boot, silently omitting the reset method.

The probe early return occurs later in the function:

	if (!(ctrl & PCI_DVSEC_CXL_CACHE_ENABLE) ||
	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
		return -ENOTTY;

	if (pdev->multifunction || pci_num_vf(pdev))
		return -ENOTTY;

	if (probe)
		return 0;

Because the transient driver state is evaluated before the probe check, it
prevents registration. Conversely, static capabilities like
cpu_cache_has_invalidate_memregion() are evaluated after the probe check,
bypassing them during probe but enforcing them at runtime. This can lead to
inconsistent reset availability.

Could the probe check be reordered to skip transient driver states while
still enforcing static architecture capability checks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001092227.3004=
747-1-smadhavan@nvidia.com?part=3D15
