Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E9BC4338F
	for <linux-pci@archiver.kernel.org>; Thu, 19 Aug 2021 10:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A3061152
	for <linux-pci@archiver.kernel.org>; Thu, 19 Aug 2021 10:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238447AbhHSK5N (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 19 Aug 2021 06:57:13 -0400
Received: from mx.socionext.com ([202.248.49.38]:36875 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238449AbhHSK5K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Aug 2021 06:57:10 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 19 Aug 2021 19:56:34 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 3B8852083C46;
        Thu, 19 Aug 2021 19:56:34 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 19 Aug 2021 19:56:34 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 0560CB631E;
        Thu, 19 Aug 2021 19:56:34 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=8F=AB=CDski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     =?UTF-8?q?Pali=20Roh=8F=AB=A1r?= <pali@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] PCI: uniphier: Take lock in INTX irq_{mask,unmask,ack} callbacks
Date:   Thu, 19 Aug 2021 19:56:06 +0900
Message-Id: <1629370566-29984-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The same condition register PCI_RCV_INTX is used in irq_mask(),
irq_unmask() and irq_ack() callbacks. Accesses to register can occur at the
same time without lock.
This introduces a lock into the callbacks to prevent the issue.

Fixes: 7e6d5cd88a6f ("PCI: uniphier: Add UniPhier PCIe host controller support")
Suggested-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pci/controller/dwc/pcie-uniphier.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index ebe43e9..5075714 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -186,12 +186,17 @@ static void uniphier_pcie_irq_ack(struct irq_data *d)
 	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
+	unsigned long flags;
 	u32 val;
 
+	raw_spin_lock_irqsave(&pp->lock, flags);
+
 	val = readl(priv->base + PCL_RCV_INTX);
 	val &= ~PCL_RCV_INTX_ALL_STATUS;
 	val |= BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_STATUS_SHIFT);
 	writel(val, priv->base + PCL_RCV_INTX);
+
+	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
 
 static void uniphier_pcie_irq_mask(struct irq_data *d)
@@ -199,12 +204,17 @@ static void uniphier_pcie_irq_mask(struct irq_data *d)
 	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
+	unsigned long flags;
 	u32 val;
 
+	raw_spin_lock_irqsave(&pp->lock, flags);
+
 	val = readl(priv->base + PCL_RCV_INTX);
 	val &= ~PCL_RCV_INTX_ALL_MASK;
 	val |= BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_MASK_SHIFT);
 	writel(val, priv->base + PCL_RCV_INTX);
+
+	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
 
 static void uniphier_pcie_irq_unmask(struct irq_data *d)
@@ -212,12 +222,17 @@ static void uniphier_pcie_irq_unmask(struct irq_data *d)
 	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
+	unsigned long flags;
 	u32 val;
 
+	raw_spin_lock_irqsave(&pp->lock, flags);
+
 	val = readl(priv->base + PCL_RCV_INTX);
 	val &= ~PCL_RCV_INTX_ALL_MASK;
 	val &= ~BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_MASK_SHIFT);
 	writel(val, priv->base + PCL_RCV_INTX);
+
+	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
 
 static struct irq_chip uniphier_pcie_irq_chip = {
-- 
2.7.4

