Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C3A43B4AB
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419478; cv=none; b=IS+ayliM8F8uaUYOUjsduSDtBNiRKMm1Tq+BWfKnkzxYLnTuM10FFNitaF1gj7/wy+bKkz+0hmljEmEqfNe+VuqZy8IB2IldO1ShaAi3vYcye/V5LMhHR1vKxH4I473haNfLdRJuRE58aE1Ws/lR/dtfGY0nOgXe0tnCqLmbSJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419478; c=relaxed/simple;
	bh=Yd67YejWUYenHtRN0xgHI8Hlo6ng39ioZ6Vk25Mu1nQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ON2jEza/mO+L2cEGAjpRW1irPKu3gPtd4hzG6hULrqJGS6vdafvHAbmi/czNZcNqJLGdaPREM6qsTSedpK/pDKVF25MwBZ5W7eSjmKl3CKGzDBeyXk3JFOs+B/UY8aukDrJxrNyW8PJfNzOLLSEJGb63IYhWvMN6OUDz+y6lmCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2532rC1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2532rC1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950031F000E9;
	Thu, 30 Jul 2026 13:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785419476;
	bh=uKow4LhRRn/FOX3YbDTulhlAqPtZn6y7Oo5nRRiHeP0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o2532rC1uI21BT8zl38bNChIbmtgN7SCb23+o9l1EoHCjbHuxgsLlVo3+rB2YlCvI
	 PqdFJiaP7wv8fIJtNsrnQp6AQDFjhY65zKIO4xwN3d149VHFB8yXkNKFRglvaK1EDY
	 +Dc3HsUgolbrCLiTLcZvkMXu46+iLwRv/7TcW2+daAYycr0s2yto9zdqZ5T6LeRNx0
	 2p0EC9XADYXQJlo0okaPrqnYCiy2MNkrTbryh3jPnmpRo9y5HPprRlXPlT76hCG96W
	 m/HK1USJk6XxxNtgeOIY78/+aJZ9Hue0Hxoco5bpsZ38TyN6nhxcuvnoLf7kwtlQRX
	 qsphOGl7A3RDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] PCI: dwc: ep: Fix unmap potentially unmapping
 the wrong iATU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260730133123.1420413-6-cassel@kernel.org>
References: <20260730133123.1420413-4-cassel@kernel.org>
 <20260730133123.1420413-6-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 13:51:16 +0000
Message-Id: <20260730135116.950031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Using `readl()` on the host's MSI target address to flush posted w=
rites generates a dangerous PCIe Memory Read Request, causing kernel panics.

Pre-existing issues:
- [High] The cached MSI iATU mapping incorrectly reuses a mapping for diffe=
rent functions, leading to wrong PCIe Requester IDs.
- [Medium] Missing synchronization/flush of posted writes before unmapping =
MSI iATU window in `dw_pcie_ep_stop()`.
- [Medium] The MSI-X table entries are read using native CPU endianness, ca=
using incorrect values on Big Endian endpoints.
--

--- Patch [2]: [PATCH v2 2/2] PCI: dwc: ep: Fix unmap potentially unmapping=
 the wrong iATU ---
commit 43c93e2ba0a475079cedb73c82f8ed9973d5ab90
Author: Niklas Cassel <cassel@kernel.org>
PCI: dwc: ep: Fix unmap potentially unmapping the wrong iATU

This patch fixes a conflict between persistent MSI iATU mappings and dynamic
MSI-X iATU mappings by ensuring the cached MSI mapping is unmapped before
raising an MSI-X interrupt.

Link: https://lore.kernel.org/linux-pci/20260729051542.DC2741F000E9@smtp.ke=
rnel.org/

> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index 3128e7ae8c5fd..7cd169d458909 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -1127,6 +1127,17 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *e=
p, u8 func_no,
>  		return -EPERM;
>  	}
> =20
> +	/*
> +	 * ep->msi_iatu_mapped means that an MSI target address is cached,
> +	 * unmap it first so that we can reuse ep->msi_mem_phys for MSI-X.
> +	 */
> +	if (ep->msi_iatu_mapped) {
> +		/* flush posted write before unmap */
> +		readl(ep->msi_mem + ep->msi_iatu_mapped_offset);

[Severity: High]
Does using readl() on the host's MSI target address generate a dangerous
non-posted PCIe Memory Read Request?

Most host interrupt controllers (like GIC ITS or APIC) do not support reads
to their doorbell addresses and will reply with an Unsupported Request (UR).

The DWC controller translates the UR completion into an AXI Slave Error,
which can trigger a synchronous external abort and kernel panic on the
endpoint CPU.

This concern applies to flushing posted writes in both
dw_pcie_ep_raise_msix_irq() and dw_pcie_ep_raise_msi_irq().

> +		dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
> +		ep->msi_iatu_mapped =3D false;
> +	}
> +
>  	msg_addr =3D dw_pcie_ep_align_addr(epc, msg_addr, &map_size, &offset);

[Severity: High]
This is a pre-existing issue, but I noticed the cached MSI iATU mapping mig=
ht
incorrectly reuse a mapping for different functions.

Looking at dw_pcie_ep_raise_msi_irq():

drivers/pci/controller/dwc/pcie-designware-ep.c:dw_pcie_ep_raise_msi_irq() {
        ...
        if (ep->msi_iatu_mapped && (ep->msi_msg_addr !=3D msg_addr ||
                    ep->msi_map_size !=3D map_size)) {
        ...
}

Since dw_pcie_ep_map_addr() programs the outbound ATU with a specific func_=
no,
if this reuses the existing mapping without checking func_no, will it send
the PCIe TLP with the first function's Requester ID?

This could cause MSIs from multi-function endpoints to be dropped or misrou=
ted
by the host's interrupt controller or IOMMU.

[Severity: Medium]
This isn't a bug introduced by this patch, but unmapping an iATU window whi=
le
posted writes are in flight on the AXI bridge could cause undefined behavior
and interconnect faults.

In dw_pcie_ep_stop():

drivers/pci/controller/dwc/pcie-designware-ep.c:dw_pcie_ep_stop() {
        ...
        if (ep->msi_iatu_mapped) {
                dw_pcie_ep_unmap_addr(epc, 0, 0, ep->msi_mem_phys);
                ep->msi_iatu_mapped =3D false;
        }
        ...
}

Is it safe to tear down the iATU here without any synchronization or delay
to ensure in-flight AXI operations have completed?

[Severity: Medium]
This is a pre-existing issue, but reading MSI-X table entries natively can
yield byte-swapped values on Big Endian endpoint CPUs.

Looking at dw_pcie_ep_raise_msix_irq():

drivers/pci/controller/dwc/pcie-designware-ep.c:dw_pcie_ep_raise_msix_irq()=
 {
        ...
        msg_addr =3D msix_tbl[(interrupt_num - 1)].msg_addr;
        msg_data =3D msix_tbl[(interrupt_num - 1)].msg_data;
        vec_ctrl =3D msix_tbl[(interrupt_num - 1)].vector_ctrl;
        ...
}

Since this memory is a PCIe BAR programmed by the host over the PCIe link,
the data should be in little-endian format. Should these accesses use
endianness conversions like le64_to_cpu() and le32_to_cpu() to ensure
correct values?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730133123.1420=
413-4-cassel@kernel.org?part=3D2
