Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f202.google.com ([209.85.217.202]:51058 "EHLO
	mail-lb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932217Ab3AIRxI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jan 2013 12:53:08 -0500
Received: by mail-lb0-f202.google.com with SMTP id s4so127026lbc.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Jan 2013 09:53:06 -0800 (PST)
Subject: [PATCH 3/5] mn10300/PCI: Remove unused pci_root_bus
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Howells <dhowells@redhat.com>,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	x86@kernel.org
Date: Wed, 09 Jan 2013 10:53:05 -0700
Message-ID: <20130109175305.13904.82833.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20130109175151.13904.84252.stgit@bhelgaas.mtv.corp.google.com>
References: <20130109175151.13904.84252.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_root_bus is unused, so remove all references to it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/mn10300/unit-asb2305/pci-asb2305.h |    1 -
 arch/mn10300/unit-asb2305/pci.c         |    4 +---
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/mn10300/unit-asb2305/pci-asb2305.h b/arch/mn10300/unit-asb2305/pci-asb2305.h
index 1194fe4..7fa66a0 100644
--- a/arch/mn10300/unit-asb2305/pci-asb2305.h
+++ b/arch/mn10300/unit-asb2305/pci-asb2305.h
@@ -36,7 +36,6 @@ extern void pcibios_resource_survey(void);
 /* pci.c */
 
 extern int pcibios_last_bus;
-extern struct pci_bus *pci_root_bus;
 extern struct pci_ops *pci_root_ops;
 
 extern struct irq_routing_table *pcibios_get_irq_routing_table(void);
diff --git a/arch/mn10300/unit-asb2305/pci.c b/arch/mn10300/unit-asb2305/pci.c
index e205948..426bf51 100644
--- a/arch/mn10300/unit-asb2305/pci.c
+++ b/arch/mn10300/unit-asb2305/pci.c
@@ -24,7 +24,6 @@
 unsigned int pci_probe = 1;
 
 int pcibios_last_bus = -1;
-struct pci_bus *pci_root_bus;
 struct pci_ops *pci_root_ops;
 
 /*
@@ -377,8 +376,7 @@ static int __init pcibios_init(void)
 
 	pci_add_resource_offset(&resources, &pci_ioport_resource, io_offset);
 	pci_add_resource_offset(&resources, &pci_iomem_resource, mem_offset);
-	pci_root_bus = pci_scan_root_bus(NULL, 0, &pci_direct_ampci, NULL,
-					 &resources);
+	pci_scan_root_bus(NULL, 0, &pci_direct_ampci, NULL, &resources);
 
 	pcibios_irq_init();
 	pcibios_fixup_irqs();

