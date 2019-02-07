Return-Path: <SRS0=HpDZ=QO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD37C282C2
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 11:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8EE21872
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 11:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zIPBan9W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfBGLcX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:32:23 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59702 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfBGLcX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Feb 2019 06:32:23 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x17BW9eU103813;
        Thu, 7 Feb 2019 05:32:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549539129;
        bh=yikLZbiZ7XlBtVkInDXU3WW2M/89dsx2CmievSEZFwA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=zIPBan9WFnKykaNJ3mYeGdeO1cDHMLfCuaMKjkgc/+L/VfzFiLAWvrzfk6QEMf3u5
         MU4yK3MBZ/gia0Jqan7zsVq2P0cc0u0zxJkDYZE/HJoQIrXoSk6r1KrOYGTlQM3z1K
         YblD7eFbLUOpWv/hTclyY+2lBtWUOBx4OQ74KfTw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x17BW9iB021366
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Feb 2019 05:32:09 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Feb 2019 05:32:09 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Feb 2019 05:32:09 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x17BVxam026282;
        Thu, 7 Feb 2019 05:32:06 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Murali Karicheri <m-karicheri2@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/9] PCI: keystone: Modify legacy_irq_handler to check the IRQ_STATUS of INTA/B/C/D
Date:   Thu, 7 Feb 2019 16:39:17 +0530
Message-ID: <20190207110924.30716-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190207110924.30716-1-kishon@ti.com>
References: <20190207110924.30716-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The legacy interrupt handler directly checks the IRQ_STATUS register
corresponding to a interrupt line inorder to invoke generic_handle_irq.

While this is okay for K2G platform which has separate interrupt line for
each of the 4 legacy interrupts, AM654 which uses the same PCIe wrapper
has a single interrupt line for all the legacy interrupts. So for AM654
the interrupt handler won't be able to directly check the IRQ_STATUS
register corresponding to the interrupt line.

Also the legacy interrupt handler uses 'virq' obtained from
irq_of_parse_and_map to find the correct interrupt line which raised the
interrupt. There is no guarantee that virq assigned for contiguous hardware
irq will be contiguous and the interrupt handler might end up checking
the wrong IRQ_STATUS register.

In order to overcome the above issues, read the IRQ_STATUS register of
all the 4 legacy interrupts to determine which interrupt was raised.

Link: https://lkml.kernel.org/r/bb081d21-7c03-0357-4294-7e92d95d838c@arm.com
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 5286a480f76b..4cf9849d5a1d 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -214,16 +214,11 @@ static void ks_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
 {
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct device *dev = pci->dev;
-	u32 pending;
 	int virq;
 
-	pending = ks_pcie_app_readl(ks_pcie, IRQ_STATUS(offset));
-
-	if (BIT(0) & pending) {
-		virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
-		dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
-		generic_handle_irq(virq);
-	}
+	virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
+	dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
+	generic_handle_irq(virq);
 
 	/* EOI the INTx interrupt */
 	ks_pcie_app_writel(ks_pcie, IRQ_EOI, offset);
@@ -607,8 +602,9 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
 	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct device *dev = pci->dev;
-	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
 	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned int irq_no;
+	u32 reg;
 
 	dev_dbg(dev, ": Handling legacy irq %d\n", irq);
 
@@ -618,7 +614,13 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
 	 * ack operation.
 	 */
 	chained_irq_enter(chip, desc);
-	ks_pcie_handle_legacy_irq(ks_pcie, irq_offset);
+	for (irq_no = 0; irq_no < PCI_NUM_INTX; irq_no++) {
+		reg = ks_pcie_app_readl(ks_pcie, IRQ_STATUS(irq_no));
+		if (!(reg & INTx_EN))
+			continue;
+		ks_pcie_handle_legacy_irq(ks_pcie, irq_no);
+	}
+
 	chained_irq_exit(chip, desc);
 }
 
-- 
2.17.1

