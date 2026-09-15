Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067AA3C13E5
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 03:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789441876; cv=none; b=dNw+GgK5WP0uEnhRRcIUptu28bv1OxWnr388qeLN++Xdi1d3wIrnQZ9/IoeqEV4WxSl6B2uF9kQ2oaitqOzZn4CcEio4jjtXpkOnvBDsjJuQ5A50B1jmIhRPP87GYmTFQvwKVfhb3imkQx5fG5LI1hCW8+pHtrLBpZpI7HULcLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789441876; c=relaxed/simple;
	bh=NDfoMeNfiyVSwdcn32cnBtErNw0H5ObRsK6l64h3cfU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h+N2W5/5veZzYKzITi+8YKoSW1xL/LrWDuWTHPYwVisJPZj9Gux7A0UYVkhLFqQMarVucMJilq6bWes4xp148FeS8Mi7flU6HKempWvXNwTp28KppS6SaTC/XLiQrde9icI/9hG4rh2YkbsO8zqEfT+Pjt3gSbmSc1Ahqca3Cis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxMhQV5J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxMhQV5J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49921F000FF;
	Tue, 15 Sep 2026 03:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789441874;
	bh=SGvad4aNbgnIv3y1BVpxzChZUwLNzX4omfUOYF9fhNY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RxMhQV5J5vRVWGuldBxivewc7B1J0LbmXQliV770Yzw2z4/2fttFuaAtP2Ih8xLsN
	 /zsR3yULQ5cC8WQlMZ5K6SqygiN7TNEkv2DkIJsfl8ybrxBRHgnwG+5lYtOXd0zP1R
	 +9698RCejHz+7FgzAzr4aoBPO1Lh7MerfK/7SQmrB4mLTLNvdDuKGAaXc+ANnf8K5o
	 8hIoWMa2JUyFH/kgjb97r29HVcUiHYXAJ4v+W9BJntQPpJbSPrsp/vniIFvvmwR3Ic
	 2Kg/LjcITi/1jgMmBhU+KO0DwIfCsPZBBiy8irkLD+57CPQejuAF2MRF1r7w8DWw1P
	 8iOEahCnChwwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: cadence: Store the core controller in platform
 drvdata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linmao Li" <lilinmao@kylinos.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260915030044.4019259-1-lilinmao@kylinos.cn>
References: <20260915030044.4019259-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 03:11:14 +0000
Message-Id: <20260915031114.A49921F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] pci: redundant devm_kzalloc of cdns_plat_pcie
--

commit 39b7fc87ca3505b497481f44dd0a65579dc50f60
Author: Linmao Li <lilinmao@kylinos.cn>

PCI: cadence: Store the core controller in platform drvdata

This commit updates cdns_plat_pcie_probe() to store the wrapped
struct cdns_pcie pointer directly in the platform drvdata. This prevents
suspend/resume callbacks from incorrectly casting the pointer and
reading beyond the wrapper structure.

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers=
/pci/controller/cadence/pcie-cadence-plat.c
> index 13edc6be21f59..7fef237cdbb74 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> @@ -55,7 +55,6 @@ static int cdns_plat_pcie_probe(struct platform_device =
*pdev)
>  	if (!cdns_plat_pcie)
>  		return -ENOMEM;

[Severity: Low]
Does this code leave behind a completely redundant memory allocation?

Since the patch changes the driver to store the inner pcie pointer directly
instead of the cdns_plat_pcie wrapper, the prior allocation of
struct cdns_plat_pcie appears to be completely unnecessary now.

> -	platform_set_drvdata(pdev, cdns_plat_pcie);
>  	if (is_rc) {
>  		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_PLAT_HOST))
>  			return -ENODEV;

[ ... ]

> @@ -114,6 +113,8 @@ static int cdns_plat_pcie_probe(struct platform_devic=
e *pdev)
>  			goto err_init;
>  	}
> =20
> +	platform_set_drvdata(pdev, cdns_plat_pcie->pcie);
> +

[Severity: Low]
Because only the internal pointer is saved here, does this permanently
orphan the allocated container structure from external access?

The cdns_plat_pcie structure is no longer exposed outside of the local
scope of cdns_plat_pcie_probe(), rendering the structure as dead code.

>  	return 0;
> =20
>   err_init:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915030044.4019=
259-1-lilinmao@kylinos.cn?part=3D1
