Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:48872 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdBOH6a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2017 02:58:30 -0500
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 1/2] PCI: update pci.txt to talk about pci_alloc_irq_vectors
Date: Wed, 15 Feb 2017 08:58:22 +0100
Message-Id: <20170215075823.3024-2-hch@lst.de>
In-Reply-To: <20170215075823.3024-1-hch@lst.de>
References: <20170215075823.3024-1-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

instead of the deprecated pci_enable_msi* APIs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/PCI/pci.txt | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/PCI/pci.txt b/Documentation/PCI/pci.txt
index 77f49dc5be23..98875f8cb7ba 100644
--- a/Documentation/PCI/pci.txt
+++ b/Documentation/PCI/pci.txt
@@ -382,18 +382,18 @@ The fundamental difference between MSI and MSI-X is how multiple
 "vectors" get allocated. MSI requires contiguous blocks of vectors
 while MSI-X can allocate several individual ones.
 
-MSI capability can be enabled by calling pci_enable_msi() or
-pci_enable_msix() before calling request_irq(). This causes
-the PCI support to program CPU vector data into the PCI device
-capability registers.
-
-If your PCI device supports both, try to enable MSI-X first.
-Only one can be enabled at a time.  Many architectures, chip-sets,
-or BIOSes do NOT support MSI or MSI-X and the call to pci_enable_msi/msix
-will fail. This is important to note since many drivers have
-two (or more) interrupt handlers: one for MSI/MSI-X and another for IRQs.
-They choose which handler to register with request_irq() based on the
-return value from pci_enable_msi/msix().
+MSI capability can be enabled by calling pci_alloc_irq_vectors with the
+PCI_IRQ_MSI and/or PCI_IRQ_MSIX flags before calling request_irq(). This
+causes the PCI support to program CPU vector data into the PCI device
+capability registers.  Many architectures, chip-sets, or BIOSes do NOT
+support MSI or MSI-X and a call to pci_alloc_irq_vectors with just
+the PCI_IRQ_MSI and PCI_IRQ_MSIX flags will fail, so try to always
+specify PCI_IRQ_LEGACY as well.
+
+Drivers that have different interrupt handlers for MSI/MSI-X and
+legacy INTx should chose the right one based on the msi_enabled
+and msix_enabled flags in the pci_dev structure after calling
+pci_alloc_irq_vectors.
 
 There are (at least) two really good reasons for using MSI:
 1) MSI is an exclusive interrupt vector by definition.
-- 
2.11.0
