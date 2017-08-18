Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:64895 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752664AbdHRO7y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2017 10:59:54 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Joao Pinto <Joao.Pinto@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <kishon@ti.com>, <nsekhar@ti.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
Subject: [PATCH 10/18] PCI: dwc: designware: Provide page_size to pci_epc_mem
Date: Fri, 18 Aug 2017 20:28:02 +0530
Message-ID: <20170818145810.17649-11-kishon@ti.com>
In-Reply-To: <20170818145810.17649-1-kishon@ti.com>
References: <20170818145810.17649-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use the newly introduced __pci_epc_mem_init instead of pci_epc_mem_init
to provide page_size to pci_epc_mem. This is in preparation for
adding EP support to K2G which has a restriction that the
address region should be either divided into 1MB/2MB/4MB or 8MB
sizes (Ref: 11.14.4.9.1 Outbound Address Translation in K2G TRM SPRUHY8F
January 2016 – Revised May 2017).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pcie-designware-ep.c | 3 ++-
 drivers/pci/dwc/pcie-designware.h    | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
index 398406393f37..e70ebe3b9b6f 100644
--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -328,7 +328,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	if (ret < 0)
 		epc->max_functions = 1;
 
-	ret = pci_epc_mem_init(epc, ep->phys_base, ep->addr_size);
+	ret = __pci_epc_mem_init(epc, ep->phys_base, ep->addr_size,
+				 ep->page_size);
 	if (ret < 0) {
 		dev_err(dev, "Failed to initialize address space\n");
 		return ret;
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index b4d2a89f8e58..714f6f21ea93 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -186,6 +186,7 @@ struct dw_pcie_ep {
 	struct dw_pcie_ep_ops	*ops;
 	phys_addr_t		phys_base;
 	size_t			addr_size;
+	size_t			page_size;
 	u8			bar_to_atu[6];
 	phys_addr_t		*outbound_addr;
 	unsigned long		ib_window_map;
-- 
2.11.0
