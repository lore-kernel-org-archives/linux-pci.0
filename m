Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC54B30C366;
	Thu, 11 Jun 2026 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167652; cv=none; b=EKM1YhGHj34B9D+3n4YwiUm6lfEeKmmLlM51LhlXu66VsG9poJioWxEZ3raL/k+nmAMWhuxzCZxS6T/rkaKzeyr3GXe+YZGWDLzSJkpxFfgLssjLWeE3Lvu9wfo0JMhFzcrlBrcf7Vdcm0sQr9dX2wd5sw1GoYEw+e8jiBdq2LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167652; c=relaxed/simple;
	bh=67pHZ3TSGynPxEzu+fLDmz+mdHGIJ6SXEOKQqQadXPs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oYREMuteKWcoMn2p7YDqfr6Yc0kTztJZgQuCXz46noyp4vvYZL4tR01iv2kOoiBKpD7JJ8vacALEuMnvtuDP+z2TvTjuljxoyBa93hXAFoee8HrvEbhG+UdmTeE2VhBRz/WheBMHPFD0BOvcoyisIJtaEcNzV9ZHqlyXlMAttps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfB7zZdc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfB7zZdc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638101F00898;
	Thu, 11 Jun 2026 08:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781167650;
	bh=gSTauo0ljBCyKajozHATxAGtJgJBeZKLMPCocLiUM9E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LfB7zZdcMO115naXFitnLW7tMYot/pc7c/P4p62Mt1ugDWt9zoJuoqzkp0tvnde5G
	 /+Bt4yB9psGeJU9TWf0EcKsg+5AT4FrEToUxc8kNohcSbvD87TZx2HksZ/LpWOuU8r
	 ftYtwTVGVLpOdr2DrWD2s9T7oWrxC12Y9HsRriCaS0GTxjUpnPztg/w5Foo58JbU+M
	 ntHT8czv7KfgjGU4rlTxJyrP1Am9mpR7R5prbDINrKBhKibkYCQZ1tdjUkQShKcwpG
	 AthmomoGBzCyveqFyJ6bmuDxdn+9HLM70WqsYRk0fvqT1KF8RSnO86bB2hY1VO7jrx
	 cCJmEBSTXcNMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10] PCI: mediatek: Add support for EcoNet EN7528 SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Caleb James DeLisle" <cjd@cjdns.fr>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260611082329.243515-1-cjd@cjdns.fr>
References: <20260611082329.243515-1-cjd@cjdns.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 08:47:29 +0000
Message-Id: <20260611084730.638101F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Premature loop termination in `mtk_pcie_retrain` prevents remainin=
g root ports from being retrained.
- [Low] Calling `dev_err_probe()` on a child device from the parent's probe=
 context.

Pre-existing issues:
- [High] IRQ domains are leaked and leave dangling pointers when a PCIe por=
t fails to start up.
- [High] The PCIe port startup callbacks sleep while executing in the atomi=
c noirq system resume phase.
- [High] The `resource_size(mem)` parameter is silently truncated on 64-bit=
 platforms because `fls()` only accepts a 32-bit unsigned int.
--

commit f0ee2a994c044496f2233db60f4bbc71d16d530c
Author: Caleb James DeLisle <cjd@cjdns.fr>
Date:   Thu Jun 11 08:23:28 2026 +0000

    PCI: mediatek: Add support for EcoNet EN7528 SoC
   =20
    Add support for the PCIe present on the EcoNet EN7528 (and EN751221) So=
Cs.
   =20
    These SoCs have a mix of Gen1 and Gen2 capable ports, but the Gen2 ports
    require re-training after startup.
   =20
    Co-developed-by: Ahmed Naseef <naseefkm@gmail.com>
    Signed-off-by: Ahmed Naseef <naseefkm@gmail.com>
    Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controlle=
r/pcie-mediatek.c
index 6d0ee089ca74b..f4963af0d6085 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c

[ ... ]

