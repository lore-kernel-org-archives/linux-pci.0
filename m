Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C047D23E342
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 20:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778271697; cv=none; b=cyJon0U2uzLNhtN+/fKOWck61RrGJai7Il5URTwxa1yGhzXB+2784d1jTCaeOsRLq2IALGm6Nq2fNNaYr60ML0PEem/x0NxVErj3CqPfSI1DOTJYaXfvZf+IMbT22LZk+By0gk9YP/1Kjiv9ntKlFBLtlgu1qFA25FvG3qLA/8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778271697; c=relaxed/simple;
	bh=NT6ZuQOSvGO4+lVLZUt9jy1lQXelaCUrt9EGcKiMItg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L9FZ5jOoypwzzyUD7RV1Yct/oXEllbXihSTLpQB5nubUHs+qmKaMoY549017znjCUmsYTaJnYVvkCo7ZdPbPcaN49Dhyp10vOz0QXZL+nLDVFdx2aVbPNW6/OLlkLs+xDXYO1sMs5qcDlO6oeOq+ZnedRzGzDVPCWWelKcjjXOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4BGIswb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4BGIswb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849F4C2BCB0;
	Fri,  8 May 2026 20:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778271697;
	bh=NT6ZuQOSvGO4+lVLZUt9jy1lQXelaCUrt9EGcKiMItg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=O4BGIswbWFafNz0ydvurbNqGVRrAqD4WFNZo1OelCjTflAoQnceKpZxsJ3iUzz/oE
	 bpJvWiOUF+r87OiF2QEOmmtQ5BvWmohQdCmTBMQlXOXYkWbyL+J806X0ybEeup95hs
	 SqKqT31Uh7a/gIcZYOCRsCMKdEhyuIKJOQoCNeKZ8zqyh0hCKy4rYpPnaOxAq4KfmR
	 o0uSH+dJbVwndVPCjVWs13SrxJElgxzxTZda73En1zAQS8rl1bBN7HL4ewyHVJEL+M
	 lpbNLDRnKRS3ONcEJ4H19zukrOyQ8XxKMT3wIAFV3JbOkWgJoODO4FboGHvwd80+qh
	 rNBPyXqH9cHhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] usb: cdnsp: Add support for device-only
 configuration
Reply-To: sashiko@lists.linux.dev
To: "Pawel Laszczak via B4 Relay" <devnull+pawell.cadence.com@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260508-no_drd_config-v3-1-0614f5044721@cadence.com>
References: <20260508-no_drd_config-v3-1-0614f5044721@cadence.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 20:21:36 +0000
Message-Id: <20260508202137.849F4C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The function `cdns_drd_host_on()` returns an uninitialized variabl=
e `ret` when `cdns->no_drd` is true.
- [High] Use-after-free and double-free in `cdnsp_pci_probe()` error path.
- [High] Concurrent probing of paired PCI functions leads to a NULL pointer=
 dereference.
- [High] Partial unbind of PCI functions leaves the platform device running=
 with disabled MMIO regions.
--

commit b3f808c677ea7f7e8a40cfd26c7b60a0f4d50887
Author: Pawel Laszczak <pawell@cadence.com>

usb: cdnsp: Add support for device-only configuration
   =20
This patch introduces support for the Cadence USBSSP (cdnsp) controller in
hardware configurations where the Dual-Role Device (DRD) register block is
not implemented or is inaccessible.

