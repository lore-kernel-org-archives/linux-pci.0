Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:62744 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935162AbcJ0PHH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2016 11:07:07 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Ruqiang Ju <juruqiang@huawei.com>
Cc: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bin.chen@linaro.org,
        elder@linaro.org, hermit.wangheming@hisilicon.com,
        yanhaifeng@hisilicon.com, xuejiancheng@hisilicon.com
Subject: Re: [PATCH 1/2] PCI: hisi: add PCIe driver support for HiSilicon STB SoCs
Date: Thu, 27 Oct 2016 17:06:40 +0200
Message-ID: <3432492.SEq6J3hYME@wuerfel>
In-Reply-To: <1477014336-12385-1-git-send-email-juruqiang@huawei.com>
References: <1477014336-12385-1-git-send-email-juruqiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, October 21, 2016 9:45:36 AM CEST Ruqiang Ju wrote:
> Add PCIe controller drvier for HiSilicon STB SoCs,
> the controller is based on the DesignWare's PCIe core.
> 
> Signed-off-by: Ruqiang Ju <juruqiang@huawei.com>
> ---
>  .../bindings/pci/hisilicon-histb-pcie.txt          |  66 +++
>  drivers/pci/host/Kconfig                           |   8 +
>  drivers/pci/host/Makefile                          |   1 +
>  drivers/pci/host/pcie-histb.c                      | 448 +++++++++++++++++++++
>  4 files changed, 523 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
>  create mode 100644 drivers/pci/host/pcie-histb.c
> 
> diff --git a/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
> new file mode 100644
> index 0000000..952f1db
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
> @@ -0,0 +1,66 @@
> +HiSilicon STB PCIe host bridge DT description
> +
> +HiSilicon PCIe host controller is based on Designware PCI core.
> +It shares common functions with PCIe Designware core driver and inherits
> +common properties defined in
> +Documentation/devicetree/bindings/pci/designware-pci.txt.
> +
> +Additional properties are described here:
> +
> +Required properties
> +- compatible: Should be one of the following strings
> +		 "hisilicon,histb-pcie",
> +		 "hisilicon,hi3798cv200-pcie"
> +- reg: Should contain sysctl, rc_dbi, config registers location and length.
> +- reg-names: Must include the following entries:
> +  "sysctrl": system control registers of PCIe controller;

> +  "rc_dbi": configuration space of PCIe controller;

Please use "-" instead of "_" in identifiers.

> +  "config": configuration transaction space of PCIe controller.
> +- interrupts: MSI interrupt.
> +- interrupt-names: Must include "msi" entries.

Shouldn't this be handled using the msi-map property?

> +- clocks: List of phandle and clock specifier pairs as listed
> +		in clock-names property.
> +- clock-name: Must include the following entries:
> +  "aux_clk": auxiliary gate clock;
> +  "pipe_clk": pipe gate clock;
> +  "sys_clk": sys gate clock;
> +  "bus_clk": bus gate clock.

drop the redundant _clk postfix.

> +- resets: List of phandle and reset specifier pairs as listed
> +			in reset-names property
> +- reset-names: Must include the following entries:
> +  "soft_reset": soft reset;
> +  "sys_reset": sys reset;
> +  "bus_rest": bus reset.

drop the _rest and _reset postfix.

> +Optional properties:
> +- power-gpios: pcie device power control gpio if needed;
> +- power-gpios-active-high: must include this propty
> +		if active level is high.
> +- status: Either "ok" or "disabled".
> +
> +Example:
> +	pcie@f9860000 {
> +		compatible = "hisilicon,histb-pcie", "snps,dw-pcie";
> +		reg = <0xf9860000 0x1000>,
> +			<0xf0000000 0x2000>,
> +			<0xf2000000 0x01000000>;
> +		reg-names = "sysctrl", "rc_dbi", "config";

Could it be that the "sysctrl" is not actually part of the PCIe
block but instead part of the system controller block?

Please use a syscon reference instead for those.

> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		device_type = "pci";
> +		num-lanes = <1>;
> +		ranges=<0x81000000 0 0 0xf4000000 0 0x00010000
> +			0x82000000 0 0xf3000000 0xf3000000 0 0x01000000>;

That is very short for the memory window. Is there no
prefetchable 64-bit window in the hardware?

> +	/* check if the link is up or not */
> +	while (!dw_pcie_link_up(pp)) {
> +		mdelay(10);
> +		count++;
> +		if (count == 50) {
> +			dev_err(pp->dev, "PCIe Link Fail\n");
> +			return -EINVAL;
> +		}
> +	}
> +

That is a very long delay here. Please don't do that.

> +	dev_info(pp->dev, "Link up\n");
> +
> +	return 0;
> +}
> +
> +static void histb_pcie_host_init(struct pcie_port *pp)
> +{
> +	histb_pcie_establish_link(pp);
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		dw_pcie_msi_init(pp);
> +}

Just make it depen on PCI_MSI_IRQ_DOMAIN and drop the IS_ENABLED
check.

> +#ifdef CONFIG_PCI_MSI
> +static irqreturn_t histb_pcie_msi_irq_handler(int irq, void *arg)
> +{
> +	struct pcie_port *pp = arg;
> +
> +	return dw_handle_msi_irq(pp);
> +}
> +#endif

This seems misplaced here. How do the other dw-pcie drivers handle
it? If there is a chance that this driver gets reused on a future
product that has a GICv3, please write the driver so it can already
use that.

	Arnd


