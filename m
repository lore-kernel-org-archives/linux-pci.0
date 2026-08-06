Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36244C9557
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 19:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786043984; cv=none; b=SXSOXPe2KckFCvNQAn7c39uHHDVzMllkwPyWO71bFLpk8Q/d0sXjPFwalVDV/puy85GS8JYfJeasJZzBQTz4qG11fRIoQOdcscy/mhdWspOc/+ACxlY0aACfnHizkxRmDqLo+hXyCDLWp8XciD2DKx6/jW2Zz9Ehv1O+f5+Q/dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786043984; c=relaxed/simple;
	bh=SkUj16wiUY3pP59gn/It9qTdt5AXgmMFLa52a3lsjZ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LGo7N+iF44KE3uMieiCqV+XehY1i65H0wYgkJo0M8dt3dwSyqw+P8JnsO3fo6/UNneVAyIex1VP6Fbuo7Ekf+fGT2zcGsaQhhZuUFBNUAurhKwua7ovf1OeGafnZcfkaJKo9WsaZlIP2D4e4gMFH71VaMnRl2ygqtbZ8jp6p7P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiZqrL92; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiZqrL92"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B691F000E9;
	Thu,  6 Aug 2026 19:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786043982;
	bh=n5/jPyDSx7Iqt27Ljx+BosXOlsCu8cmGg/iiK1SHgbU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QiZqrL9218hVzufUK04Mi90R6ej0NzOulWJyUFUg3AlRzwtU0J2r6GTvP3SYUisqz
	 D99qU7ziM6+UBe16OwqgRSDr5yy0vLUjPPPAulLdPwIErOw8m/XtpiPx0cWHaXB3Zh
	 DIhFJ+FxmOjcjy/ur5LncFT9KWx3t96Q4SmJpv9+1QpaYwUzKL9dVlcm6C6VfVux5o
	 875Xu57EusywrdvEKCrIxZcRUJXK7DQUa2MQRPdBUEimPjPSXsXOyqUooZ1+HAPZCD
	 +bIggdOEPfIomhQe3hVK12hrME/ewFWM7okXQ4B46JXqm2Nyfk6R2thwthD3r/6L9r
	 eVQrSD0Hspq/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] pci: quirks: Disable native PCIe hotplug on MSI Claw A8
 root bridge
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260806190439.12022-1-derekjohn.clark@gmail.com>
References: <20260806190439.12022-1-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 19:19:41 +0000
Message-Id: <20260806191942.39B691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The quirk disables native PCIe hotplug on the shared host bridge r=
ather than specifically for the target root port, which breaks hotplug func=
tionality for dynamically enumerated Thunderbolt/USB4 devices system-wide.
--

--- Patch [1]: [PATCH] pci: quirks: Disable native PCIe hotplug on MSI Claw=
 A8 root bridge ---
commit 841400e3b6d906dff0f94738835128127178d2e6
Author: Derek J. Clark <derekjohn.clark@gmail.com>

pci: quirks: Disable native PCIe hotplug on MSI Claw A8 root bridge

This commit adds a quirk for the MSI Claw A8 to prevent s2idle resume failu=
res
caused by the Realtek card reader. It disables native PCIe hotplug on the h=
ost
bridge when the specific root port is found.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c

[ ... ]

> +static void quirk_claw_a8_no_native_hotplug(struct pci_dev *pdev)
> +{
> +	struct pci_host_bridge *bridge;
> +
> +	if (!dmi_match(DMI_BOARD_NAME, "MS-1T8K"))
> +		return;
> +
> +	if (pdev->bus->number !=3D 0 ||
> +	    PCI_SLOT(pdev->devfn) !=3D 2 ||
> +	    PCI_FUNC(pdev->devfn) !=3D 2)
> +		return;
> +
> +	bridge =3D pci_find_host_bridge(pdev->bus);
> +	if (!bridge)
> +		return;
> +	dev_info(&pdev->dev, "disabling native PCIe hotplug\n");
> +	bridge->native_pcie_hotplug =3D false;

[Severity: High]
Does setting bridge->native_pcie_hotplug =3D false here break hotplug
functionality for dynamically enumerated Thunderbolt/USB4 devices on this
system?

Because the pci_host_bridge is a shared structure, modifying it globally
prevents the pciehp driver from claiming any hotplug-capable PCIe port under
that domain. While this might be the only fixed slot reporting HotPlug+ dur=
ing
boot, downstream ports on dynamically hot-plugged PCIe switches (like
Thunderbolt docks, eGPUs, or NVMe enclosures) rely on the host bridge's nat=
ive
hotplug capability to function.

Would it be safer to clear pdev->is_pciehp and pdev->is_hotplug_bridge on t=
he
specific root port instead of modifying the shared host bridge?

> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, 0x150b,
> +			 quirk_claw_a8_no_native_hotplug);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806190439.1202=
2-1-derekjohn.clark@gmail.com?part=3D1
