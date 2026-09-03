Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044C11A9B24
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 03:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788405192; cv=none; b=AGbiR3dzMmysZAkll116GTLgApiCtvfh3I4RAZPk4qzNDlHeGxfp5UPqfdSXXzKT+RHH3htRiVwQkL7nsTJlE/yF5v0hnxptfRq7kQZD05K+1Qpo3KgUNO6EXd2Dfg9sI4Jr/Zf3vSllvmxKEFWqZhkpdp4boIFG/ZOOQATappk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788405192; c=relaxed/simple;
	bh=v4tJLwbqeqKbZpwcnMsKGrKFwusDVGFkprbAiJ/+8Vk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j8SoTEUTXgO0o/eqFtUYC61R8KNJ45DNUuJ/j2VrQZBo0qALE3XONrVUb1yK83YDpHyKTsWlnjfQd10xxpOOeBAKTNGwRIZ8Pg7rD4u7PG/qa37TDyivDfOB+4NsFgzqCuSFgFKoL6p9j0Gt4GQMHJX6n7sRSqgacndtDk0vb64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBi+5Kql; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBi+5Kql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA0F1F000E9;
	Thu,  3 Sep 2026 03:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788405190;
	bh=DQLadWpfEZVVx7SIFf1spaFI72RXUy9mFJgw2QUg3zI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XBi+5KqlPjQka/mAMj/YQiPZTme8roJG0HwwVitSGtiAB1FNt6okjR/CaRbmmaW30
	 OLlG2Xfi/ZykxBPH2Ti+efmrZ/QxxWOF1XOKqek3VwV8aN8m5JBMUQ2CSUGWWEQ5Zf
	 1MJqvFFyy/57gd8DRm+izOITHGmWFZJN0DW4+yT/yzAFSGiTG4lDpFKkNzg3czQubP
	 HsIy++ijdXCtLrM8coHcMvo4nZt3WINHzGLimhAXwxEFGAoZ2dbTH4TG4lUtKJAuZP
	 /xUiF5bfsDEaSz3tejcRjkjOh2dLoMRZ2BBv6PuFnnbdmpdeGhHFZhXNBTPn06EqmY
	 mEsXqJaPWED3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI: dw-rockchip: Do not recreate the INTx irq
 domain on root port reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shawn Lin" <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <1788403477-71491-3-git-send-email-shawn.lin@rock-chips.com>
References: <1788403477-71491-1-git-send-email-shawn.lin@rock-chips.com>
 <1788403477-71491-3-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 03:13:09 +0000
Message-Id: <20260903031310.5FA0F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Probe error path and driver unload fail to clean up INTx irq domai=
n and chained handler, leading to a potential use-after-free and memory lea=
k.
- [High] Disabling clocks during root port reset without masking IRQs can c=
ause a synchronous external abort.
- [High] Double PHY de-initialization permanently bricks the PCI controller=
 on subsequent resets.
- [High] DBI registers are accessed before the controller is set to RC mode=
 during root port reset.
--

commit 2778c4d5819445db0e096281981b7df261e7bc31
Author: Shawn Lin <shawn.lin@rock-chips.com>

PCI: dw-rockchip: Do not recreate the INTx irq domain on root port reset

This patch extracts the programming of Root Complex registers out of
the .init() callback into a separate rockchip_pcie_host_hw_init() function.
It then calls this new function from .reset_root_port() instead, ensuring
the INTx IRQ domain and chained handler are set up only once at probe time.

> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index 50824c8b1d83e..ff9239403cf22 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
[ ... ]
> @@ -440,13 +459,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp=
 *pp)
>  	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
>  					 rockchip);

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for the INTx
irq domain and chained handler to be leaked on probe failure or driver
unload?

If rockchip_pcie_host_init() or a later step in probe fails, devres will fr=
ee
the rockchip structure. However, it appears the irq domain is created in
rockchip_pcie_init_irq_domain() without devm management and is never remove=
d.
Additionally, the chained handler is assigned with the rockchip structure as
data but is never cleared on the error path.

If the legacy IRQ fires after probe failure, could the chained handler
(rockchip_pcie_intx_handler) dereference the freed rockchip pointer and cau=
se a
use-after-free panic? Also, since the driver lacks a .deinit callback, does
this permanently leak the domain on module removal?

[ ... ]
> @@ -920,11 +933,7 @@ static int rockchip_pcie_rc_reset_root_port(struct p=
ci_host_bridge *bridge,
>  	if (ret)
>  		goto deinit_phy;

[Severity: High]
This is a pre-existing issue, but does this jump lead to a double PHY
de-initialization that permanently bricks the PCI controller?

If the reset fails (e.g., dw_pcie_start_link() fails later in this function=
),
the code jumps to the deinit_phy label and calls rockchip_pcie_phy_deinit().
However, rockchip_pcie_rc_reset_root_port() already unconditionally calls
rockchip_pcie_phy_deinit() near the top of the function.

If the PCI core attempts another reset later, the unconditional deinit at t=
he
top will execute again. Does this erroneously drop the PHY's power_count and
init_count from 0 to -1, causing subsequent rockchip_pcie_phy_init() calls =
to
silently fail to power on the PHY?

[Severity: High]
This is another pre-existing issue, but can disabling clocks during root po=
rt
reset cause a synchronous external abort (SError) if the chained IRQ is not
masked?

Earlier in rockchip_pcie_rc_reset_root_port(), the controller clocks are
disabled via clk_bulk_disable_unprepare() before resetting the hardware. If=
 an
unhandled interrupt fires concurrently while the clocks are disabled, the C=
PU
will attempt to execute rockchip_pcie_intx_handler(), which directly reads
PCIE_CLIENT_INT_STATUS over the unclocked APB bus.

Should the chained IRQ be explicitly masked (or disable_irq() used) before
disabling the clocks to prevent accessing unclocked APB MMIO space?

> -	ret =3D pp->ops->init(pp);
> -	if (ret) {
> -		dev_err(dev, "Host init failed: %d\n", ret);
> -		goto deinit_clk;
> -	}
> +	rockchip_pcie_host_hw_init(pp);

[Severity: High]
This is a pre-existing issue, but does rockchip_pcie_host_hw_init() access =
DBI
registers before the controller is explicitly set to Root Complex mode?

During reset, rockchip_pcie_rc_reset_root_port() applies a hardware reset v=
ia
reset_control_assert(). It then calls rockchip_pcie_host_hw_init(), which w=
rites
to DBI registers (like PCI_BASE_ADDRESS_0) and accesses PCIe capabilities.

Since the controller is instructed to act as a Root Complex
(PCIE_CLIENT_MODE_RC) only after rockchip_pcie_host_hw_init() returns, does
accessing the PCI configuration space prematurely violate hardware state
constraints and risk an SError on the AXI bus?

> =20
>  	/* LTSSM enable control mode */
>  	val =3D FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1788403477-71491-1-=
git-send-email-shawn.lin@rock-chips.com?part=3D2
