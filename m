Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7B2C32789
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 12:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8233C2075B
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 12:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8233C2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbeKTWoq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 17:44:46 -0500
Received: from mx.socionext.com ([202.248.49.38]:5786 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728884AbeKTWoq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 17:44:46 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 20 Nov 2018 21:15:54 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 7547960062;
        Tue, 20 Nov 2018 21:15:54 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Tue, 20 Nov 2018 21:15:54 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 1594F40387;
        Tue, 20 Nov 2018 21:15:54 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id D3803120455;
        Tue, 20 Nov 2018 21:15:53 +0900 (JST)
Date:   Tue, 20 Nov 2018 21:15:53 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RESEND PATCH v3 1/2] dt-bindings: PCI: Add UniPhier PCIe host controller description
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
In-Reply-To: <20181119114028.GA30042@e107981-ln.cambridge.arm.com>
References: <1539667641-26024-2-git-send-email-hayashi.kunihiko@socionext.com> <20181119114028.GA30042@e107981-ln.cambridge.arm.com>
Message-Id: <20181120211553.3608.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On Mon, 19 Nov 2018 11:40:36 +0000 <lorenzo.pieralisi@arm.com> wrote:

> On Tue, Oct 16, 2018 at 02:27:20PM +0900, Kunihiko Hayashi wrote:
> > Add DT bindings for PCIe controller implemented in UniPhier SoCs when
> > configured in Root Complex (host) mode. This controller is based on
> > the DesignWare PCIe core.
> > 
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/pci/uniphier-pcie.txt      | 81 ++++++++++++++++++++++
> >  1 file changed, 81 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/uniphier-pcie.txt b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> > new file mode 100644
> > index 0000000..46a2754
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> > @@ -0,0 +1,81 @@
> > +Socionext UniPhier PCIe host controller bindings
> > +
> > +This describes the devicetree bindings for PCIe host controller implemented
> > +on Socionext UniPhier SoCs.
> > +
> > +UniPhier PCIe host controller is based on the Synopsys DesignWare PCI core.
> > +It shares common functions with the PCIe DesignWare core driver and inherits
> > +common properties defined in
> > +Documentation/devicetree/bindings/pci/designware-pcie.txt.
> > +
> > +Required properties:
> > +- compatible: Should be "socionext,uniphier-pcie".
> > +- reg: Specifies offset and length of the register set for the device.
> > +	According to the reg-names, appropriate register sets are required.
> > +- reg-names: Must include the following entries:
> > +    "dbi"    - controller configuration registers
> > +    "link"   - SoC-specific glue layer registers
> > +    "config" - PCIe configuration space
> > +- clocks: A phandle to the clock gate for PCIe glue layer including
> > +	the host controller.
> > +- resets: A phandle to the reset line for PCIe glue layer including
> > +	the host controller.
> > +- interrupts: A list of interrupt specifiers. According to the
> > +	interrupt-names, appropriate interrupts are required.
> > +- interrupt-names: Must include the following entries:
> > +    "dma" - DMA interrupt
> > +    "msi" - MSI interrupt
> > +
> > +Optional properties:
> > +- phys: A phandle to generic PCIe PHY. According to the phy-names, appropriate
> > +	phys are required.
> > +- phy-names: Must be "pcie-phy".
> > +
> > +Required sub-node:
> > +- legacy-interrupt-controller: Specifies interrupt controller for legacy PCI
> > +	interrupts.
> > +
> > +Required properties for legacy-interrupt-controller:
> > +- interrupt-controller: identifies the node as an interrupt controller.
> > +- #interrupt-cells: specifies the number of cells needed to encode an
> > +	interrupt source. The value must be 1.
> > +- interrupt-parent: Phandle to the parent interrupt controller.
> > +- interrupts: An interrupt specifier for legacy interrupt.
> > +
> > +Example:
> > +
> > +	pcie: pcie@66000000 {
> > +		compatible = "socionext,uniphier-pcie", "snps,dw-pcie";
> > +		status = "disabled";
> > +		reg-names = "dbi", "link", "config";
> > +		reg = <0x66000000 0x1000>, <0x66010000 0x10000>,
> > +		      <0x2fff0000 0x10000>;
> > +		#address-cells = <3>;
> > +		#size-cells = <2>;
> > +		clocks = <&sys_clk 24>;
> > +		resets = <&sys_rst 24>;
> > +		num-lanes = <1>;
> > +		num-viewport = <1>;
> > +		bus-range = <0x0 0xff>;
> > +		device_type = "pci";
> > +		ranges =
> > +		/* downstream I/O */
> > +			<0x81000000 0 0x00000000  0x2ffe0000  0 0x00010000
> > +		/* non-prefetchable memory */
> > +			 0x82000000 0 0x00000000  0x20000000  0 0x0ffe0000>;
> > +		#interrupt-cells = <1>;
> > +		interrupt-names = "dma", "msi";
> > +		interrupts = <0 224 4>, <0 225 4>;
> > +		interrupt-map-mask = <0 0 0  7>;
> > +		interrupt-map = <0 0 0  1  &pcie_intc 1>,	/* INTA */
> > +				<0 0 0  2  &pcie_intc 2>,	/* INTB */
> > +				<0 0 0  3  &pcie_intc 3>,	/* INTC */
> > +				<0 0 0  4  &pcie_intc 4>;	/* INTD */
> 
> This is not correct and we must fix this concept for all DWC based host
> bridges bindings. We are mapping INTX to inputs [0,1,2,3] of the host
> bridge interrupt controllers and the binding should reflect that.
> 
> This should be the correct mapping:
> 
> 		interrupt-map = <0 0 0  1  &pcie_intc 0>,	/* INTA */
> 				<0 0 0  2  &pcie_intc 1>,	/* INTB */
> 				<0 0 0  3  &pcie_intc 2>,	/* INTC */
> 				<0 0 0  4  &pcie_intc 3>;	/* INTD */

I see. Although this numbering has been affected by pci_irqd_intx_xlate(),
I understand it's wrong for DWC based host.
I'll fix the numbering next.

Thank you,

---
Best Regards,
Kunihiko Hayashi


