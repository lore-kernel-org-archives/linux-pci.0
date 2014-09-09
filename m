Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:50982 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352AbaIIMMT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Sep 2014 08:12:19 -0400
Date: Tue, 9 Sep 2014 15:11:50 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Srikanth Thokala <sthokal@xilinx.com>
Cc: Michal Simek <michal.simek@xilinx.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Srikanth Thokala <sthokal@xilinx.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [patch] PCI: xilinx: testing wrong variable in setup irq function
Message-ID: <20140909121150.GD19760@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We should be testing "hwirq" instead of "irq".  "irq" is unsigned so
it's never less than zero.  Also it's uninitialized.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 44f8944..ccc496b 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -359,8 +359,8 @@ static int xilinx_pcie_msi_setup_irq(struct msi_chip *chip,
 	phys_addr_t msg_addr;
 
 	hwirq = xilinx_pcie_assign_msi(port);
-	if (irq < 0)
-		return irq;
+	if (hwirq < 0)
+		return hwirq;
 
 	irq = irq_create_mapping(port->irq_domain, hwirq);
 	if (!irq)
