Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC833433E9C;
	Thu,  2 Jul 2026 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783006244; cv=none; b=gfPcxsEos8ZxwFJY4PlA9k/ER65oz48LeHkkVWQOh374K89Z26NCgd/xJ6jQm+LwOde4A/h3S7hebLXlBHWZsau/9Ss2dELgUiVngfeJuXjbB5qR31kSSQBpmSkVzZYWDfgnz3xptZdnIovY/VnF+vMfyfihhhStttrrSSLVts8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783006244; c=relaxed/simple;
	bh=ad2zvgj0YM0RON5Mx1Su54fP6iKIEuLv5oALZdQToYU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L3gruDNh9M5MeRKwRwSKJ5Fkb+XFTnMhbiohCu7mIBBV6iwcJyoKnwIaZ0zUsw+hziI5YYrIlI/oyZH+SB6p7+fjQ7yV14VAH795/mM4uaQKZKlMm6LZzL4EqUQHI6bVzdwzxA0aBZEVL7V7BeyG6Rdx3H7kbUI4ZRAOOsMay48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Go+7xuWa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Go+7xuWa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B521F00A3A;
	Thu,  2 Jul 2026 15:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783006242;
	bh=7DbtlGSinQ1BlEhFU8F0jb/Dtm5yomTIBaX2zUh4fls=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Go+7xuWa+LGZBkEtVepRlG6lLzGtb2TgBY+S1srHi6oUgpMhK5mDYRuYo98jGKdur
	 WTPJj09hpIBx0POAX4WE0rLkBrxFpucW477n9eladsUFKv/sioAaQr0q4VeDY+oi3C
	 Fv23W5BaXqZDTGoO68Xcj+yqILFLjrewTPAZrcHbfoJOy1JmBoSGFb6/mBXpSN/5Ts
	 mMfy6tR75oHY6jVMgcFExXlZGXMlAqchg7u+xmKTZUdeS9IkihGk8DoYikWKFMk+hv
	 QKDW8el6xU4O6dzB2I61bzJhmS6UCEDOgVDqE5vmzCvBz4zMYEHUoNycsniOJqJ2qK
	 yNKh0mea2HczA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11] PCI: mediatek: Add support for EcoNet EN7528 SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Caleb James DeLisle" <cjd@cjdns.fr>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260702150704.265282-1-cjd@cjdns.fr>
References: <20260702150704.265282-1-cjd@cjdns.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:30:41 +0000
Message-Id: <20260702153042.49B521F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] PCIe link retraining is initiated after endpoint devices are regis=
tered, causing a race condition where drivers may probe while the link is d=
own.
- [Medium] Failure to retrain one PCIe root port aborts the retraining loop=
, preventing subsequent independent ports from being retrained.
- [Medium] Driver degrades functionality when built as a module due to miss=
ing EXPORT_SYMBOL for pcie_retrain_link().
--

commit d5f03f20dd1953eb7241e17dbd765b2b467f01c7
Author: Caleb James DeLisle <cjd@cjdns.fr>

PCI: mediatek: Add support for EcoNet EN7528 SoC

This adds support for the PCIe controller present on the EcoNet EN7528 and
EN751221 SoCs. These SoCs contain a mix of Gen1 and Gen2 ports, where Gen2
ports require retraining after startup.

> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/control=
ler/pcie-mediatek.c
> index 8b57c3d75b942..a60d1ae076f80 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c

[ ... ]

> @@ -756,6 +767,134 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie=
_port *port)
>  	return 0;
>  }
> =20
> +static int mtk_pcie_startup_port_en7528(struct mtk_pcie_port *port)
> +{

[ ... ]

> +	if (!IS_BUILTIN(CONFIG_PCIE_MEDIATEK))
> +		dev_info(pcie->dev,
> +			 "module not built-in, Gen2 unavailable even if supported\n");
> +
> +	return 0;
> +}
> +
> +/**
> + * mtk_pcie_retrain - retrain the root bridge link if needed
> + * @dev: The device, for use in logging
> + * @host: The host bridge which contains the link
> + *
> + * Due to what is likely a hardware bug, some devices (notably EcoNet) s=
tart up
> + * as Gen1, and must be retrained once after initial configuration in or=
der to
> + * reach Gen2.
> + *
> + * These devices always self-identify as Gen2 capable, but sometimes the=
 PHY is
> + * only capable of Gen1 operation, and sometimes the PCIe card (e.g. wif=
i) is
> + * only Gen1 capable. Therefore it is most convenient to retrain every p=
ort
> + * after startup.
> + */
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
> +	guard(rwsem_read)(&pci_bus_sem);
> +
> +	for_each_pci_bridge(rp, host->bus) {
> +		if (pci_pcie_type(rp) !=3D PCI_EXP_TYPE_ROOT_PORT)
> +			continue;
> +
> +#if IS_BUILTIN(CONFIG_PCIE_MEDIATEK)
> +		ret =3D pcie_retrain_link(rp, true);
> +#endif

[Severity: Medium]
Does skipping the pcie_retrain_link() call for module builds unintentionally
degrade functionality?

If this driver requires pcie_retrain_link() for Gen2 speeds, would it be
more appropriate to export pcie_retrain_link() in the PCI core instead of
guarding the call and silently falling back to Gen1 when compiled as a modu=
le?

> +
> +		if (ret)
> +			return dev_err_probe(&rp->dev, ret,
> +					     "failed to retrain port\n");

[Severity: Medium]
If pcie_retrain_link() fails on one root port, this early return will abort
the for_each_pci_bridge() iteration.

Will this prevent subsequent independent root ports from being retrained?

Could this use a continue statement instead to ensure remaining ports are
still processed?

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

> @@ -1169,6 +1308,13 @@ static int mtk_pcie_probe(struct platform_device *=
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

[Severity: High]
Since pci_host_probe() was already called, downstream endpoint devices are
already registered and their drivers might be concurrently executing their
probe routines.

Could mtk_pcie_retrain() drop the physical link while an endpoint driver is
performing MMIO reads or writes?

This concurrent access during link downtime could result in master aborts
(returning 0xFFFFFFFF) and cause driver initialization failures or system
crashes.=20

Is it possible to perform link retraining prior to registering the
downstream devices?

> +
>  	return 0;
> =20
>  put_resources:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702150704.2652=
82-1-cjd@cjdns.fr?part=3D1
