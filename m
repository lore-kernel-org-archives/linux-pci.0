Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08724908B5
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635692; cv=none; b=FFLH72ooxqpJTNjhRkH/0ngZK3pASnftlnfF+B0E87O5B3IgBwUQKcaQztPjnN9riIqaPE+lkNZUTeJej8BfjtRpaWnXQF3GKluceKlDZXWWDCFNXG8TSQL5h/5KsLYnQrbm9FkKBz4Y7itEUY+ups8o17CcDmQcapuDHZ/xb9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635692; c=relaxed/simple;
	bh=bXVnmmmxE+/FQTBq8zjSkDDnDKPqyE78Rt8HYm1hIKw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S9vYpquX6VYPLezRjcxlLc61Wb3oN6ntFYr0PPw/sDYBkX5ho+Rno61KN5Tg20MVUxcxLyz7RzYain9PZw+Dk3ISa9ZspeovqO23SHXc5hUyBX+pJXLaFBxz22p5MTBYELrYB6hd7dXkqcwrcq5DMeIIpBYTvsSmzT8Wlffix+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6PRyY/y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6PRyY/y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619221F000E9;
	Thu, 13 Aug 2026 15:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786635671;
	bh=1EOL0nws38zhbgy886UbgKw4MK2PdX744Ky7ag4hnjg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c6PRyY/yZHO+4N9+Vl+Og+29qXOrmMz8fmR9Tc//Gk4lstxM6zr0Q07e9/PwGeTWX
	 vYc2pq+1dACmz0I1sHOWP1QdMYbCH1XBvUuNf1EyaCtzjzZhg9PHOwbXssBj1kCmLW
	 5XRzZHcKVUeFB01IW834HlWUTMLD63l2hBwivJuUGN2GYA4Fwji07KXy0qTcNYa2dH
	 iazZsosr0T+zJkKw9oHFZibSwkVE4NprOS0nrNYxrAP3Gi30hwUzfNeaZOb0oV1Wgf
	 gPSTcF7UUOy6zrnRESyGPbCfYVfJACGHBaTfhnLQrpyZ83bil3dnD2vBXQTHKkHxcr
	 zHehOuph+M8ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] xen/pcifront: Fix PCI device reference leak in AER
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ruoyu Wang" <ruoyuw560@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260813153138.3953222-1-ruoyuw560@gmail.com>
References: <20260813153138.3953222-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 15:41:10 +0000
Message-Id: <20260813154111.619221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Accessing `pcidev->dev.driver` and invoking driver AER callbacks w=
ithout holding `device_lock` risks a Use-After-Free due to concurrent drive=
r unbinding.
- [High] Unconditional invocation of optional AER callbacks (`mmio_enabled`=
, `slot_reset`, `resume`) without verifying they are implemented by the dri=
ver.
--

--- Patch [1]: [PATCH] xen/pcifront: Fix PCI device reference leak in AER h=
andling ---
commit 8d4be8a3c9e93de894d26cb69e9804d8f8ff8144
Author: Ruoyu Wang <ruoyuw560@gmail.com>

xen/pcifront: Fix PCI device reference leak in AER handling

This commit fixes a reference leak in pcifront_common_process by storing
the AER callback result, releasing the device reference, and then returning.
This keeps the device alive while its callback runs and balances the lookup
on every successful path.

> --- a/drivers/pci/xen-pcifront.c
> +++ b/drivers/pci/xen-pcifront.c

[ ... ]

> @@ -597,21 +598,25 @@ static pci_ers_result_t pcifront_common_process(int=
 cmd,
>  		pci_dbg(pcidev, "trying to call AER service\n");
>  		switch (cmd) {
>  		case XEN_PCI_OP_aer_detected:
> -			return pdrv->err_handler->error_detected(pcidev, state);
> +			result =3D pdrv->err_handler->error_detected(pcidev, state);
> +			break;

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to access the
driver pointer and invoke callbacks in this function without holding the
device lock?

The code earlier extracts the driver:

pcidev =3D pci_get_domain_bus_and_slot(domain, bus, devfn);
if (!pcidev || !pcidev->dev.driver) {
	...
}
pdrv =3D to_pci_driver(pcidev->dev.driver);

If a concurrent unbind occurs (for example, via sysfs), can the driver be
unbound and freed between the check for pcidev->dev.driver and the callback
invocation? Core PCI error recovery typically holds the device lock to prev=
ent
a use-after-free or NULL pointer dereference in this scenario.

>  		case XEN_PCI_OP_aer_mmio:
> -			return pdrv->err_handler->mmio_enabled(pcidev);
> +			result =3D pdrv->err_handler->mmio_enabled(pcidev);
> +			break;
>  		case XEN_PCI_OP_aer_slotreset:
> -			return pdrv->err_handler->slot_reset(pcidev);
> +			result =3D pdrv->err_handler->slot_reset(pcidev);
> +			break;

[Severity: High]
This is a pre-existing issue, but does this code assume all drivers
implement the optional AER callbacks?

The function checks if the error_detected callback is present before
entering the switch statement:

if (pdrv->err_handler && pdrv->err_handler->error_detected) {
	...
}

However, many PCI drivers do not implement mmio_enabled, slot_reset, or
resume. If the Xen backend forwards one of these events for a driver lacking
the specific callback, could invoking it here result in an immediate NULL
pointer dereference?

>  		case XEN_PCI_OP_aer_resume:
>  			pdrv->err_handler->resume(pcidev);
> -			return PCI_ERS_RESULT_NONE;
> +			break;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813153138.3953=
222-1-ruoyuw560@gmail.com?part=3D1
