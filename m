Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752565AbcK2EQo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Nov 2016 23:16:44 -0500
Subject: [PATCH v4 6/7] PCI: Decouple IORESOURCE_ROM_ENABLE and
 PCI_ROM_ADDRESS_ENABLE
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: clsoto@us.ibm.com, benh@kernel.crashing.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au
Date: Mon, 28 Nov 2016 22:16:07 -0600
Message-ID: <20161129041607.21453.52485.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161129035218.21453.93986.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161129035218.21453.93986.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove the assumption that IORESOURCE_ROM_ENABLE == PCI_ROM_ADDRESS_ENABLE.
PCI_ROM_ADDRESS_ENABLE is the ROM enable bit defined by the PCI spec, so if
we're reading or writing a BAR register value, that's what we should use.
IORESOURCE_ROM_ENABLE is a corresponding bit in struct resource flags.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ab00267..cf7670e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -227,7 +227,8 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 			mask64 = (u32)PCI_BASE_ADDRESS_MEM_MASK;
 		}
 	} else {
-		res->flags |= (l & IORESOURCE_ROM_ENABLE);
+		if (l & PCI_ROM_ADDRESS_ENABLE)
+			res->flags |= IORESOURCE_ROM_ENABLE;
 		l64 = l & PCI_ROM_ADDRESS_MASK;
 		sz64 = sz & PCI_ROM_ADDRESS_MASK;
 		mask64 = (u32)PCI_ROM_ADDRESS_MASK;

