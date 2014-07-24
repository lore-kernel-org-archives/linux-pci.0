Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:60940 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758701AbaGXGWv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jul 2014 02:22:51 -0400
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Thu, 24 Jul 2014 11:52:49 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id 4F8391258061
	for <linux-pci@vger.kernel.org>; Thu, 24 Jul 2014 11:52:39 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s6O6OZpZ18874414
	for <linux-pci@vger.kernel.org>; Thu, 24 Jul 2014 11:54:35 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s6O6MhHJ010455
	for <linux-pci@vger.kernel.org>; Thu, 24 Jul 2014 11:52:44 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
	yan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V7 06/17] powerpc/pci: Define pcibios_disable_device() on powerpc
Date: Thu, 24 Jul 2014 14:22:16 +0800
Message-Id: <1406182947-11302-7-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
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
index f92b0b5..3909d1b 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -238,7 +238,10 @@ struct machdep_calls {
 
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
index ee70f57..d38a330 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1457,6 +1457,14 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
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

