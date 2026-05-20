Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0C83546C6;
	Wed, 20 May 2026 19:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307088; cv=none; b=UjptcC49YPWRKzTK8Kc1ZNOixJCTnMBrYT5crKnUA2yWs9M3E4H2l7ahk8FOXAsrycVtBO7+yX6KLfA9Th6eCiUJOeG6gVc8EBH/4t8ZQ37csdrm/l5KjE3kkJfvmqO4aN7gu0sIGDEUAEF+j6p7/DHkvTUFPJOZzpRBTdR5bWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307088; c=relaxed/simple;
	bh=LnCgVsSog/RePlvNEz5hW6AflVhww4QcAKkTWCDiTCo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bcX+Mz3elvIh6MMjqCKnC93prA2hL7fUUjgGLKfDrRtG18mH68l9s/TmcDboPLw/2lsYGvTD9LWzDqmkt9SFbfg3I2XTu3zWuyANDHmzGyNB2ZYNuCoMfD8NRKowu84bG6hEUFhlIcT5AG8bgK5eqofK6gG7Vf90+r1FK7MbYqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EA5aIBsC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EA5aIBsC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4726A1F000E9;
	Wed, 20 May 2026 19:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779307086;
	bh=u/G55Pcu45bwHkBEVJ1hiBQqzf/8UxRbPrFh0DZqerk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EA5aIBsC5w3jlFdpegQAwn+LUrVvCX0WsRvg+GUaRsqc2DSLX9JiRmO9vCopliQo6
	 lenjN/7dIfxkgoPvCIc1WKc1GFqKtYHj6aTH90QSrPKTCxnYTuIGaJP696AfD8jQr8
	 BWPSaAYpnrQ3gqtH4WFCuMeR3umfFYfvgM3XQrsvOUVJ54KVDS0hv73y/FT2tTMelJ
	 GBoiyy7WjRGptfHnFEB2WyOuHrvldiM8kmuhMPzss6a9wxaopInUekhmv6jYXaaM+d
	 uY/KHixnrb87+Iulyoj2r9puTAAKEenqSPh0yhn7O4iU6mbYF416tvtbnFuVXUkefB
	 czF7OKzgSYbeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/3] PCI: mediatek: Add support for EcoNet EN7528 SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Caleb James DeLisle" <cjd@cjdns.fr>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260520183827.908243-4-cjd@cjdns.fr>
References: <20260520183827.908243-4-cjd@cjdns.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 19:58:05 +0000
Message-Id: <20260520195806.4726A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Link retraining is performed after device enumeration and driver b=
inding, causing a severe race condition.
- [High] Iterating the PCI bus devices list without holding the pci_bus_sem=
 read lock.
- [Medium] Early return in mtk_pcie_retrain() aborts retraining of all rema=
ining root ports if a single port fails.

Pre-existing issues:
- [High] Freeing port in error paths causes a Use-After-Free because the ac=
tive IRQ domain's host_data still points to it.
--

commit c1c3bb9bcba6bb8a070037578912a2f02c381591
Author: Caleb James DeLisle <cjd@cjdns.fr>
Subject: PCI: mediatek: Add support for EcoNet EN7528 SoC

This commit adds support for the PCIe controller present on the EcoNet
EN7528 (and EN751221) SoCs. These SoCs feature a mix of Gen1 and Gen2 ports,
and require a manual link retraining after startup for Gen2 ports to functi=
on.

> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/control=
ler/pcie-mediatek.c
> index c503fbd774d09..4e4d4b1559f71 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c

[ ... ]