> diff --git a/drivers/usb/cdns3/cdnsp-pci.c b/drivers/usb/cdns3/cdnsp-pci.c
> index 432007cfe6954..992700479172f 100644
> --- a/drivers/usb/cdns3/cdnsp-pci.c
> +++ b/drivers/usb/cdns3/cdnsp-pci.c
[ ... ]
> @@ -93,7 +103,7 @@ static int cdnsp_pci_probe(struct pci_dev *pdev,
> =20
>  	pci_set_master(pdev);
> =20
> -	if (pci_is_enabled(func)) {
> +	if (func && pci_is_enabled(func)) {
>  		wrap =3D pci_get_drvdata(func);

This wasn't introduced by this patch, but does this code have a race condit=
ion
during concurrent probing?=20

If both PCI functions are probed simultaneously (e.g., via sysfs bind), both
threads could see pci_is_enabled(func) as true before either has called
pci_set_drvdata().=20

This would cause pci_get_drvdata() to return NULL, leading to an immediate
NULL pointer dereference when accessing wrap->dev_res.

>  	} else {
>  		wrap =3D kzalloc_obj(*wrap);
[ ... ]
> @@ -158,6 +181,7 @@ static int cdnsp_pci_probe(struct pci_dev *pdev,
>  		plat_info.dma_mask =3D pdev->dma_mask;
>  		plat_info.data =3D &pdata;
>  		plat_info.size_data =3D sizeof(pdata);
> +		plat_info.properties =3D wrap->prop;
>  		wrap->devfn =3D pdev->devfn;
>  		/* register platform device */
>  		wrap->plat_dev =3D platform_device_register_full(&plat_info);
>  		if (IS_ERR(wrap->plat_dev)) {
>  			ret =3D PTR_ERR(wrap->plat_dev);
>  			kfree(wrap);

This wasn't introduced by this patch, but is it safe to unconditionally call
kfree(wrap) here if we're probing the second PCI function?=20

Since the wrap structure was allocated and set as drvdata by the first
function, freeing it here could destroy the shared structure while the first
function is still actively bound and relying on its drvdata.

When the first function is eventually unbound, cdnsp_pci_remove() would
retrieve this dangling pointer, dereference it, and free it again.

>  			goto put_pci;
>  		}
>  	}
[ ... ]
> @@ -185,13 +209,17 @@ static void cdnsp_pci_remove(struct pci_dev *pdev)
>  	if (wrap->devfn =3D=3D pdev->devfn)
>  		platform_device_unregister(wrap->plat_dev);

This wasn't introduced by this patch, but what happens if a user manually
unbinds the PCI function that didn't trigger the platform device registrati=
on?

It looks like the platform device would remain registered and active since
wrap->devfn !=3D pdev->devfn, but the underlying PCI MMIO resources for this
function would be abruptly disabled. Could this cause a fatal bus fault on
subsequent accesses by the platform child drivers to the disabled BARs?

> -	if (!pci_is_enabled(func))
> +	if (!func || !pci_is_enabled(func))
>  		kfree(wrap);
> =20
>  	pci_dev_put(func);
>  }
[ ... ]
> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> index 84fb38a5723a3..f87cf85cb97a1 100644
> --- a/drivers/usb/cdns3/drd.c
> +++ b/drivers/usb/cdns3/drd.c
[ ... ]
> @@ -181,6 +184,9 @@ int cdns_drd_host_on(struct cdns *cdns)
>  	u32 val, ready_bit;
>  	int ret;
> =20
> +	if (cdns->no_drd)
> +		goto phy_set;
> +
>  	/* Enable host mode. */
>  	writel(OTGCMD_HOST_BUS_REQ | OTGCMD_OTG_DIS,
>  	       &cdns->otg_regs->cmd);
> @@ -197,6 +203,7 @@ int cdns_drd_host_on(struct cdns *cdns)
>  	if (ret)
>  		dev_err(cdns->dev, "timeout waiting for xhci_ready\n");
> =20
> +phy_set:
>  	phy_set_mode(cdns->usb2_phy, PHY_MODE_USB_HOST);
>  	phy_set_mode(cdns->usb3_phy, PHY_MODE_USB_HOST);
>  	return ret;

If cdns->no_drd is true, we jump directly to phy_set, skipping the hardware
polling loop that assigns a value to ret.=20

Does this cause the function to return uninitialized stack garbage in ret?

Callers checking for a non-zero return value might abort the host
initialization unexpectedly.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508-no_drd_con=
fig-v3-1-0614f5044721@cadence.com?part=3D1
