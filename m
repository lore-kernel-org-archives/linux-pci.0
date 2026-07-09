Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5923408622;
	Thu,  9 Jul 2026 10:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783593330; cv=none; b=jEEwcTqfB4v6qvNY3rVIqWA/qZ+Bukj65RZXYjIPsHG9UC95cd9oE7SBdJIFvm0kl4EKB1tnFQFVxHBsjv7cpOFVbP+fqt2p6OHvt8VQvbxpQS8E/1J6udVNvrF6gQCU/yvWlnooJTyVT4OzoP06RBAayo20ms4/1C3G9vruZck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783593330; c=relaxed/simple;
	bh=YPQidFbDFsuyMuWgwlD3+ATfb87UHzE+JFppldkJSNA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JQOBxKNdyEctNcl29xw3dWZRWQSqJ1bnHPyzemf/HWMTEePRtPv7OcGsf46Bj9jvMkojHyAqcwwP2Ns6X8mUZQnIZHYdK4lHO8EN+gTqSPQRd031U/CSaQsUVFAGtVE4tJ/1ZYYnGh8eRNNMDi9+x897iz4HSkPnzk561/EgZEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3ec1n95; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3ec1n95"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140011F000E9;
	Thu,  9 Jul 2026 10:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783593328;
	bh=ZQldwSQ0luo+iMtkiKAxc9iZ0M0boIyg68R2WpQGlTw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d3ec1n95CbDqZyAoPbMpuq5nXIJMp6NHtOkPLFvXB9l0uO2so98LrJ/PbudiQsdQF
	 SAiRjNvkwt6FISAfXV0DDpTQ2BCAKH15RbcSn6a3R242d/JfRNh2+oZTsgnG+e3UDv
	 8qIN7dZ0jkcDWC69gXT64R17aXUbuqZjvKVdTkFv/OJ18N8uxpFlJCGIV+gt4Rep/n
	 viUB5iIWySXPdB9UBQgOVHH2n25YubleEt7k/gNRnqfv2E6E4FK0SYC+8Ekx4/VOBQ
	 h9arywX1jkO9yD4j6RL9ex6pII1h9+/UcHEgEHcUOfpxXd5AfQ/G6vJF4wyhmpN1kd
	 nkKcJcO3/SPjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 1/4] PCI: imx6: Move pci_pwrctrl_create_devices() to
 imx_pcie_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U2hlcnJ5IFN1biAoT1NTKQ==?= <sherry.sun@oss.nxp.com>
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260709101555.3034853-2-sherry.sun@oss.nxp.com>
References: <20260709101555.3034853-1-sherry.sun@oss.nxp.com>
 <20260709101555.3034853-2-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 10:35:27 +0000
Message-Id: <20260709103528.140011F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] In Endpoint (EP) mode, `imx_add_pcie_ep()` ignores the return valu=
e of `imx_pcie_host_init()` and fails to clean up on error, leading to a ke=
rnel panic.
- [High] Missing PM domain detach and device link deletion in `imx_pcie_pro=
be()` error paths causes permanent probe failure on `-EPROBE_DEFER`.
--

--- Patch [1]: [PATCH V5 1/4] PCI: imx6: Move pci_pwrctrl_create_devices() =
to imx_pcie_probe() ---
commit c4ce7635410a21f29d4b7bcc43f48a82e9c31e5b
Author: Sherry Sun <sherry.sun@nxp.com>

PCI: imx6: Move pci_pwrctrl_create_devices() to imx_pcie_probe()

This commit moves pci_pwrctrl_create_devices() from imx_pcie_host_init()
to imx_pcie_probe(). This ensures the power control devices are created
only once during probe, avoiding duplicate creation across suspend and
resume cycles.

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index f55a68f60eea9..92f8e4a299e88 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c

[ ... ]

> @@ -1954,11 +1945,15 @@ static int imx_pcie_probe(struct platform_device =
*pdev)
>  	if (ret)
>  		return ret;
> =20
> +	ret =3D pci_pwrctrl_create_devices(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to create pwrctrl devices\n");
> +
>  	pci->use_parent_dt_ranges =3D true;
>  	if (imx_pcie->drvdata->mode =3D=3D DW_PCIE_EP_TYPE) {
>  		ret =3D imx_add_pcie_ep(imx_pcie, pdev);

[Severity: High]
This is a pre-existing issue, but does imx_add_pcie_ep() need to check the
return value of imx_pcie_host_init()?

If imx_pcie_host_init() fails (for example, returning -EPROBE_DEFER) and
powers down the hardware, imx_add_pcie_ep() completely ignores this and
continues execution:

imx_add_pcie_ep()
    imx_pcie_host_init(pp); /* Return value ignored */
    ep =3D &pci->ep;
    ...
    ret =3D dw_pcie_ep_init(ep); /* Writes to hardware registers */

Writing to unclocked or unpowered peripheral registers on i.MX causes an
asynchronous external abort (System Error / Data Abort). Could this result
in an immediate kernel panic during boot if imx_pcie_host_init() fails?

>  		if (ret < 0)
> -			return ret;
> +			goto err_pwrctrl_destroy;

[ ... ]

> @@ -1985,6 +1980,11 @@ static int imx_pcie_probe(struct platform_device *=
pdev)
>  	}
> =20
>  	return 0;
> +
> +err_pwrctrl_destroy:
> +	if (ret !=3D -EPROBE_DEFER)
> +		pci_pwrctrl_destroy_devices(dev);
> +	return ret;

[Severity: High]
This is a pre-existing issue, but does this error path also need to detach
the PM domains and delete device links?

Earlier in imx_pcie_probe(), imx_pcie_attach_pd() dynamically allocates
virtual PM domain devices and creates stateless device links. If the probe
fails and jumps here (for instance, if pci_pwrctrl_create_devices() or
imx_add_pcie_ep() returns -EPROBE_DEFER), these virtual devices and device
links are not cleaned up.

On the next probe attempt, dev_pm_domain_attach_by_name() attempts to
register a new virtual device with the exact same name, which causes a
sysfs/kobject naming collision.

Could this missing cleanup cause device_register() to fail with -EEXIST,
permanently preventing the PCIe controller from probing if it defers once
during boot?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709101555.3034=
853-1-sherry.sun@oss.nxp.com?part=3D1
