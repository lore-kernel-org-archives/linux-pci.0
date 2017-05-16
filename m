Return-Path: <SRS0=f3dI=4W=huawei.com=gabriele.paoloni@kernel.org>
Return-Path: <SRS0=f3dI=4W=huawei.com=gabriele.paoloni@kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <bhelgaas@google.com>, <helgaas@kernel.org>
CC: <gabriele.paoloni@huawei.com>, <linuxarm@huawei.com>,
        <linux-pci@vger.kernel.org>, <lukas@wunner.de>,
        <linux-kernel@vger.kernel.org>, <mika.westerberg@linux.intel.com>
Subject: [PATCH 2/2] PCI/portdrv: allocate MSI/MSIx vector for DPC RP service
Date: Tue, 16 May 2017 11:25:42 +0100
Message-ID: <1494930342-7132-3-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1494930342-7132-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1494930342-7132-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

From: gabriele paoloni <gabriele.paoloni@huawei.com>

Currently the MSI/MSIx vectors for the root port services are
allocated calling pcie_init_service_irqs(). At the moment these
vectors are only allocated for AER, PME, HP.
This patch allocate an MSI/MSIx vector also for DPC.

Signed-off-by: Liudongdong <liudongdong3@huawei.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 drivers/pci/pcie/portdrv_core.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index e2c7bfd..477bf14 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -131,6 +131,35 @@ int pcie_port_enable_msix_or_msi(struct pci_dev *dev, int *irqs, int mask)
 		nvec = max(nvec, entry + 1);
 	}
 
+	if (mask & PCIE_PORT_SERVICE_DPC) {
+		u16 reg16, pos;
+
+		/*
+		 * The code below follows Section 6.2.10.1 of the PCI Express
+		 * Base Specification 4.0 stating that bits 4-0 of DPC
+		 * Capability Register contain a value indicating which of the
+		 * MSI/MSI-X vectors assigned to the port is going to be used
+		 * for DPC, where "For MSI-X, the value in this register
+		 * indicates which MSI-X Table entry is used to generate the
+		 * interrupt message." and "For MSI, the value in this field
+		 * indicates the offset between the base Message Data and the
+		 * interrupt message that is generated."
+		 *
+		 * pci_irq_vector() below is able to handle entry differently
+		 * depending on MSI vs MSI-x case
+		 *
+		 */
+		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC);
+		pci_read_config_word(dev, pos + PCI_EXP_DPC_CAP, &reg16);
+		entry = reg16 & 0x1f;
+		if (entry >= nr_entries)
+			goto out_free_irqs;
+
+		irqs[PCIE_PORT_SERVICE_DPC_SHIFT] = pci_irq_vector(dev, entry);
+
+		nvec = max(nvec, entry + 1);
+	}
+
 	/*
 	 * If nvec is equal to the allocated number of entries, we can just use
 	 * what we have.  Otherwise, the port has some extra entries not for the
-- 
2.7.4
