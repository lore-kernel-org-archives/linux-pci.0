Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kamal Mostafa <kamal@canonical.com>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	kernel-team@lists.ubuntu.com
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Meelis Roos <mroos@linux.ee>, Helge Deller <deller@gmx.de>,
	Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.19.y-ckt 103/156] PCI,parisc: Enable 64-bit bus addresses on PA-RISC
Date: Tue, 20 Oct 2015 14:37:24 -0700
Message-Id: <1445377097-9921-104-git-send-email-kamal@canonical.com>
In-Reply-To: <1445377097-9921-1-git-send-email-kamal@canonical.com>
References: <1445377097-9921-1-git-send-email-kamal@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

3.19.8-ckt8 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit e02a653e15d8d32e9e768fd99a3271aafe5c5d77 upstream.

Commit 3a9ad0b ("PCI: Add pci_bus_addr_t") unconditionally introduced usage of
64-bit PCI bus addresses on all 64-bit platforms which broke PA-RISC.

It turned out that due to enabling the 64-bit addresses, the PCI logic decided
to use the GMMIO instead of the LMMIO region. This commit simply disables
registering the GMMIO and thus we fall back to use the LMMIO region as before.

Reverts commit 45ea2a5fed6dacb9bb0558d8b21eacc1c45d5bb4
("PCI: Don't use 64-bit bus addresses on PA-RISC")

To: linux-parisc@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Meelis Roos <mroos@linux.ee>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 drivers/parisc/lba_pci.c | 7 +++++--
 drivers/pci/Kconfig      | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
index dceb9dd..a32c1f6 100644
--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -1556,8 +1556,11 @@ lba_driver_probe(struct parisc_device *dev)
 	if (lba_dev->hba.lmmio_space.flags)
 		pci_add_resource_offset(&resources, &lba_dev->hba.lmmio_space,
 					lba_dev->hba.lmmio_space_offset);
-	if (lba_dev->hba.gmmio_space.flags)
-		pci_add_resource(&resources, &lba_dev->hba.gmmio_space);
+	if (lba_dev->hba.gmmio_space.flags) {
+		/* pci_add_resource(&resources, &lba_dev->hba.gmmio_space); */
+		pr_warn("LBA: Not registering GMMIO space %pR\n",
+			&lba_dev->hba.gmmio_space);
+	}
 
 	pci_add_resource(&resources, &lba_dev->hba.bus_num);
 
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 944f500..73de4ef 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -2,7 +2,7 @@
 # PCI configuration
 #
 config PCI_BUS_ADDR_T_64BIT
-	def_bool y if (ARCH_DMA_ADDR_T_64BIT || (64BIT && !PARISC))
+	def_bool y if (ARCH_DMA_ADDR_T_64BIT || 64BIT)
 	depends on PCI
 
 config PCI_MSI
-- 
1.9.1

