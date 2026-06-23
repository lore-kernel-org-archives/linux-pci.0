Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EF17262E;
	Tue, 23 Jun 2026 03:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782186427; cv=none; b=KYHP2zmHx0NbAm0S69uw1y3lFlY9rZYdbYMVY2Xm77XIczfdFtyPawJAn7TI+UeYhF3heAZYOHg2lwHwTZ3DG9R09wLD2KFqAERTG7d5mMQ4t/Uww2gk/J8vN1Rp0f3Yg67Bmgl9PwRy5WOMOjnaR2I2/uswOvQlzTc/1SA9sHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782186427; c=relaxed/simple;
	bh=uXFEkhiFkyIhiaxeKGbM98jftPoTJ5aEgLLlChe+8z4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LlfoKjxippproCda3u/4mMcAR8sl1v05pQvddlvxprBV3WM3lziwiwEZuaATeT9kMKnZUjBuDgPt4F2Hz5//rHvPCsKKsQyo3JuFmRF39s0v2Wht88kAgH94xWgr2xR6qCyiLzFz6vdLomh9VsukBcyswefHlGbbdSSg534xb3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmMlm+QB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmMlm+QB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EF11F000E9;
	Tue, 23 Jun 2026 03:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782186426;
	bh=HgOxEWZFc0L1fno/gUzY+jtTzZ/jQaI8vS1B86qjAGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WmMlm+QBpPG95bte6g55kvn1H1FN2xum5LFLRhiHFH+6SbTxjBbNIRzM0hYAVqYnZ
	 fkhn3cbzIhX18jBKWdNCpqJ5KhVmODnWk9X6GdSxCQ58gLcxlyKzIPJctaEutbpgIT
	 F9/6PFRrg20cmMfbWVKE3jdzBenNnWiygol0Uz+tcre0+KtTKNHhnyLH05s2C58uX3
	 cE8+nMK22FBrvHvBpU4dYSue1ULdQNt8MTNeVgGeO5GjyichvKr1vMd11v6tEvQQLR
	 qLsoR4eXnhsHsMKstFnWbi8r/u+JDBhdLpNRWV9R14n3qpbUapuVOZ0VWTc4+Xp5hE
	 qxiCwI8Vfdg0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/11] PCI/cxl: Expose CXL Reset as a PCI reset
 method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260623032453.3404772-11-smadhavan@nvidia.com>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
 <20260623032453.3404772-11-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 03:47:05 +0000
Message-Id: <20260623034705.E1EF11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Accessing devres-managed `pdev->hdm` before holding sibling device=
 locks leads to a Time-of-Check-to-Time-of-Use (TOCTOU) Use-After-Free duri=
ng concurrent driver unbind or hot-unplug.
--

commit c1746289413d4e364b4a471be081d1821258af44
Author: Srirangan Madhavan <smadhavan@nvidia.com>

PCI/cxl: Expose CXL Reset as a PCI reset method
   =20
This commit adds the CXL Reset helper to the PCI reset-method table, allowi=
ng
userspace to select it via the reset_method ABI. It introduces checks to ve=
rify
that cached HDM decoder state is available for the target and mem-capable
siblings before executing the reset.

> diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
> index d801c91a5cbf8..694d8a3789a42 100644
> --- a/drivers/cxl/core/reset.c
> +++ b/drivers/cxl/core/reset.c
> @@ -1035,6 +1035,34 @@ static int cxl_reset_dvsec(struct pci_dev *pdev)
>  	return dvsec;
>  }
> =20
> +static bool cxl_reset_hdm_available(struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_info *info =3D READ_ONCE(pdev->hdm);
> +
> +	/*
> +	 * pdev->hdm is allocated with PCI-device devres. Reset requests
> +	 * operate on a live pci_dev, so the devres allocation remains valid
> +	 * for this check.
> +	 */
> +	return info && info->regs.hdm_decoder;

[Severity: High]
Does this assumption hold true during a concurrent driver unbind or hot-unp=
lug
event?

Devres is tied to the driver binding lifecycle, which is protected by the
device lock, not just a reference to the live pci_dev.

If a sibling device's driver is unbound concurrently, devres_release_all()
will free the info structure. Since READ_ONCE(pdev->hdm) could read a valid
pointer right before it is freed, couldn't the subsequent access to
info->regs.hdm_decoder result in a use-after-free?

[ ... ]

> @@ -1211,6 +1239,11 @@ int cxl_reset_function(struct pci_dev *pdev, bool =
probe)
>  	if (rc)
>  		goto out;
> =20
> +	if (!cxl_reset_scope_hdm_available(&ctx)) {
> +		rc =3D -ENOTTY;
> +		goto out;
> +	}
> +

[Severity: High]
Is it safe to call cxl_reset_scope_hdm_available() before holding the sibli=
ng
device locks?

Because the check iterates through siblings and accesses their devres-manag=
ed
pdev->hdm pointers without the device locks held, there appears to be a race
condition against concurrent unbinds.

Could moving cxl_reset_scope_hdm_available() to after cxl_pci_functions_loc=
k()
protect the devres structures from being freed during this check?

>  	rc =3D cxl_pci_functions_lock(&ctx);
>  	if (rc)
>  		goto out_unlock;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623032453.3404=
772-1-smadhavan@nvidia.com?part=3D10
