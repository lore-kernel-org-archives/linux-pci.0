Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794017280;
	b=PeKuCY7zYffe8BR9SFy9jg9PrY9VrUizyMP3gZMSpM3OmwMxQhyRTitmkTNoTv1m5qx9
	 D8GRRV/dbLGdssgq70xabfBnzb2/k8gFX2Y+tY1D582wyDc9rszkrwCKpDXT06hVA6nTs
	 lvUvntPWzzOmO/2VGo8Gtttwg4YThqrhLantpdAKEiTm0o0Fc5fqz0zXXjDX5303AzGNZ
	 DuY2SmxBApljCM4pA+68vzPTnPMJC/5QxGoanJUgfuNCzzdbRH8HRB6r1hARYdiSgEi5T
	 h9sPtanxLYyHOznZ8nmw1SobwwixlLjq3fEyg7Tb9Sy7pnyT13pkhXT6FvfV745W8Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794017280;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9XfkFEh0TSHNI4o8+9IDxSWg70RO4IM8GgO6QBlwGe4=;
	b=zqcJ6/u17leV0JFAEqSgzTcmTyCddSuFCRrxEch+bwFOCRdHoZ+WDZ05DAG78DwB47/t
	 kwnHZ+HV3OfJ6dgf4IwYOCgb4vGdlvdL5EirEPvTpBg24TvpmJtLfCTQRyHiacDAJ8uJy
	 s0AoIwrqciJpIo68j3q1y5TSqWQ3kMhGzW2C14DDBFlvCaCClZMEEhKq9tnmy+Zux7dYl
	 PpzXq81QYQyibU2lCFaYeqALqW0lu25mVMnnyrPcXsb4zKlb+T5Q7FMru9aR7TdOETfk/
	 rbn115ShDCqrFJPBQRnwM9t2I5zbNGQ0aO0oI0mnbG80yLqlTRtFBBU6dsRlJcxB/8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IU8pHww6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0CA606A32C
	for <linux-pci@vger.kernel.org>; Sat,  7 Nov 2026 02:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IU8pHww6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A261F008A2;
	Sat,  7 Nov 2026 02:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794017280;
	bh=9XfkFEh0TSHNI4o8+9IDxSWg70RO4IM8GgO6QBlwGe4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IU8pHww6aTtqxArOlSen5etIRG4l49JwEvPmOoD1M/W0j+ERsjrrjxan5BlyffpgT
	 QdYmSzSTszNphsJCqJyP2rWhP/AGMxdvhIPSufjvQ1r0coP+FSNAim3qsh4aSYxU9F
	 cX2fEn4Fr+SXcpQg/aVugqMWf7XG2lgJfh8Y1H/fgrp44ZMyF/C4lykD/HMXJjIt4u
	 c5h79XB4cEqxZ1//J9tp0PjndngpCvF75nkbwAthnyjvmOjz2HuYeDngxyeD/4OHWU
	 bcSRB94WRRV4H1aVpvp4z6LnTqr3akrb611UC3/7fWfdyfBfUmBFmW6626TsHLoP/g
	 oY5vlmTGcSOsg==
Message-ID: <sashiko-outbox-202480@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/4] PCI: dwc: Add dw_pcie_mask_msi() to mask chained
 MSI without freeing domain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261107-shutdown-v8-3-bf607c6429b0@oss.qualcomm.com>
References: <20261107-shutdown-v8-0-bf607c6429b0@oss.qualcomm.com>
 <20261107-shutdown-v8-3-bf607c6429b0@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 02:07:59 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] PCI: dwc: dw_pcie_mask_msi() fails to mask chained IRQs under
  lazy disable
--

commit ab8d07addca7ae6a44fdcf9867d820b3c416593e
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

PCI: dwc: Add dw_pcie_mask_msi() to mask chained MSI without freeing domain

This commit adds dw_pcie_mask_msi() to disable the DesignWare PCIe
controller's chained MSI parent interrupt lines during shutdown without
removing the MSI IRQ domain.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> index 0837bb9e67e02..7f0126c5336bc 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -240,6 +240,28 @@ void dw_pcie_free_msi(struct dw_pcie_rp *pp)
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_free_msi);
> =20
> +/**
> + * dw_pcie_mask_msi - Mask the chained MSI parent interrupt(s)
> + * @pp: DWC PCIe RP private data
> + *
> + * Disable the controller's chained MSI interrupt line(s) to stop further
> + * MSI delivery, while leaving the MSI IRQ domain and the MSI mappings h=
eld
> + * by downstream devices intact. Unlike dw_pcie_free_msi(), this does not
> + * remove the IRQ domain, so it is safe to call from the shutdown()/rebo=
ot
> + * path where PCI devices are not removed and their MSI descriptors must=
 not
> + * be orphaned.
> + */
> +void dw_pcie_mask_msi(struct dw_pcie_rp *pp)
> +{
> +	u32 ctrl;
> +
> +	for (ctrl =3D 0; ctrl < MAX_MSI_CTRLS; ctrl++) {
> +		if (pp->msi_irq[ctrl] > 0)
> +			disable_irq(pp->msi_irq[ctrl]);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_mask_msi);

[Severity: High]
Does calling disable_irq() on pp->msi_irq[ctrl] actually mask or stop a
chained interrupt on controllers with lazy disable (such as ARM GICv2/v3)?

dw_pcie_msi_host_init() registers pp->msi_irq[ctrl] via
irq_set_chained_handler_and_data() without setting IRQ_DISABLE_UNLAZY.
When the parent irq_chip does not implement .irq_disable, disable_irq()
only sets IRQD_IRQ_DISABLED and leaves the hardware interrupt unmasked.
Standard flow handlers mask the line on the next interrupt when checking
irqd_irq_disabled(), and set IRQD_IRQ_INPROGRESS so synchronize_irq() can
wait for them, but chained handlers replace desc->handle_irq with
dw_chained_msi_isr(), which does neither.

If an MSI arrives during shutdown after controller clocks and power are
cut, dw_chained_msi_isr() -> dw_handle_msi_irq() will still run and read
unclocked DBI registers, causing an external abort or bus hang.

Detaching the chained handler with
irq_set_chained_handler_and_data(pp->msi_irq[ctrl], NULL, NULL), as
dw_pcie_free_msi() does before irq_domain_remove(), masks the hardware
interrupt via mask_ack_irq() and resets desc->handle_irq while leaving
pp->msi_irq_domain intact.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107-shutdown-v=
8-0-bf607c6429b0@oss.qualcomm.com?part=3D3
