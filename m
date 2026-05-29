Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A660133B97B
	for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068737; cv=none; b=cMpZwHOlQJ5tAF61k9WgZNbKFaBgNva9Ou3F78csv2Vmx72zAJ7cMKU4LRNwJZ9EsX/TixeQOZnMSlrqPQcotKkUazCturZHCP20HPGQ2RhTaJllA/JdbSPNw9eYj7FOHBgcXfbHUkxzhpF5SQjPs9XdHlyigWp0B/Tk5/A5NWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068737; c=relaxed/simple;
	bh=GVIf9vN3bJC4BXs/25y+sbAgjgE1CCsidT8P8ZILemA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F5GX9QPOvbeWOwQBq1M/PD0ZnbVaxNd7H7AXPODuZCtWOV3DapXTwzBz9gdwVbnd7v8Szi+MuBXvfVLtB6gp9f6518y1BOBb6Vl0GnfHg8h4XMiWycZUbZ/dYoy5GP/o+HEBd7svivyuU2PxLPjJC0m9tmxRMgtjZ44BVOWTPSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9cb10HG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9cb10HG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD1E1F00899;
	Fri, 29 May 2026 15:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780068736;
	bh=NmIgcTcztvOBGgp6tnTUFe+lHaHCiiIPQykhW2PUqXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d9cb10HG9IPRAR8n2CIWhYHxof67ljPyVZ/rTgo1DdPNywhWHML/8Cx2NdbtCctQ6
	 qO5R8/1jOjJuZCvXwiwImpElGkRH8YnGRiVdTQiBc82CAw+o45CgvuewLPpSqqLx/F
	 /YXp8O6zuh74boOaKJIKaBb46K7JXg2bw9jAcSGMBBaVPEerCQ3vicKYOrR517Ja4z
	 oLa3i9mhjNzK4fSpaIjH6i1vVxUayNgkA/fthlGMWJnuUBlTdBaVTE6wtShoxrVH/K
	 0PsRabI4UtMBHsZMdXLpSlFB/OHtMDoPv+tQyTQXQBJ7DsZ1sXOwuahjX16Y/uQyoQ
	 rlHSl8kggLaYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/6] iommu/amd: Fail probe on ATS configuration
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260529111208.387412-7-praan@google.com>
References: <20260529111208.387412-7-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 15:32:15 +0000
Message-Id: <20260529153216.2AD1E1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Critical] Unconditional iommu_ignore_device() on probe failure breaks IR=
Q remapping in PD_MODE_NONE.
- [High] Failing IOMMU probe on optional ATS configuration failure causes d=
evice breakage and leaves a dangling MSI domain.
- [Low] Redundant double invocation of iommu_ignore_device() on iommu_init_=
device() failure.

Pre-existing issues:
- [High] iommu_ignore_device() fails to clear DTEs for PCI aliases due to i=
ncorrect operation ordering.
- [High] Unprotected, non-atomic memset() on the hardware-accessed dev_tabl=
e array.
--

commit e469ff12f2f6dc9d49a92308828b4812fa6c58ef
Author: Pranjal Shrivastava <praan@google.com>

iommu/amd: Fail probe on ATS configuration failure

