Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:33279 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754433AbaBZXlw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Feb 2014 18:41:52 -0500
Received: by mail-ig0-f175.google.com with SMTP id hl1so11559030igb.2
        for <linux-pci@vger.kernel.org>; Wed, 26 Feb 2014 15:41:52 -0800 (PST)
Subject: [PATCH 3/7] microblaze/PCI: Use default pcibios_enable_device()
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: microblaze-uclinux@itee.uq.edu.au, Michal Simek <monstr@monstr.eu>,
	linux-kernel@vger.kernel.org
Date: Wed, 26 Feb 2014 16:41:48 -0700
Message-ID: <20140226234148.18970.24484.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140226233541.18970.83328.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140226233541.18970.83328.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We don't need anything arch-specific in pcibios_enable_device(), so drop
the arch implementation and use the default generic one.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Michal Simek <monstr@monstr.eu>
CC: microblaze-uclinux@itee.uq.edu.au
---
 arch/microblaze/pci/pci-common.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 66804adcacf0..70996cc66aa2 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -1294,11 +1294,6 @@ void pcibios_finish_adding_to_bus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL_GPL(pcibios_finish_adding_to_bus);
 
-int pcibios_enable_device(struct pci_dev *dev, int mask)
-{
-	return pci_enable_resources(dev, mask);
-}
-
 static void pcibios_setup_phb_resources(struct pci_controller *hose,
 					struct list_head *resources)
 {

