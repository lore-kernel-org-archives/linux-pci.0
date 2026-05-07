Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDFF3CF69D;
	Thu,  7 May 2026 22:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778193739; cv=none; b=jn/oF2e4qn6Q3NeADv1SckusvEV4+Dxtx+e2HJk0Kfx8cL4jIxZg6XFZvidVz8cOCdGEFZWcPhq6LoMTAg5LKAElcaw3l1v3Whet2nnzbm+IWzjnrEl442aY1fXTldOY+zG9IVE0AD/4tVGV/UArzjQhM3CppeURftR4yCgM5ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778193739; c=relaxed/simple;
	bh=J0kRFG9bUaWTTHIU1f8/BZmV72pbWWRzeSv5tn2IJ+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qreVWgYtvi809Em1da/n4yDmuID8/BEb8XUTAn9f2lhSF/u/MI8r+Bj/3XcBa4Y0hV+3+mKya1ODNsRMyg7BDWkHLmBAD7+d8eZxENKy+Nxo6UDM/uwb+6+CCbOx3h8tA8is9ULzkc/KLEEX5wW/VS4gB3E1xHRmmkF/HW/u1VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZ8OJoJD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZ8OJoJD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED86C2BCB2;
	Thu,  7 May 2026 22:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778193739;
	bh=J0kRFG9bUaWTTHIU1f8/BZmV72pbWWRzeSv5tn2IJ+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pZ8OJoJDjVp74T5HTAFYAW24ULTzTS5u6XyQpEYzf/fwJ5askHm4Fepx+Mb8uIuBh
	 TTWkblCiS9WBse7RVNTyWkBEd6TQDKcRX4EFPjrBJ1/wnrNBYScemGuDwm5uQmWla2
	 F/28EibEfFcTpulfbdWpo4wOhiE4GwjNtSEVwOK9iKai27Zxp2rvtKUTNoPQ+UJR9B
	 N7G5SWN8B3xOPKcvsiFMQTUaj/25gFtPjx0RFsJAuhRUmDrSRJg5R0nF0XDYF1LUdZ
	 saU/G2E92XATlbrCE6iN3x0H4Jfxqq+T1rAzFc+lQSLeDTrl0JYmf65tvMbU+dZE+U
	 or2kQaRwQdKVA==
Date: Thu, 7 May 2026 17:42:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Alex Elder <elder@riscstar.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 5/5] PCI: spacemit-k1: Add Spacemit K3 PCIe host
 controller support
Message-ID: <20260507224217.GA48780@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260502101319.2364052-6-inochiama@gmail.com>

On Sat, May 02, 2026 at 06:13:18PM +0800, Inochi Amaoto wrote:
> The PCIe controller on Spacemit K3 is almost a standard Synopsys
> Designware PCIe IP with extra link and reset control. Unlike
> the PCIe controller on K1, this controller supports external MSI
> interrupt controller and can use multiple phy at the same time.
> 
> Add driver to support PCIe controller on Spacemit K3 PCIe.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Sashiko had some good questions:
https://sashiko.dev/#/patchset/20260502101319.2364052-1-inochiama%40gmail.com

Looks like the CONFIG_PCIE_SPACEMIT_K1 menu item and help text
drivers/pci/controller/dwc/Kconfig should be updated to include K3.

The "CONFIG_PCIE_SPACEMIT_K1" name itself should stay the same.

s/Designware/DesignWare/, also in 4/5 commit log
s/phy/PHY/ here and other patches and subject lines
s/msi/MSI/ in 3/5 subject and commit log when it's a stand-alone word
s/pci:/PCI:/ in 4/5 subject to match history (and patch 3/5)

> +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c

> +#define INTR_STATUS				0x0010
> +
>  #define INTR_ENABLE				0x0014
>  #define MSI_CTRL_INT			BIT(11)
> +#define RDLH_LINK_UP_INT		BIT(20)
> +
> +#define K3_PHY_AHB_IRQSTATUS_INTX		0x0008
> +
> +#define K3_PHY_AHB_IRQENABLE_SET_INTX		0x000c
> +#define LEG_EP_INTERRUPTS		(BIT(6) | BIT(7) | BIT(8) | BIT(9))

Would be nicer to use "INTX" rather than "LEG" here since we use
"INTX" in K3_PHY_AHB_IRQENABLE_SET_INTX, in the comments, etc.

> +#define K3_PHY_AHB_IRQENABLE_SET_MSI		0x0014
> +/* MSI defined as BIT(11) in existing INTR_ENABLE, reusing */
> +
> +#define K3_ADDR_INTR_STATUS1			0x0018
> +
> +#define K3_ADDR_INTR_ENABLE1			0x001C