The patch updates the AMD IOMMU driver to fail device probe if ATS
configuration (pci_prepare_ats) fails. It also adds a WARN_ON for
pci_enable_ats failure and unconditionally calls iommu_ignore_device
on all probe failures to fix a use-after-free risk.

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 84cad43dc188c..b74c4504bee39 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2502,10 +2508,22 @@ static struct iommu_device *amd_iommu_probe_devic=
e(struct device *dev)
>  	else
>  		dev_data->max_irqs =3D MAX_IRQS_PER_TABLE_512;
> =20
> -	if (dev_is_pci(dev))
> -		pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
> +	if (dev_is_pci(dev)) {
> +		struct pci_dev *pdev =3D to_pci_dev(dev);
> +
> +		if (pci_ats_supported(pdev)) {
> +			ret =3D pci_prepare_ats(pdev, PAGE_SHIFT);
> +			if (ret) {
> +				iommu_dev =3D ERR_PTR(ret);
> +				goto out_err;

[Severity: High]
Does this error path leave a dangling MSI domain?

Since ATS is an optional PCIe performance enhancement, failing the probe
disables the device in the IOMMU. However, earlier in the probe sequence,
amd_iommu_set_pci_msi_domain() assigned the device's MSI domain to the
IOMMU's IRQ domain.

Because this assignment is not reverted on error, the device is left in an
inconsistent state. The device will be assigned to a default bypass or
direct DMA ops, but will be forced to use the IOMMU's IRQ domain for MSIs.

When the driver requests MSIs, irq_remapping_alloc() will fail to find the
IOMMU in the rlookup_table, breaking interrupt allocation completely for
the device.

> +			}
> +		}
> +	}
> =20
>  out_err:
> +	if (IS_ERR(iommu_dev))
> +		iommu_ignore_device(iommu, dev);

[Severity: Low]
Is this double invocation of iommu_ignore_device() intentional?

The patch adds a new call to iommu_ignore_device() here to ensure cleanup
on all probe failure paths, but it leaves the pre-existing explicit call
inside the error handling block for iommu_init_device():

drivers/iommu/amd/iommu.c:amd_iommu_probe_device() {
	...
	ret =3D iommu_init_device(iommu, dev);
	if (ret) {
		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
		iommu_dev =3D ERR_PTR(ret);
		iommu_ignore_device(iommu, dev);
		goto out_err;
	}
	...
}

If iommu_init_device() fails, the code evaluates IS_ERR(iommu_dev) as true
at out_err and calls the cleanup function a second time. While not function=
ally
damaging, it iterates over DMA aliases and clears tables twice unnecessaril=
y.


[Severity: Critical]
Does unconditionally calling iommu_ignore_device() on probe failure break
IRQ remapping when the page table mode is PD_MODE_NONE?

Previously, when amd_iommu_pgtable =3D=3D PD_MODE_NONE (DMA translation
unsupported/disabled), the probe returned -ENODEV to disable DMA
translation for the device but intentionally bypassed iommu_ignore_device().

This kept the device in the rlookup_table, allowing IRQ remapping to
function correctly. By executing iommu_ignore_device() unconditionally
here, the rlookup_table entry is cleared.

Consequently, irq_remapping_alloc() will fail to find the IOMMU for any
device, breaking MSI allocation system-wide when the IOMMU is in
IRQ-remapping-only mode.


[Severity: High]
This is a pre-existing issue, but does iommu_ignore_device() clear DTEs
for PCI aliases in the correct order?

Looking at iommu_ignore_device():

drivers/iommu/amd/iommu.c:iommu_ignore_device() {
	...
	pci_seg->rlookup_table[devid] =3D NULL;
	...
	setup_aliases(iommu, dev);
}

Inside setup_aliases(), the callback clone_alias() attempts to look up
the IOMMU using rlookup_amd_iommu(&pdev->dev), which internally reads
rlookup_table[devid].

Because it was already set to NULL, the lookup fails, and clone_alias()
immediately returns 0. This skips clearing the Device Table Entries (DTEs)
for the device's DMA aliases, leaving them active and dangling.


[Severity: High]
This is a pre-existing issue, but does iommu_ignore_device() use a
non-atomic memset() on the hardware-accessed dev_table array?

Looking at iommu_ignore_device():

drivers/iommu/amd/iommu.c:iommu_ignore_device() {
	...
	memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
	...
}

The AMD IOMMU driver explicitly documents that "IOMMU reads the entire
Device Table entry in a single 256-bit transaction" and requires that
the "DTE[V|GV] bit is being written first when clearing".

A non-atomic clear can cause torn writes where the IOMMU hardware
concurrently reads a partially modified entry (e.g., seeing the Valid
bit still set while the page table pointers are zeroed), leading to
IOMMU faults or wild DMAs.

> +
>  	return iommu_dev;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529111208.3874=
12-1-praan@google.com?part=3D6
