Return-Path: <SRS0=aHpY=BK=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=aHpY=BK=huawei.com=liudongdong3@kernel.org>
From: Dongdong Liu <liudongdong3@huawei.com>
To: <helgaas@kernel.org>, <hch@lst.de>
CC: <linux-pci@vger.kernel.org>, <stable@vger.kernel.org>,
        <gabriele.paoloni@huawei.com>, <charles.chenxin@huawei.com>,
        <linuxarm@huawei.com>, Dongdong Liu <liudongdong3@huawei.com>
Subject: [PATCH V4 1/2] PCI/portdrv: Fix MSI/MSI-X bug for PCIe port service drivers
Date: Wed, 11 Oct 2017 18:52:57 +0800
Message-ID: <1507719178-112556-2-git-send-email-liudongdong3@huawei.com>
In-Reply-To: <1507719178-112556-1-git-send-email-liudongdong3@huawei.com>
References: <1507719178-112556-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

After removing and adding back the PCI root port device,
we see the PCIe port service drivers request irq failed.
pcie_pme: probe of 0000:00:00.0:pcie001 failed with error -22
aer: probe of 0000:00:00.0:pcie002 failed with error -22
pciehp 0000:00:00.0:pcie004: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd-
PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
pciehp 0000:00:00.0:pcie004: Cannot get irq 20 for the hotplug controller
pciehp 0000:00:00.0:pcie004: Notification initialization failed (-1)
dpc 0000:00:00.0:pcie010: request IRQ22 failed: -22
dpc: probe of 0000:00:00.0:pcie010 failed with error -22

The current code basically does this:

  - allocate 32 vectors
  - figure out vector used by PME and hotplug
  - figure out vector used by AER
  - figure out vector used by DPC
  - free the 32 vectors we allocated
  - allocate only as many vectors as we need

but it is broken as calling pci_free_irq_vectors()
invalidates the IRQ numbers returned before by pci_irq_vectors();

The hardware works:
  - PME and hotplug use the Interrupt Message Number from the PCIe
    Capability register.

  - AER uses the AER Interrupt Message Number from the AER Root Error
    Status register.

  - DPC uses the DPC Interrupt Message Number from the DPC Capability
    register.

  - FRS (not supported by Linux yet) uses the FRS Interrupt Message
    Number from the FRS Queuing Capability register.

  - That's a total of 4 possible MSI/MSI-X vectors used for PME,
    hotplug, AER, DPC, and FRS, so there's no point in trying to
    allocate more than 4 vectors (we currently start with 32).

  - All these Interrupt Message Numbers are read-only to software but
    are updated by hardware when software writes the Multiple Message
    Enable field of the MSI Message Control register.  Thanks for
    pointing this out; I didn't realize this before.

  - Therefore, we must read the Interrupt Message Numbers *after* we
    write Multiple Message Enable.

Since we can use at most 4 vectors, this patch is to optimize the
interrupt vector allocation strategy in pcie_port_enable_irq_vec().
First figure out how many vectors we need,allocate them, and then fill
in the slots in the irqs[] table.

Cc: <stable@vger.kernel.org>
Fixes: 3674cc49da9a ("PCI/portdrv: Use pci_irq_alloc_vectors()")
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 drivers/pci/pcie/portdrv_core.c | 45 +++++++++++++----------------------------
 1 file changed, 14 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 313a21d..9692379 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -56,14 +56,16 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 {
 	int nr_entries, entry, nvec = 0;
 
-	/*
-	 * Allocate as many entries as the port wants, so that we can check
-	 * which of them will be useful.  Moreover, if nr_entries is correctly
-	 * equal to the number of entries this port actually uses, we'll happily
-	 * go through without any tricks.
-	 */
-	nr_entries = pci_alloc_irq_vectors(dev, 1, PCIE_PORT_MAX_MSI_ENTRIES,
-			PCI_IRQ_MSIX | PCI_IRQ_MSI);
+	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP))
+		nvec++;
+	if (mask & PCIE_PORT_SERVICE_AER)
+		nvec++;
+	if (mask & PCIE_PORT_SERVICE_DPC)
+		nvec++;
+
+	/* Allocate as many vectors as the we need */
+	nr_entries = pci_alloc_irq_vectors(dev, 1, nvec,
+					   PCI_IRQ_MSIX | PCI_IRQ_MSI);
 	if (nr_entries < 0)
 		return nr_entries;
 
@@ -90,10 +92,10 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 		if (entry >= nr_entries)
 			goto out_free_irqs;
 
-		irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pci_irq_vector(dev, entry);
-		irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pci_irq_vector(dev, entry);
-
-		nvec = max(nvec, entry + 1);
+		if (mask & PCIE_PORT_SERVICE_PME)
+			irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pci_irq_vector(dev, entry);
+		if (mask & PCIE_PORT_SERVICE_HP)
+			irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pci_irq_vector(dev, entry);
 	}
 
 	if (mask & PCIE_PORT_SERVICE_AER) {
@@ -120,7 +122,6 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 
 		irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pci_irq_vector(dev, entry);
 
-		nvec = max(nvec, entry + 1);
 	}
 
 	if (mask & PCIE_PORT_SERVICE_DPC) {
@@ -146,24 +147,6 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 			goto out_free_irqs;
 
 		irqs[PCIE_PORT_SERVICE_DPC_SHIFT] = pci_irq_vector(dev, entry);
-
-		nvec = max(nvec, entry + 1);
-	}
-
-	/*
-	 * If nvec is equal to the allocated number of entries, we can just use
-	 * what we have.  Otherwise, the port has some extra entries not for the
-	 * services we know and we need to work around that.
-	 */
-	if (nvec != nr_entries) {
-		/* Drop the temporary MSI-X setup */
-		pci_free_irq_vectors(dev);
-
-		/* Now allocate the MSI-X vectors for real */
-		nr_entries = pci_alloc_irq_vectors(dev, nvec, nvec,
-				PCI_IRQ_MSIX | PCI_IRQ_MSI);
-		if (nr_entries < 0)
-			return nr_entries;
 	}
 
 	return 0;
-- 
1.9.1
