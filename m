Return-Path: <SRS0=Hio3=OO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C83C04EB8
	for <linux-pci@archiver.kernel.org>; Wed,  5 Dec 2018 02:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE6B20851
	for <linux-pci@archiver.kernel.org>; Wed,  5 Dec 2018 02:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE6B20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbeLECNz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Dec 2018 21:13:55 -0500
Received: from mx.socionext.com ([202.248.49.38]:14799 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbeLECNz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Dec 2018 21:13:55 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 05 Dec 2018 11:13:53 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 97FD160062;
        Wed,  5 Dec 2018 11:13:53 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 5 Dec 2018 11:13:53 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id F258140377;
        Wed,  5 Dec 2018 11:13:52 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id B7A94120304;
        Wed,  5 Dec 2018 11:13:52 +0900 (JST)
Date:   Wed, 05 Dec 2018 11:13:52 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v4 2/2] PCI: uniphier: Add UniPhier PCIe host controller support
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
In-Reply-To: <20181204151227.GA29926@e107981-ln.cambridge.arm.com>
References: <1543377866-16634-3-git-send-email-hayashi.kunihiko@socionext.com> <20181204151227.GA29926@e107981-ln.cambridge.arm.com>
Message-Id: <20181205111351.00E3.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On Tue, 4 Dec 2018 15:12:27 +0000 <lorenzo.pieralisi@arm.com> wrote:

> On Wed, Nov 28, 2018 at 01:04:26PM +0900, Kunihiko Hayashi wrote:
> 
> [...]
> 
> > +static void uniphier_pcie_irq_ack(struct irq_data *d)
> > +{
> > +	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> > +	u32 val;
> > +
> > +	val = readl(priv->base + PCL_RCV_INTX);
> > +	val &= ~PCL_RCV_INTX_ALL_STATUS;
> > +	val |= BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_STATUS_SHIFT);
> > +	writel(val, priv->base + PCL_RCV_INTX);
> > +}
> > +
> > +static void uniphier_pcie_irq_mask(struct irq_data *d)
> > +{
> > +	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> > +	u32 val;
> > +
> > +	val = readl(priv->base + PCL_RCV_INTX);
> > +	val &= ~PCL_RCV_INTX_ALL_STATUS;
> > +	val |= BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_MASK_SHIFT);
> > +	writel(val, priv->base + PCL_RCV_INTX);
> > +}
> > +
> > +static void uniphier_pcie_irq_unmask(struct irq_data *d)
> > +{
> > +	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> > +	u32 val;
> > +
> > +	val = readl(priv->base + PCL_RCV_INTX);
> > +	val &= ~PCL_RCV_INTX_ALL_STATUS;
> 
> I have noticed this operation is carried out on ACK/MASK/UNMASK,
> what's its purpose ?

Thanks for pointing out. This is wrong.

The register PCL_RCV_INTX has 3 parts of bits.

#define PCL_RCV_INTX_ALL_ENABLE         GENMASK(19, 16)
#define PCL_RCV_INTX_ALL_MASK           GENMASK(11, 8)
#define PCL_RCV_INTX_ALL_STATUS         GENMASK(3, 0)

In the mask/unmask operation,
We should use PCL_RCV_INTX_ALL_MASK to represent 'mask bits',
not PCL_RCV_INTX_ALL_STATUS.
And the ack operation is effective by writing 1 to 'status bits'.

Thank you,

---
Best Regards,
Kunihiko Hayashi


