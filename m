Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4663446BC;
	Tue, 23 Jun 2026 03:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782186159; cv=none; b=C2Ts3u53zTONjHYvBsHFrkyXTu9Xa4AZ7xBK/A1WLO9iL3eKb8Njviu4jktGIl3A46mzG+igZuJthFIOlkM0zpv43YSbWB00v/c5qfnrs8XdALsOoh0OE/mq/5I5esAqe49rYqtpkEe6Mo6lCCv5h2pytVdUeCEiXcvJonf7j3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782186159; c=relaxed/simple;
	bh=ajV8VDXako+UsOq39sd17mFx07L5o2xu1qI8aIzxpvQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=spJsW2Nysx0tvb++Na6eh//HvVdOP/0k9YnaRmaUcbprcmGeB289v089Z+/tUz52O9D+1OWIvUbphIl3vXzeW9z/HOiwLM0Q/5d/Y+RSEHroom+0KisaUNgJaG7w2qxQeiS4YMcOB0K36NxI7zKGtlP6JfjdJL7snEjNeBABjqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOEL6PXA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOEL6PXA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F3F1F000E9;
	Tue, 23 Jun 2026 03:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782186158;
	bh=oHIUGnVFgp4XsFKXo015ISCkOJA9/IWsiJfoAElKtwk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TOEL6PXAKo9Ri9VMT3wg4xxmvjXTi9xr1wt2vJ3Sv5frEioLEmUfaRsHN7CezFg53
	 TvutNnbYadBnMv368hE/Hpmv8c2lTHLjbLm953+xPaLG87ARUkZU8RzP5k64al9Zjl
	 L2iYlR5QbqM7EtFd9kkSHJdX0YhvUjqCBFGCOKZEGCj3JacUluzUBNm3WApTm6N3b6
	 TH7tyDKFgl3S8Q1RwuWihNcG4iV0TZmTcAnm5gN18wZLqqUCUoM9GMdNQfs8WQFgZW
	 t/B+Zf/CA4I1EfXHuUoes6RhwxiGuQJoRFGtXuHRd7vwycU4AIErI3wLzsyW6bhkiG
	 x1YocE2ALXxAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/11] cxl: Coordinate sibling functions for CXL
 reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260623032453.3404772-9-smadhavan@nvidia.com>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
 <20260623032453.3404772-9-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 03:42:37 +0000
Message-Id: <20260623034237.C8F3F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] AB-BA deadlock between `device_lock` and `pci_bus_sem` during CXL =
reset
- [Low] Mixed usage of goto-based error handling and scope-based cleanup he=
lpers (`scoped_guard`)
--

commit e204e091df9c0890781be70b3733c1aeae326d91
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl: Coordinate sibling functions for CXL reset

CXL Device Reset affects all CXL.cache and CXL.mem functions in the reset
scope. Lock same-scope siblings with pci_dev_trylock(), save/disable them,
drain pending transactions, and hold IOMMU reset blocks until recovery.

> diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
> index 1ae714a3595cb..69bcfab898589 100644
> --- a/drivers/cxl/core/reset.c
> +++ b/drivers/cxl/core/reset.c

[ ... ]

> @@ -944,11 +1045,24 @@ int cxl_reset_function(struct pci_dev *pdev, bool =
probe)

[Severity: High]
Could this lead to an AB-BA deadlock between the device lock and pci_bus_se=
m?

When the PCI core invokes a device-specific reset method, it holds the
target device's lock (device_lock(&pdev->dev)). If cxl_reset_function()
subsequently calls cxl_reset_collect_siblings() which uses pci_walk_bus(),
that will attempt to acquire a read lock on pci_bus_sem.

The standard PCI lock acquisition order is pci_bus_sem followed by
device_lock (for example, in pcie_do_recovery()). This inversion could
create a deadlock if another thread (like hotplug) requests a write lock
on pci_bus_sem, queuing the read lock request and blocking all involved
threads.

>  	if (rc)
>  		goto out;
> =20
> +	rc =3D cxl_pci_functions_lock(&ctx);
> +	if (rc)
> +		goto out_unlock;
> +
> +	rc =3D cxl_pci_functions_reset_prepare(&ctx);
> +	if (rc)
> +		goto out_functions_done;
> +
>  	scoped_guard(rwsem_write, &cxl_rwsem.region) {
> -		rc =3D cxl_hdm_ranges_prepare(&range_ctx, pdev);
> +		rc =3D cxl_hdm_ranges_prepare(&range_ctx, &ctx);
>  		if (!rc)
>  			rc =3D cxl_reset_execute(pdev, dvsec);
>  	}
> +
> +out_functions_done:

[Severity: Low]
Does this mix goto-based error handling with scope-based cleanup helpers?

According to the cleanup guidelines, functions should not mix goto-based
cleanup labels (like out_functions_done) with scope-based helpers like
scoped_guard(). All resources needing a cleanup should either be converted
to scope-based cleanup, or none of them should use it.

> +	cxl_pci_functions_reset_done(&ctx);
> +out_unlock:
> +	cxl_pci_functions_unlock(&ctx);
>  out:
>  	cxl_hdm_range_context_destroy(&range_ctx);
>  	cxl_reset_context_destroy(&ctx);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623032453.3404=
772-1-smadhavan@nvidia.com?part=3D8
