Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83006390CB0
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 05:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785302144; cv=none; b=bn3jfHPDTDqOjE6pcv4wv/nUGBlZT1sa7p3ccpOIhfR7pT7hBjoRMPu76dbGOgCkqYLF0k/HmscdBlp3N1GOmryd+c4fm5XEkC2Zd3Q7R29AIbpQg2wcIMLS6+V6+0oPJZox/+lHIuwtFhXlmyONafSRkJS8ToL1wJFsrCBdJqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785302144; c=relaxed/simple;
	bh=+N1XTz0cJai8ZFoYbVo3HA+Iel7xE2eN+DCQy5MmT6w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OdelZLTRCjnnioNNCMBM2hYbvuoxMgLgXl1jNXCfOGNZzaFxxdOTnI6WvmYDw0ShTCDA/C8YoHgJRo6l1RyMqZKS8BtQXjDo1TQDJFFMLHqW9ySKVK4yCZAJ4/UYvdK/7UdzX7ceqT3c76nUry1MzjLCy/LHbn+SGTA0KzCrG+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Byux66os; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Byux66os"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2741F000E9;
	Wed, 29 Jul 2026 05:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785302143;
	bh=oA3NoKYxVs7IZ0pzYuKcIFle0TwwflgfP2PUTFL30Ck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Byux66osPQgaic3ySd+Xvzpyxi1/Ny0ECK+tZaN/cn5AXBBwhUTYa++JRuD/L/FbA
	 65eGO2eX647XdCDcl5H6hahGfmEe6p5mIWwpUBHY4mTwKcWT0Tw88ZNGi8L9awnfZV
	 fxsMy12921HUqat1fL1N9S0Ha816gahEzF7PJvDbeDicS0LhFuJBn6tuwcHUUvawoa
	 79QUCmqd8Yz8pzp+XXiSfBb/2ESNyDsxC2tmyHVbK5H/dISUX9SMUaMRJ8IRrB4FFL
	 4XpW6QUWhFaARoDa4jNn1M3jtIBYcvEMK0C+YMTE3m6z3cLD5Hxhcz7CB0g1O0PMIu
	 ubeCjxUzzkRYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/5] PCI: dwc: ep: Clear MSI iATU mapping in
 dw_pcie_ep_cleanup()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260729-pci-port-reset-v9-1-53570b92064d@oss.qualcomm.com>
References: <20260729-pci-port-reset-v9-0-53570b92064d@oss.qualcomm.com>
 <20260729-pci-port-reset-v9-1-53570b92064d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 05:15:42 +0000
Message-Id: <20260729051542.DC2741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] dw_pcie_ep_cleanup() modifies ep->msi_iatu_mapped and unmaps iATU =
without holding epc->lock, introducing a race condition.

Pre-existing issues:
- [Critical] Repeated invocations of dwc_pcie_debugfs_deinit() lead to a do=
uble-free of pci->ptm_debugfs.
- [High] Persistent MSI iATU mapping conflicts with dynamic MSI-X iATU mapp=
ing, causing misdirected unmaps and permanent iATU window leaks.
- [High] Multi-Function (MF) MSI Requester ID is corrupted because the iATU=
 mapping cache does not track func_no.
- [Medium] Debugfs entries are permanently lost after the first link reset.
--

--- Patch [1]: [PATCH v9 1/5] PCI: dwc: ep: Clear MSI iATU mapping in dw_pc=
ie_ep_cleanup() ---
commit c81bd7f3f798231612f6baba5357a5d4dcc7b736
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

PCI: dwc: ep: Clear MSI iATU mapping in dw_pcie_ep_cleanup()

