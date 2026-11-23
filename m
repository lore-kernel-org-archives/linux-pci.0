Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795459951;
	b=w2zwUbu9r72pF1kbUeSWoqwxGgmlYkqh9w+ItqmxPGOHBs5Rn5RfBls/uA2cdttrknTg
	 vEQlaeucvwvyAQf1uCg8aFc/z6yRlzj246Kx3m6EFxHZI6fIGjlMa1/Fqu4J61I+POIbf
	 dpyZ3ccXKMl9jgA3pmX4yb6YrgDw4STbeUuEds3B2Z8BL3A8+CKIch2SQEI4gHc0txYmt
	 LRG1qZb5/IrgVho5BW+SXuG0bEkkWBJ1HDaI/SR7nLAUItrqD2sAHpD57EKioEGgpdXmG
	 0AlCMww1b18pv/XEioDye2B7G0DYssVvQVDeUoYPo0LELeDyl7qe1B8le9RPE5QV92A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459951;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lstZztA1mDrFB9PHgmMDTPXyLU6CoCr0SlAF6QN7mvs=;
	b=NOHSfLoh5WsG3+Crt8JpBxwQOZaozcaf1uvOsJU+Vm73+Mu3FKAYclW5aWikusCQiq2D
	 U9tjmF26heAUw2JzOMc9iudzA/GKFf31pPDSLsU3c6UgBgQv0xGiiol2+VZLqtyIvTxdX
	 TpfOpDC5B6y8q6otFQWb6ag4XCTy4fbWLq6wGrmoC/qccc4hfyvmxV7XoEaJqnwxQAm3P
	 BGF1uYZJ187kIfEI4tWcrWkEcZZ2eP1v1S9By68MCXbV/il9GDzkbSsKQLwc9EIQbDXKv
	 kZqx48+46jaWTaRecu1thpfLpzyUxE7mY5x2vEsKD16CermckpNbvA7mk/Mh/Ah6WsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N5cF+hLo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87FA606A31A;
	Mon, 23 Nov 2026 18:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N5cF+hLo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF8E1F000CA;
	Mon, 23 Nov 2026 18:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795459951;
	bh=lstZztA1mDrFB9PHgmMDTPXyLU6CoCr0SlAF6QN7mvs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N5cF+hLoAXbdEfg9OAUtdpa+W9up/V1euG8ChQytlr0NcTZZCcjHdGaFRU+T4PEOT
	 uGyPQGU28YUhJqOpSFOFomRWPxccePnFxBTYKIFJkhe7Rb+do1mrKzmdGlECwKhz/S
	 63Snfrck46LBTbNK3xzuHmcqzPmln7GO7qCdyOYo13o1SCSuYOmj4Ig6BB/rz/ta1n
	 VRxkL+NEvDN46UHdlgNHI7t0AJS92+det5KvUC1zTNaMmSXrWz7JdxDNJfeRjc1vL1
	 9A4rjAPpOSfVvU/cO6ppoJmcYbgaQzBW0U0qvXUTgxUvQHmkhSrXkQAt0BhJSDpnzO
	 N54bVzQdj7o5A==
Message-ID: <sashiko-outbox-229882@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/8] PCI: dwc: Export the multiplexed MSI interrupt
 handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-clk@vger.kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261123-b4-cs7542-pcie-v1-1-4cde5201d404@gmail.com>
References: <20261123-b4-cs7542-pcie-v1-0-4cde5201d404@gmail.com>
 <20261123-b4-cs7542-pcie-v1-1-4cde5201d404@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 18:52:30 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] PCI: dwc: use-after-free in dw_pcie_free_msi() [1]
--

commit 73ef750c2f801a3eaf7bfcf95e0a5bd88aebd4c3
Author: Fil Dunsky <filipp.dunsky@gmail.com>

PCI: dwc: Export the multiplexed MSI interrupt handler

This commit exports dw_handle_msi_irq() so that modular DesignWare PCIe host
glue drivers can dispatch the internal MSI receiver directly from a combined
application interrupt handler.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> index bbb02458af58f..1d076bb62783c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -85,6 +85,7 @@ void dw_handle_msi_irq(struct dw_pcie_rp *pp)
>  			generic_handle_demux_domain_irq(pp->msi_irq_domain, irq_off + pos);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(dw_handle_msi_irq);
> =20
>  /* Chained MSI interrupt service routine */
>  static void dw_chained_msi_isr(struct irq_desc *desc)

[Severity: Critical]
This problem wasn't introduced by this patch, but can dw_handle_msi_irq() h=
it
a use-after-free on pp->msi_irq_domain when racing with dw_pcie_free_msi()
[1]?

During device unbind or module removal, dw_pcie_free_msi() clears the chain=
ed
MSI handlers with irq_set_chained_handler_and_data() and immediately removes
pp->msi_irq_domain without waiting for in-flight interrupts on other CPUs:

drivers/pci/controller/dwc/pcie-designware-host.c:dw_pcie_free_msi() {
	for (ctrl =3D 0; ctrl < MAX_MSI_CTRLS; ctrl++) {
		if (pp->msi_irq[ctrl] > 0)
			irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
							 NULL, NULL);
	}

	irq_domain_remove(pp->msi_irq_domain);
}

If dw_chained_msi_isr() is already running on another CPU when teardown
starts, dw_handle_msi_irq() will pass the freed pp->msi_irq_domain to
generic_handle_demux_domain_irq():

CPU0                                    CPU1
dw_pcie_free_msi()                      dw_chained_msi_isr()
  irq_set_chained_handler_and_data()
  irq_domain_remove(pp->msi_irq_domain)
                                          dw_handle_msi_irq(pp)
                                            generic_handle_demux_domain_irq(
                                              pp->msi_irq_domain, ...)
                                              <-- use-after-free

Calling synchronize_irq() for each active pp->msi_irq[ctrl] before
irq_domain_remove() would ensure no chained handler is still running.

[1] https://sashiko.dev/#/bug/linux-a392f803-d749-417f-bb89-17e283cf6476

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-b4-cs7542-=
pcie-v1-0-4cde5201d404@gmail.com?part=3D1
