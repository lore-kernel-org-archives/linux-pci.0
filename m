Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E0522156C
	for <linux-pci@vger.kernel.org>; Tue,  2 Jun 2026 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780399703; cv=none; b=KKsZNXP6q09QV0PyC9zUyLYzbP/rhEQ5arbi6oJ1BipK2RMDypckaYjDpsTdztmWs8RnGVz2N687dFNXK5bvYUezYqY6s5BT6X7Z+5x3dsgIJcd3+c3DrfXi3KK0FySW2iMiSQLfTj47rjFDc0k2YfoS9sZzCn1W5VJOd32jlHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780399703; c=relaxed/simple;
	bh=BKifaNHvzzGxlvXa02lmWMAuo7StAF6v4zQ+3mwpGlc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rTyydkRwYRtu7HiVSvH8WVRtpCL3as2ifiv8H/SBSRcGtQbGZwZgTJuXVuCo89ExOCWSTRVmnUqiC/+bow+4uD3kbEH/wI9Qn9iW9P5vS0dex+VgukVyDIZVu5OgdJbclyTwHYVPcz96PLeG0p8WKTQ2L78VYDp7AzuimGDBGHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4zxf9jT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4zxf9jT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA631F00893;
	Tue,  2 Jun 2026 11:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780399702;
	bh=gERvYyuiyCSM7mZlTY3IuFsfR07ZziVCNWuVRZe6frM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F4zxf9jTCBRByDhRVDfOnycOH97G15GRksfGlFaBaTphFU9Z0tb2k5RZ0/hk2MSMT
	 naYZJdute1ZuqAbvfvYoOzio4fvc6GjF2DAyc2QIChVGgCt7IiKeeya1i87sd0l7t4
	 aLDBwN4i4pBboxqlZqfALQlmyWapVF/HvGko4QoFraKCZo9bmyoobyOlnVvomisjFi
	 mSLAM8NoBfXGkHOSTmRv3wf6N2cjCw987WpZXsrmByZoCqXh768vGAP+2b8J9zGSuF
	 Ld1lxahvrF3OHdcrampzPADCCyV7RBuKc3JXb/CMzpdfJGQfbdEhCEH0TRR3dnZsz8
	 TqW/vuTuPSImA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI: Add pci=nodpc kernel boot option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Murashka" <yurypm@arista.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260602105558.1799563-3-yurypm@arista.com>
References: <20260602105558.1799563-3-yurypm@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 11:28:21 +0000
Message-Id: <20260602112822.2AA631F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Using the `pci=3Dnodpc` boot parameter prevents initialization=
 of `pdev->dpc_cap`, leaving it as 0. However, the DPC port service is stil=
l probed, causing the driver to use 0 as the base offset and corrupt standa=
rd PCI configuration registers.
--

commit 85278f34398b97df6932c6536a28ecec0294df49
Author: Yury Murashka <yurypm@arista.com>

PCI: Add pci=3Dnodpc kernel boot option
   =20
PCI DPC (Downstream Port Containment) support can be advertised by PCIe
devices, but it might not be fully supported in the firmware. On large
modular systems with a complex PCIe tree, enabling DPC could cause
unexpected behavior and side effects. Sometimes it would be nice to have
the option to keep the system in an unmodified state and be able to
handle PCIe errors from userspace.
   =20
Add pci=3Dnodpc kernel boot option to disable PCI DPC. When this option
is set, DPC initialization, state save/restore, and recovery are all
skipped.

> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 2b779bd1d861b..10d1a0e026d74 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c

[ ... ]

> @@ -404,6 +411,9 @@ void pci_dpc_init(struct pci_dev *pdev)
>  {
>  	u16 cap;
> =20
> +	if (pcie_dpc_disable)
> +		return;
> +

[Severity: Critical]
If pcie_dpc_disable is true, pdev->dpc_cap remains 0. However, does this
completely prevent the DPC service from probing?

Looking at get_port_device_capability() in drivers/pci/pcie/portdrv.c, it
queries the hardware directly instead of checking pcie_dpc_disable:

drivers/pci/pcie/portdrv.c:get_port_device_capability() {
    ...
    if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
        pci_aer_available())
            services |=3D PCIE_PORT_SERVICE_DPC;
    ...
}

This will cause the port driver to register the DPC service anyway, and
dpc_probe() will be called.

Since pdev->dpc_cap is 0, won't dpc_probe() and dpc_enable() use 0 as the
base offset for DPC registers?

drivers/pci/pcie/dpc.c:dpc_enable() {
    ...
    pci_read_config_word(pdev, dpc + PCI_EXP_DPC_CTL, &ctl);
    ...
}

Using 0 as the base means PCI_EXP_DPC_CTL accesses offset 0x06, which is
the standard PCI_STATUS register. Writing back to it could inadvertently
clear critical Write-1-to-Clear (W1C) bits like PCI_STATUS_SIG_SYSTEM_ERROR.

Furthermore, in dpc_irq():

drivers/pci/pcie/dpc.c:dpc_irq() {
    ...
    pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
    ...
}

This will read offset 0x08 (PCI_CLASS_REVISION). Since DPC registers a
shared IRQ, when it fires for another device, a Revision ID with bits 0 and
3 set could be interpreted as a DPC trigger. This could cause a spurious
PCIe link reset, disconnecting downstream devices.

Could the pcie_dpc_disable flag be checked in get_port_device_capability(),
or could dpc_probe() verify that pdev->dpc_cap is non-zero before
proceeding?

>  	pdev->dpc_cap =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
>  	if (!pdev->dpc_cap)
>  		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602105558.1799=
563-1-yurypm@arista.com?part=3D2
