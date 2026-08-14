Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2730A2853E9;
	Fri, 14 Aug 2026 01:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786672769; cv=none; b=Fq6AjKl6JLVJhqXU30ZruBmAv3PsScY4JoNUFMZw1DnNqqqdwlx5rCgs6+cm/azMRwjB4cRevzEscwuDqHVU8GDgkrMLvKsku5k6BrkzPaCX6KE4o+8AgtELwYei4FP9vS/+oCLAwAHbPjUPX0jG/dsv08lPPvypWKZrBpMwwrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786672769; c=relaxed/simple;
	bh=Je8TltdyHE6kx9O3zZX0hkzdsDD12JppP/O6xIbCuAU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nsMaoUVVUVZx7sPn7NIEmI8FWUlpPsZ+pgL2T9YJwrjtxgr9Gm+7y1FTmzUpl8HWIGatMWES9/eO4MPS6Kw0b/jWBW8+iuuDT5JoYvF1JURryGtJ/rDm73GfFSak/2A3xmY/De20VU01bkao0qHlrLHoacoOllRo9NJHlR8teRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnl3drbd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnl3drbd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7E21F000E9;
	Fri, 14 Aug 2026 01:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786672767;
	bh=jNJjg0cra7hzFp1KgjtYRWvHJjPYAOwD+hVOb6V5C0w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dnl3drbd8nwGTgVKj4jnLxNd63AnBlK+irat6NzPZk6WcXI85SR9K0A/k12JogSjb
	 IdDuTIqdruzq+vNk+w3YlRq67ldPi0oDY+TL1Ysf4jjM9PmZr/zq8Y6Rn2wO7wD3Ex
	 TiBrNM8GC6lfu2JjwPo4S1+E88EFRWXIUGwXhkgpsdxJRiYN2GkdEWCKgh6EBOh+Ny
	 04QNZfTijMTdnU0MpvDZ1PjteQ1SaJ1a1UDG3pVSz+V1/Q/PpgGiIrRYPgQQoVbbnN
	 xY+8KtVVxDNv+AXybW7qUMjVbm5/OvmL7+3bzlz4Op0vIUd2TunVlpWiIG4IAPlP2e
	 l+yiGjS5EMhyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] misc: tc9564: introduce base PCI driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260813222943.1655453-3-elder@riscstar.com>
References: <20260813222943.1655453-1-elder@riscstar.com>
 <20260813222943.1655453-3-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:59:23 +0000
Message-Id: <20260814015923.8E7E21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing PCI IRQ vector allocation prevents MSI/MSI-X usage for hig=
h-speed child devices.
--

--- Patch [2]: [PATCH 2/2] misc: tc9564: introduce base PCI driver ---
commit e66bfe4041c21f48829a22eb54cde73756806870
Author: Alex Elder <elder@riscstar.com>
misc: tc9564: introduce base PCI driver

This commit introduces a base PCI driver for the Toshiba TC9564 SoC which
implements a PCIe switch and Ethernet AVB/TSN bridge. The driver binds to t=
he
embedded PCI endpoint functions, performs basic PCI initialization, and uses
devicetree to populate any endpoint bus children.

[ ... ]

> diff --git a/drivers/misc/tc9564-pci.c b/drivers/misc/tc9564-pci.c
> new file mode 100644
> index 0000000000000..d3ffcac1c522f
> --- /dev/null
> +++ b/drivers/misc/tc9564-pci.c

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
> +
> +	ret =3D pcim_enable_device(pdev);
> +	if (ret)
> +		return ret;
> +
> +	pci_set_master(pdev);
> +
> +	/* Scan for pci-ep-bus nodes and probe their sub-devices */

[Severity: High]
Does this setup sequence omit PCI IRQ vector allocation?=20

Without calling pci_alloc_irq_vectors() in tc9564_function_probe() before
populating the child devices, the Linux PCI core won't configure the device=
's
MSI/MSI-X capabilities with host addresses and data payloads.=20

Since child platform drivers cannot safely allocate PCI IRQ vectors on beha=
lf
of their parent PCI device, will the high-speed child devices (like the 10G=
bps
Ethernet XGMACs) be forced to share a single legacy INTx interrupt, or fail
entirely if the host platform does not support legacy PCI interrupts?

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

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813222943.1655=
453-1-elder@riscstar.com?part=3D2
