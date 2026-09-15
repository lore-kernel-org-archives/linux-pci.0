Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0625E3D4132;
	Tue, 15 Sep 2026 03:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442461; cv=none; b=VsPdt8e+Kx8xVpzWP+aBGCEvGB58hl75rkTyo+wxC3VC0YZ5i7x2jeYdKkXdPKN7htOkskytZm1MxzR1g4pyZa6SIHM2iPrODyKLcwp/3fxW+UujTWgUCOGWzeqyEPctXUoJt5t4AP9cEHVv/i4PeCivHguW3rqqUXafjj8277Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442461; c=relaxed/simple;
	bh=GAoAhpS01iAPFC3UHmQNWFocCD62+dinYfH9PVt7MXk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GYJB+gYFEkhzePNVhB2fJMjBYRQuctmhCW8ZwtiFX0f1gh5+we9jGpv3k25sGPtd+tMczebXKmS/VAlCjz8Ji5axfHB6DQZ6QOdqmTTt/B9h3xD4Qr+0mAejtFKhOCfkHBk4igQvQh0fYuMaUWjIyVy0Vfq91iUF+bn1jaLwJB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6Zz2h+o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6Zz2h+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CC61F000FF;
	Tue, 15 Sep 2026 03:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789442459;
	bh=2H+RUJNwqO6cELIpDUoWNZngIWJ4CY9ThbKwLIoMKMg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M6Zz2h+oUC4fd6DJM4i8SGAt9uUXkIqjhXc2HZ0YjeqWyPgG9VlfiE+oV0rI0cp2a
	 OQtVJoTNezYRoaemVkW4/sACh6DkcHGXen0yIOvrE6f2b4PuPgEwQJri73pEs4CPzw
	 HQzR85YT0u/pW+dCgvc5/YtXsMRTo9kgHRjzDO4rqHZvfpfgnEE69bvMN5SYBhUabY
	 9Ipb0FFfd4rAUx5d6gnHiQK24Dvc+joRii/x3WskTm/bjlJksBr3X0Mq1Z4nWQxue3
	 1KgvE4+m2i2g1K+qM2qzW5hMQbaayiBOosWY9X1eTHm1aKBVaCOyBkpKBHEMmqxWch
	 mIRyvv83X9J4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] misc: tc9564: introduce base PCI driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260915031038.1087264-3-elder@riscstar.com>
References: <20260915031038.1087264-1-elder@riscstar.com>
 <20260915031038.1087264-3-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 03:20:58 +0000
Message-Id: <20260915032059.60CC61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] misc: missing of_platform_depopulate() on probe error path
- [Low] kconfig: unused REGMAP_MMIO selection in TC9564_PCI
--

commit 526cbf40d582cb34a1f4613745e5ca7890f929d2
Author: Alex Elder <elder@riscstar.com>

misc: tc9564: introduce base PCI driver

This commit introduces a base PCI driver for the Toshiba TC9564 SoC, which
implements a PCIe switch and Ethernet AVB/TSN bridge. It performs basic PCI
initialization and uses of_platform_default_populate() to scan and probe
child devices defined in the devicetree.

> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 7364931dad3a1..91950d2928f07 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -568,6 +568,16 @@ config MCHP_LAN966X_PCI
>  	    - lan966x-miim (MDIO_MSCC_MIIM)
>  	    - lan966x-switch (LAN966X_SWITCH)
> =20
> +config TC9564_PCI
> +	tristate "Toshiba TC9564 PCI function support"
> +	depends on PCI
> +	select REGMAP_MMIO

[Severity: Low]
Is the REGMAP_MMIO selection required for this driver?

Looking at drivers/misc/tc9564-pci.c, it does not seem to include
linux/regmap.h or use any regmap APIs. Could this lead to unnecessary
kernel bloat if the regmap infrastructure isn't selected by other
configurations?

[ ... ]
> diff --git a/drivers/misc/tc9564-pci.c b/drivers/misc/tc9564-pci.c
> new file mode 100644
> index 0000000000000..d7ebbd90d1584
> --- /dev/null
> +++ b/drivers/misc/tc9564-pci.c
[ ... ]
> +static int
> +tc9564_function_probe(struct pci_dev *pdev, const struct pci_device_id *=
id)
> +{
[ ... ]
> +	/* Scan for pci-ep-bus nodes and probe their sub-devices */
> +	ret =3D of_platform_default_populate(np, NULL, dev);
> +	if (ret)
> +		goto err_clear_master;
> +
> +	return 0;
> +
> +err_clear_master:
> +	pci_clear_master(pdev);
> +
> +	return dev_err_probe(dev, ret, "failed to populate platform bus\n");
> +}

[Severity: High]
Does this error path need to call of_platform_depopulate() before returning?

When of_platform_default_populate() fails midway, it leaves any successfully
created child platform devices registered and sets the OF_POPULATED_BUS fla=
g.
If we only call pci_clear_master() and return an error here, devres will
subsequently disable the PCI device completely via pcim_disable_device().

Since the orphaned child devices remain bound to their drivers, any later
attempt by those drivers to perform MMIO accesses on the disabled PCI
device could result in PCIe Unsupported Requests (UR), which can trigger a
fatal SError/MCE on many architectures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915031038.1087=
264-1-elder@riscstar.com?part=3D2
