Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94711A23A6;
	Sun, 23 Aug 2026 01:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787448271; cv=none; b=L6nRj6OYcnXbaaQl6jQ3NfzxQklBHgKyQtItlLiIVt9KjvpVS9t0SBfVqEb9tDcBzZNps0B/ZkmOLZyUYEMdnpO2T/2/hwJ5e4NX4qz9Z75uZiDljGtZvailrtFoKkIGMwRM/FG37T1Zma09PAPAXSED5Q5nxVf8hXFLcfOAZrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787448271; c=relaxed/simple;
	bh=U6Z+vW/iw5RP9fz1uqyXryM+kUyvKCJG7RFw47bVFGw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bz+Pb34U/gEqMHUqqM3q63Zbom6v76E50MTPxenxxDOfkvaGxO+4dXJrJZOe8gnuurF+ueDVYabm5y63AnriPVlWo533/Qr4HnSqTD6O1Dgj5kE7x4bmEB/igBgCoaj1/2DZBVCPuoYYfWNn2a4VcFa8mOoSsJexO23BP7KLrSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mmd5Gvbz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mmd5Gvbz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8541F000E9;
	Sun, 23 Aug 2026 01:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787448269;
	bh=7x5/lGutLmwc6PS3x6Ag1vy751/Tuavykc+MKOSCE9g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mmd5GvbzCNzf+ZovqdhVHM9Hbp8XLAiokNfdKEbDbk244kCZMwVPc3D4bbK04emza
	 mqPjoFP4HDKvASyReRw5my1zSnP0SA+7Xn8nxusBLvIFDjmpNbUurp1EcTtXTj3nfP
	 5cGJVSfN7d0IGeXOSQacXf4N+QhSyqpMtqPF5wxrROGHo+1FexerKiSEkfEosV/jJ/
	 oue6mxrKRPvHo7PJlP9q8vRw4B13VB2EzerSEB9CyNWnXagM2tSGL3dCXsq9MRmxjF
	 9N+zc+deJwHjZu3aZusJPEP28mYB+PBAvRquv2q9orr3vU2nDB70yLeBExq/9OzVKB
	 VkvH49QLqzVBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: imx6: fix power domain leak on probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: hanzhijian <hanzhijian1991@gmail.com>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20260823011125.2876504-1-hanzhijian1991@gmail.com>
References: <20260823011125.2876504-1-hanzhijian1991@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 01:24:28 +0000
Message-Id: <20260823012429.2B8541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] LIFO order violations during error cleanup cause premature power d=
omain detachment.

Pre-existing issues:
- [High] Resource leak of power domain and device link on partial attach fa=
ilure.
- [High] Probe error path bypasses cleanup logic, leaking power domains and=
 pwrctrl devices.
--

--- Patch [1]: [PATCH] PCI: imx6: fix power domain leak on probe failure ---
commit 887e76ee860dcc87d2150e367092c569b216fc14
Author: hanzhijian <hanzhijian1991@gmail.com>

PCI: imx6: fix power domain leak on probe failure

This commit fixes a power domain leak in the i.MX6 PCIe driver by
introducing imx_pcie_detach_pd() and calling it in probe error paths.
It also saves the device links to properly release them during cleanup.

Link: https://lore.kernel.org/all/20260822013640.182C01F000E9@smtp.kernel.o=
rg/

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 39790e66b98dc..4df548679464c 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c

[ ... ]

> @@ -662,6 +665,7 @@ static int imx_pcie_attach_pd(struct device *dev)
>  		dev_err(dev, "Failed to add device_link to pcie pd\n");
>  		return -EINVAL;
>  	}
> +	imx_pcie->pd_link =3D link;
> =20
>  	imx_pcie->pd_pcie_phy =3D dev_pm_domain_attach_by_name(dev, "pcie_phy");
>  	if (IS_ERR(imx_pcie->pd_pcie_phy))
>  		return PTR_ERR(imx_pcie->pd_pcie_phy);

[Severity: High]
This is a pre-existing issue, but if dev_pm_domain_attach_by_name() fails
here, does it leak the previously attached "pcie" power domain and its
device link?

Because the function returns directly without cleaning up the earlier
attach, these resources might be permanently leaked on every probe deferral.

Furthermore, the function leaves an ERR_PTR in imx_pcie->pd_pcie_phy,
which would cause a crash if a cleanup path ever attempted to use
imx_pcie_detach_pd() to handle this partial failure.

> @@ -675,10 +679,24 @@ static int imx_pcie_attach_pd(struct device *dev)
>  		dev_err(dev, "Failed to add device_link to pcie_phy pd\n");
>  		return -EINVAL;
>  	}
> +	imx_pcie->pd_phy_link =3D link;
> =20
>  	return 0;
>  }
> =20
> +static void imx_pcie_detach_pd(struct imx_pcie *imx_pcie)
> +{
> +	if (imx_pcie->pd_link)
> +		device_link_del(imx_pcie->pd_link);
> +	if (imx_pcie->pd_pcie)
> +		dev_pm_domain_detach(imx_pcie->pd_pcie, true);
> +
> +	if (imx_pcie->pd_phy_link)
> +		device_link_del(imx_pcie->pd_phy_link);
> +	if (imx_pcie->pd_pcie_phy)
> +		dev_pm_domain_detach(imx_pcie->pd_pcie_phy, true);
> +}

[Severity: High]
Does imx_pcie_detach_pd() detach the power domains in the wrong order?

The power domains are attached in FIFO order ("pcie", then "pcie_phy") in
imx_pcie_attach_pd(). However, they are also detached in FIFO order here.

Should the "pcie_phy" domain and link be detached before the "pcie" domain
to properly follow reverse initialization (LIFO) order?

[ ... ]

> @@ -1999,6 +2019,7 @@ static int imx_pcie_probe(struct platform_device *p=
dev)
>  	return 0;
> =20
>  err_pwrctrl_destroy:

[Severity: High]
This is a pre-existing issue, but does the probe error path for PM runtime
enablement bypass this cleanup logic?

Looking at imx_pcie_probe() earlier in the function:

drivers/pci/controller/dwc/pci-imx6.c:imx_pcie_probe() {
    ...
	if (imx_pcie->drvdata->flags & IMX_PCIE_FLAG_PM_RUNTIME) {
		pm_runtime_no_callbacks(dev);
		ret =3D devm_pm_runtime_set_active_enabled(dev);
		if (ret < 0)
			return ret;
	}
    ...
}

If devm_pm_runtime_set_active_enabled() fails, it returns directly. Because
it completely bypasses the err_pwrctrl_destroy label, doesn't it permanently
leak the power domains and pwrctrl devices initialized earlier in the probe?

> +	imx_pcie_detach_pd(imx_pcie);
>  	if (ret !=3D -EPROBE_DEFER)
>  		pci_pwrctrl_destroy_devices(dev);
>  	return ret;

[Severity: High]
Does detaching the power domains before destroying the pwrctrl devices
violate LIFO cleanup order?

If a failure occurs after pci_pwrctrl_create_devices() succeeds, this calls
imx_pcie_detach_pd() to cut power before pci_pwrctrl_destroy_devices() has
a chance to unregister the devices.=20

Could this cause the driver remove() callbacks to attempt to access
unpowered PCI registers and trigger a hardware hang or kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823011125.2876=
504-1-hanzhijian1991@gmail.com?part=3D1
