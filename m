Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B0B1D6DA9
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 00:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788569811; cv=none; b=k7+q2PS1Jdj2Qqz8TwqL1dyzM1u9VLgf3owJCQ25g3JOlyQg0mM4iO5G6wavKYSx6FvuK2fobtlAp5e7pPeCsUSrsz9UY+AbcS0SWnOzPYnwZlk+sa05JFdlmvxy2w6EFdTL3dwKHaLhgtKv5bbcWP0XMpe1p1en0hvCUVK6rwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788569811; c=relaxed/simple;
	bh=1bQxUNY8TQZyf2JjDa4cF97S4WbHAK2O9MaII2b7DGQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jBpdvyglk4H/sbXCeW1ROFhg1VHQXCz3oFhT7q22VVqnEzTVrG+pGhbIa12aD7B7tEjkXREBrOI8J7l7JLGd3BVIBxJbwNglkMYBZnRI8J+U+RoI7IyvARZgbWtNgwQtvMmB0VgbszbO7FMCs6SO2tWTzvS2Huhb9h51U+vNpb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1fTOPAZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1fTOPAZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8311F00A3D;
	Sat,  5 Sep 2026 00:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788569809;
	bh=c15W5KJFRKhZpw1/hheHCMdpFw3of+pyZcUO/kgwZWI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S1fTOPAZH2pAU+kKfv4BPX1w3Izz2hQfFMCbSZ/KlIbknKLmWkYtI7yH4gl58FpTE
	 LWg2FqQDgZEQ25AYnbwgQAhwWcZW+m1WLx7xpA19jbYbCco9UN4WQUc3tBsxFK/8hK
	 pVRrUSQD07jb5ID6NVBqTaPRtY6H4I38bC2/5XZDJnwQcs6rCsf+ygj0xvul+C9cr8
	 ho9H+sMzH3qVNliGmZskfN7yRSwz2PLmOtmXCXbGI4C64Nnt57HGG71hLOBPGRjeWX
	 0rBfvOflqKVFBGAcyy0hiM1r7sXGa7l5oDalXheIMnqPhDt7hCtaeOfbjlOoXplHE9
	 AOxjbpqc32yow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] PCI: host-common: Fix early bus-walk exit in
 d3cold_possible()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260905-shutdown-v5-1-f0c6bafa1d4f@oss.qualcomm.com>
References: <20260905-shutdown-v5-0-f0c6bafa1d4f@oss.qualcomm.com>
 <20260905-shutdown-v5-1-f0c6bafa1d4f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 00:56:49 +0000
Message-Id: <20260905005649.6D8311F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] PME capability detection is still skipped for devices not in D3hot=
, leaving the fix incomplete for endpoints in D0.
--

commit 6e30f6ce4308da682727250705301b528bde2289
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

PCI: host-common: Fix early bus-walk exit in d3cold_possible()

This commit addresses an issue in __pci_host_common_d3cold_possible() where=
=20
the bus walk was aborted when a downstream device was found outside of=20
PCI_D3hot. By changing the return value to 0 instead of -EOPNOTSUPP, it all=
ows=20
the bus walk to continue and check subsequent devices for PME-from-D3cold=20
capabilities, which is especially important during shutdown when devices mi=
ght=20
still be in D0.

> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/contr=
oller/pci-host-common.c
> index a23907a875e57..78bc4c8c96564 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -274,22 +274,19 @@ static int __pci_host_common_d3cold_possible(struct=
 pci_dev *pdev,
>  	if (!pdev->dev.driver && !pci_is_enabled(pdev))
>  		return 0;
> =20
> -	if (pdev->current_state !=3D PCI_D3hot)
> -		goto exit;
> +	if (pdev->current_state !=3D PCI_D3hot) {
> +		*flags &=3D ~PCI_HOST_D3COLD_ALLOWED;
> +		return 0;
> +	}

[Severity: High]
This is a pre-existing issue, but doesn't this early return still skip PME=
=20
capability detection for endpoints in D0?

The commit message notes it is common during shutdown for an endpoint to st=
ill
be in D0, and this patch aims to ensure later devices on the bus are visite=
d.
However, for the very device in D0, __pci_host_common_d3cold_possible() will
clear PCI_HOST_D3COLD_ALLOWED and return 0 before it checks device_may_wake=
up().

Does this mean a PCIe endpoint in D0 that supports Wakeup/PME from D3cold w=
ill
fail to have its PME capabilities recorded, causing its auxiliary power (Va=
ux)
to be incorrectly turned off during shutdown?

> =20
>  	if (device_may_wakeup(&pdev->dev)) {
> -		if (!pci_pme_capable(pdev, PCI_D3cold))
> -			goto exit;
> -		else
> +		if (pci_pme_capable(pdev, PCI_D3cold))
>  			*flags |=3D PCI_HOST_PME_D3COLD_CAPABLE;
> +		else
> +			*flags &=3D ~PCI_HOST_D3COLD_ALLOWED;
>  	}
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-shutdown-v=
5-0-f0c6bafa1d4f@oss.qualcomm.com?part=3D1
