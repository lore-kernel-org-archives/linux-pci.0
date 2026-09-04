Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BF83769ED
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 01:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788485633; cv=none; b=Mf4jcl+YbxZYDp25iSuLq90Y0DImacb8UJOcYI2YczbjYOWf2F8uJdj1/wV7LsycKYE0+0nYBS8Q9W2uC1pwWehAI+Ii4czc4x8HlwBdt+W1CHsFMM9Wwgo706qMrJE5gIbSPmV6CF3NGCDEeoa8rOnpXB48wmp4r/MP6xtFHFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788485633; c=relaxed/simple;
	bh=mM36IsR2jRQVc+D5SHkywgPiCg/9c3lBv6nWk/lJCs0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ggZx9+j2hmMLd+yZnq2oyrt6O197ntWfzYG/PYLheC6NoqEG+WkcCKrc10q/8NZ6s1vkdAaoYX7lIT6Em+oAESi6h4WbBLc2iNnsGuPokfCRadYZUH8mU/p+JaolrLYu1lWQqKtjD+AFJkWm+A8HkmjbROoDpHi1SnOujp+OGt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIUvWsGG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIUvWsGG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247FF1F00A3E;
	Fri,  4 Sep 2026 01:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788485632;
	bh=XEvDDdBxaPLDaqW+utR4UvxrYPw7nSfycOf5bmzdJow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LIUvWsGGNH0MHtCkZg6KlGNgHd9KichAdRIdRi9t8FLqk/s6fyvEvdUIvPSCmitEq
	 xLQagjbJnClm0pjMZoKmE8jsOFrTqOOXybJuEEB+VtrRyhteggNpL3J9cvH0YQ1UYp
	 4ZmWEavYhcMtRb/nEmHepBnBiw2kd1BaaEaoNBQVbLkrQnngEMX537N08uT0X5G9T+
	 sPcNkt8AxLF7C0fnqHUX7LtSHQ3fkzUAPO++t+TZXJ4fAzgGnBwT2sMC7UhOuq3qFC
	 /VEP5qJp7ilinUS5zPykgoKuHfIrQUAmECSbX6ldjbaCBwTG0QazIPyRFTpDU1qEXl
	 qE94BV6CYP1hA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dw-rockchip: Move the INTx irq setup to
 probe and make it devm-managed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shawn Lin" <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <1788484709-139123-2-git-send-email-shawn.lin@rock-chips.com>
References: <1788484709-139123-1-git-send-email-shawn.lin@rock-chips.com>
 <1788484709-139123-2-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 01:33:51 +0000
Message-Id: <20260904013352.247FF1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Probe failure after dw_pcie_host_init() skips required dw_pcie_hos=
t_deinit() cleanup, causing a severe use-after-free and resource leak.
- [High] PCI host enumerated before INTx IRQ domain is created, causing dow=
nstream legacy interrupts to unconditionally fail.

Pre-existing issues:
- [High] Early SYS IRQ firing causes NULL pointer dereference in rockchip_p=
cie_rc_sys_irq_thread.
--

commit 34e8273412a67c1e80ddbd4e8fe81a6ec9d9efab
Author: Shawn Lin <shawn.lin@rock-chips.com>

PCI: dw-rockchip: Move the INTx irq setup to probe and make it devm-managed

This commit moves the INTx IRQ domain creation and chained handler setup
into the probe function, managing their lifetimes with devres. This prevents
IRQ domain leaks and use-after-free issues during root port resets.

> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index af26a07c0c9e5..ecf0d7e043b36 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c

[ ... ]

> @@ -739,6 +739,33 @@ static int rockchip_pcie_configure_rc(struct platfor=
m_device *pdev,
>  		return ret;
>  	}

[Severity: High]
This is a pre-existing issue, but does the current driver initialization
order risk a NULL pointer dereference in rockchip_pcie_rc_sys_irq_thread()?

The SYS IRQ is requested with devm_request_threaded_irq() earlier in
rockchip_pcie_configure_rc(), before dw_pcie_host_init() is called.
If the IRQ fires immediately (for example, if the bootloader leaves a
pending link-down reset status), rockchip_pcie_rc_sys_irq_thread() will
iterate over pp->bridge->bus. However, pp->bridge is not allocated until
dw_pcie_host_init() runs, which would cause a crash.

> =20
> +	/*
> +	 * This is done here instead of in the host ops .init() callback,
> +	 * which is also re-run by .reset_root_port(), so that the INTx irq
> +	 * domain is only created once, at probe time.
> +	 */
> +	rockchip->intx_irq =3D of_irq_get_byname(dev->of_node, "legacy");
> +	if (rockchip->intx_irq < 0)
> +		return rockchip->intx_irq;

[Severity: High]
If of_irq_get_byname() fails here, the function returns directly. Since
dw_pcie_host_init() has already successfully executed and registered the
PCI host bridge, does this path need to call dw_pcie_host_deinit() before
returning?=20

Without explicit cleanup, devres will free the rockchip_pcie structure on
probe failure, while the PCI subsystem might still retain active references
to the host controller. Can this cause a use-after-free?

> +
> +	ret =3D rockchip_pcie_init_irq_domain(dev, rockchip);

[Severity: High]
Since the INTx IRQ domain is now instantiated after dw_pcie_host_init()
has completed, will this cause legacy interrupts for downstream devices to
fail unconditionally?

The dw_pcie_host_init() call enumerates the PCI bus and probes downstream
devices. If those devices attempt to request legacy INTx interrupts during
their probe, the INTx IRQ domain will not exist yet.

> +	if (ret < 0) {
> +		dev_err(dev, "failed to init irq domain\n");
> +		return ret;
> +	}

[Severity: High]
Similarly to the above error path, returning here skips tearing down the
enumerated PCI host via dw_pcie_host_deinit(), which leaves dangling
references to the host structure.

> +
> +	irq_set_chained_handler_and_data(rockchip->intx_irq,
> +					 rockchip_pcie_intx_handler, rockchip);
> +
> +	/*
> +	 * Uninstall the chained handler on probe failure, so that it can
> +	 * never run against the devm-freed rockchip structure.
> +	 */
> +	ret =3D devm_add_action_or_reset(dev, rockchip_pcie_intx_chained_releas=
e,
> +				       rockchip);
> +	if (ret)
> +		return ret;

[Severity: High]
This error path also skips dw_pcie_host_deinit(). Should all of these new
error returns be updated to properly unregister the PCI host?

> +
>  	/* unmask hot reset/link-down reset */
>  	val =3D FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
>  	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1788484709-139123-1=
-git-send-email-shawn.lin@rock-chips.com?part=3D1
