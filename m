Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Meelis Roos <mroos@linux.ee>, Helge Deller <deller@gmx.de>
Subject: [PATCH 4.1 076/159] PCI,parisc: Enable 64-bit bus addresses on PA-RISC
Date: Sat, 26 Sep 2015 13:55:22 -0700
Message-Id: <20150926205318.076976875@linuxfoundation.org>
In-Reply-To: <20150926205313.363686083@linuxfoundation.org>
References: <20150926205313.363686083@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

4.1-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/parisc/lba_pci.c |    7 +++++--
 drivers/pci/Kconfig      |    2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -1556,8 +1556,11 @@ lba_driver_probe(struct parisc_device *d
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


