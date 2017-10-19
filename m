Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752393AbdJSXBQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Oct 2017 19:01:16 -0400
Subject: [PATCH v5 2/3] PCI/portdrv: Remove excessive comments
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: Charles Chenxin <charles.chenxin@huawei.com>, linuxarm@huawei.com,
        Christoph Hellwig <hch@lst.de>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        linux-pci@vger.kernel.org
Date: Thu, 19 Oct 2017 18:01:15 -0500
Message-ID: <20171019230115.17806.52138.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171019225726.17806.62380.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20171019225726.17806.62380.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Remove some wordy and repetitive comments so we can see the code better.
The register field #defines should be enough of a hook to find relevant
descriptions in the spec.  No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/portdrv_core.c |   56 +--------------------------------------
 1 file changed, 2 insertions(+), 54 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 72fcbe5567dd..7cd2eafda652 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -56,12 +56,7 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 {
 	int nr_entries, entry, nvec = 0;
 
-	/*
-	 * Allocate as many entries as the port wants, so that we can check
-	 * which of them will be useful.  Moreover, if nr_entries is correctly
-	 * equal to the number of entries this port actually uses, we'll happily
-	 * go through without any tricks.
-	 */
+	/* Allocate the maximum possible number of MSI/MSI-X vectors */
 	nr_entries = pci_alloc_irq_vectors(dev, 1, PCIE_PORT_MAX_MSI_ENTRIES,
 			PCI_IRQ_MSIX | PCI_IRQ_MSI);
 	if (nr_entries < 0)
@@ -70,21 +65,6 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
 		u16 reg16;
 
-		/*
-		 * Per PCIe r3.1, sec 6.1.6, "PME and Hot-Plug Event
-		 * interrupts (when both are implemented) always share the
-		 * same MSI or MSI-X vector, as indicated by the Interrupt
-		 * Message Number field in the PCI Express Capabilities
-		 * register".
-		 *
-		 * Per sec 7.8.2, "For MSI, the [Interrupt Message Number]
-		 * indicates the offset between the base Message Data and
-		 * the interrupt message that is generated."
-		 *
-		 * "For MSI-X, the [Interrupt Message Number] indicates
-		 * which MSI-X Table entry is used to generate the
-		 * interrupt message."
-		 */
 		pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
 		entry = (reg16 & PCI_EXP_FLAGS_IRQ) >> 9;
 		if (entry >= nr_entries)
@@ -99,19 +79,6 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 	if (mask & PCIE_PORT_SERVICE_AER) {
 		u32 reg32, pos;
 
-		/*
-		 * Per PCIe r3.1, sec 7.10.10, the Advanced Error Interrupt
-		 * Message Number in the Root Error Status register
-		 * indicates which MSI/MSI-X vector is used for AER.
-		 *
-		 * "For MSI, the [Advanced Error Interrupt Message Number]
-		 * indicates the offset between the base Message Data and
-		 * the interrupt message that is generated."
-		 *
-		 * "For MSI-X, the [Advanced Error Interrupt Message
-		 * Number] indicates which MSI-X Table entry is used to
-		 * generate the interrupt message."
-		 */
 		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
 		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &reg32);
 		entry = (reg32 & PCI_ERR_ROOT_AER_IRQ) >> 27;
@@ -126,19 +93,6 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 	if (mask & PCIE_PORT_SERVICE_DPC) {
 		u16 reg16, pos;
 
-		/*
-		 * Per PCIe r4.0 (v0.9), sec 7.9.15.2, the DPC Interrupt
-		 * Message Number in the DPC Capability register indicates
-		 * which MSI/MSI-X vector is used for DPC.
-		 *
-		 * "For MSI, the [DPC Interrupt Message Number] indicates
-		 * the offset between the base Message Data and the
-		 * interrupt message that is generated."
-		 *
-		 * "For MSI-X, the [DPC Interrupt Message Number] indicates
-		 * which MSI-X Table entry is used to generate the
-		 * interrupt message."
-		 */
 		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC);
 		pci_read_config_word(dev, pos + PCI_EXP_DPC_CAP, &reg16);
 		entry = reg16 & PCI_EXP_DPC_IRQ;
@@ -150,16 +104,10 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 		nvec = max(nvec, entry + 1);
 	}
 
-	/*
-	 * If nvec is equal to the allocated number of entries, we can just use
-	 * what we have.  Otherwise, the port has some extra entries not for the
-	 * services we know and we need to work around that.
-	 */
+	/* If we allocated more than we need, free them and allocate fewer */
 	if (nvec != nr_entries) {
-		/* Drop the temporary MSI-X setup */
 		pci_free_irq_vectors(dev);
 
-		/* Now allocate the MSI-X vectors for real */
 		nr_entries = pci_alloc_irq_vectors(dev, nvec, nvec,
 				PCI_IRQ_MSIX | PCI_IRQ_MSI);
 		if (nr_entries < 0)
