Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam01on0040.outbound.protection.outlook.com ([104.47.32.40]:5760
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752147AbdHHLND (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Aug 2017 07:13:03 -0400
From: Ravi Shankar Jonnalagadda <venkata.ravi.jonnalagadda@xilinx.com>
To: <bhelgaas@google.com>, <michal.simek@xilinx.com>,
        <soren.brinkmann@xilinx.com>, <lorenzo.pieralisi@arm.com>,
        <bharat.kumar.gogada@xilinx.com>, <vjonnal@xilinx.com>,
        <paul.gortmaker@windriver.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dan.j.williams@intel.com>,
        <vinod.koul@intel.com>, <dmaengine@vger.kernel.org>
Subject: [PATCH 2/4] PCI:xilinx-nwl: Correcting Styling checks
Date: Tue, 8 Aug 2017 16:42:17 +0530
Message-ID: <1502190739-13474-3-git-send-email-vjonnal@xilinx.com>
In-Reply-To: <1502190739-13474-1-git-send-email-vjonnal@xilinx.com>
References: <1502190739-13474-1-git-send-email-vjonnal@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Correcting Style checks thrown by checkpatch scripts

Signed-off-by: Ravi Shankar Jonnalagadda <vjonnal@xilinx.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 5766582..3c62e3d 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -506,15 +506,15 @@ static int nwl_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 	for (i = 0; i < nr_irqs; i++) {
 		irq_domain_set_info(domain, virq + i, bit + i, &nwl_irq_chip,
-				domain->host_data, handle_simple_irq,
-				NULL, NULL);
+				    domain->host_data, handle_simple_irq,
+				    NULL, NULL);
 	}
 	mutex_unlock(&msi->lock);
 	return 0;
 }
 
 static void nwl_irq_domain_free(struct irq_domain *domain, unsigned int virq,
-					unsigned int nr_irqs)
+				unsigned int nr_irqs)
 {
 	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
 	struct nwl_pcie *pcie = irq_data_get_irq_chip_data(data);
@@ -767,7 +767,6 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 	/* Enable all misc interrupts */
 	nwl_bridge_writel(pcie, MSGF_MISC_SR_MASKALL, MSGF_MISC_MASK);
 
-
 	/* Disable all legacy interrupts */
 	nwl_bridge_writel(pcie, (u32)~MSGF_LEG_SR_MASKALL, MSGF_LEG_MASK);
 
@@ -932,4 +931,5 @@ static struct platform_driver nwl_pcie_driver = {
 	},
 	.probe = nwl_pcie_probe,
 };
+
 builtin_platform_driver(nwl_pcie_driver);
-- 
2.1.1
