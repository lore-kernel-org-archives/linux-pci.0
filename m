Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:54034 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbaJWCKI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Oct 2014 22:10:08 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NDV00I69KOTRD40@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 23 Oct 2014 11:10:05 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>,
	'Murali Karicheri' <m-karicheri2@ti.com>,
	'Santosh Shilimkar' <ssantosh@kernel.org>
Subject: [PATCH] PCI: keystone: make local symbol static
Date: Thu, 23 Oct 2014 11:10:16 +0900
Message-id: <000101cfee66$7d1ed040$775c70c0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Make local symbol static, because this is used only in this file.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pci/host/pci-keystone-dw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
index 34086ce..4a97cd1 100644
--- a/drivers/pci/host/pci-keystone-dw.c
+++ b/drivers/pci/host/pci-keystone-dw.c
@@ -201,7 +201,7 @@ static int ks_dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
 	return 0;
 }
 
-const struct irq_domain_ops ks_dw_pcie_msi_domain_ops = {
+static const struct irq_domain_ops ks_dw_pcie_msi_domain_ops = {
 	.map = ks_dw_pcie_msi_map,
 };
 
-- 
1.7.9.5


