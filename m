Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794622651;
	b=Fs7LBvei24AylOCgsySgsVOhwLeIfxHClDcGxzdWl0lVb51SHHmsuiQobCM4ptHZW93I
	 sGkPhO/61iHPNgYOiq/0p1Pc4Z0uIOX8wl095pkJLpNxbITktYxcSNVYMlxPCVlBnby5f
	 ZxnEkT30fdiTf6BjgostLivYLFe29gmdxrlNSXkkCiiRWSIm3BtGqAG+V8HpoGLxdxz4V
	 zNSt1IxOQLJytv11UHQmbjqAyxN3EsxzRvbpE2rzjR4h7iX8jOdopFlqleokBZMW296Lf
	 t4THDBSsiDgGZOOZTYnrcAczyLcUE9C4KH9V89C5C6KihcyT5rGCxLiumynJW5h5Z9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794622651;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/0PPi8HgOWwIYA6DTpAtpiOs8DnZtX8Uk3deaRG/IQ0=;
	b=q/mZwg3HFExZpKIn85PFqcGxB6qus2+wzcq1aOH9HBMWc5H9W18hKiGV+hWflrIbdItf
	 cvQHojtjQlKkxqZpA4mNJliQDFOBfK3llyWXx9ZZtBy4XEk5wUFvHpzAdHbcd0hoeg1mX
	 auMUJt3Zg7Oxu591JfCgTX5/aNDS/PiB5iEWIcVfcZq34pS8wmFFc8Jz02voBYsGltH5K
	 DtsXMliEoRAri2Uajo90zKrdhEyZmdngApKICt1Opt6qVvakYnRkUiF8bBd3lsnLQcb/v
	 mzX55ZFYI6EUQEQDXki6KX/Gk+WF9flAoUtBAUUrnUwQYjvH4jbN7BQ/39FHEx8gTmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iGM4hQ3X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02004606A332
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 02:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iGM4hQ3X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597E51F000C4;
	Sat, 14 Nov 2026 02:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794622650;
	bh=/0PPi8HgOWwIYA6DTpAtpiOs8DnZtX8Uk3deaRG/IQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iGM4hQ3XIXezBGbBAazazQKICQtPX5YuyU09UrKXBHAfX2X+gZsaTvLOgqSVos2vr
	 WpcL8/B2mbrdg16nhjfudOLzbEPJ+cua3PksHWKw3y+XotCjoVM92fVPmTaTeNZ6OH
	 U/cRk0z0L5x9ScEgDrmbOm62L3vh6eMHRdUh+N50NjSqtspP2WMI4H/3khK24UUkzo
	 RolZQtXbzUnVKVafm8Zb0TI0ivOQHa7e8Xp6FKYCtr6Egbt5r63b6P5NPjRCne9vkX
	 6EY70ZRdZy3MAsHyDETaSIusgTAaQ1Ag05jFkmRvIXkyTNVfxnbwmP7DO2e5xtR3WW
	 VUjnPdPgVO92g==
Message-ID: <sashiko-outbox-214048@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/4] PCI: qcom: Implement shutdown() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261114-shutdown-v9-4-5430c9f242ed@oss.qualcomm.com>
References: <20261114-shutdown-v9-0-5430c9f242ed@oss.qualcomm.com>
 <20261114-shutdown-v9-4-5430c9f242ed@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 02:17:29 +0000
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
- [Medium] PCI: qcom: chained MSI IRQs left unmasked by
  dw_pcie_mask_msi() in shutdown
--

commit 4909e5bc39d1622646337d65d38a92d3c39b97f5
Author: Manivannan Sadhasivam <mani@kernel.org>

PCI: qcom: Implement shutdown() callback

This commit implements the platform driver shutdown() callback for the
Qualcomm PCIe host controller to mask interrupts, transition the link to
L2, and disable runtime PM during system shutdown.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index 5327792957340..0f548c6ce6a88 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c

[ ... ]

> @@ -2467,6 +2478,24 @@ static int qcom_pcie_probe(struct platform_device =
*pdev)
>  	return ret;
>  }
> =20
> +static void qcom_pcie_shutdown(struct platform_device *pdev)
> +{
> +	struct qcom_pcie *pcie =3D platform_get_drvdata(pdev);
> +	struct dw_pcie *pci =3D pcie->pci;
> +
> +	if (pcie->global_irq)
> +		disable_irq(pcie->global_irq);
> +
> +	if (pci->pp.use_imsi_rx)
> +		dw_pcie_mask_msi(&pci->pp);
> +
> +	if (!pcie->cfg->firmware_managed && !pci->suspended)
> +		dw_pcie_suspend_noirq(pci, true);
> +
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +}

[Severity: Medium]
Does dw_pcie_mask_msi() actually mask or detach the chained MSI handler
before DBI clocks are turned off?

dw_pcie_msi_host_init() registers each pp->msi_irq[ctrl] as a chained
handler via irq_set_chained_handler_and_data() with dw_chained_msi_isr(),
and dw_pcie_mask_msi() only calls disable_irq() on those interrupts.  On
interrupt controllers whose irq_chip does not implement .irq_disable (such
as GICv3 on Qualcomm SoCs) and when unlazy disable is not set,
__irq_disable() only marks the descriptor disabled in software without
calling mask_irq().

Because generic_handle_irq_desc() invokes desc->handle_irq directly for
chained interrupts, dw_chained_msi_isr() does not check
irqd_irq_disabled().  If a late or spurious MSI arrives after
dw_pcie_suspend_noirq() or pm_runtime_put_sync() cuts DBI clocks and
power, dw_chained_msi_isr() will still call dw_handle_msi_irq() and read
unclocked DBI registers, causing an SError or NoC fault.

Clearing the chained handler via irq_set_chained_handler_and_data() (as
dw_pcie_free_msi() does) would shut down and mask the parent IRQ line at
the interrupt controller while leaving the MSI domain and mappings intact.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-shutdown-v=
9-0-5430c9f242ed@oss.qualcomm.com?part=3D4
