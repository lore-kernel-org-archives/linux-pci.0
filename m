Return-Path: <SRS0=LBaz=BI=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=LBaz=BI=huawei.com=liudongdong3@kernel.org>
From: Dongdong Liu <liudongdong3@huawei.com>
To: <helgaas@kernel.org>, <hch@lst.de>
CC: <linux-pci@vger.kernel.org>, <stable@vger.kernel.org>,
        <gabriele.paoloni@huawei.com>, <charles.chenxin@huawei.com>,
        <linuxarm@huawei.com>, Dongdong Liu <liudongdong3@huawei.com>
Subject: [PATCH V3] PCI/portdrv: Fix MSI/MSI-X bug for PCIe port service drivers
Date: Mon, 9 Oct 2017 20:46:07 +0800
Message-ID: <1507553167-27833-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

Current code is broken as calling pci_free_irq_vectors()
invalidates the IRQ numbers returned before by pci_irq_vectors();
so we need to move all the assignment of the Linux IRQ numbers at
the bottom of the function.

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

Cc: <stable@vger.kernel.org>
Fixes: 3674cc49da9a ("PCI/portdrv: Use pci_irq_alloc_vectors()")
Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
v2->v3:
- Use a 12-character SHA1 commit id.
- Rebase on v4.14-rc4.
v1->v2:
- Fix comments on PATCH v1.
- Simplify implementation.
---
 drivers/pci/pcie/portdrv_core.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 313a21d..89f4cf5b 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -55,7 +55,8 @@ static void release_pcie_device(struct device *dev)
 static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 {
 	int nr_entries, entry, nvec = 0;
-
+	int i;
+	int idx[PCIE_PORT_DEVICE_MAXSERVICES];
 	/*
 	 * Allocate as many entries as the port wants, so that we can check
 	 * which of them will be useful.  Moreover, if nr_entries is correctly
@@ -67,6 +68,9 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 	if (nr_entries < 0)
 		return nr_entries;
 
+	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
+		idx[i] = -1;
+
 	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
 		u16 reg16;
 
@@ -90,8 +94,8 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 		if (entry >= nr_entries)
 			goto out_free_irqs;
 
-		irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pci_irq_vector(dev, entry);
-		irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pci_irq_vector(dev, entry);
+		idx[PCIE_PORT_SERVICE_PME_SHIFT] = entry;
+		idx[PCIE_PORT_SERVICE_HP_SHIFT] = entry;
 
 		nvec = max(nvec, entry + 1);
 	}
@@ -118,7 +122,7 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 		if (entry >= nr_entries)
 			goto out_free_irqs;
 
-		irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pci_irq_vector(dev, entry);
+		idx[PCIE_PORT_SERVICE_AER_SHIFT] = entry;
 
 		nvec = max(nvec, entry + 1);
 	}
@@ -145,7 +149,7 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 		if (entry >= nr_entries)
 			goto out_free_irqs;
 
-		irqs[PCIE_PORT_SERVICE_DPC_SHIFT] = pci_irq_vector(dev, entry);
+		idx[PCIE_PORT_SERVICE_DPC_SHIFT] = entry;
 
 		nvec = max(nvec, entry + 1);
 	}
@@ -166,6 +170,9 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 			return nr_entries;
 	}
 
+	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
+		irqs[i] = idx[i] >= 0 ? pci_irq_vector(dev, idx[i]) : -1;
+
 	return 0;
 
 out_free_irqs:
-- 
1.9.1
