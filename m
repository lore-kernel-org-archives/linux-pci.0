Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp02.in.ibm.com ([122.248.162.2]:34365 "EHLO
	e28smtp02.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754065Ab3IFBqM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2013 21:46:12 -0400
Received: from /spool/local
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 6 Sep 2013 07:05:25 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 99F4D394004E
	for <linux-pci@vger.kernel.org>; Fri,  6 Sep 2013 07:15:54 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r861k4xh47382776
	for <linux-pci@vger.kernel.org>; Fri, 6 Sep 2013 07:16:04 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id r861k5aT019769
	for <linux-pci@vger.kernel.org>; Fri, 6 Sep 2013 07:16:05 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH 2/3] PCI: Use spec name for the comment of PCIe capability field
Date: Fri,  6 Sep 2013 09:45:57 +0800
Message-Id: <1378431958-7874-2-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1378431958-7874-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1378431958-7874-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

According to the PCIe specification, bit 7:4 of PCI Express Capabilities
Register in a PCI Express Capability Structure is used to identify the
Device/Port type. If this field equals to 0x7, this PCIe device is a PCI
Express to PCI/PCI-X Bridge. While the comment of this value in the code
does not comply with the specification.

This patch changes the comment to "PCIE to PCI/PCI-X Bridge" instead of
"PCI/PCI-X Bridge", which comply with the specification.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 include/uapi/linux/pci_regs.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index c3cc01d..b82b2ff 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -421,7 +421,7 @@
 #define  PCI_EXP_TYPE_ROOT_PORT 0x4	/* Root Port */
 #define  PCI_EXP_TYPE_UPSTREAM	0x5	/* Upstream Port */
 #define  PCI_EXP_TYPE_DOWNSTREAM 0x6	/* Downstream Port */
-#define  PCI_EXP_TYPE_PCI_BRIDGE 0x7	/* PCI/PCI-X Bridge */
+#define  PCI_EXP_TYPE_PCI_BRIDGE 0x7	/* PCIE to PCI/PCI-X Bridge */
 #define  PCI_EXP_TYPE_PCIE_BRIDGE 0x8	/* PCI/PCI-X to PCIE Bridge */
 #define  PCI_EXP_TYPE_RC_END	0x9	/* Root Complex Integrated Endpoint */
 #define  PCI_EXP_TYPE_RC_EC	0xa	/* Root Complex Event Collector */
-- 
1.7.1

