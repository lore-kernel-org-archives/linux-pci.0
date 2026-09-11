Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4088E1DC198
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789170432; cv=none; b=iHfLWZnpKcXV0O56ZKEfqR70MgJ20YuiVvQ/qYK6QDDTLpeSslnmUWkMer33ogNXX5qgpPK8z1Ms0KZoSZJb9V1/E5AQJAlrL5HqyNN+8xuAOzz+JMyA4aO9PZCWylvFat+KFfUTo7l5Qr1sXXyKpoI9344mT9tloW+7NX5Iz5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789170432; c=relaxed/simple;
	bh=mh/2dsYXV3AsuIzFKriSJuupJDtW5F6zkBWsYdBm7xo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qUQtIKAyHq2ZW/59OGlBTZRBXIJVf5Hh92kTrndcgtZHZ8z+HDETkhpAcNx4IGymOzDNUkaIpUnfAMMFxpi1Fhj5J4IiuPAP9D045gLfTnNUsqoelrSC5p9+1Wbt/m89f06QkhQtuqTJbTLjCdctk5gB82wNSlRt+f5KF4a36PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NS40+4h8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NS40+4h8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F286F1F000FF;
	Fri, 11 Sep 2026 23:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789170423;
	bh=+tl71FnzymQEJIfT5W1lQrR/GCSmEgUdLEPvkYeuA/4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NS40+4h8vatvo6FVU+mX+VU4MbqMeP1iHNGDcKY27dcVTjTqtKgih92IfpNROl9At
	 TWVVsPD5HLS8XIUjlx/iFM99nxb2vaZYzBhX5WW18uEyCjA+083oZyUh1uyuCLWPvz
	 fY9xaN4YnXjgn78+Ao+opxqQ5DlJ63AUoKR1Pd4mgfzadEwDtNhvRtqxiV6JM2Yutg
	 aQ0po7CDe46yfdlBblKSK7LpW5BXVk27nOQEh4EHu2LJEngI0UMdlE6yCJ+v+6ItII
	 k6CG00yp/Fc8poFaKdXXkOrvUSb+lX2LX5S0B1LcbNPysAOS7Z51P9SqtPh2EjqLdF
	 DGPm20clRbO2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/13] PCI: brcmstb: Declare and assign quirk
 32BIT_PCI_OPS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Quinlan" <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260911233541.1650895-8-james.quinlan@broadcom.com>
References: <20260911233541.1650895-1-james.quinlan@broadcom.com>
 <20260911233541.1650895-8-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 23:47:02 +0000
Message-Id: <20260911234702.F286F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional teardown in brcm_pcie_remove on pci_host_probe failu=
re causes UAF or NULL pointer dereference.
--

commit d3ea9196e71b4fdf62dbbe06f00b5b226f406396
Author: Jim Quinlan <james.quinlan@broadcom.com>

PCI: brcmstb: Declare and assign quirk 32BIT_PCI_OPS
   =20
Declare a new quirk that indicates SoCs where the config-space accesses are
restricted to 32bit R/W.

> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controll=
er/pcie-brcmstb.c
> index 8927d1d97f4a8..be414d3468555 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c

[ ... ]

> @@ -2180,8 +2182,8 @@ static int brcm_pcie_probe(struct platform_device *=
pdev)
>  		}
>  	}
> =20
> -	bridge->ops =3D pcie->cfg->soc_base =3D=3D BCM7425 ?
> -				&brcm7425_pcie_ops : &brcm_pcie_ops;
> +	bridge->ops =3D BQUIRK(pcie, 32BIT_PCI_OPS)
> +		? &brcm_pcie_ops32 : &brcm_pcie_ops;
>  	bridge->sysdata =3D pcie;
> =20
>  	platform_set_drvdata(pdev, pcie);

[Severity: High]
This isn't a bug introduced by this patch, but does this probe error path h=
ave
a use-after-free?

Right after the modified code in brcm_pcie_probe(), we have this error path:

	ret =3D pci_host_probe(bridge);
	if (!ret && !brcm_pcie_link_up(pcie))
		ret =3D -ENODEV;

	if (ret) {
		brcm_pcie_remove(pdev);
		return ret;
	}

If pci_host_probe() returns an error, it has already cleaned up and freed
bridge->bus.

When we then call brcm_pcie_remove(pdev), it unconditionally accesses the
freed pointer:

	pci_lock_rescan_remove();
	pci_stop_root_bus(bridge->bus);
	pci_remove_root_bus(bridge->bus);
	pci_unlock_rescan_remove();

Can this cause a kernel panic on device probe failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911233541.1650=
895-1-james.quinlan@broadcom.com?part=3D7
