Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68462F12AB
	for <linux-pci@vger.kernel.org>; Sat, 30 May 2026 16:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157074; cv=none; b=sFDOlkjB2fRHQI6tdNw0JKwdDtHXcnqpd6iAsr7f5ZqsvK+k8cpoNEHJnt4/P/u8ih/SM+T/tvuLJ8xS8p6sdeCWviTPw6oeldXYf/haKszJIzbneMC6vRaedvy6ZShggzNbJSMve5ask9ngMzlSRgKbmyybJ11P6vvue78Qte4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157074; c=relaxed/simple;
	bh=hvGQLxLBb1NhqpbFp8l/raHZQQo1xlCUEZ5Sk5thW3Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VgTV70sF/HAMUGeszG2PFci3u2LDcgusxUMenLf3Vu0Tdbkaop9//AvZdLn2uOw5enDIKkdTwSrtCpuVVMf3cxgWgbAEGrizPBUy8xaHFZ1/P6LiJYSYchDZswui7xg4WEF2m8iTOFqf1cRjez34fBKvBep1G9ofn8/blzGoeSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBj/ao+x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBj/ao+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD961F00893;
	Sat, 30 May 2026 16:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780157073;
	bh=wr1Zs7KLCbLxcsZXonw6gdRFXZI49E3G+JoPND87x80=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WBj/ao+xe1JIvusueSUrXSM54HNldsj+Zz2YfzIr7ncm8jRo/6c3WJZlOvWe5bTGz
	 yszkOxKo+RrRr1NGL6TedYvMFfFyqDIZjuUOkFibCmzdC+0NnLVaKC1LadTdWzFgIx
	 m8yWMR+qHkwvElp1uof6L52bZbKRTwchHAl6m4NHAcMGDJqeUGW3Z2awXFEDw3Jojk
	 UdS4RfYD22IfofiWu8go9bj8KqHwfyNiNjnJcpxD3GuGvIjRDAmATxwFectYOlvDBu
	 IjmWOBt/otDgvMzoK5sucqN4zrCh9FTzJOkEn6gE0AVRWbvvbubXsQrbMkIEYpKLM0
	 +OmXlKJ33ETfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/16] PCI: dwc: layerscape-ep: Use cached PCIe
 capability offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260530153101.695580-5-18255117159@163.com>
References: <20260530153101.695580-5-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 16:04:32 +0000
Message-Id: <20260530160433.2AD961F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Sleeping in atomic context due to mutex_lock() inside hardirq hand=
ler
- [High] Race condition in DBI register access leading to silent PCIe confi=
guration failures
--

commit 68e2e619ed44719a7c9ec1273ed94120c179ed09
Author: Hans Zhang <18255117159@163.com>

PCI: dwc: layerscape-ep: Use cached PCIe capability offset
   =20
Replace these with dw_pcie_get_pcie_cap(). The hardware is already enabled
by the driver before ls_pcie_ep_probe() and before the interrupt handler
runs. dw_pcie_get_pcie_cap() will cache the offset on first call, and
subsequent calls (including inside dw_pcie_ep_init) will use the cached
value without re-searching.

> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci=
/controller/dwc/pci-layerscape-ep.c
> index 8936975ff104e..b2d0b51df3c53 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -83,9 +82,6 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, vo=
id *dev_id)
>  		return IRQ_NONE;
> =20
>  	if (val & PEX_PF0_PME_MES_DR_LUD) {
> -
> -		offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -
>  		/*
>  		 * The values of the Maximum Link Width and Supported Link
>  		 * Speed from the Link Capabilities Register will be lost
> @@ -93,7 +89,8 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, vo=
id *dev_id)
>  		 * that configured by the Reset Configuration Word (RCW).
>  		 */
>  		dw_pcie_dbi_ro_wr_en(pci);
> -		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, pcie->lnkcap);
> +		dw_pcie_writel_dbi(pci, pci->pcie_cap + PCI_EXP_LNKCAP,
> +				   pcie->lnkcap);
>  		dw_pcie_dbi_ro_wr_dis(pci);

[Severity: High]
This isn't a bug introduced by this patch, but does using
dw_pcie_dbi_ro_wr_en() and dw_pcie_dbi_ro_wr_dis() in hardirq context
here create a race condition with process-context operations?

Since dw_pcie_dbi_ro_wr_dis() unconditionally clears PCIE_DBI_RO_WR_EN:

static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
{
	...
	val &=3D ~PCIE_DBI_RO_WR_EN;
	dw_pcie_writel_dbi(pci, reg, val);
}

If this hardirq interrupts a process-context operation (like
dw_pcie_ep_set_bar_programmable()) right after it enabled RO_WR_EN but
before it writes to a DBI register, will this unconditionally clear the
flag, causing the interrupted thread's subsequent writes to be silently
ignored by the hardware?

> =20
>  		cfg =3D ls_pcie_pf_lut_readl(pcie, PEX_PF0_CONFIG);

[Severity: High]
This is a pre-existing issue, but does the code in this same hardirq
handler sleep in atomic context?

Shortly after this point in ls_pcie_ep_event_handler(), the code calls:

	dw_pcie_ep_linkup(&pci->ep);

Which invokes pci_epc_linkup() in the EPC core, doing:

void pci_epc_linkup(struct pci_epc *epc)
{
	mutex_lock(&epc->list_lock);
	...
}

Will attempting to acquire this sleepable mutex from hardirq context
trigger a BUG for scheduling while atomic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530153101.6955=
80-1-18255117159@163.com?part=3D4
