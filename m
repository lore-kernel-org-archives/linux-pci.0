Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35569 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933120AbcJ0Owy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2016 10:52:54 -0400
Date: Thu, 27 Oct 2016 09:52:39 -0500
From: Rob Herring <robh@kernel.org>
To: Ruqiang Ju <juruqiang@huawei.com>
Cc: bhelgaas@google.com, mark.rutland@arm.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bin.chen@linaro.org,
        elder@linaro.org, hermit.wangheming@hisilicon.com,
        yanhaifeng@hisilicon.com, xuejiancheng@hisilicon.com
Subject: Re: [PATCH 1/2] PCI: hisi: add PCIe driver support for HiSilicon STB
 SoCs
Message-ID: <20161027145239.yso327bl6iiazusb@rob-hp-laptop>
References: <1477014336-12385-1-git-send-email-juruqiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477014336-12385-1-git-send-email-juruqiang@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 21, 2016 at 09:45:36AM +0800, Ruqiang Ju wrote:
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

This should either be a fallback compatible or be dropped.

> +		 "hisilicon,hi3798cv200-pcie"
> +- reg: Should contain sysctl, rc_dbi, config registers location and length.
> +- reg-names: Must include the following entries:
> +  "sysctrl": system control registers of PCIe controller;
> +  "rc_dbi": configuration space of PCIe controller;
> +  "config": configuration transaction space of PCIe controller.
> +- interrupts: MSI interrupt.
> +- interrupt-names: Must include "msi" entries.
> +- clocks: List of phandle and clock specifier pairs as listed
> +		in clock-names property.
> +- clock-name: Must include the following entries:
> +  "aux_clk": auxiliary gate clock;
> +  "pipe_clk": pipe gate clock;
> +  "sys_clk": sys gate clock;
> +  "bus_clk": bus gate clock.
> +- resets: List of phandle and reset specifier pairs as listed
> +			in reset-names property
> +- reset-names: Must include the following entries:
> +  "soft_reset": soft reset;
> +  "sys_reset": sys reset;
> +  "bus_rest": bus reset.
> +
> +Optional properties:
> +- power-gpios: pcie device power control gpio if needed;
> +- power-gpios-active-high: must include this propty
> +		if active level is high.

This should be dropped. The power-gpios property should indicate the 
active state.

> +- status: Either "ok" or "disabled".

No need to explicitly document this.

> +
> +Example:
> +	pcie@f9860000 {
> +		compatible = "hisilicon,histb-pcie", "snps,dw-pcie";
> +		reg = <0xf9860000 0x1000>,
> +			<0xf0000000 0x2000>,
> +			<0xf2000000 0x01000000>;
> +		reg-names = "sysctrl", "rc_dbi", "config";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		device_type = "pci";
> +		num-lanes = <1>;
> +		ranges=<0x81000000 0 0 0xf4000000 0 0x00010000
> +			0x82000000 0 0xf3000000 0xf3000000 0 0x01000000>;
> +		interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "msi";
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0x0 0 0 1 &gic 0 131 4>;
> +		clocks = <&crg PCIE_AUX_CLK>,
> +			 <&crg PCIE_PIPE_CLK>,
> +			 <&crg PCIE_SYS_CLK>,
> +			 <&crg PCIE_BUS_CLK>;
> +		clock-names = "aux_clk", "pipe_clk", "sys_clk", "bus_clk";
> +		resets = <&crg 0x18c 6>, <&crg 0x18c 5>, <&crg 0x18c 4>;
> +		reset-names = "soft_reset", "sys_reset", "bus_reset";
> +	};