> @@ -750,6 +761,134 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie=
_port *port)
>  	return 0;
>  }
> =20
> +static int mtk_pcie_startup_port_en7528(struct mtk_pcie_port *port)
> +{
> +	struct mtk_pcie *pcie =3D port->pcie;
> +	struct pci_host_bridge *host =3D pci_host_bridge_from_priv(pcie);

[ ... ]

> +	/* Assert all reset signals */
> +	writel(0, port->base + PCIE_RST_CTRL);
> +
> +	/*
> +	 * Enable PCIe link down reset, if link status changed from link up to
> +	 * link down, this will reset MAC control registers and configuration
> +	 * space.
> +	 */
> +	writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
> +
> +	msleep(PCIE_T_PVPERL_MS);

[Severity: High]
This is a pre-existing issue in the driver's power management design, but
will adding msleep() here cause a "scheduling while atomic" BUG?

The driver's PM ops configure mtk_pcie_resume_noirq() to run during the
system resume_noirq phase, which executes with local hardware interrupts
disabled.

Since mtk_pcie_resume_noirq() unconditionally calls mtk_pcie_enable_port(),
which then invokes this startup callback, will calling sleepable functions
like msleep() and regmap_read_poll_timeout() here trigger a panic during
system resume?

> +
> +	/* De-assert PHY, PE, PIPE, MAC and configuration reset */
> +	val =3D readl(port->base + PCIE_RST_CTRL);
> +	val |=3D PCIE_PHY_RSTB | PCIE_PERSTB | PCIE_PIPE_SRSTB |
> +	       PCIE_MAC_SRSTB | PCIE_CRSTB;
> +	writel(val, port->base + PCIE_RST_CTRL);
> +
> +	writel(PCIE_CLASS_CODE | PCIE_REVISION_ID,
> +	       port->base + PCIE_CONF_REV_CLASS);
> +	writel(EN7528_HOST_MODE, port->base);
> +
> +	link_mask =3D (port->slot =3D=3D 0) ? EN7528_RC0_LINKUP : EN7528_RC1_LI=
NKUP;
> +
> +	/* 100ms timeout value should be enough for Gen1/2 training */
> +	err =3D regmap_read_poll_timeout(pcie->cfg, EN7528_LINKUP_REG, val,
> +				       !!(val & link_mask), 20,
> +				       PCI_PM_D3COLD_WAIT * USEC_PER_MSEC);
> +	if (err) {
> +		dev_err(pcie->dev, "EN7528: port%d link timeout\n", port->slot);
> +		return -ETIMEDOUT;

[Severity: High]
This is a pre-existing issue, but does returning an error here leak IRQ
domains?

When this function returns -ETIMEDOUT for an empty slot, the caller
mtk_pcie_enable_port() executes its error path and calls
mtk_pcie_port_free().

However, mtk_pcie_port_free() frees the port struct using devm_kfree(), but
it never tears down the IRQ domains using irq_domain_remove(). Does this
permanently leak the IRQ domains on every empty slot timeout and leave their
domain->host_data pointers dangling to the freed port struct?

> +	}
> +
> +	/* Activate INTx interrupts */
> +	val =3D readl(port->base + PCIE_INT_MASK);
> +	val &=3D ~INTX_MASK;
> +	writel(val, port->base + PCIE_INT_MASK);
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		mtk_pcie_enable_msi(port);
> +
> +	/* Set AHB to PCIe translation windows */
> +	val =3D lower_32_bits(mem->start) |
> +	      AHB2PCIE_SIZE(fls(resource_size(mem)));

[Severity: High]
This is a pre-existing issue, but is resource_size(mem) silently truncated
here on 64-bit platforms?

The resource_size(mem) function returns a resource_size_t, which is a 64-bit
integer on 64-bit architectures. Since fls() only accepts a 32-bit unsigned
int, if the resource size is 4GB (0x100000000) or larger, will the lower 32
bits evaluate to zero or be truncated, causing fls() to return an
incorrectly small value and misconfiguring the inbound translation window?

> +	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);

[ ... ]

> +static int mtk_pcie_retrain(struct device *dev, struct pci_host_bridge *=
host)
> +{
> +	struct pci_dev *rp;
> +	int ret =3D -ENOENT;
> +	u16 lnksta =3D 0;
> +	u32 speed;
> +
> +	/* Should already have been warned about during startup_port */
> +	if (!IS_BUILTIN(CONFIG_PCIE_MEDIATEK))
> +		return 0;
> +
> +	guard(rwsem_read)(&pci_bus_sem);
> +
> +	for_each_pci_bridge(rp, host->bus) {
> +		if (pci_pcie_type(rp) !=3D PCI_EXP_TYPE_ROOT_PORT)
> +			continue;
> +
> +#if IS_BUILTIN(CONFIG_PCIE_MEDIATEK)
> +		ret =3D pcie_retrain_link(rp, true);
> +#endif
> +
> +		if (ret)
> +			return dev_err_probe(&rp->dev, ret,
> +					     "failed to retrain port\n");

[Severity: High]
Does returning early here prevent the remaining root ports on the bus from
being retrained?

If pcie_retrain_link() fails for any port (for example, due to a timeout on
an empty slot), this aborts the loop. Since mtk_pcie_probe() intentionally
ignores the return value of mtk_pcie_retrain(), the early return doesn't
propagate the error but causes subsequent ports to be permanently stuck at
Gen1 speeds.

Should this instead log the error and continue to the next port?

[Severity: Low]
Additionally, is it correct to call dev_err_probe() on the root port
(rp->dev) here?

Since this function executes as part of the parent host controller's probe
sequence (mtk_pcie_probe()), the root port is not the device actively
probing. Will calling dev_err_probe() on a device that is not currently
probing print a misleading message (like 'probe of <device> failed')?

Should standard pci_err(rp, ...) be used instead?

> +
> +		pcie_capability_read_word(rp, PCI_EXP_LNKSTA, &lnksta);
> +		speed =3D lnksta & PCI_EXP_LNKSTA_CLS;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611082329.2435=
15-1-cjd@cjdns.fr?part=3D1
