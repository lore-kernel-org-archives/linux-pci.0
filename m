Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38063DD526;
	Tue, 13 Oct 2026 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901207; cv=none; b=nuYCztvpW51j5yJeSX+wHMIwXHttxSl/kgBytgzeVV/iH9iKJe641ePG0gqgCdg70JNO8f2TG23lX/782kjSkTz86DF492fK99CFfhqCJTxiDjC89d9rz9Wd98GCMDuHkiubJvuRqwKIA4UWDHMfBH9s8aGMnWN9j21G3vW+sUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901207; c=relaxed/simple;
	bh=w9iXcdNAy9q5kpInJ63QcmeNzkngbgW7GozEWnALozk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=qVgqyK5CH7H+Z9Rpnbdd1PHrdjfjIfXMjlP77Fh68IL0Cp49zPjgao4VWClwDpK5qNHWYvTrgQCLWZlpiCctktXzdtZDF/MiZQaJoBRT0vvpg7PwvVZWKIhtavB+BuOewnLoVAOIp3exoc4rRzHLxSvVE+hh2yXIzyDmB2IQvn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBa5hNQ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBa5hNQ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5F31F000FF;
	Tue, 13 Oct 2026 14:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791901205;
	bh=VFUKf4WT1PC9FZhPf1gCPKKTYAdHhpxy5ngxtUFm0FA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=RBa5hNQ1EN2izACHg84lWz5itrvyP4DdpiIfrFn53wQagcEmr6uIIfWUcwEQLB5L/
	 NvO/QyG3zHF/ZQA6xsa2I2OtO7Vgbe2q4O2JCQfxQiMsCbdtB8Ya+3TWOiH0L10mr2
	 vpKxgbS2l/nJl+GOIuZxBKulvZYfWD1fzfqRTdA7ASbQs77j+qAQWE9PI3mE655ajK
	 j8Sm4Q2ZRMoiOIxX+jNBucWHbtsbi2h+pbacGEoKWZtbSLu5FEzseYvtg7WIOvfgPB
	 4eV6gwNjqt2rCCyWA/leg2O500s9Js5Y/dJXtWAWWmWuWI9qBQWgBX9Fd1Ck6s8jYo
	 x0Y7AYsvviyhA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 3/3] PCI: imx6: Add root port reset to support link
 recovery
From: Manivannan Sadhasivam <mani@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: hongxing.zhu@oss.nxp.com, robh@kernel.org, conor+dt@kernel.org, 
 Frank.Li@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org
In-Reply-To: <20260618093438.12B9B1F000E9@smtp.kernel.org>
References: <20260618092100.3669556-1-hongxing.zhu@oss.nxp.com>
 <20260618092100.3669556-4-hongxing.zhu@oss.nxp.com>
 <20260618093438.12B9B1F000E9@smtp.kernel.org>
Date: Tue, 13 Oct 2026 19:49:58 +0530
Message-Id: <179190119866.12828.2001673028236159096.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8140; i=mani@kernel.org;
 h=from:subject:message-id; bh=w9iXcdNAy9q5kpInJ63QcmeNzkngbgW7GozEWnALozk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqzj4RkBQlSf3o29RXJHwdXpSm1eckarO9yUILS
 yP/8ZK8AKyJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas4+EQAKCRBVnxHm/pHO
 9ePsB/9DHNBVfn9ovVA2xK9tUOEQ6HNVfHyRBIDmNnF4AUcIQI+0Jc+Vrvd1vaZ0D63d/gzM6jL
 lCEBcTpCwGmui/G0Z4eBI6h6uVoeRkhyyXKPhHehcUmT5Jj/ODZxYwO8qPUIftHkqU4BkKgEcs4
 QEICN2DSUTXuoiN03pDSxaHOH2TYPpN1dr23GnM+DuEzGHocyiZ39QHfBDE/bVwwFrJF2hfhxq2
 jwVAC04yQayPunzab/Eu2WWiA9uhLc8brfbT1ZC6OeJsHBH8ShajPqR0S3kIgto8xnaV72hhz/y
 D7pqYNFx5FapicDEdbLHCTivwhOatU0D7ShJAFg1eT2lxMae
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-06-18 09:34 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 7 potential issue(s) to consider:
> - [High] Using read-modify-write operations on a mixed RW/W1C register unintentionally clears pending hardware interrupts.
> - [High] The ISR unconditionally clears the link down status bit even if the interrupt is disabled, dropping shared link recovery events.
> - [High] Unsafe, lockless iteration over the PCI bus devices list without holding pci_bus_sem.
> - [High] The threaded interrupt handler is not synchronized during system shutdown, leading to a race condition with controller power-off.
> - [High] Accessing shared LUT GPR registers without acquiring imx_pcie->lock causes a data race.
> - [Medium] The `imx_pcie_reset_root_port` function silently ignores failures to recover the PCIe link.
> - [Low] The patch references undeclared functions and undefined struct members, causing build failures.

