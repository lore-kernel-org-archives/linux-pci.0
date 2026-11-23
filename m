Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461072;
	b=pg8+Djkh+KHJwEodi2dZ9cPYuGpgFJxMz3b3qn4Lykr3me3hR0aDnbTJRE+ZB9MUwdbd
	 QW09ZnxV1JzXBbBKDWiacahegoaiadf23QGuQ0L61qrgYkNm8r9ozPuYlUS+3XHat2+De
	 nnFAZ6TKNcT0t7o/p6RtDcIdmWV0fN4vElS6LaU0CjzFhtk+TK+Q/1kwDvBy7Uw6cmO1f
	 e+mGI9GzX+gOyruefpQYdzTbS+9Fn8YAvbTKFDEzURBu6PpVSg4nBtQyrryQ9R5woxCzd
	 5XTeFPPzvLJJyicGVlRu8DB73MkN7MMG1U7dxLeAV9S1f++fSSz2d76MnunlvuJMUTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461072;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Idvm97dvG7bTw2FwlJmYkLbnCrFv39HWDBLFEaw7lno=;
	b=FJKJN1ISvQPdPFIuMzGTuUP06kojdYVXsrPlCnDz86tl39yJ8eJBePKBJ3iUYOxtEMDS
	 ELSRPE1ruL/TDmtURCr6sl/HZ9W7AMdUqkFPPmAivrL3SFKkgaC3mnfUScP6b/K1Li28S
	 oQzxl7ZOi2UbNsCXZA+GctWUIn9I4VmY1F470Q5SkUi6TWgfSsXr3Q5O85ER/gPkPreAh
	 qN5yReLEIkCereDc0DA0cI9VmaHBQj/9rohAB0V0xhJgHHkte8yd9IP9LfSwMZDFWhNN8
	 jiKmn29lJxLomtbIIVWkGeelf5hvqpOPZrpqdst6hudUFcuZp2Pm8YBOkhY8aYJaGFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UXAG/h5g";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61D3606A32A;
	Mon, 23 Nov 2026 19:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UXAG/h5g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D5B1F000C4;
	Mon, 23 Nov 2026 19:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461071;
	bh=Idvm97dvG7bTw2FwlJmYkLbnCrFv39HWDBLFEaw7lno=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UXAG/h5gcaXsoQt+kMAmviAJm66SUcara9oSzYqWQUv3zd56izLHBx98PPuu3frOr
	 55T6J5QfliUjPb77RQRgs5XNY1sRYUlK45HQDb12FSEXsGHgIp/jUyiqSti40GNi+h
	 vN6a5QhqDH1CqBDyWxK3tpheymYefUO2OK6Tpt0iESphKX8M9PwFZ2MQ/e4zJhMelu
	 8++MrvB40HiXV9VlDobMoOKP75UYXR2oV9YgsQNVXiJqExu8JUHxY/LVswFdHgBpa4
	 x9egZLsGkJBnoG7JZ5//wk18XWzKQ2gtm/+WCrRxBBjgzcYn6gyIE7CaK1KQijonAL
	 SJYxBK+coqgPw==
Message-ID: <sashiko-outbox-229914@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] PCI: cs7542: Add CS7542 PCIe host support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-clk@vger.kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261123-b4-cs7542-pcie-v1-7-4cde5201d404@gmail.com>
References: <20261123-b4-cs7542-pcie-v1-0-4cde5201d404@gmail.com>
 <20261123-b4-cs7542-pcie-v1-7-4cde5201d404@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 19:11:10 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] PCI: cs7542: PCI_MSI_FLAGS_ENABLE in cortina_pcie_host_init()
  cleared on probe
- [High] PCI: cs7542: undisposed INTx virq mappings before
  irq_domain_remove()
- [Medium] PCI: cs7542: cortina_pcie_read_dbi() ~0U return masks iATU
  failure on link loss
- [Medium] PCI: cs7542: missing link_lost and IRQ sync in
  cortina_pcie_shutdown()
--

commit cd2c931b6a3541fd8734c17e2a7332622247b319
Author: Fil Dunsky <filipp.dunsky@gmail.com>

PCI: cs7542: Add CS7542 PCIe host support

This commit adds a DesignWare PCIe host controller driver for Cortina
Systems CS7542 SoCs, handling clock/reset/PHY setup, multiplexed INTx and
MSI interrupts, root configuration filtering, and link-loss blocking.

> diff --git a/drivers/pci/controller/dwc/pcie-cs7542.c b/drivers/pci/contr=
oller/dwc/pcie-cs7542.c
> new file mode 100644
> index 0000000000000..19225e9a292ef
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-cs7542.c
[ ... ]
> +static int cortina_pcie_host_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> +	u8 cap =3D dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> +	u16 flags;
> +
> +	pp->bridge->ops =3D &cortina_own_pci_ops;
> +	pp->keep_rp_msi_en =3D true;
> +	if (cap) {
> +		flags =3D dw_pcie_readw_dbi(pci, cap + PCI_MSI_FLAGS);
> +		dw_pcie_writew_dbi(pci, cap + PCI_MSI_FLAGS, flags | PCI_MSI_FLAGS_ENA=
BLE);
> +	}
> +	return 0;
> +}

[Severity: High]
Will pci_host_probe() clear PCI_MSI_FLAGS_ENABLE right after
cortina_pcie_host_init() sets it?

