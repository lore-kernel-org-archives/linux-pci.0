Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:38529 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdBOH6d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2017 02:58:33 -0500
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 2/2] PCI: update MSI/MSI-X bits in PCIEBUS-HOWTO
Date: Wed, 15 Feb 2017 08:58:23 +0100
Message-Id: <20170215075823.3024-3-hch@lst.de>
In-Reply-To: <20170215075823.3024-1-hch@lst.de>
References: <20170215075823.3024-1-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Stop talking about low-level details that mention deprecated APIs and
concentrate on what service drivers should do and why.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/PCI/PCIEBUS-HOWTO.txt | 33 +++++++--------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/Documentation/PCI/PCIEBUS-HOWTO.txt b/Documentation/PCI/PCIEBUS-HOWTO.txt
index 6bd5f372adec..15f0bb3b5045 100644
--- a/Documentation/PCI/PCIEBUS-HOWTO.txt
+++ b/Documentation/PCI/PCIEBUS-HOWTO.txt
@@ -161,21 +161,13 @@ Since all service drivers of a PCI-PCI Bridge Port device are
 allowed to run simultaneously, below lists a few of possible resource
 conflicts with proposed solutions.
 
-6.1 MSI Vector Resource
-
-The MSI capability structure enables a device software driver to call
-pci_enable_msi to request MSI based interrupts. Once MSI interrupts
-are enabled on a device, it stays in this mode until a device driver
-calls pci_disable_msi to disable MSI interrupts and revert back to
-INTx emulation mode. Since service drivers of the same PCI-PCI Bridge
-port share the same physical device, if an individual service driver
-calls pci_enable_msi/pci_disable_msi it may result unpredictable
-behavior. For example, two service drivers run simultaneously on the
-same physical Root Port. Both service drivers call pci_enable_msi to
-request MSI based interrupts. A service driver may not know whether
-any other service drivers have run on this Root Port. If either one
-of them calls pci_disable_msi, it puts the other service driver
-in a wrong interrupt mode.
+6.1 MSI and MSI-X Vector Resource
+
+Once MSI or MSI-X interrupts are enabled on a device, it stays in this
+mode until they are disabled again.  Since service drivers of the same
+PCI-PCI Bridge port share the same physical device, if an individual
+service driver enables or disables MSI/MSI-X mode it may result
+unpredictable behavior.
 
 To avoid this situation all service drivers are not permitted to
 switch interrupt mode on its device. The PCI Express Port Bus driver
@@ -187,17 +179,6 @@ driver. Service drivers should use (struct pcie_device*)dev->irq to
 call request_irq/free_irq. In addition, the interrupt mode is stored
 in the field interrupt_mode of struct pcie_device.
 
-6.2 MSI-X Vector Resources
-
-Similar to the MSI a device driver for an MSI-X capable device can
-call pci_enable_msix to request MSI-X interrupts. All service drivers
-are not permitted to switch interrupt mode on its device. The PCI
-Express Port Bus driver is responsible for determining the interrupt
-mode and this should be transparent to service drivers. Any attempt
-by service driver to call pci_enable_msix/pci_disable_msix may
-result unpredictable behavior. Service drivers should use
-(struct pcie_device*)dev->irq and call request_irq/free_irq.
-
 6.3 PCI Memory/IO Mapped Regions
 
 Service drivers for PCI Express Power Management (PME), Advanced
-- 
2.11.0
