Return-Path: <SRS0=q0B1=N6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244F1C43441
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 11:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C252086A
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 11:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C252086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbeKSWEK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:04:10 -0500
Received: from foss.arm.com ([217.140.101.70]:55032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728573AbeKSWEK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Nov 2018 17:04:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3599C80D;
        Mon, 19 Nov 2018 03:40:48 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2241B3F5B7;
        Mon, 19 Nov 2018 03:40:45 -0800 (PST)
Date:   Mon, 19 Nov 2018 11:40:36 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: Re: [RESEND PATCH v3 1/2] dt-bindings: PCI: Add UniPhier PCIe host
 controller description
Message-ID: <20181119114028.GA30042@e107981-ln.cambridge.arm.com>
References: <1539667641-26024-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1539667641-26024-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539667641-26024-2-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 16, 2018 at 02:27:20PM +0900, Kunihiko Hayashi wrote:
> Add DT bindings for PCIe controller implemented in UniPhier SoCs when
> configured in Root Complex (host) mode. This controller is based on
> the DesignWare PCIe core.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/pci/uniphier-pcie.txt      | 81 ++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/uniphier-pcie.txt b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> new file mode 100644
> index 0000000..46a2754
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> @@ -0,0 +1,81 @@
> +Socionext UniPhier PCIe host controller bindings
> +
> +This describes the devicetree bindings for PCIe host controller implemented
> +on Socionext UniPhier SoCs.
> +
> +UniPhier PCIe host controller is based on the Synopsys DesignWare PCI core.
> +It shares common functions with the PCIe DesignWare core driver and inherits
> +common properties defined in
> +Documentation/devicetree/bindings/pci/designware-pcie.txt.
> +
> +Required properties:
> +- compatible: Should be "socionext,uniphier-pcie".
> +- reg: Specifies offset and length of the register set for the device.
> +	According to the reg-names, appropriate register sets are required.
> +- reg-names: Must include the following entries:
> +    "dbi"    - controller configuration registers
> +    "link"   - SoC-specific glue layer registers
> +    "config" - PCIe configuration space
> +- clocks: A phandle to the clock gate for PCIe glue layer including
> +	the host controller.
> +- resets: A phandle to the reset line for PCIe glue layer including
> +	the host controller.
> +- interrupts: A list of interrupt specifiers. According to the
> +	interrupt-names, appropriate interrupts are required.
> +- interrupt-names: Must include the following entries:
> +    "dma" - DMA interrupt
> +    "msi" - MSI interrupt
> +
> +Optional properties:
> +- phys: A phandle to generic PCIe PHY. According to the phy-names, appropriate
> +	phys are required.
> +- phy-names: Must be "pcie-phy".
> +
> +Required sub-node:
> +- legacy-interrupt-controller: Specifies interrupt controller for legacy PCI
> +	interrupts.
> +
> +Required properties for legacy-interrupt-controller:
> +- interrupt-controller: identifies the node as an interrupt controller.
> +- #interrupt-cells: specifies the number of cells needed to encode an
> +	interrupt source. The value must be 1.
> +- interrupt-parent: Phandle to the parent interrupt controller.
> +- interrupts: An interrupt specifier for legacy interrupt.
> +
> +Example:
> +
> +	pcie: pcie@66000000 {
> +		compatible = "socionext,uniphier-pcie", "snps,dw-pcie";
> +		status = "disabled";
> +		reg-names = "dbi", "link", "config";
> +		reg = <0x66000000 0x1000>, <0x66010000 0x10000>,
> +		      <0x2fff0000 0x10000>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		clocks = <&sys_clk 24>;
> +		resets = <&sys_rst 24>;
> +		num-lanes = <1>;
> +		num-viewport = <1>;
> +		bus-range = <0x0 0xff>;
> +		device_type = "pci";
> +		ranges =
> +		/* downstream I/O */
> +			<0x81000000 0 0x00000000  0x2ffe0000  0 0x00010000
> +		/* non-prefetchable memory */
> +			 0x82000000 0 0x00000000  0x20000000  0 0x0ffe0000>;
> +		#interrupt-cells = <1>;
> +		interrupt-names = "dma", "msi";
> +		interrupts = <0 224 4>, <0 225 4>;
> +		interrupt-map-mask = <0 0 0  7>;
> +		interrupt-map = <0 0 0  1  &pcie_intc 1>,	/* INTA */
> +				<0 0 0  2  &pcie_intc 2>,	/* INTB */
> +				<0 0 0  3  &pcie_intc 3>,	/* INTC */
> +				<0 0 0  4  &pcie_intc 4>;	/* INTD */

This is not correct and we must fix this concept for all DWC based host
bridges bindings. We are mapping INTX to inputs [0,1,2,3] of the host
bridge interrupt controllers and the binding should reflect that.

This should be the correct mapping:

		interrupt-map = <0 0 0  1  &pcie_intc 0>,	/* INTA */
				<0 0 0  2  &pcie_intc 1>,	/* INTB */
				<0 0 0  3  &pcie_intc 2>,	/* INTC */
				<0 0 0  4  &pcie_intc 3>;	/* INTD */

Lorenzo

> +
> +		pcie_intc: legacy-interrupt-controller {
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <0 226 4>;
> +		};
> +	};
> -- 
> 2.7.4
> 
