Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614373BC669
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 10:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779964912; cv=none; b=MaCFBxRj5f2HXjrSonZfuN7qk58rMFvTF4NQRE9lYZN9htrEeKz+cBUxKSFsB2ah7sUxztdP4YjoEdm3cazW6fgCR+gB9On9hlat74IeIEXmuu5BtmESArT3i/L9IEppxmAd+Jl0L9SqfwwCDWuIVmRq5CTuZ3ni+p01jE7vrCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779964912; c=relaxed/simple;
	bh=vj2/5mMhv8/p3KmdLqljh6NFgld8drBt5D0ESPzJko4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QvlQEaG/JRXNGtSCup/Wht3rIDj96vyFN1LxAq4B5dxaScrnUW95GucRwzwmDgy4E4R7TYY8sf5EKCycg5R6Sra84YgljaOFukI6JCEWcD6WptvHjknQ91vuuwE2pfDsU4OIcjjAy38y2sQBveIbnq1OsHpxEY+pmRngYjN2HhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0U0vlfm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0U0vlfm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5781F00A3A;
	Thu, 28 May 2026 10:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779964911;
	bh=fNosBqDb5ZZNhp7GbD9zU44SyTob/fjLnlA8RslkzYU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a0U0vlfmjhqhhy2nP7Hnd4FWoxeys0wd3C2eyDQz+tneYCjqI26UaioPDW90Z1KMO
	 PA0SFd4S0D4zdY4c7z/MrSoGA3QzWpDKYTA2Je1TlS50183pHum8AUgscTAXc5ntwO
	 M+OVrdOlCCqozMnFbPZ0IrzSMf4POVvSr1sVYpcldMNXH0CSw5t3AxdBQSNnRTbWP8
	 xh0iDelkw3vwMLwKArzYdyZcnCs0ay05bbj4mS/K1rtxsCvALeEwslizjGBianWy1z
	 5aZ3rUuf2ywKvpb/DWDA/y11iT4RaAIWXKNHWA7+KiduTYiPblbyfr9s99DYdmy6nb
	 jRAX/KTVyj0mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/9] PCI/CXL: Add sibling function coordination for
 reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260528083154.137979-5-smadhavan@nvidia.com>
References: <20260528083154.137979-5-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 10:41:50 +0000
Message-Id: <20260528104150.8C5781F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect bit indexing when checking the Non-CXL Function Map DVSE=
C for non-ARI devices.
--

commit b310856ad85d3fc081d86a4d5ea3b158b15fce9f
Author: Srirangan Madhavan <smadhavan@nvidia.com>

PCI/CXL: Add sibling function coordination for reset

This commit adds helpers to collect CXL sibling PCI functions affected by a
CXL reset and prepares them by saving and disabling them. It uses the
Non-CXL Function Map DVSEC to filter out non-CXL functions and functions
without CXL.cache or CXL.mem capabilities.

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 318744695f628..01effbb4e7cd1 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c

[ ... ]

> @@ -1096,3 +1102,204 @@ cxl_reset_flush_cpu_caches(struct cxl_reset_regio=
n_context *ctx)

[ ... ]

> +static bool cxl_reset_is_cxl_sibling(struct pci_dev *pdev,
> +				     struct pci_dev *sibling,
> +				     unsigned long *non_cxl_func_map)
> +{
> +	if (sibling =3D=3D pdev || sibling->bus !=3D pdev->bus)
> +		return false;
> +
> +	if (pci_ari_enabled(pdev->bus))
> +		return !test_bit(sibling->devfn, non_cxl_func_map);
> +
> +	if (PCI_SLOT(sibling->devfn) !=3D PCI_SLOT(pdev->devfn))
> +		return false;
> +
> +	return !test_bit(PCI_FUNC(sibling->devfn) * 32 +
> +			 PCI_SLOT(sibling->devfn), non_cxl_func_map);

[Severity: High]
Does this formula correctly index the Non-CXL Function Map for non-ARI
devices?

For a non-ARI device, the function map typically uses bits 0-7 to represent
functions 0-7. With this formula, a sibling at function 0 and slot 2 will
evaluate to bit 2 (0 * 32 + 2) instead of bit 0.

If bit 2 happens to be set (indicating function 2 is non-CXL), function 0
could be incorrectly identified as a non-CXL function and excluded from the
reset coordination.

Will this cause the skipped function to miss having its state saved and
IOMMU blocked, potentially leading to lost configuration state, unhandled
IOMMU faults, or driver crashes during the reset?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528083154.1379=
79-1-smadhavan@nvidia.com?part=3D4
