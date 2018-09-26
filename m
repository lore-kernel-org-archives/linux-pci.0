Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF290C43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 12:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08BB214DA
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 12:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08BB214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeIZSqd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:46:33 -0400
Received: from mx.socionext.com ([202.248.49.38]:27123 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbeIZSqd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Sep 2018 14:46:33 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 26 Sep 2018 21:33:44 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id D18E4180B7D;
        Wed, 26 Sep 2018 21:33:44 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 26 Sep 2018 21:33:44 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id B2DBF4039A;
        Wed, 26 Sep 2018 21:33:44 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 74FC2120417;
        Wed, 26 Sep 2018 21:33:44 +0900 (JST)
Date:   Wed, 26 Sep 2018 21:33:44 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: add UniPhier PCIe host controller description
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <20180925205502.GA12949@bogus>
References: <1536226832-5089-2-git-send-email-hayashi.kunihiko@socionext.com> <20180925205502.GA12949@bogus>
Message-Id: <20180926213343.A4B8.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On Tue, 25 Sep 2018 15:55:02 -0500 <robh@kernel.org> wrote:

> On Thu, Sep 06, 2018 at 06:40:31PM +0900, Kunihiko Hayashi wrote:
> > Add DT bindings for PCIe controller implemented in UniPhier SoCs when
> > configured in Root Complex (host) mode. This controller is based on
> > the DesignWare PCIe core.
> > 
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > ---
> >  .../devicetree/bindings/pci/uniphier-pcie.txt      | 78 ++++++++++++++++++++++
> >  1 file changed, 78 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/uniphier-pcie.txt b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> > new file mode 100644
> > index 0000000..a34e167
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> > @@ -0,0 +1,78 @@
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
> > +    "dma"    - DMA interrupt
> > +    "msi"    - MSI interrupt
> > +    "intx"   - Legacy INTA/B/C/D interrupt
> > +
> > +Optional properties:
> > +- phys: A phandle to generic PCIe PHY. According to the phy-names, appropriate
> > +	phys are required.
> > +- phy-names: Must be "pcie-phy".
> > +
> > +Required sub-node:
> > +- interrupt-controller: Specifies interrupt controller for legacy PCI
> > +	interrupts. The node name isn't important.
> 
> No, it is important.
> 
> With that sentence removed,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

I was wrong. the node name is important to express its role.
I'll remove that sentence in next.

Thank you,

---
Best Regards,
Kunihiko Hayashi