> @@ -755,6 +766,132 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie=
_port *port)
>  	return 0;
>  }
> =20
> +static int mtk_pcie_startup_port_en7528(struct mtk_pcie_port *port)
> +{

[ ... ]

> +	/* 100ms timeout value should be enough for Gen1/2 training */
> +	err =3D regmap_read_poll_timeout(pcie->cfg, EN7528_LINKUP_REG, val,
> +				       !!(val & link_mask), 20,
> +				       PCI_PM_D3COLD_WAIT * USEC_PER_MSEC);
> +	if (err) {
> +		dev_err(pcie->dev, "EN7528: port%d link timeout\n", port->slot);
> +		return -ETIMEDOUT;
> +	}

[Severity: High]
This is a pre-existing issue, but returning an error here can cause a
use-after-free crash.

When a port fails to start up (for example, if the slot is empty and link
training times out), the caller frees the port structure by calling
mtk_pcie_port_free(). However, mtk_pcie_port_free() does not call
irq_domain_remove().

Since mtk_pcie_init_irq_domain() sets the newly allocated port structure
as the IRQ domain's host_data, the domain remains registered with a
dangling pointer.

Could we make sure the IRQ domain is properly cleaned up in error paths?

[ ... ]

> +static int mtk_pcie_retrain(struct device *dev, struct pci_host_bridge *=
host)
> +{
> +	struct pci_dev *rp;
> +	int ret =3D -ENOENT;
> +	u16 lnksta =3D 0;
> +	u32 speed;
> +
> +	/* Should already have been warned about during startup_port */
> +	if (!IS_BUILTIN(CONFIG_PCIE_MEDIATEK))
> +		return 0;
> +
> +	for_each_pci_bridge(rp, host->bus) {

[Severity: High]
Does iterating the PCI bus devices list here require holding the pci_bus_sem
read lock?

Since mtk_pcie_retrain() is called after pci_host_probe() completes, the PCI
bus is live and devices are exposed to the system. Concurrent operations li=
ke
sysfs hotplug events could modify the host->bus->devices list during traver=
sal.

Should we hold down_read(&pci_bus_sem) or use pci_walk_bus() to avoid a race
condition?

> +		if (pci_pcie_type(rp) !=3D PCI_EXP_TYPE_ROOT_PORT)
> +			continue;
> +
> +#if IS_BUILTIN(CONFIG_PCIE_MEDIATEK)
> +		ret =3D pcie_retrain_link(rp, true);
> +#endif
> +
> +		if (ret)
> +			return dev_err_probe(&rp->dev, ret,
> +					     "failed to retrain port\n");

[Severity: Medium]
Will this early return abort the retraining process for all remaining root
ports?

If pcie_retrain_link() fails on the first port, we immediately break out of
the loop.

Should this log the error and use continue instead, so that a failure on one
independent slot does not prevent the others from retraining successfully?

> +
> +		pcie_capability_read_word(rp, PCI_EXP_LNKSTA, &lnksta);
> +		speed =3D lnksta & PCI_EXP_LNKSTA_CLS;
> +
> +		pci_info(rp, "link retrained, speed %s\n",
> +			 pci_speed_string(pcie_link_speed[speed]));
> +
> +	}
> +
> +	return 0;
> +}

[ ... ]

> @@ -1159,6 +1296,13 @@ static int mtk_pcie_probe(struct platform_device *=
pdev)
>  	if (err)
>  		goto put_resources;
> =20
> +	/*
> +	 * Ignore error because pci_host_probe() was already called, and in any
> +	 * case it is possible that the port will still work as Gen1.
> +	 */
> +	if (pcie->soc->quirks & MTK_PCIE_RETRAIN)
> +		mtk_pcie_retrain(dev, host);
> +

[Severity: High]
Can retraining the link at this stage cause issues with actively bound endp=
oint
drivers?

By the time pci_host_probe() returns, devices have already been discovered,
exposed to the system, and their drivers bound. Retraining the PCIe link fo=
rces
it into recovery, which could stall transactions or temporarily drop the li=
nk.

If an endpoint driver (like NVMe or Wi-Fi) is actively performing MMIO or D=
MA,
could this cause unhandled exceptions, AER errors, or initialization failur=
es?

Would it be safer to retrain before devices are added to the system (e.g.,
before pci_bus_add_devices())?

>  	return 0;
> =20
>  put_resources:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520183827.9082=
43-1-cjd@cjdns.fr?part=3D3