Atleast some of these issues are valid. Can you please take a look?

- Mani

> --
> 
> commit 1a657928e9eb6aa6da8f1cc80545e5be5d066898
> Author: Richard Zhu <hongxing.zhu@nxp.com>
> 
> PCI: imx6: Add root port reset to support link recovery
> 
> The PCIe link can go down due to various unexpected circumstances. Add
> root port reset support to enable link recovery for the i.MX PCIe
> controller when the optional "intr" interrupt is present.
> 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 98e1db751132a..b38eb61983e15 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> 
> [ ... ]
> 
> > @@ -1442,6 +1450,13 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
> >  
> >  	imx_setup_phy_mpll(imx_pcie);
> >  
> > +	/*
> > +	 * Callback invoked by PCI core when link down is detected and
> > +	 * recovery is needed.
> > +	 */
> > +	if (pp->bridge)
> > +		pp->bridge->reset_root_port = imx_pcie_reset_root_port;
> 
> [Severity: Low]
> Is reset_root_port defined in struct pci_host_bridge? Looking at
> include/linux/pci.h, this member does not appear to exist in the standard
> kernel. Does this patch depend on a prerequisite patch that adds it?
> 
> [ ... ]
> 
> > @@ -1774,6 +1795,86 @@ static const struct dev_pm_ops imx_pcie_pm_ops = {
> >  				  imx_pcie_resume_noirq)
> >  };
> >  
> > +static irqreturn_t imx_pcie_lnk_irq_isr(int irq, void *priv)
> > +{
> > +	struct imx_pcie *imx_pcie = priv;
> > +	struct dw_pcie *pci = imx_pcie->pci;
> > +	struct device *dev = pci->dev;
> > +	u32 val;
> > +
> > +	regmap_read(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS, &val);
> > +	if (val & IMX95_LINK_DOWN_INT_STS) {
> > +		dev_dbg(dev, "PCIe link down detected, initiating recovery\n");
> > +		/* Clear link down interrupt status by writing 1b'1 to it */
> > +		regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
> > +				IMX95_LINK_DOWN_INT_STS);
> > +		if (!(val & IMX95_LINK_DOWN_INT_EN))
> > +			return IRQ_NONE;
> 
> [Severity: High]
> If this interrupt is shared and masked during thread execution, could this
> unconditionally clear a new link down event?
> 
> Since the status is cleared before checking IMX95_LINK_DOWN_INT_EN, if a new
> event triggers concurrently with the threaded handler, it appears the event
> will be cleared and then discarded when the ISR returns IRQ_NONE.
> 
> > +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
> > +				  IMX95_LINK_DOWN_INT_EN);
> > +
> > +		return IRQ_WAKE_THREAD;
> > +	}
> > +
> > +	regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_INT_STS, &val);
> > +	if (unlikely(val))
> > +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_INT_STS, val);
> > +
> > +	return IRQ_NONE;
> > +}
> > +
> > +static irqreturn_t imx_pcie_lnk_irq_thread(int irq, void *priv)
> > +{
> > +	struct imx_pcie *imx_pcie = priv;
> > +	struct dw_pcie *pci = imx_pcie->pci;
> > +	struct dw_pcie_rp *pp = &pci->pp;
> > +	struct pci_dev *port;
> > +
> > +	for_each_pci_bridge(port, pp->bridge->bus)
> > +		if (pci_pcie_type(port) == PCI_EXP_TYPE_ROOT_PORT)
> > +			pci_host_handle_link_down(port);
> 
> [Severity: High]
> Is it safe to iterate over the PCI bus devices list asynchronously here without
> holding the pci_bus_sem semaphore?
> 
> If concurrent PCI enumeration, hotplug device removal, or SR-IOV VF
> modifications occur, could this result in list pointer corruption or a
> use-after-free?
> 
> [Severity: Low]
> Also, is pci_host_handle_link_down() declared in the standard kernel headers?
> I am unable to find it in include/linux/pci.h, which might cause a build
> failure without a prerequisite patch.
> 
> > +
> > +	regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
> > +			IMX95_LINK_DOWN_INT_EN);
> 
> [Severity: High]
> Can regmap_set_bits() unintentionally clear pending hardware interrupts here?
> 
> Since regmap_set_bits() performs a read-modify-write, and the
> IMX95_LINK_DOWN_INT_STS (BIT 11) is a write-1-to-clear bit, could it
> accidentally write back a 1 for a newly arrived link down event and
> permanently lose that event?
> 
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int imx_pcie_reset_root_port(struct pci_host_bridge *bridge,
> > +				    struct pci_dev *pdev)
> > +{
> > +	struct pci_bus *bus = bridge->bus;
> > +	struct dw_pcie_rp *pp = bus->sysdata;
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
> > +	int ret;
> > +
> > +	imx_pcie_msi_save_restore(imx_pcie, true);
> > +	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
> > +		imx_pcie_lut_save(imx_pcie);
> 
> [Severity: High]
> Does imx_pcie_lut_save() need to acquire the imx_pcie->lock?
> 
> Since imx_pcie_reset_root_port() runs asynchronously in the recovery thread,
> could this cause a data race on the shared IMX95_PE0_LUT_ACSCTRL index
> register if another device probe concurrently calls imx_pcie_add_lut()?
> 
> > +	imx_pcie_stop_link(pci);
> > +	imx_pcie_host_exit(pp);
> > +
> > +	ret = imx_pcie_host_init(pp);
> > +	if (ret) {
> > +		dev_err(pci->dev, "Failed to re-init PCIe\n");
> > +		return ret;
> > +	}
> > +	ret = dw_pcie_setup_rc(pp);
> > +	if (ret)
> > +		return ret;
> > +
> > +	imx_pcie_start_link(pci);
> > +	dw_pcie_wait_for_link(pci);
> 
> [Severity: Medium]
> Should the return value of dw_pcie_wait_for_link() be checked and propagated?
> 
> If the link fails to come up (for example, returning -ETIMEDOUT because the
> endpoint was unplugged), dropping the error allows the function to
> unconditionally return 0. Could this leave the system in an inconsistent
> state?
> 
> > +
> > +	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
> > +		imx_pcie_lut_restore(imx_pcie);
> 
> [Severity: High]
> Similar to the save function above, does imx_pcie_lut_restore() need to
> acquire imx_pcie->lock to prevent data races on the shared LUT index register
> during restoration?
> 
> [ ... ]
> 
> > @@ -1973,15 +2074,46 @@ static int imx_pcie_probe(struct platform_device *pdev)
> 
> [ ... ]
> 
> >  static void imx_pcie_shutdown(struct platform_device *pdev)
> >  {
> >  	struct imx_pcie *imx_pcie = platform_get_drvdata(pdev);
> >  
> > +	if (imx_pcie->lnk_intr > 0)
> > +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
> > +				  IMX95_LINK_DOWN_INT_EN);
> >  	/* bring down link, so bootloader gets clean state in case of reboot */
> >  	imx_pcie_assert_core_reset(imx_pcie);
> 
> [Severity: High]
> Can a concurrent threaded interrupt handler run during this shutdown process?
> 
> Since disable_irq() is not called, if a link down event triggers just before
> shutdown, could the thread access PCIe configuration space right as
> pci_pwrctrl_power_off_devices() powers off the hardware, potentially causing a
> synchronous external abort?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260618092100.3669556-1-hongxing.zhu@oss.nxp.com?part=3
> 


