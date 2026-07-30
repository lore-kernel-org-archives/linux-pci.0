Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97BB43B6D9
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419320; cv=none; b=Wrlu9BUjX8qMLMSL0PtY9yXk7G1HbyjHddcAnAVBFja7LTyZEHJYerqu4quqRyXV4NIeTwiSa1x+ud9ZDNEl7K+E5oQjmk72u+uFVIeiDfJPjtoCWtK1rsyYMHPYrPYcUc13cv0TR1ewKfEUVzMV7HB6VNKhkY5VgwTTaJccfJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419320; c=relaxed/simple;
	bh=L7PZh2A2LjSHxfq13Y2fJcoRgEBAPGR7zvazLjiMvW8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sQTEvH95jyiu79J/inNp1T2v5cCl7qSC86oOI94T/eE0XNByxISHmUD/kDgP25fqxoKrJ8+UriwQ1rRkvkgvGJSov0gJDrDNZzBCTtdLuLMy6Q2hRO/7itvtw9toAF4ZG665Kz62K/FWzeiIe3jatO2fcIGKmjqUzrEknkhLyLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9m8fBUQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9m8fBUQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBE91F00ACA;
	Thu, 30 Jul 2026 13:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785419318;
	bh=zjV3LO0WcpQiTA7gpWddy63PQZPZfA/oMlc7es0Rft4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K9m8fBUQsV2+3lkb/n0v1JbctQFL0ggSdpEr7ob6/FNd4N1XumkRI1XuWavXMI5A1
	 tp+3wY95LDjG8e6nqqHI578r3S98IuEcKbfuZiBcvqT2BYZwxIyPxZB1AQD5fOYCB8
	 3sSIX7/IqOsCZTHXd+uLiHKDp0ZiaMarTBZ/OXJp6+ysUl/Sql0QozBWYc9V7JRENH
	 FLH5X6Z1ObywEO+H2ttBkqDjq3mTk6Rs6GHXPDdvqFbKJ+UDijHLzTREMD0k9UCJkM
	 352B9nUAqWDFeW/n46DTKtA5BAqNwdwFETbKNWCo2o8EwpQTBZtNiXxwb21sMyxKY+
	 7LpYcq+yJs/DA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dwc: ep: Flush the cached MSI address
 before unmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260730133123.1420413-5-cassel@kernel.org>
References: <20260730133123.1420413-4-cassel@kernel.org>
 <20260730133123.1420413-5-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 13:48:38 +0000
Message-Id: <20260730134838.8BBE91F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The cached MSI iATU mapping logic in dw_pcie_ep_raise_msi_irq() om=
its checking func_no, causing MSIs from subsequent functions to be sent wit=
h the wrong Requester ID.
- [High] Missing flush of posted MSI writes before unmapping the ATU window=
 in dw_pcie_ep_stop().
- [High] Hardware address conflict and ATU window leak due to shared ep->ms=
i_mem_phys between MSI and MSI-X.
--

--- Patch [1]: [PATCH v2 1/2] PCI: dwc: ep: Flush the cached MSI address be=
fore unmap ---
commit 61e06ab5c5d18de814a8a431d661886fcd30c6d7
Author: Niklas Cassel <cassel@kernel.org>

PCI: dwc: ep: Flush the cached MSI address before unmap

While we do a flush before unmap in dw_pcie_ep_raise_msix_irq(), we do
not do a flush before unmap in dw_pcie_ep_raise_msi_irq(), if the cached
MSI target address changed. Fix this by doing a flush before unmap.

Link: https://lore.kernel.org/linux-pci/20260729214859.B9E2B1F00A3A@smtp.ke=
rnel.org/

> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -1032,6 +1032,8 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep,=
 u8 func_no,
>  		 * there is no unified way to check if we have operations in
>  		 * flight, thus we don't know if we should WARN() or not.
>  		 */
> +		/* flush posted write before unmap */
> +		readl(ep->msi_mem + ep->msi_iatu_mapped_offset);

[Severity: High]
This is a pre-existing issue, but since this patch adds a flush here to
drain posted writes, is a similar flush needed in dw_pcie_ep_stop()?

During device stop, dw_pcie_ep_stop() unmaps the MSI ATU window:

drivers/pci/controller/dwc/pcie-designware-ep.c:dw_pcie_ep_stop() {
    ...
	if (ep->msi_iatu_mapped) {
		dw_pcie_ep_unmap_addr(epc, 0, 0, ep->msi_mem_phys);
		ep->msi_iatu_mapped =3D false;
	}
    ...
}

Would stopping the controller and unmapping the window without a dummy
read to drain the AXI bridge cause in-flight MSI writes to be dropped?

>  		dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);

[Severity: High]
This isn't a bug introduced by this patch, but does the MSI iATU mapping
logic need to track the function number?

Currently, struct dw_pcie_ep lacks a field to track which function number
is mapped. The caching logic in dw_pcie_ep_raise_msi_irq() checks the
target address and size, but omits the function number.

If Function 0 raises an MSI, the ATU is programmed with Function 0's
Requester ID. If Function 1 then raises an MSI to the identical target
address, the cache check succeeds and bypasses ATU reprogramming.

Might this cause Function 1's MSIs to be transmitted via the ATU window
still configured with Function 0's Requester ID, leading to dropped
interrupts by the host IOMMU?


[Severity: High]
This is a pre-existing issue, but does sharing ep->msi_mem_phys between
MSI and MSI-X cause hardware address conflicts?

If dw_pcie_ep_raise_msi_irq() maps an ATU window for ep->msi_mem_phys,
and subsequently dw_pcie_ep_raise_msix_irq() unconditionally allocates
and maps a new ATU window for the exact same physical address, overlapping
translation windows are created.

When dw_pcie_ep_unmap_addr() is called, it searches for the physical address
and unmaps the first matching window:

drivers/pci/controller/dwc/pcie-designware-ep.c:dw_pcie_find_index() {
    ...
	for_each_set_bit(index, ep->ob_window_map, pci->num_ob_windows) {
		if (ep->outbound_addr[index] !=3D addr)
			continue;
		*atu_index =3D index;
		return 0;
	}
    ...
}

Would this incorrectly return the MSI window's index, unmapping the MSI
window instead of the MSI-X window, and permanently leaking the newly
allocated MSI-X ATU window?

>  		ep->msi_iatu_mapped =3D false;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730133123.1420=
413-4-cassel@kernel.org?part=3D1
