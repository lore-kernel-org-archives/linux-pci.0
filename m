Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4653E7BBD
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 09:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783501433; cv=none; b=n8P+cDBGiqJr6n+oRmPjYkv7LGCk31uz5Fvq66oY55JUU9oEwfACfngeP+6rpmg+wO1sB1gUUqbUwrqfI3uiduM2LPpfe2+pn3OqmnsM31jDl+VXTMckA7H87jVnzMqWuzgEXhJrzoViw7KGsWByesf4RTGxcht6ptHu9gJ14gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783501433; c=relaxed/simple;
	bh=uGE0ASDvXm6iLOEgvsMKO6wo8QP4A4IpedaflAm0ngc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F3LuDt6ZA8/7I7U0PaWfzyuTeSTwPsk0RZV3XEz45O4va55ZsYlSNJG692liuDhFuk0o9ZersPWWRVIDAWehpPO4VEXkfjBfKQZshxj4ND+EqAlCKBaKHutEzdNzwFPzF/IpEPJcLARyHDVJSVCYAnNZr0vgyNh8b8kbWSiIB5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=he+4jvCh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="he+4jvCh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB341F000E9;
	Wed,  8 Jul 2026 09:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783501432;
	bh=fUsCiYULA8P1Hy6BUDHG193Xc8aLHGVmQEQkxuoYCDU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=he+4jvChtwnn0N1WXxgsvX3pfhOkanyhmZVcHIdz22M2lxZ2EZZkY987g2r7mdJFR
	 5OaiNDOW6ssvgzn3LZvOs9O4fH6KyNy2Hb7XMuAlyEMV68xDPsgsMW4OYUoxBOPKh9
	 DbDDIxQbzYAhX0bWk+ptiNLMWAeNHhEfFFq2N+6Fo9XfzL0FVEFUI9lllFdGAEVPjH
	 jLdSEPAJ136jl2UO1nkZCIqg437VBe5/PDAUc6oWY0qAWJKKeBP9lMvEK9v9J505i1
	 atmEY2QDu2Gvv+CvluIpy935ltpPbQ58LF9AQXeRbjwqZhIfZDICcGiDRWSdRXo6DJ
	 zi+jBbBHAcS7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] perf/dwc_pcie: Convert to faux device interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yicong Yang" <yang.yicong@picoheart.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260708084507.98242-4-yang.yicong@picoheart.com>
References: <20260708084507.98242-1-yang.yicong@picoheart.com>
 <20260708084507.98242-4-yang.yicong@picoheart.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 09:03:52 +0000
Message-Id: <20260708090352.7FB341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unprotected concurrent access and modification of the global list =
`dwc_pcie_dev_info_head`, leading to list corruption during PCI device hotp=
lug.
- [High] Missing PM Runtime Management before PCIe config space accesses.
- [Medium] TOCTOU window between iterating existing devices and registering=
 the bus notifier allows missed hotplug events.
--

--- Patch [3]: [PATCH v3 3/4] perf/dwc_pcie: Convert to faux device interfa=
ce ---
commit f158e1644b202fefbbe3ae998c84159858150d0e
Author: Yicong Yang <yang.yicong@picoheart.com>

perf/dwc_pcie: Convert to faux device interface

This patch converts the DWC PCIe PMU from using the platform device
interface to the lightweight faux device framework. It also moves the
cpuhp state registration prior to faux device creation.

> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index f5f3e5b83f5bc..7b4ee71b966b0 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c

[ ... ]

> @@ -686,31 +693,41 @@ static u16 dwc_pcie_des_cap(struct pci_dev *pdev)
> =20
>  static void dwc_pcie_unregister_dev(struct dwc_pcie_dev_info *dev_info)
>  {
> -	platform_device_unregister(dev_info->plat_dev);
> +	faux_device_destroy(dev_info->fdev);
>  	list_del(&dev_info->dev_node);

[Severity: High]
This is a pre-existing issue, but is it safe to modify dwc_pcie_dev_info_he=
ad
without a lock here?

Since dwc_pcie_pmu_notifier() executes concurrently for different root ports
on PCI hotplug events, modifying this global list via list_del() and list_a=
dd()
without synchronization primitives could lead to list corruption and panics.

> +	kfree(dev_info->name);
>  	kfree(dev_info);
>  }

[ ... ]

> -static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
> +static int dwc_pcie_pmu_probe(struct faux_device *fdev)
>  {
> -	struct pci_dev *pdev;
> +	struct pci_dev *pdev =3D to_pci_dev(fdev->dev.parent);

[ ... ]

>  	vsec =3D dwc_pcie_des_cap(pdev);
>  	if (!vsec)
>  		return -ENODEV;

[Severity: High]
This isn't a bug introduced by this patch, but does the hardware access in
dwc_pcie_des_cap() and other event callbacks have sufficient PM runtime
protection?

If the device is dynamically suspended (D3hot), accessing the configuration
space without holding a PM runtime reference could return corrupted data
or trigger an asynchronous bus fault.

[ ... ]

> @@ -895,6 +899,15 @@ static int __init dwc_pcie_pmu_init(void)
>  	struct pci_dev *pdev =3D NULL;
>  	int ret;

[ ... ]

> -	ret =3D bus_register_notifier(&pci_bus_type, &dwc_pcie_pmu_nb);
> -	if (ret)
> -		goto err_unregister_driver;
> +	ret =3D bus_register_notifier(&pci_bus_type, &dwc_pcie_pmu_nb);
> +	if (ret)
> +		goto err_cleanup;
>  	notify =3D true;

[Severity: Medium]
This is a pre-existing issue, but could this sequence miss hotplug events?

By iterating existing PCI devices before registering the bus notifier,
any device added or removed in the tiny window between the loop's end
and the notifier activation could be missed.

If a removal is missed, it would permanently leak the PMU structure and
the pci_dev reference.

> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708084507.9824=
2-1-yang.yicong@picoheart.com?part=3D3
