Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8C4625;
	Thu, 14 May 2026 02:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778724420; cv=none; b=Ns0B2KM3NmfXmDc5KOGIRpxoEMTtWa8oiBthBnIlxYCBXVaFSpg8GcyJbm2aHtEmLTZJxjUTp2Emp7elLzpf2HmSerf984IogjR56CuELw1W4o4THP2ZS24m39bcK4cuSWIREHa9UZMWHVULlU7IHyYkVuT3nGOdd1rZ8QbZ4xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778724420; c=relaxed/simple;
	bh=6ZO/SdkcUL0ZfHkfoL7/mu6bd3ZRt4b638icmr3tqQM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tBntJuNWXxhENIpSTq8FjlIOzqwvGXwpgVzjsAVc8nm3QW0DE375+ORrFAqe8XMmXfHBtq1dxBCc56gicEeJojqG3DXa/0p+wBjy5I7t8jWQmXpYxx0gjV0DraQ7SCekisDZYvtJBeWiaweLO/MJ2ucPzd/xvFGPP2hnM/hOf6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spp3QG3v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spp3QG3v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200DFC19425;
	Thu, 14 May 2026 02:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778724419;
	bh=6ZO/SdkcUL0ZfHkfoL7/mu6bd3ZRt4b638icmr3tqQM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=spp3QG3v2aDEwM3CouKn1n0RWyE/CaXP3ql6+t2DuNTKRiyCya7ckrIR2ANULkDB+
	 6I/pwoXAPDAKH5V/7EpzyadeevObkD5bqm0OEayfrRpBuNpkPAvfaRF7kh2W519oqW
	 kkWFcy1dWLC5YOjxG8vJD1i/bodRdQ4GwqzTG33wX9fWpByn5TMmCU7nC9WZFGSCY6
	 dWM9QQ3JNauX+yC0zUc3bgNSdrheQK6wpLTKdFqvBiKTMefDcW4D0F08oG+YopLl3x
	 rqGVeuoz/O0+Dlu90DEdGBtCtij6zMrzUdB484OnniHP9IQ/45cM/GVF1k4wwe5452
	 ACP+T7hmGfLZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] PCI: imx6: Add root port reset to support link
 recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Zhu" <hongxing.zhu@nxp.com>
Cc: krzk+dt@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260513025101.1498104-4-hongxing.zhu@nxp.com>
References: <20260513025101.1498104-4-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 02:06:58 +0000
Message-Id: <20260514020659.200DFC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] Optional IRQ negative error code implicitly cast to `u32` causes p=
robe failure on older platforms.
- [High] Iterating over `bus->devices` without acquiring `pci_bus_sem` crea=
tes a Use-After-Free race condition.
- [High] Read-Modify-Write regmap operations on W1C status bits silently cl=
ear unhandled interrupts.
- [High] Disabling hardware clocks while a shared interrupt remains active =
enables a synchronous external abort vector.
- [High] Using a standard mmio regmap from a primary hardirq handler causes=
 sleep-in-atomic deadlocks on PREEMPT_RT.
- [Medium] System shutdown callback inadvertently triggers a link recovery =
thread, leaving hardware out of reset.
- [Medium] Non-atomic LUT save/restore operations in the recovery thread la=
ck mutex protection.
- [Medium] Failure to mask the hardware interrupt on driver unbind causes a=
n unhandled interrupt storm.
--

commit c32252b83882f7c8756d22c0a5aa880135207cb1
Author: Richard Zhu <hongxing.zhu@nxp.com>

PCI: imx6: Add root port reset to support link recovery

The PCIe link can go down due to various unexpected circumstances. Add
root port reset support to enable link recovery for the i.MX PCIe
controller when the optional "intr" interrupt is present.

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index e35044cc52185..38e0a16655092 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
[ ... ]
> @@ -1573,6 +1588,9 @@ static int imx_pcie_suspend_noirq(struct device *de=
v)
>  	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
>  		return 0;
> =20
> +	if (imx_pcie->lnk_intr)
> +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
> +				  IMX95_LINK_DOWN_INT_EN);

Does using regmap_clear_bits() and regmap_set_bits() here unintentionally
clear pending Write-1-to-Clear (W1C) status bits?

Since these functions perform a read-modify-write operation, if a W1C status
bit like IMX95_LINK_DOWN_INT_STS is active during the read phase, writing it
back will clear the status bit. This could potentially result in losing
pending link-down or PME events before their handlers can process them.

