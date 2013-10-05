Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:56281 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196Ab3JEAc0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Oct 2013 20:32:26 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MU600FTF6TBCA30@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Sat, 05 Oct 2013 09:31:59 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, 'Seungwon Jeon' <tgih.jun@samsung.com>,
	'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH V2] PCI: designware: add missing header guards
Date: Sat, 05 Oct 2013 09:31:59 +0900
Message-id: <001801cec162$4d74f770$e85ee650$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Seungwon Jeon <tgih.jun@samsung.com>

Add missing header guards against the redundant inclusion.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pci/host/pcie-designware.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index faccbbf..d87fbae 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -11,6 +11,9 @@
  * published by the Free Software Foundation.
  */
 
+#ifndef _PCIE_DESIGNWARE_H
+#define _PCIE_DESIGNWARE_H
+
 struct pcie_port_info {
 	u32		cfg0_size;
 	u32		cfg1_size;
@@ -77,3 +80,5 @@ int dw_pcie_host_init(struct pcie_port *pp);
 int dw_pcie_setup(int nr, struct pci_sys_data *sys);
 struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys);
 int dw_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
+
+#endif /* _PCIE_DESIGNWARE_H */
-- 
1.7.10.4


