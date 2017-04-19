Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966745AbdDSQt3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Apr 2017 12:49:29 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v4 08/21] PCI: xilinx: update PCI config space remap function
Date: Wed, 19 Apr 2017 17:48:57 +0100
Message-Id: <20170419164913.19674-9-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
References: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI configuration space should be mapped with a memory region type that
generates on the CPU host bus non-posted write transations. Update the
driver to use the devm_pci_remap_cfg* interface to make sure the correct
memory mappings for PCI configuration space are used.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: Michal Simek <michal.simek@xilinx.com>
---
 drivers/pci/host/pcie-xilinx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 7f030f5..2fe2df5 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -606,7 +606,7 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie_port *port)
 		return err;
 	}
 
-	port->reg_base = devm_ioremap_resource(dev, &regs);
+	port->reg_base = devm_pci_remap_cfg_resource(dev, &regs);
 	if (IS_ERR(port->reg_base))
 		return PTR_ERR(port->reg_base);
 
-- 
2.10.0
