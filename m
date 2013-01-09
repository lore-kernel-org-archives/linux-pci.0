Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f201.google.com ([209.85.220.201]:59282 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932217Ab3AIRxB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jan 2013 12:53:01 -0500
Received: by mail-vc0-f201.google.com with SMTP id p1so263045vcq.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Jan 2013 09:53:01 -0800 (PST)
Subject: [PATCH 2/5] frv/PCI: Remove unused pci_root_bus
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Howells <dhowells@redhat.com>,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	x86@kernel.org
Date: Wed, 09 Jan 2013 10:53:00 -0700
Message-ID: <20130109175300.13904.34950.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20130109175151.13904.84252.stgit@bhelgaas.mtv.corp.google.com>
References: <20130109175151.13904.84252.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_root_bus is unused, so remove all references to it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/frv/mb93090-mb00/pci-frv.h |    1 -
 arch/frv/mb93090-mb00/pci-vdk.c |    4 +---
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/frv/mb93090-mb00/pci-frv.h b/arch/frv/mb93090-mb00/pci-frv.h
index 089eeba..76c4e73 100644
--- a/arch/frv/mb93090-mb00/pci-frv.h
+++ b/arch/frv/mb93090-mb00/pci-frv.h
@@ -31,7 +31,6 @@ void pcibios_resource_survey(void);
 /* pci-vdk.c */
 
 extern int __nongpreldata pcibios_last_bus;
-extern struct pci_bus *__nongpreldata pci_root_bus;
 extern struct pci_ops *__nongpreldata pci_root_ops;
 
 /* pci-irq.c */
diff --git a/arch/frv/mb93090-mb00/pci-vdk.c b/arch/frv/mb93090-mb00/pci-vdk.c
index 71e9bcf..1152a1e 100644
--- a/arch/frv/mb93090-mb00/pci-vdk.c
+++ b/arch/frv/mb93090-mb00/pci-vdk.c
@@ -26,7 +26,6 @@
 unsigned int __nongpreldata pci_probe = 1;
 
 int  __nongpreldata pcibios_last_bus = -1;
-struct pci_bus *__nongpreldata pci_root_bus;
 struct pci_ops *__nongpreldata pci_root_ops;
 
 /*
@@ -416,8 +415,7 @@ int __init pcibios_init(void)
 	printk("PCI: Probing PCI hardware\n");
 	pci_add_resource(&resources, &pci_ioport_resource);
 	pci_add_resource(&resources, &pci_iomem_resource);
-	pci_root_bus = pci_scan_root_bus(NULL, 0, pci_root_ops, NULL,
-					 &resources);
+	pci_scan_root_bus(NULL, 0, pci_root_ops, NULL, &resources);
 
 	pcibios_irq_init();
 	pcibios_fixup_peer_bridges();