dw_pcie_host_init() runs pp->ops->init(pp) before calling
pci_host_probe(bridge).  Because pp->keep_rp_msi_en keeps PCI_CAP_ID_MSI
visible on the Root Port, enumerating the Root Port calls
pci_init_capabilities() -> pci_msi_init(), which clears
PCI_MSI_FLAGS_ENABLE via cortina_pcie_wr_own_conf() and leaves the Root
Port MSI receiver disabled.  Setting PCI_MSI_FLAGS_ENABLE in
pp->ops->post_init (or after dw_pcie_host_init() returns) would avoid
this.

[ ... ]

> +/* Standard RC configuration above 512 bytes wedges the CS7542 bus.
> + * The DesignWare private register bank at 0x700 and above remains acces=
sible.
> + */
> +static u32 cortina_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
> +				 u32 reg, size_t size)
> +{
> +	struct cortina_pcie *cp =3D to_cortina_pcie(pci);
> +	u32 value =3D 0;
> +
> +	if (READ_ONCE(cp->link_lost))
> +		return ~0U;
> +	if (base =3D=3D pci->dbi_base && reg < 0x700 && reg + size > RC_CFG_LIM=
IT)
> +		return 0;
> +	dw_pcie_read(base + reg, size, &value);
> +	return value;
> +}

[Severity: Medium]
Can returning ~0U from cortina_pcie_read_dbi() when cp->link_lost is set
trick dw_pcie_prog_outbound_atu() into reporting success?

CPU0                                    CPU1
dw_pcie_other_conf_map_bus()
  dw_pcie_link_up() -> true
                                        cortina_pcie_irq_handler()
                                          cp->link_lost =3D true
  dw_pcie_prog_outbound_atu()
    dw_pcie_writel_atu_ob() (dropped)
    dw_pcie_readl_atu_ob(..., ATU_REGION_CTRL2)
      cortina_pcie_read_dbi() -> ~0U
    val & ATU_ENABLE -> true
    return 0
  return pp->va_cfg0_base + where       <-- accesses downstream cfg window

Because ATU_ENABLE is BIT(31), ~0U satisfies the poll in
dw_pcie_prog_outbound_atu() even though cortina_pcie_write_dbi() dropped
the iATU writes, allowing downstream config accesses to proceed after link
loss.

[ ... ]

> +	ret =3D dw_pcie_host_init(&pci->pp);
> +	if (ret) {
> +		writel(0, cp->app + APP_INT_ENABLE);
> +		irq_set_chained_handler_and_data(cp->irq, NULL, NULL);
> +		irq_domain_remove(cp->intx_domain);
> +		goto power_off;
> +	}
> +	platform_set_drvdata(pdev, cp);
> +	return 0;
> +
> +power_off:
> +	gpiod_set_value_cansleep(cp->perst, 1);
> +	reset_control_assert(cp->reset);
> +	phy_power_off(cp->phy);
> +exit_phy:
> +	phy_exit(cp->phy);
> +disable_clk:
> +	reset_control_assert(cp->reset);
> +	clk_disable_unprepare(cp->clk);
> +	return dev_err_probe(dev, ret, "host initialization\n");
> +}
> +
> +static void cortina_pcie_remove(struct platform_device *pdev)
> +{
> +	struct cortina_pcie *cp =3D platform_get_drvdata(pdev);
> +
> +	dw_pcie_host_deinit(&cp->pci.pp);
> +	irq_set_chained_handler_and_data(cp->irq, NULL, NULL);
> +	irq_domain_remove(cp->intx_domain);
> +	cortina_pcie_power_off(cp);
> +}

[Severity: High]
Does removing cp->intx_domain without disposing of its mapped virtual IRQs
leak IRQ descriptors and leave dangling pointers to cp and
cortina_intx_chip?

During pci_host_probe(), pci_assign_irq() maps INTx interrupts in
cp->intx_domain (including for the Root Port itself, where
dw_pcie_setup_rc() sets PCI_INTERRUPT_PIN =3D 1), and the PCI core does not
unmap shared INTx lines on bus removal.  Both cortina_pcie_remove() and
the dw_pcie_host_init() error path call irq_domain_remove(cp->intx_domain)
without first calling irq_dispose_mapping(irq_find_mapping(cp->intx_domain,=
 i))
for each INTx line, leaving allocated irq_desc entries referencing the
freed domain and driver state.

> +static void cortina_pcie_shutdown(struct platform_device *pdev)
> +{
> +	struct cortina_pcie *cp =3D platform_get_drvdata(pdev);
> +
> +	writel(0, cp->app + APP_INT_ENABLE);
> +	cortina_pcie_stop_link(&cp->pci);
> +	gpiod_set_value_cansleep(cp->perst, 1);
> +	reset_control_assert(cp->reset);
> +}

[Severity: Medium]
Can cortina_pcie_shutdown() race with in-flight interrupts or subsequent
DBI accesses while asserting controller reset?

CPU0                                    CPU1
cortina_pcie_shutdown()
  writel(0, cp->app + APP_INT_ENABLE)
                                        cortina_pcie_irq_handler()
                                          dw_handle_msi_irq()
  cortina_pcie_stop_link()
  reset_control_assert(cp->reset)
                                            dw_pcie_readl_dbi()  <-- DBI ac=
cess in reset

cortina_pcie_shutdown() does not take cp->lock, set cp->link_lost =3D true,
or call synchronize_irq(cp->irq).  An in-flight IRQ handler or a
concurrent config/DBI access (which checks cp->link_lost) can access DBI
after the link is stopped and cp->reset is asserted, and a concurrent
cortina_intx_unmask() can also re-enable bits in APP_INT_ENABLE.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-b4-cs7542-=
pcie-v1-0-4cde5201d404@gmail.com?part=3D7
