Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9863BED01
	for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726019; cv=none; b=ugm9f1TVCKwi3gEbpDZiWrOokEvxKHr+27BuBOdA3EXtAV+twoRccjaWbmhq033rBwNKdKbuoX4w8/Is9JXCrxzu9b1O3fOoQ+pxMQLH48VwgPCy6edIulOBJJspr69CTe2gppwDcn1Wg2e44ynGSjKdm+P74atHmnWyuMzhSws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726019; c=relaxed/simple;
	bh=stNRQvnmkmP4tX2Qb6gjOYU977qet+HVLnJmbqA4AUU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JobYIG1ePuYeOQmAZg7EpJvIeIIfeeSBdukb8y0sHtwXnFm8ty/KSnu0nYPdC+71VbgRyT3AqZIJyp95oN4y3aOJ2b7LhnQz1HcCuzl+Ne+9yGzkQ53bprV1yFvlDOF1c4xajupI7X7Vi4zavEsohC6NoiVhpbDYyuRYlfPAAKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkI66eyi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkI66eyi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AFF1F000E9;
	Mon, 29 Jun 2026 09:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782726017;
	bh=+chqLQCG2+e4IV20N9xNxHl2zCm4R02oVHTVxXPFcSY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EkI66eyiVbUsp4M1N7EABrDLdSvezD12kJOWRG3T571lxekByoUj4lSokSWTb9+qP
	 AV6wWW3sfHWquLadgzzEGC7VSrlvOYgfosWAl1/9GBsJpkYTlK60AwEnyKqbZg87mJ
	 BBtX2A/uYnW4Nrvc1fqu4UjXrAYHct6MK6TU1B+fOuCcVrCJ1Vq9BtWv0HbqGftRb8
	 kYMMwxusOHs+eLQszlgNu7t1657euN9xTvZRKsPkqVdmyAoa5dvv9sQ2b7FBWfRIKa
	 pcHhFUShzyCdKxq7zQuU4CpuMTE9szJR4VgXtFvFE8A2sPUHgZK+2q7kxtOcQF/vKQ
	 Mbb7ZBcdGXMfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] perf/dwc_pcie: Convert to faux device interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yicong Yang" <yang.yicong@picoheart.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260629092717.74946-4-yang.yicong@picoheart.com>
References: <20260629092717.74946-1-yang.yicong@picoheart.com>
 <20260629092717.74946-4-yang.yicong@picoheart.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 09:40:16 +0000
Message-Id: <20260629094017.28AFF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless modifications to `dwc_pcie_dev_info_head` corrupt the glo=
bal list during concurrent PCI hotplug events.
- [High] Returning NOTIFY_BAD halts the notifier chain and breaks subsystem=
s.
- [High] Premature CPU hotplug registration crashes the kernel via a NULL p=
ointer dereference.
--

commit 699b6522ae4c9d70c5bdeb799d79993149c02386
Author: Yicong Yang <yang.yicong@picoheart.com>

perf/dwc_pcie: Convert to faux device interface

The DWC PCIe PMU makes use of the platform device interface but
is not the real device, it's actually the RAS DES capability of
the root port. It's more appropriate to use the lightweight
faux framework to abstract this, it'll be more simple and no
need for the complete device and drivers model. So convert to
the faux device interface.

> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index 7ec8302d4090b..3a9965b5abf4b 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -684,31 +691,41 @@ static u16 dwc_pcie_des_cap(struct pci_dev *pdev)
> =20
>  static void dwc_pcie_unregister_dev(struct dwc_pcie_dev_info *dev_info)
>  {
> -	platform_device_unregister(dev_info->plat_dev);
> +	faux_device_destroy(dev_info->fdev);
>  	list_del(&dev_info->dev_node);
> +	kfree(dev_info->name);
>  	kfree(dev_info);
>  }
> =20
>  static int dwc_pcie_register_dev(struct pci_dev *pdev)
>  {
> -	struct platform_device *plat_dev;
>  	struct dwc_pcie_dev_info *dev_info;
> +	struct faux_device *fdev;
> +	char *name;
>  	u32 sbdf;
> =20
>  	sbdf =3D (pci_domain_nr(pdev->bus) << 16) | PCI_DEVID(pdev->bus->number=
, pdev->devfn);
> -	plat_dev =3D platform_device_register_simple("dwc_pcie_pmu", sbdf, NULL=
, 0);
> -	if (IS_ERR(plat_dev))
> -		return PTR_ERR(plat_dev);
> +	name =3D kasprintf(GFP_KERNEL, "dwc_pcie_pmu_%x", sbdf);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	fdev =3D faux_device_create(name, &pdev->dev, &dwc_pcie_faux_ops);
> +	if (!fdev) {
> +		kfree(name);
> +		return -ENODEV;
> +	}
> =20
>  	dev_info =3D kzalloc_obj(*dev_info);
>  	if (!dev_info) {
> -		platform_device_unregister(plat_dev);
> +		faux_device_destroy(fdev);
> +		kfree(name);
>  		return -ENOMEM;
>  	}
> =20
> -	/* Cache platform device to handle pci device hotplug */
> -	dev_info->plat_dev =3D plat_dev;
> +	/* Cache faux device to handle pci device hotplug */
> +	dev_info->fdev =3D fdev;
>  	dev_info->pdev =3D pdev;
> +	dev_info->name =3D name;
>  	list_add(&dev_info->dev_node, &dwc_pcie_dev_info_head);

[Severity: High]
This isn't a bug introduced by this patch, but does this list modification
need synchronization?

Concurrent PCI hotplug events can invoke the bus notifier, which calls
dwc_pcie_register_dev() or dwc_pcie_unregister_dev(). This results in
list_add() or list_del() on dwc_pcie_dev_info_head without any locking,
which can cause list corruption and lead to an infinite loop or kernel pani=
c.

[Severity: High]
This is a pre-existing issue, but if dwc_pcie_register_dev() fails
during the BUS_NOTIFY_ADD_DEVICE event:

drivers/perf/dwc_pcie_pmu.c:dwc_pcie_pmu_notifier() {
    ...
    case BUS_NOTIFY_ADD_DEVICE:
        if (dwc_pcie_register_dev(pdev))
            return NOTIFY_BAD;
    ...
}

Does returning NOTIFY_BAD here halt the notifier chain?

If an allocation fails in dwc_pcie_register_dev(), returning NOTIFY_BAD
aborts the bus notifier chain. This can silently break other subsystems
like the IOMMU that rely on BUS_NOTIFY_ADD_DEVICE.

[ ... ]

> @@ -811,7 +820,7 @@ static int dwc_pcie_pmu_probe(struct platform_device =
*plat_dev)
>  	}
> =20
>  	/* Unwind when platform driver removes */
> -	ret =3D devm_add_action_or_reset(&plat_dev->dev,
> +	ret =3D devm_add_action_or_reset(&fdev->dev,
>  				       dwc_pcie_pmu_remove_cpuhp_instance,
>  				       &pcie_pmu->cpuhp_node);
>  	if (ret)

[Severity: High]
This is a pre-existing issue, but can this cause a NULL pointer dereference
if a CPU offline event happens during probe?

In dwc_pcie_pmu_probe(), cpuhp_state_add_instance() is called right before
this point, and perf_pmu_register() is called afterward. If a CPU offline
event occurs in that window:

drivers/perf/dwc_pcie_pmu.c:dwc_pcie_pmu_offline_cpu() {
    ...
    perf_pmu_migrate_context(&pcie_pmu->pmu, cpu, target);
    ...
}

Because perf_pmu_register() hasn't been called yet, pmu->cpu_pmu_context is
not yet allocated. Does this cause perf_pmu_migrate_context() to dereference
a NULL cpu_pmu_context?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629092717.7494=
6-1-yang.yicong@picoheart.com?part=3D3
