Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:62337 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753386AbdHOTFL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2017 15:05:11 -0400
From: Paul Burton <paul.burton@imgtec.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v7 7/8] PCI: ftpci100: Use PCI_NUM_INTX
Date: Tue, 15 Aug 2017 12:02:22 -0700
Message-ID: <20170815190223.18807-8-paul.burton@imgtec.com>
In-Reply-To: <20170815190223.18807-1-paul.burton@imgtec.com>
References: <20170815190223.18807-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use the PCI_NUM_INTX macro to indicate the number of PCI INTx interrupts
rather than the magic number 4. This makes it clearer where the number
comes from & what it relates to.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org

---
I have only build tested this.

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/pci/host/pci-ftpci100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-ftpci100.c b/drivers/pci/host/pci-ftpci100.c
index 5162dffc102b..1f1f780182de 100644
--- a/drivers/pci/host/pci-ftpci100.c
+++ b/drivers/pci/host/pci-ftpci100.c
@@ -355,7 +355,7 @@ static int faraday_pci_setup_cascaded_irq(struct faraday_pci *p)
 		return -EINVAL;
 	}
 
-	p->irqdomain = irq_domain_add_linear(intc, 4,
+	p->irqdomain = irq_domain_add_linear(intc, PCI_NUM_INTX,
 					     &faraday_pci_irqdomain_ops, p);
 	if (!p->irqdomain) {
 		dev_err(p->dev, "failed to create Gemini PCI IRQ domain\n");
-- 
2.14.1
