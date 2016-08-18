Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:48608 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947064AbcHRNVA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2016 09:21:00 -0400
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: bhelgaas@google.com
Cc: jszhang@marvell.com, jingoohan1@gmail.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH] pcie-designware: build error fix
Date: Thu, 18 Aug 2016 14:18:29 +0100
Message-Id: <7083dc9188405f25307d0a75d4e199846ac06ac9.1471525771.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch is to fix a building error in branch pci/host-designware. 

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
 drivers/pci/host/pcie-designware.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index be70f28..6a743c5 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -511,9 +511,8 @@ static const struct irq_domain_ops msi_domain_ops = {
 
 static u8 dw_pcie_iatu_unroll_enabled(struct pcie_port *pp)
 {
-	u32 val = 0;
+	u32 val = dw_pcie_readl_rc(pp, PCIE_ATU_VIEWPORT);
 
-	dw_pcie_readl_rc(pp, PCIE_ATU_VIEWPORT, &val);
 	if (val == 0xffffffff)
 		return 1;
 
-- 
1.8.1.5

