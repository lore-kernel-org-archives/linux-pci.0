Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794622671;
	b=aDGKwo07TE11dcT1uINxG9lthmuAocvRZjPB4MpJwweooq9aBqKQ1yK6Bkf4i24YqWTK
	 Vn1Ou9sKujBoyGil32dcIGNEk5W08E8N+fR1+CUITa2jt9IOgJnU36ibivtDTqo1nCsj+
	 kThROH+pv0Z6RF4rb1v8PR8MliDlglfvT3qhu2G1X1GyS1A07fGVA0iXHVe21zvWWaRmt
	 yoa7L4VxM32eKdY7D15FqgZHCCzBEgit1idz8GEwUrE4CZG3YMHUDBH5LbE/2kRahO/Gp
	 BEPmc6ct0MZwXsh5VIwq4eWx/m/Wo9066Oy7P0wbuIvvariBORa/XDSZyr/ykGAT2Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794622671;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/Y2Pv2s4ndneyhn4G+cLSlksHZLv57VZHPqMDhqOrog=;
	b=hfe3s+O2NJ9poHCeW3hlXG69tyhOqhPhGl9VkLmw8ucHffRfeIAkD9ddhAjPzAaZnS3J
	 VfnfOIxsz79oo+uXqTpvFtYKPWw24k/e07+T06llaW6u1acHfg7+fj+PEbgfDNKCnTaER
	 59IlUS4AyEzoghlnHLkYlrjuNCExrTtsjOoW/+NrllofpL659V6YiQ+KYvdZR1eEh7EtH
	 DxPSQD6M62C1DfJQ42ZKN+Tp+XaRnWbZU7ptyxzgHyzUfsVrCE9LuP2aa0lg5maKy895I
	 eT3lzkOifn2t1LvttAwe1nt61YOrb/zeNO4d+h99AdIKZWftUuXvTfkDYRLpsKw9efw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+h060o4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C23606A327
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 02:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+h060o4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6201F000C4;
	Sat, 14 Nov 2026 02:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794622671;
	bh=/Y2Pv2s4ndneyhn4G+cLSlksHZLv57VZHPqMDhqOrog=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B+h060o4iIFgOeQ3CKZ3WKhvrxpfjyeMsDorfRkXZ1Y7NgxnQDYgvyr8RLyVxD+hy
	 keJ8NlQt0gurKbaxBoP0HXqKMSoEBeFtV/iSbV92foQWW4BxSVKQhT7obs7cbRoMmi
	 PLPZV5htbiGGmHPZZ/5rNx/C7RiXLdmXGt8d+nc2Viln3X5RKj/9EOcK5Nhr0p8WLW
	 cNSb+RwWDC8dy0KedOZ82XZWUWxaVhXtCdUjhmAZTUnNudPrDWFxF6uiMgXPWzp4Zd
	 LtflKdfV3AMaqmiW86irGIIdYB1mEqE6RkqD1pv7fn6vMbp2Ho9zKzRtQJPaKZWsBB
	 2JExnAZvUgHMQ==
Message-ID: <sashiko-outbox-214049@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/4] PCI: dwc: Add dw_pcie_mask_msi() to mask chained
 MSI without freeing domain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261114-shutdown-v9-3-5430c9f242ed@oss.qualcomm.com>
References: <20261114-shutdown-v9-0-5430c9f242ed@oss.qualcomm.com>
 <20261114-shutdown-v9-3-5430c9f242ed@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 02:17:50 +0000
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

commit d4b2b9fb18b8b61f597edf1b19b5aa67a2433fc6
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

PCI: dwc: Add dw_pcie_mask_msi() to mask chained MSI without freeing domain

This commit adds a dw_pcie_mask_msi() helper to disable the controller's
chained MSI parent interrupts without removing the MSI IRQ domain.

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
Does disable_irq() actually mask pp->msi_irq[ctrl] when it is registered as
a chained handler via irq_set_chained_handler_and_data()?

On interrupt controllers that do not implement .irq_disable (such as ARM
GICv2 and GICv3), disable_irq() performs a lazy disable unless
_IRQ_DISABLE_UNLAZY is set: __irq_disable() only sets IRQD_IRQ_DISABLED and
leaves the hardware line unmasked, relying on standard flow handlers to
check irqd_irq_disabled() and mask the interrupt on the next delivery.

Because dw_pcie_msi_host_init() installs dw_chained_msi_isr() as a chained
flow handler, generic_handle_irq_desc() invokes dw_chained_msi_isr()
directly without checking irqd_irq_disabled() or setting
IRQD_IRQ_INPROGRESS.  As a result, disable_irq() neither masks the hardware
interrupt nor synchronizes with an in-flight handler, and any MSI arriving
during or after controller clock/power teardown in the shutdown path will
still run dw_handle_msi_irq() and read unclocked DBI registers.

Calling irq_set_chained_handler_and_data(pp->msi_irq[ctrl], NULL, NULL), as
dw_pcie_free_msi() does before removing the domain, detaches the handler
and masks the interrupt line under desc->lock while leaving
pp->msi_irq_domain intact.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-shutdown-v=
9-0-5430c9f242ed@oss.qualcomm.com?part=3D3
