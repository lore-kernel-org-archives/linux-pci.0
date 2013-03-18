Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:34412 "EHLO
	relmlor2.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149Ab3CRRAm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Mar 2013 13:00:42 -0400
Received: from relmlir2.idc.renesas.com ([10.200.68.152])
 by relmlor2.idc.renesas.com ( SJSMS)
 with ESMTP id <0MJV001RP8L5EDA0@relmlor2.idc.renesas.com> for
 linux-pci@vger.kernel.org; Tue, 19 Mar 2013 02:00:41 +0900 (JST)
Received: from relmlac4.idc.renesas.com ([10.200.69.24])
 by relmlir2.idc.renesas.com ( SJSMS)
 with ESMTP id <0MJV00AZJ8L54140@relmlir2.idc.renesas.com> for
 linux-pci@vger.kernel.org; Tue, 19 Mar 2013 02:00:41 +0900 (JST)
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Magnus <magnus.damm@gmail.com>,
	Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH]  pci: Add ID for Renesas R-Car PCIe host
Message-id: <1363626009-25242-1-git-send-email-phil.edworthy@renesas.com>
Date: Mon, 18 Mar 2013 17:00:09 +0000
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 include/linux/pci_ids.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index f11c1c2..04693b7 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2363,6 +2363,7 @@
 #define PCI_DEVICE_ID_RENESAS_SH7763	0x0004
 #define PCI_DEVICE_ID_RENESAS_SH7785	0x0007
 #define PCI_DEVICE_ID_RENESAS_SH7786	0x0010
+#define PCI_DEVICE_ID_RENESAS_RCAR	0x0018
 
 #define PCI_VENDOR_ID_SOLARFLARE	0x1924
 #define PCI_DEVICE_ID_SOLARFLARE_SFC4000A_0	0x0703
-- 
1.7.5.4

