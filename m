Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f73.google.com ([209.85.212.73]:34911 "EHLO
	mail-vb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932316Ab3AIR7F (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jan 2013 12:59:05 -0500
Received: by mail-vb0-f73.google.com with SMTP id l1so264483vba.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Jan 2013 09:59:04 -0800 (PST)
Subject: [PATCH 1/5] x86/PCI: Remove unused pci_root_bus
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Howells <dhowells@redhat.com>,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	x86@kernel.org
Date: Wed, 09 Jan 2013 10:52:55 -0700
Message-ID: <20130109175255.13904.16833.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20130109175151.13904.84252.stgit@bhelgaas.mtv.corp.google.com>
References: <20130109175151.13904.84252.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_root_bus is unused, so remove all references to it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/include/asm/pci_x86.h |    1 -
 arch/x86/pci/common.c          |    1 -
 arch/x86/pci/legacy.c          |    2 +-
 arch/x86/pci/numaq_32.c        |    2 +-
 4 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 73e8eef..0126f10 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -54,7 +54,6 @@ void pcibios_set_cache_line_size(void);
 /* pci-pc.c */
 
 extern int pcibios_last_bus;
-extern struct pci_bus *pci_root_bus;
 extern struct pci_ops pci_root_ops;
 
 void pcibios_scan_specific_bus(int busn);
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 412e128..505731b 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -34,7 +34,6 @@ int noioapicreroute = 1;
 #endif
 int pcibios_last_bus = -1;
 unsigned long pirq_table_addr;
-struct pci_bus *pci_root_bus;
 const struct pci_raw_ops *__read_mostly raw_pci_ops;
 const struct pci_raw_ops *__read_mostly raw_pci_ext_ops;
 
diff --git a/arch/x86/pci/legacy.c b/arch/x86/pci/legacy.c
index a1df191..a9e8308 100644
--- a/arch/x86/pci/legacy.c
+++ b/arch/x86/pci/legacy.c
@@ -30,7 +30,7 @@ int __init pci_legacy_init(void)
 	}
 
 	printk("PCI: Probing PCI hardware\n");
-	pci_root_bus = pcibios_scan_root(0);
+	pcibios_scan_root(0);
 	return 0;
 }
 
diff --git a/arch/x86/pci/numaq_32.c b/arch/x86/pci/numaq_32.c
index 83e125b..00edfe6 100644
--- a/arch/x86/pci/numaq_32.c
+++ b/arch/x86/pci/numaq_32.c
@@ -152,7 +152,7 @@ int __init pci_numaq_init(void)
 
 	raw_pci_ops = &pci_direct_conf1_mq;
 
-	pci_root_bus = pcibios_scan_root(0);
+	pcibios_scan_root(0);
 	if (num_online_nodes() > 1)
 		for_each_online_node(quad) {
 			if (quad == 0)

