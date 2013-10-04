Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:50070 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325Ab3JDIvs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Oct 2013 04:51:48 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MU400DM3Z8E9DA0@mailout2.samsung.com> for
 linux-pci@vger.kernel.org; Fri, 04 Oct 2013 17:51:46 +0900 (KST)
From: Seungwon Jeon <tgih.jun@samsung.com>
To: linux-pci@vger.kernel.org
Cc: 'Jingoo Han' <jg1.han@samsung.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>
References: <001d01cea3e5$3a07c8b0$ae175a10$%jun@samsung.com>
 <000f01cea48e$f5fc3160$e1f49420$%han@samsung.com>
In-reply-to: 
Subject: [PATCH] PCI: designware: add missing header guards
Date: Fri, 04 Oct 2013 17:51:45 +0900
Message-id: <002001cec0de$f4cd48d0$de67da70$%jun@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Added missing header guards against the redundant inclusion.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/pci/host/pcie-designware.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index faccbbf..0b685b5 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -11,6 +11,9 @@
  * published by the Free Software Foundation.
  */
 
+#ifndef _PCIE_DESIGNWARE_H_
+#define _PCIE_DESIGNWARE_H_
+
 struct pcie_port_info {
 	u32		cfg0_size;
 	u32		cfg1_size;
@@ -77,3 +80,5 @@ int dw_pcie_host_init(struct pcie_port *pp);
 int dw_pcie_setup(int nr, struct pci_sys_data *sys);
 struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys);
 int dw_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
+
+#endif /* _PCIE_DESIGNWARE_H_ */
-- 
1.7.0.4


