Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE49A2F690F
	for <linux-pci@vger.kernel.org>; Sat, 19 Sep 2026 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789835958; cv=none; b=klfKbXzaPbJ5j4kY05ueDlORAIMuTwxVe33shOWPNGbSUn1Cxg8HvGV6urQQ/OLjiEMV9WlG17k9ta5p9xGE3YQhr3jcK8ji1c0kUAE4F9t72yxuz2SLSDDTuycpZvh0z498imR9p+3kaVNFvgZ/XzNee2935cPDq5PdMwwO/NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789835958; c=relaxed/simple;
	bh=Gl8UzjlBEYBWgohbZc4HzisajFNI9nFXFmi5IsdT9/o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kjsdBVJsaBIZRSNbJiMqGauT3aYvtvvs3ieNJi8xIJf5YdRSabzmO4SYkIs67HVNxWpdoLl2GRu4W6kuMjFRpnIIo4uW9t3JNowWU0frzpYOt2iMq9ytsYNPD/v+3uq+6dsmN254bFBWnrfB4LsGE/b1QPBgt6W5DKBu6YKrIVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8dHvb1p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8dHvb1p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DC41F000FF;
	Sat, 19 Sep 2026 16:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789835957;
	bh=sO/evHyZbXIyUzN30ZaOE36wQk43EFueDHyx9cmVmRw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A8dHvb1pYI6CcK+tuIgFQbEhr3smV/ah6gvo620Nrun0S/I2x+qLEcN/Pm4T9/t0B
	 ttdNU4UdkmKHEkCd0svsJkZvkeANAYSXac/fm9UDimgaJgruGM4OTruZHsNw5KyZgh
	 RbKFyc+RLZvygtqs0OTay5ytu9C1KMYfQmv2FC6VI/wevNWtdJElZ6xGaqZkVWeqfr
	 lqgQAwesU+UA2D/VQIihqDZjFpA2xSfHVSCpnvF24oqZ+q9FwtjqzOlsZOU0MIyIfe
	 xkV6qz3MhoKvzANxsnPtDE0eKcpD2ozoCF58hiRKwMj4ilwVze+Pz0PXGfQ0eaWej+
	 5JNPKhH88VDeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 4/5] PCI/ACPI: Centralize pcie_ports_native checking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260919162655.3499010-5-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20260919162655.3499010-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 16:39:16 +0000
Message-Id: <20260919163917.36DC41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pci: implicit system-wide DPC binding contradicts commit message
--

commit 07669185337d665d35c6cf7148608c57752e5ecb
Author: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.=
com>

PCI/ACPI: Centralize pcie_ports_native checking

This commit centralizes the testing of pcie_ports_native in=20
acpi_pci_root_create() by folding it into the _OSC control mask. It allows=
=20
other subsystems to simply check the host_bridge->native_X flags instead of=
=20
using scattered pcie_ports_native tests.

Link: https://lore.kernel.org/r/bc87c9e675118960949043a832bed86bc22becbd.16=
03766889.git.sathyanarayanan.kuppuswamy@linux.intel.com

> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 756dc2f055f51..2494811dd69b2 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
[ ... ]
> @@ -1039,6 +1052,21 @@ struct pci_bus *acpi_pci_root_create(struct acpi_p=
ci_root *root,
>  	ctrl =3D root->osc_control_set;
>  	ext_ctrl =3D root->osc_ext_control_set;
> =20
> +	/*
> +	 * If the user specified "pcie_ports=3Dnative", use the PCIe port
> +	 * services regardless of what _OSC says, i.e., proceed as though the
> +	 * platform had granted us control of them.  This may conflict with
> +	 * firmware that expects to own those features.
> +	 */
> +	if (pcie_ports_native) {
> +		u32 override =3D OSC_PCIE_PORT_SERVICE_CONTROLS & ~ctrl;
> +
> +		if (override)
> +			decode_osc_control(root, "OS forcing control (\"pcie_ports=3Dnative\"=
) of",
> +					   override);
> +		ctrl |=3D override;
> +	}
> +
>  	OSC_OWNER(ctrl, OSC_PCI_EXPRESS_NATIVE_HP_CONTROL,
>  		  host_bridge->native_pcie_hotplug);
>  	OSC_OWNER(ctrl, OSC_PCI_SHPC_NATIVE_HP_CONTROL,
> @@ -1051,6 +1079,14 @@ struct pci_bus *acpi_pci_root_create(struct acpi_p=
ci_root *root,
>  	OSC_OWNER(ctrl, OSC_PCI_EXPRESS_AER_CONTROL, host_bridge->native_aer);
>  	OSC_OWNER(ctrl, OSC_PCI_EXPRESS_PME_CONTROL, host_bridge->native_pme);
>  	OSC_OWNER(ctrl, OSC_PCI_EXPRESS_LTR_CONTROL, host_bridge->native_ltr);
>  	OSC_OWNER(ctrl, OSC_PCI_EXPRESS_DPC_CONTROL, host_bridge->native_dpc);

[Severity: Medium]
The commit message states that extending "pcie_ports=3Dnative" to DPC has a
"narrow" effect, only impacting pci_dpc_recovered(). However, does this
unintentionally enable the DPC port driver system-wide?

Because pcie_ports=3Dnative now forces host_bridge->native_aer to true via =
the
OSC_PCI_EXPRESS_AER_CONTROL bit override, this impacts the DPC port service
binding in get_port_device_capability():

drivers/pci/pcie/portdrv.c:get_port_device_capability() {
        ...
        if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
            pci_aer_available() &&
            (pcie_ports_dpc_native || host->native_aer))
                services |=3D PCIE_PORT_SERVICE_DPC;
        ...
}

Since host->native_aer evaluates to true when the pcie_ports=3Dnative param=
eter
is provided, the DPC capability check will now unconditionally pass. Could
this break the assumption that the effect on DPC was isolated?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919162655.3499=
010-1-sathyanarayanan.kuppuswamy@linux.intel.com?part=3D4
