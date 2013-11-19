Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5]:33755 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab3KSGhK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Nov 2013 01:37:10 -0500
Received: from /spool/local
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <yan@linux.vnet.ibm.com>;
	Tue, 19 Nov 2013 12:07:08 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id 79622E0057
	for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2013 12:09:03 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id rAJ6axb849283114
	for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2013 12:07:00 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id rAJ6b2Eo008597
	for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2013 12:07:02 +0530
From: Guo Chao <yan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, yinghai@kernel.org
Subject: [RFC PATCH 2/3] PCI: set proper default value of PCIBIOS_MAX_MEM_32
Date: Tue, 19 Nov 2013 14:36:57 +0800
Message-Id: <1384843018-9479-3-git-send-email-yan@linux.vnet.ibm.com>
In-Reply-To: <1384843018-9479-1-git-send-email-yan@linux.vnet.ibm.com>
References: <1384843018-9479-1-git-send-email-yan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCIBIOS_MAX_MEM_32 is used to prevent 32-bit BAR from getting 4G-above
address. Its default value -1 extends to 0xffffffffffffffff in 64-bit
platform which make it useless at all. While arch can overwrite it,
0xffffffff should be good enough for those who does not have special
requirement. Set PCIBIOS_MAX_MEM_32 to 0xffffffff and kill this
definition in x86.

Signed-off-by: Guo Chao <yan@linux.vnet.ibm.com>
---
 arch/x86/include/asm/pci.h | 1 -
 include/linux/pci.h        | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 7d74432..73ff4bc 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -125,7 +125,6 @@ int setup_msi_irq(struct pci_dev *dev, struct msi_desc *msidesc,
 
 /* generic pci stuff */
 #include <asm-generic/pci.h>
-#define PCIBIOS_MAX_MEM_32 0xffffffff
 
 #ifdef CONFIG_NUMA
 /* Returns the node based on pci bus */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 835ec7b..f43405d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1487,7 +1487,7 @@ static inline struct pci_dev *pci_dev_get(struct pci_dev *dev)
 #include <asm/pci.h>
 
 #ifndef PCIBIOS_MAX_MEM_32
-#define PCIBIOS_MAX_MEM_32 (-1)
+#define PCIBIOS_MAX_MEM_32 (0xffffffff)
 #endif
 
 /* these helpers provide future and backwards compatibility
-- 
1.8.3.2

