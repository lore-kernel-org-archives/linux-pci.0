Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:44806 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755343AbcCOHNI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Mar 2016 03:13:08 -0400
Date: Tue, 15 Mar 2016 10:12:48 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: Michal Simek <michal.simek@xilinx.com>,
	=?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Rob Herring <robh@kernel.org>,
	Ravi Kiran Gummaluri <rgummal@xilinx.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [patch] PCI: xilinx-nwl: fix an error code in
 nwl_pcie_init_irq_domain()
Message-ID: <20160315071248.GG13560@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Returning PTR_ERR(legacy_intc_node) is zero which is success but we want
to return a negative error code.

Fixes: 4337ea1d4b10 ('PCI: xilinx-nwl: Add support for Xilinx NWL PCIe Host Controller')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 7a2dc2e..5139e64 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -525,7 +525,7 @@ static int nwl_pcie_init_irq_domain(struct nwl_pcie *pcie)
 	legacy_intc_node = of_get_next_child(node, NULL);
 	if (!legacy_intc_node) {
 		dev_err(pcie->dev, "No legacy intc node found\n");
-		return PTR_ERR(legacy_intc_node);
+		return -EINVAL;
 	}
 
 	pcie->legacy_irq_domain = irq_domain_add_linear(legacy_intc_node,
