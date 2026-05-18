Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E00047CC6D
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120257; cv=none; b=J1+qR+MR8SqJoratoF/sFb8kb/pqzb6MDj2D0qF58TiCfmp+I41gow+0VPfz66CL+Xxw8JQ0eCALE67C0oiUu8iIr74zD0VkYX8UbzUkHPS9NaM4OBW8O1gqnMRb80YaJrA/Rxf+2zAxFasmpwkYA0/E3eUj1GexXTsgj+4csIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120257; c=relaxed/simple;
	bh=qjMN/2u4u0vZ2vPuY7/DZpOaaNr1Fed9ONJ18s77FPI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ovj/o3maI4YXe2x5B2e3UAIL6+YoDEp9DFwy96+Syky8nisEZtNOjuHL0Vog9EBNLKexzDGRTMTQTiIUKOvqfNiEavX7rRQQxGMf9mRYMpkJ9V8dojnUFZF6UwKyX+YVnxrX5PZvMcajReZY2eKvICCU8F/plsYXKYEu+6f7jTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIGbLdz3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIGbLdz3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BCEC2BCC7;
	Mon, 18 May 2026 16:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779120254;
	bh=qjMN/2u4u0vZ2vPuY7/DZpOaaNr1Fed9ONJ18s77FPI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=iIGbLdz3xuklkjPiEjyST6Ft24TBBdTgVL8w7NWHGpJD0tuNIfEW63OWlSCcI0VxM
	 Ymry4U/rmP/pbG89wYQcZUSPIknvfy2jmPcO4dZ1Wnv2oNdXH8qiDvQrTMVmFuovp8
	 N/gUmmVCWwK0hGqfUawXchxFPzqAGMl9uWynw7EWZt6FZf7OAJ9ckZZYCv0aXUd0u0
	 7u6H4EqW0g/pg4WwsjYFegaxv9eAqsFV+jt0oLMmD5u5xTtXPzAtwEC5Lg/GXXUSmY
	 YOMbZPgXUkEoaTSRVRYmMB0pBqjmzGDYu4056LAe7jWOd7yWdhaVH68jNgbMGSoMkl
	 DZu+kAOoqogcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/5] PCI: dwc: ep: Clear MSI iATU mapping in
 dw_pcie_ep_cleanup()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam via B4 Relay" <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260518-pci-port-reset-v8-1-eb5a7d331dfc@oss.qualcomm.com>
References: <20260518-pci-port-reset-v8-1-eb5a7d331dfc@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 16:04:13 +0000
Message-Id: <20260518160413.E8BCEC2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] dw_pcie_ep_cleanup() modifies the MSI iATU mapping without holding=
 ep->epc->lock, introducing a critical race condition with concurrent EPF i=
nterrupt requests.
--

commit f01add14b7c42730aa5b71bb56cc8682eb2fa21a
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

PCI: dwc: ep: Clear MSI iATU mapping in dw_pcie_ep_cleanup()

This commit clears the MSI iATU mapping in dw_pcie_ep_cleanup() to avoid
retaining a stale MSI iATU mapping after a fundamental reset triggered by
PERST# assert/deassert.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index d4dc3b24da607..4ae0e1b55f390 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -1035,6 +1035,11 @@ void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
>  {
>  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> =20
> +	if (ep->msi_iatu_mapped) {
> +		dw_pcie_ep_unmap_addr(ep->epc, 0, 0, ep->msi_mem_phys);

Is it safe to modify the MSI iATU mapping without holding ep->epc->lock her=
e?

dw_pcie_ep_cleanup() can be invoked asynchronously from reset/link-down
threaded IRQ handlers (e.g., qcom_pcie_perst_irq_thread() calling
qcom_pcie_perst_deassert()) which might not hold the endpoint controller lo=
ck.

Concurrently, an endpoint function driver can attempt to raise an MSI
interrupt via pci_epc_raise_irq(), which acquires ep->epc->lock and invokes
dw_pcie_ep_raise_msi_irq().

If dw_pcie_ep_cleanup() unmaps the window right before
dw_pcie_ep_raise_msi_irq() writes to ep->msi_mem, could this result in
a write to an unmapped PCIe outbound window and trigger an AXI bus error?

Furthermore, dw_pcie_ep_unmap_addr() modifies the shared ep->ob_window_map
bitmask. Does modifying this without the EPC lock race against other functi=
ons
like dw_pcie_ep_map_addr(), potentially corrupting the hardware outbound wi=
ndow
routing?

> +		ep->msi_iatu_mapped =3D false;
> +	}
> +
>  	dwc_pcie_debugfs_deinit(pci);
>  	dw_pcie_edma_remove(pci);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518-pci-port-r=
eset-v8-0-eb5a7d331dfc@oss.qualcomm.com?part=3D1
