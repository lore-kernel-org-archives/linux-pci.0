Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1909E43DEC7;
	Tue, 15 Sep 2026 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789496549; cv=none; b=Rq+sF8YOQd/PM3mUFLkyO1Wu1djMIXbP4S8Sr1f46ojqOv9PhgLSlx5UpmhMXRGch6nuySiM6oruaMQKAyCk759ofOgf2GzD60m/tZFvS4jRlW5wub3xTfRfydjMFwyAmnx+pANhGuyaTHumUIr7LJaCaUiu3csFo5c3i+wvGKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789496549; c=relaxed/simple;
	bh=FIXzWIE5cEPw/zi9R+DH21ymNUaIt6Y9Z1or4DT7ZIU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NmtbSxh0NLyVoOFhzZGm0sx1iWxKltI6cNa8x/6+zZdfJps8OQUlGaVWv3lxufMPzGYzirz85WC/T1aPOHExDdgCqpPW1hW2N5J4HMF5ZNpR0fb5G5LnsoFNasHBVvnxa9GTGL+UyWiO08HaF23WHSJlcWf9rQiY63emcW5aDLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eurr619W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eurr619W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53281F000FF;
	Tue, 15 Sep 2026 18:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789496548;
	bh=MxZ0PwGMC9JYVDw3X/JXfK/Q/hjn17rSSWaU/klIAlw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Eurr619WGdMwFO+s42GpcUSC+g8Dww3r16qYKkUb8gjK4e4qrUv138uAjo/eHVyCG
	 WQQpATB761lrewexxYJv5Pfc99xMRxBGwOeqqlBJv3QtHLKMW4YpUqcBXb/xmSMWUR
	 KKQKFOmcVtbyHnBGY+U0O0MTbtDnBo9khDxGvKfeDC40RFe4+ZQRQM7f8XuQV+lGE2
	 Gkl/04uy2RgqTTw8gHxJm0Zg1gtLusTrDr7lRABrhUAdPZClR+tvDNlyZYjkf6M6ol
	 Ywdf3OTs8iVIolz3hfxBUWzHTJbjucWc6+X7pXEUmjkdXx7CVABTC2AsuorZ3+l3bb
	 UgRBsH9GPyYZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] misc: tc9564: introduce base PCI driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260915181003.1633543-3-elder@riscstar.com>
References: <20260915181003.1633543-1-elder@riscstar.com>
 <20260915181003.1633543-3-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 18:22:27 +0000
Message-Id: <20260915182227.A53281F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tc9564: missing Kconfig dependencies on OF and PCI_DYNAMIC_OF_NO=
DES
--

commit e821d4f3b3a6f26cf2df684fa3788ceb3794a058
Author: Alex Elder <elder@riscstar.com>
Subject: misc: tc9564: introduce base PCI driver

This commit introduces a base PCI driver for the Toshiba TC9564 SoC. It bin=
ds
with embedded PCIe endpoint functions within the chip to perform basic PCI
initialization. The driver then uses Open Firmware APIs to populate and pro=
be
endpoint bus children.

> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -568,6 +568,15 @@ config MCHP_LAN966X_PCI
>  	    - lan966x-miim (MDIO_MSCC_MIIM)
>  	    - lan966x-switch (LAN966X_SWITCH)
> =20
> +config TC9564_PCI
> +	tristate "Toshiba TC9564 PCI function support"
> +	depends on PCI

[Severity: Medium]
Should this configuration also depend on OF and PCI_DYNAMIC_OF_NODES?

Because the driver relies entirely on Open Firmware to function, compiling
it without CONFIG_OF or CONFIG_PCI_DYNAMIC_OF_NODES will result in a
successful build but an unconditional runtime probe failure.

[ ... ]

> diff --git a/drivers/misc/tc9564-pci.c b/drivers/misc/tc9564-pci.c
> --- /dev/null
> +++ b/drivers/misc/tc9564-pci.c
> @@ -0,0 +1,84 @@
[ ... ]
> +static int
> +tc9564_function_probe(struct pci_dev *pdev, const struct pci_device_id *=
id)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *np;
> +	int ret;
> +
> +	/* Despite being a PCI device, we require devicetree */
> +	np =3D dev_of_node(dev);
> +	if (!np)
> +		return dev_err_probe(dev, -EINVAL, "no devicetree node\n");

[Severity: Medium]
Will this probe fail unconditionally if the required dependencies are missi=
ng?

If CONFIG_OF is disabled, dev_of_node() will always return NULL, causing
dev_err_probe() to trigger here.

Similarly, this commit relies on of_pci_make_dev_node() via a PCI quirk to
dynamically create the devicetree node for the PCIe function. If
CONFIG_PCI_DYNAMIC_OF_NODES is disabled, of_pci_make_dev_node() compiles
to an empty stub, meaning the node is never created.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915181003.1633=
543-1-elder@riscstar.com?part=3D2
