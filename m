Return-Path: <SRS0=nzUO=27=cavium.com=Jayachandran.Nair@kernel.org>
Return-Path: <SRS0=nzUO=27=cavium.com=Jayachandran.Nair@kernel.org>
From: Jayachandran C <jnair@caviumnetworks.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	iommu@lists.linux-foundation.org
Cc: Jayachandran C <jchandra@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	Jon Masters <jcm@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Jayachandran C <jnair@caviumnetworks.com>
Subject: [PATCH v3 1/2] PCI: Add device flag PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT
Date: Wed, 22 Mar 2017 08:51:10 +0000
Message-Id: <1490172671-2648-2-git-send-email-jnair@caviumnetworks.com>
In-Reply-To: <1490172671-2648-1-git-send-email-jnair@caviumnetworks.com>
References: <1490172671-2648-1-git-send-email-jnair@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

From: Jayachandran C <jchandra@broadcom.com>

Add a new quirk flag PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT to limit the DMA
alias search to go no further than the bridge where the IOMMU unit is
attached.

The flag will be used to indicate a bridge device which forwards the
address translation requests to the IOMMU, i.e where the interrupt and
DMA requests leave the PCIe hierarchy and go into the system blocks.

Usually this happens at the PCI RC, so this flag is not needed. But
on systems where there are bridges that introduce aliases above the
"real" root bridge, this flag is needed to ensure that the function
pci_for_each_dma_alias() works correctly.

The function pci_for_each_dma_alias() is updated to stop when it see a
bridge with this flag set.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
---
 drivers/pci/search.c | 4 ++++
 include/linux/pci.h  | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index 33e0f03..4c6044a 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -60,6 +60,10 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 
 		tmp = bus->self;
 
+		/* stop at bridge where translation unit is associated */
+		if (tmp->dev_flags & PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT)
+			return ret;
+
 		/*
 		 * PCIe-to-PCI/X bridges alias transactions from downstream
 		 * devices using the subordinate bus number (PCI Express to
diff --git a/include/linux/pci.h b/include/linux/pci.h
index eb3da1a..3f596ac 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -178,6 +178,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_PM_RESET = (__force pci_dev_flags_t) (1 << 7),
 	/* Get VPD from function 0 VPD */
 	PCI_DEV_FLAGS_VPD_REF_F0 = (__force pci_dev_flags_t) (1 << 8),
+	/* a non-root bridge where translation occurs, stop alias search here */
+	PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT = (__force pci_dev_flags_t) (1 << 9),
 };
 
 enum pci_irq_reroute_variant {
-- 
2.7.4
