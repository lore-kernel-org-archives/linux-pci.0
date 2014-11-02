Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:45245 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbaKBPl7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 2 Nov 2014 10:41:59 -0500
Received: from /spool/local
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 3 Nov 2014 01:41:57 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id D167B357804C
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2014 02:41:55 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sA2Ffs2D37093604
	for <linux-pci@vger.kernel.org>; Mon, 3 Nov 2014 02:41:54 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sA2FfsgU028185
	for <linux-pci@vger.kernel.org>; Mon, 3 Nov 2014 02:41:55 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V9 07/18] powerpc/pci: Define pcibios_disable_device() on powerpc
Date: Sun,  2 Nov 2014 23:41:23 +0800
Message-Id: <1414942894-17034-8-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When driver remove a pci_dev, it will call pcibios_disable_device() which is
platform dependent. This gives flexibility to platforms.

This patch defines this weak function on powerpc architecture.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h |    5 ++++-
 arch/powerpc/kernel/pci-common.c   |    8 ++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 307347f..8242262 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -240,7 +240,10 @@ struct machdep_calls {
 
 	/* Called when pci_enable_device() is called. Returns 0 to
 	 * allow assignment/enabling of the device. */
-	int  (*pcibios_enable_device_hook)(struct pci_dev *);
+	int (*pcibios_enable_device_hook)(struct pci_dev *);
+
+	/* Called when pci_disable_device() is called. */
+	void (*pcibios_disable_device_hook)(struct pci_dev *);
 
 	/* Called after scan and before resource survey */
 	void (*pcibios_fixup_phb)(struct pci_controller *hose);
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 399d813..17acfa7 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1452,6 +1452,14 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	return pci_enable_resources(dev, mask);
 }
 
+void pcibios_disable_device(struct pci_dev *dev)
+{
+	if (ppc_md.pcibios_disable_device_hook)
+		ppc_md.pcibios_disable_device_hook(dev);
+
+	return;
+}
+
 resource_size_t pcibios_io_space_offset(struct pci_controller *hose)
 {
 	return (unsigned long) hose->io_base_virt - _IO_BASE;
-- 
1.7.9.5

