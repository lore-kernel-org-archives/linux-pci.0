Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:18570 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbaKLD0Y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Nov 2014 22:26:24 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NEW00M5LPJY26E0@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Wed, 12 Nov 2014 12:26:22 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, 'Mohit Kumar' <mohit.kumar@st.com>,
	'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH] PCI: designware: Add a blank line after declarations
Date: Wed, 12 Nov 2014 12:27:04 +0900
Message-id: <002a01cffe28$87fb3d10$97f1b730$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch fixes the following checkpatch warning.

  WARNING: Missing a blank line after declarations

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pci/host/pcie-designware.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index dfed00a..f9be371 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -380,6 +380,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 	/* Get the I/O and memory ranges from DT */
 	for_each_of_pci_range(&parser, &range) {
 		unsigned long restype = range.flags & IORESOURCE_TYPE_BITS;
+
 		if (restype == IORESOURCE_IO) {
 			of_pci_range_to_resource(&range, np, &pp->io);
 			pp->io.name = "I/O";
-- 
1.7.9.5