[ ... ]
> @@ -1632,6 +1653,84 @@ static const struct dev_pm_ops imx_pcie_pm_ops =3D=
 {
>  				  imx_pcie_resume_noirq)
>  };
> =20
> +static irqreturn_t imx_pcie_lnk_irq_isr(int irq, void *priv)
> +{
> +	struct imx_pcie *imx_pcie =3D priv;
> +	struct dw_pcie *pci =3D imx_pcie->pci;
> +	struct device *dev =3D pci->dev;
> +	u32 val;
> +
> +	regmap_read(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS, &val);

Could this regmap_read() call cause a sleep-in-atomic deadlock on PREEMPT_R=
T?

Since this handler is registered with IRQF_SHARED, it runs in primary hardi=
rq
context. The iomuxc_gpr regmap is initialized via devm_regmap_init_mmio()
without enabling the use_raw_spinlock flag, meaning it relies on a standard
spinlock. On PREEMPT_RT kernels, this maps to a sleepable rt_mutex, which
cannot be acquired safely from hardirq context.

> +	if (val & IMX95_LINK_DOWN_INT_STS) {
> +		dev_dbg(dev, "PCIe link down detected, initiating recovery\n");
> +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
> +				  IMX95_LINK_DOWN_INT_EN);
> +		regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
> +				IMX95_LINK_DOWN_INT_STS);
> +
> +		return IRQ_WAKE_THREAD;
> +	} else {
> +		return IRQ_NONE;
> +	}
> +}
> +
> +static irqreturn_t imx_pcie_lnk_irq_thread(int irq, void *priv)
> +{
> +	struct imx_pcie *imx_pcie =3D priv;
> +	struct dw_pcie *pci =3D imx_pcie->pci;
> +	struct dw_pcie_rp *pp =3D &pci->pp;
> +	struct pci_dev *port;
> +
> +	for_each_pci_bridge(port, pp->bridge->bus)

Is it safe to iterate over the bus devices list here without acquiring the
pci_bus_sem read lock?

Since this threaded handler executes asynchronously, concurrent PCI subsyst=
em
modifications like hotplug events or driver unbinding could mutate the list.
Traversing bus->devices without down_read(&pci_bus_sem) might expose the
system to list corruption or use-after-free dereferences.

> +		if (pci_pcie_type(port) =3D=3D PCI_EXP_TYPE_ROOT_PORT)
> +			pci_host_handle_link_down(port);
> +
> +	regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
> +			IMX95_LINK_DOWN_INT_EN);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int imx_pcie_reset_root_port(struct pci_host_bridge *bridge,
> +				    struct pci_dev *pdev)
> +{
> +	struct pci_bus *bus =3D bridge->bus;
> +	struct dw_pcie_rp *pp =3D bus->sysdata;
> +	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> +	struct imx_pcie *imx_pcie =3D to_imx_pcie(pci);
> +	int ret;
> +
> +	imx_pcie_msi_save_restore(imx_pcie, true);
> +	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
> +		imx_pcie_lut_save(imx_pcie);

Should these LUT save and restore operations be protected by the
imx_pcie->lock mutex?

Other parts of the driver appear to protect concurrent LUT accesses using
this mutex. Since the recovery thread runs asynchronously, racing with
concurrent endpoint configuration routines could lead to interleaved I/O
operations and corrupt the LUT index.

> +	imx_pcie_stop_link(pci);
> +	imx_pcie_host_exit(pp);

Does fully disabling the clocks here risk a synchronous external abort?

The imx_pcie_host_exit() function completely disables the PCIe controller
clocks. If another device sharing this interrupt line triggers an interrupt
while the clocks are off, the kernel will invoke all registered primary
handlers. If the PME handler attempts to read PCIe Root Port configuration
registers, accessing unclocked memory-mapped registers could trigger a
synchronous external abort.

[ ... ]
> @@ -1834,9 +1933,33 @@ static int imx_pcie_probe(struct platform_device *=
pdev)
>  			val |=3D PCI_MSI_FLAGS_ENABLE;
>  			dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
>  		}
> +
> +		/* Get link event irq if it is present */
> +		imx_pcie->lnk_intr =3D platform_get_irq_byname(pdev, "intr");
> +		if (imx_pcie->lnk_intr > 0) {

Could this check fail to handle missing optional interrupts on older
platforms?

The platform_get_irq_byname() function returns a negative error code like
-ENXIO when the interrupt is missing. Because lnk_intr is declared as a u32,
the negative error code is implicitly cast to a large positive integer.
The condition > 0 will evaluate to true, and the driver will attempt to
request an invalid massive IRQ number, unconditionally failing the probe.

> +			ret =3D devm_request_threaded_irq(dev, imx_pcie->lnk_intr,
> +							imx_pcie_lnk_irq_isr,
> +							imx_pcie_lnk_irq_thread,
> +							IRQF_SHARED,
> +							"lnk", imx_pcie);
> +			if (ret) {
> +				dev_err_probe(dev, ret,
> +					      "unable to request LNK IRQ\n");
> +				goto err_host_deinit;
> +			}
> +
> +			regmap_set_bits(imx_pcie->iomuxc_gpr,
> +					IMX95_LINK_INT_CTRL_STS,
> +					IMX95_LINK_DOWN_INT_EN);

Is there a mechanism to disable the hardware interrupt on driver unbind?

The interrupt is enabled in the IOMUXC GPR register during probe. If the
driver is unbound and its IRQ handler is freed without a removal callback
clearing the IMX95_LINK_DOWN_INT_EN bit, the hardware could assert the
shared interrupt continuously if the link goes down. Since no handler
would be registered to acknowledge it, this might lead to an unhandled
interrupt storm.

> +		}
>  	}
> =20
>  	return 0;
> +
> +err_host_deinit:
> +	dw_pcie_host_deinit(&pci->pp);
> +
> +	return ret;
>  }
> =20
>  static void imx_pcie_shutdown(struct platform_device *pdev)

Will asserting the core reset during shutdown unintentionally trigger the
link recovery thread?

During system reboot, imx_pcie_shutdown() calls imx_pcie_assert_core_reset()
to quiesce the hardware, which physically drops the PCIe link. Because the
interrupt enable bit is not cleared during shutdown, this intentional link
drop will trigger the hardware interrupt.

The resulting interrupt will queue imx_pcie_lnk_irq_thread(), which calls
imx_pcie_reset_root_port(). This will explicitly deassert the core reset,
unintentionally bringing the hardware back out of reset and defeating the
purpose of the shutdown routine.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513025101.1498=
104-1-hongxing.zhu@nxp.com?part=3D3
