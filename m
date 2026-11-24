Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479347;
	b=m+8nveVrS7Qe5Sk+iy4wDb6LJCERs9/2BtADeLVLBTrTvgpSrCL9I3kdYRv2QClxb5io
	 UA83J2PNtaRCcEaKyEwQPcwMmo9+X3hz2/E5muXEy9BoNWKd9bM6tr4JuOrOIUjQWxhk4
	 0pj01xatMXqNrb0OYT3CAMOImqc6WTJMuwDNptDcrABIYL03mBTmArCLiNskAkJwwfVae
	 QNN7jkfLOCFelt0udVbj/AuMqDUyn608AkZZ1jVu8vyDmQ8ufET1/bF8LhfmfPMfcADVU
	 ylCZW4VShGFPaGgScuPo2eU2/G4DhU2B6oBQKN6LCLXuyqxJcPC7lBYp4p0v5/dkEuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479347;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Stm+vYkjami4eZTjfcqkMccfLFkb411BDlLFFt/ZOWk=;
	b=XbK065L/puakEpPezSXooE6l47sgKHFEeD4E68dAwegsfy28fHB4GWnIRpqQTdjPXqZ0
	 1N8UqRmtO6P0UHHED7vqToOYg7aS6Y4WW4J2p5g+Xf9HV0ZtORyBZJGS0ilxHDm1zB99q
	 of45yrEh3Bn0RgxqCX+2IyMXHRBl8usHSuYXun7WwEHgoAH5mm5/ylGqC8atKYQ3h9oAU
	 GJ4DG3/ci0dBveIaEMbFz6L8M3CxxAChV0p9qveYf5fJ3GKx+Gcb4po0tJsZ3h5sXAiRB
	 NOgtreZfXWdRcSifjljRh0u4hwoBc0TRyO2eRgzaq4/cnN8roEYLpNe0P/jtPQSOgBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UU03yuEo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3C9606A31E
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 00:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UU03yuEo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD18A1F000C6;
	Tue, 24 Nov 2026 00:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479346;
	bh=Stm+vYkjami4eZTjfcqkMccfLFkb411BDlLFFt/ZOWk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UU03yuEoEVWejBL9OI5+qvLMSAmCP4Io/7xffk+rr7y9HEosZx5NfzusKOL/COA0y
	 aoODD8Aa/kXiLovxX5tJKhZGaKopdPlJaKdijblvz5cOxaA74bEIL43+jxKoUHqLRJ
	 nYQuuAau68XtpyVTYuuxhLcrI5FtSXQmF0teK8hTf+kmo8ChyQLles+k37xGpOPnkV
	 rXKekTit/InycXTWJp0rFg/7sKlP31hRN7/BFRJtDjumJ3uBBIFf/hvixBBKbe3SfE
	 xovQv5ZxZFJ9qCNNQLnw5MQluwvsuMRrslxItJFVHvC/EiFpAlVsDd+KH/RiZE4vYE
	 Bi6dw+RvZK71g==
Message-ID: <sashiko-outbox-230247@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/2] PCI/ACPI: Support Microsoft's "DmaProperty"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmytro Maluka" <dmaluka@chromium.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261123235845.564027-2-dmaluka@chromium.org>
References: <20261123235845.564027-1-dmaluka@chromium.org>
 <20261123235845.564027-2-dmaluka@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 00:15:46 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] PCI/ACPI: platform_optin_force_iommu() ignores DmaProperty
  devices
- [Medium] PCI: SR-IOV VFs do not inherit untrusted flag from
  DmaProperty PF
--

commit 534ec8c0dc4ebcebaa88d905d9760f867ca5b38f
Author: Rajat Jain <rajatja@google.com>

PCI/ACPI: Support Microsoft's "DmaProperty"

This commit adds support for the Microsoft ACPI _DSD "DmaProperty" to mark
PCI devices as untrusted when the property is set to 1.

Link: [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd=
-for-pcie-root-ports#identifying-internal-pcie-ports-accessible-to-users-an=
d-requiring-dma-protection
Link: [2] https://docs.microsoft.com/en-us/windows/security/information-pro=
tection/kernel-dma-protection-for-thunderbolt

> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 1150f2fbabf41..5971ffc2a375a 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1427,12 +1427,34 @@ static void pci_acpi_set_external_facing(struct p=
ci_dev *dev)
>  		dev->external_facing =3D 1;
>  }
> =20
> +static int pci_dev_has_dma_property(struct pci_dev *dev)
> +{
> +	struct acpi_device *adev;
> +	const union acpi_object *obj;
> +
> +	adev =3D ACPI_COMPANION(&dev->dev);
> +	if (!adev)
> +		return 0;
> +
> +	/*
> +	 * Property used by Microsoft Windows to enforce IOMMU DMA
> +	 * protection from any device, that the system may not fully trust;
> +	 * we'll honour it the same way.
> +	 */
> +	if (!acpi_dev_get_property(adev, "DmaProperty", ACPI_TYPE_INTEGER,
> +				   &obj) && obj->integer.value =3D=3D 1)
> +		return 1;
> +
> +	return 0;
> +}
> +
>  void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
>  {
>  	struct pci_dev *pci_dev =3D to_pci_dev(dev);
> =20
>  	pci_acpi_optimize_delay(pci_dev, adev->handle);
>  	pci_acpi_set_external_facing(pci_dev);
> +	pci_dev->untrusted |=3D pci_dev_has_dma_property(pci_dev);

[Severity: Medium]
Should platform_optin_force_iommu() also check for devices marked via
DmaProperty?

In drivers/iommu/intel/iommu.c, platform_optin_force_iommu() only checks
has_external_pci(), which tests pdev->external_facing:

drivers/iommu/intel/iommu.c:has_external_pci() {
	...
	for_each_pci_dev(pdev)
		if (pdev->external_facing) {
			pci_dev_put(pdev);
			return true;
		}
	return false;
}

On systems with CONFIG_INTEL_IOMMU_DEFAULT_ON=3Dn where firmware sets the
DMAR platform opt-in flag and marks internal ports or devices with
DmaProperty instead of ExternalFacingPort, has_external_pci() returns
false.  platform_optin_force_iommu() then returns early without enabling
DMAR_FORCE_ON, and intel_iommu_init() disables the IOMMU, leaving those
devices without DMA remapping protection.

[Severity: Medium]
Do SR-IOV Virtual Functions inherit pci_dev->untrusted when DmaProperty is
placed directly on an endpoint Physical Function?

When VFs are created via pci_iov_add_virtfn() -> pci_iov_scan_device() ->
pci_setup_device(), set_pcie_untrusted() checks pci_upstream_bridge(dev).
Because pci_upstream_bridge() resolves pci_physfn(dev) first and returns
the bridge upstream of the PF (or NULL on a root bus) rather than the PF
itself, and VFs do not share the PF's ACPI companion, virtfn->untrusted
remains 0.  IOMMU and DMA paths then treat the VFs of an untrusted PF as
trusted.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123235845.5640=
27-1-dmaluka@chromium.org?part=3D1
