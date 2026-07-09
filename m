Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ABF2ED872;
	Thu,  9 Jul 2026 01:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783560249; cv=none; b=tUNGLmRjsIqoUR1IZRBZwpL5ZaydZeQs/MO8v5c1aZKOseDcnsFIb2P8VMZcfPnHPG5Nf0aKjNrUl4p0MWhJ6iCIlwP81y2XjvTrjOSaPVWtvNk4Ym3mqhE6BOmUtHi6FFCj9FIpH+/Q9SLn6xdZ1r532SHekj1IWn2qEbZLZfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783560249; c=relaxed/simple;
	bh=qUXjTO9Ev/HXe1vb57Nn7npLVY0BWu8WKcbu3YNYDiQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pvf+3jeCK7SvjoD9s73VjpRFxXDarlvqaWQ0OXAlnJ7RoH92lZIbLgs5eDOBuCM3A2kkdgrrOJwsK/rzmUNV4jRqdT3sHSYZTDoWwTuCiXaS4iRWj0uhojdPTGPH8WbI1L8XEYHqYts/18QsjlI3tzA8eTSXq5LzqqYL72wTqQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odlm0641; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odlm0641"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5401F000E9;
	Thu,  9 Jul 2026 01:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783560248;
	bh=wbPieze4mk1wbE5Rz+uuCQxbVJQ5QYCGcyrX8BnSlJE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=odlm0641FZVjb26j0HYQv6UNTMnPX3c0/d5RukUb4bz5a0D64fiZAsKlSVGtl+VCf
	 fHtfTb4ZxilFKA2uLtHQzQxqyoet7jnP9NeCUkW9TU08Fz3PaAJsyNRQs+7U6or0B6
	 wz1dmcyDWyuM4N8LUoTZ5ZL/r/kRJR6BcqSvNtXMJlUmFuCuAR5/1x+PpGNNOvVq9q
	 NajrQWcGicIbvxTBeljX0OCX5fMMd0G06FTBryeIkjveyE9gSFkyUy/lhREUE+GOU+
	 HwRTWcoZFaI/KPyMg79IXr2NZM7yx9Rti+/zi8iotMrg57L4LxIfWcDAzD5eoI3S+l
	 ofsznByJ00UOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 07/11] PCI/CXL: Discover the CXL reset scope
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260709010304.680422-8-smadhavan@nvidia.com>
References: <20260709010304.680422-1-smadhavan@nvidia.com>
 <20260709010304.680422-8-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 01:24:07 +0000
Message-Id: <20260709012408.0B5401F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] CXL Reset scope validation is conditionally bypassed during actual=
 reset execution, creating a TOCTOU vulnerability that fails to protect sib=
lings.
--

--- Patch [7]: [PATCH v9 07/11] PCI/CXL: Discover the CXL reset scope ---
commit 363800e2ebd7dad78179683be8d0a027b5bd8a7e
Author: Srirangan Madhavan <smadhavan@nvidia.com>

PCI/CXL: Discover the CXL reset scope

This commit adds reset context support to validate that a CXL Reset is
function-scoped before advertising it as a PCI reset method. It uses the
Non-CXL Function Map, ARI/devfn rules, and CXL capability bits to reject
the reset if another same-scope function would be affected.

> diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
> index fb741b66e5022..cdfaa699583d2 100644
> --- a/drivers/cxl/core/reset.c
> +++ b/drivers/cxl/core/reset.c
[ ... ]
> @@ -890,6 +1037,7 @@ static int cxl_reset_execute(struct pci_dev *pdev, i=
nt dvsec)
>  int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  {
>  	struct cxl_hdm_range_context range_ctx;
> +	struct cxl_reset_context ctx;
>  	int dvsec;
>  	int rc;
> =20
> @@ -897,8 +1045,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool pr=
obe)
>  	if (dvsec < 0)
>  		return dvsec;
> =20
> +	cxl_reset_context_init(&ctx, pdev);
>  	if (probe)
> -		return 0;
> +		return cxl_reset_validate_function_scoped(&ctx);

[Severity: High]
Is it safe to conditionally bypass scope validation when probe is false?

During the early probe phase, when this is called from pci_init_capabilitie=
s()
for Function 0, higher-numbered sibling functions might not have been
enumerated and added to the bus list yet. As a result,
cxl_reset_validate_function_scoped() could find no siblings and incorrectly
report the reset as safe.

Later, when a user or driver actually triggers the reset and this function
is called with probe=3D0, it skips validation and executes the reset direct=
ly.
Could this inadvertently reset and destroy the state of active sibling
functions that were enumerated after the initial probe?

> =20
>  	cxl_hdm_range_context_init(&range_ctx);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709010304.6804=
22-1-smadhavan@nvidia.com?part=3D7