You're using a mix of upper- and lower-case hex here.  Be consistent
and match the existing code.

Seems a little weird to have a mix of "IRQ" names (e.g.,
K1_PHY_AHB_IRQ_EN, K3_PHY_AHB_IRQSTATUS_INTX,
K3_PHY_AHB_IRQENABLE_SET_INTX) and "INTR" names (e.g., INTR_STATUS,
INTR_ENABLE, K3_ADDR_INTR_STATUS1, K3_ADDR_INTR_ENABLE1) when I think
they're really talking about the same concept.

And why do the new K3 names have "ADDR" in the middle when the
existing "INTR_ENABLE" names don't?  It's obvious these are addresses
(well, actually I think they're *offsets*, but no need to be that
detailed).

> +static int k3_pcie_init(struct dw_pcie_rp *pp)
> +{
> ...
> +	val = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
> +	val &= ~(0xffff << 8);
> +	val |= ((0x1 << 4) << 8);

Can you use FIELD_MODIFY and some #defines here?

> +	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, val);
> +
> +	/* Set the PCI vendor and device ID */

Superfluous comment since the code is obvious.

> +	dw_pcie_dbi_ro_wr_en(pci);
> +	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, PCI_VENDOR_ID_SPACEMIT);
> +	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, PCI_DEVICE_ID_SPACEMIT_K3);
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +
> +	/* Finally, as a workaround, disable ASPM L1 */

I guess this means a device erratum?  It advertises L1 but it doesn't
actually work?

> +	k1_pcie_disable_aspm_l1(k1);

> +static int k3_pcie_msi_host_init(struct dw_pcie_rp *pp)
> +{
> ...
> +	val = dw_pcie_readl_dbi(pci, COHERENCY_CONTROL_3_OFF);
> +	val |= (0xf << 11);

FIELD_MODIFY and some #defines here?

> +static int k3_pcie_start_link(struct dw_pcie *pci)
> +{
> +	struct k1_pcie *k1 = to_k1_pcie(pci);
> +	u32 val;
> +
> +	k1_pcie_start_link(pci);
> +
> +	/* Enable INTx */
> +	val = readl_relaxed(k1->link + K3_PHY_AHB_IRQENABLE_SET_INTX);
> +	val |= LEG_EP_INTERRUPTS;
> +	writel_relaxed(val, k1->link + K3_PHY_AHB_IRQENABLE_SET_INTX);
> +
> +	/* Enable MSI/MSIX specific to K3 */

s/MSIX/MSI-X/ to match spec usage.

> +	val = readl_relaxed(k1->link + K3_ADDR_INTR_ENABLE1);
> +	val |= (MSI_INT | MSIX_INT);
> +	writel_relaxed(val, k1->link + K3_ADDR_INTR_ENABLE1);

Generally speaking I think the interrupt setup belongs somewhere other
than .start_link().  Usually .start_link() only enables LTSSM.

> +	return 0;
> +}

> +static irqreturn_t k3_pcie_irq_thread(int irq, void *data)
> +{
> +	struct k1_pcie *k1 = data;
> +	struct dw_pcie_rp *pp = &k1->pci.pp;
> +	struct device *dev = k1->pci.dev;
> +	u32 status0, status1, status2;
> +
> +	k3_pcie_clear_irq_status(k1, &status0, &status1, &status2);
> +
> +	writel_relaxed(status0, k1->link + K3_PHY_AHB_IRQSTATUS_INTX);
> +	writel_relaxed(status1, k1->link + INTR_STATUS);
> +	writel_relaxed(status2, k1->link + K3_ADDR_INTR_STATUS1);
> +
> +	if (FIELD_GET(RDLH_LINK_UP_INT, status1)) {
> +		msleep(PCIE_RESET_CONFIG_WAIT_MS);
> +		/* Rescan the bus to enumerate endpoint devices */
> +		pci_lock_rescan_remove();
> +		pci_rescan_bus(pp->bridge->bus);

This is the *only* driver that uses pci_rescan_bus() this way, which
automatically makes it suspicous.  Maybe it's the first hardware that
implements or is willing to use RDLH_LINK_UP_INT for this, but somehow
I doubt it.

> +		pci_unlock_rescan_remove();
> +	} else if (!status0 && !status1 && !status2)
> +		dev_WARN_ONCE(dev, true,
> +			      "Received unknown event. status0=0x%08x status1=0x%08x status2=0x%08x\n",
> +			      status0, status1, status2);
> +
> +	return IRQ_HANDLED;
> +}