This commit unmaps the MSI iATU region and clears the msi_iatu_mapped
flag in dw_pcie_ep_cleanup() during a PERST# reset sequence. This ensures
that dw_pcie_ep_raise_msi_irq() performs a fresh iATU mapping on its next
invocation.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index 7d2794945704e..31402ae218c79 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -1153,6 +1153,11 @@ void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
>  {
>  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> =20
> +	if (ep->msi_iatu_mapped) {
> +		dw_pcie_ep_unmap_addr(ep->epc, 0, 0, ep->msi_mem_phys);
> +		ep->msi_iatu_mapped =3D false;
> +	}

[Severity: High]
Does this introduce a regression due to a race condition with epc->lock?

If a user-space ioctl or workqueue in an EPF driver calls pci_epc_raise_irq=
(),
it takes epc->lock and modifies ep->msi_iatu_mapped and iATU registers.
Concurrently, if a host-initiated PERST# reset triggers dw_pcie_ep_cleanup()
in the controller driver's IRQ handler, it modifies the exact same state he=
re
without taking epc->lock.

Could this lead to data corruption of iATU registers or concurrent unaligned
accesses to the outbound window bitmap?

[Severity: High]
This is a pre-existing issue, but does the persistent MSI iATU mapping
conflict with dynamic MSI-X iATU mapping?

Both MSI and MSI-X use the same physical address (ep->msi_mem_phys). If
dw_pcie_ep_raise_msi_irq() caches the ATU mapping, and then
dw_pcie_ep_raise_msix_irq() is called, it maps the same address to a new
window:

drivers/pci/controller/dwc/pcie-designware-ep.c:dw_pcie_ep_raise_msix_irq()=
 {
    ...
    ret =3D dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
                              map_size);
    ...
}

When dw_pcie_ep_raise_msix_irq() later calls dw_pcie_ep_unmap_addr(), the
lookup function returns the first matching address:

drivers/pci/controller/dwc/pcie-designware-ep.c:dw_pcie_find_index() {
    ...
    if (ep->outbound_addr[index] !=3D addr)
        continue;
    *atu_index =3D index;
    return 0;
}

Could this unmap the cached MSI window instead of the newly allocated MSI-X
window, permanently leaking the MSI-X window?

[Severity: High]
This is a pre-existing issue, but is the Multi-Function (MF) MSI Requester =
ID
corrupted because the iATU mapping cache does not track func_no?

When multiple endpoint functions are assigned the same MSI address by the h=
ost,
dw_pcie_ep_raise_msi_irq() for function 1 hits the cache because msg_addr a=
nd
map_size match the values cached by function 0:

drivers/pci/controller/dwc/pcie-designware-ep.c:dw_pcie_ep_raise_msi_irq() {
    ...
    if (ep->msi_iatu_mapped && (ep->msi_msg_addr !=3D msg_addr ||
                                ep->msi_map_size !=3D map_size)) {
    ...
}

Will it reuse the iATU programmed with PCIE_ATU_FUNC_NUM(0), sending functi=
on
1's MSI with the Requester ID of function 0, causing host IOMMU faults?

> +
>  	dwc_pcie_debugfs_deinit(pci);

[Severity: Critical]
This is a pre-existing issue, but do repeated invocations of
dwc_pcie_debugfs_deinit() lead to a double-free of pci->ptm_debugfs?

dw_pcie_ep_cleanup() is called by host drivers during a PERST# reset sequen=
ce.
It invokes dwc_pcie_debugfs_deinit(), which calls pcie_ptm_destroy_debugfs()
and frees the structure:

drivers/pci/pcie/ptm.c:pcie_ptm_destroy_debugfs() {
    ...
    kfree(ptm_debugfs);
}

However, pci->ptm_debugfs is never set to NULL. If the host resets the link=
 a
second time, will the same pointer be passed to kfree() resulting in a
double-free?

[Severity: Medium]
This is a pre-existing issue, but are debugfs entries permanently lost after
the first link reset?

dw_pcie_ep_cleanup() unconditionally removes the debugfs directory during a
PERST# reset. However, dwc_pcie_debugfs_init() is only called during the
initial driver probe.

Does this mean the debugfs structure is destroyed and never recreated on
subsequent link-ups?

>  	dw_pcie_edma_remove(pci);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-pci-port-r=
eset-v9-0-53570b92064d@oss.qualcomm.com?part=3D1
