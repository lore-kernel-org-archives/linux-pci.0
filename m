Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Grant Likely <grant.likely@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Yingjoe Chen <yingjoe.chen@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [Patch Part2 v5 18/31] PCI/MSI: Remove unnecessary braces around single statements
Date: Thu,  6 Nov 2014 22:20:31 +0800
Message-Id: <1415283644-2559-19-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1415283644-2559-1-git-send-email-jiang.liu@linux.intel.com>
References: <1415283644-2559-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Per Documentation/CodingStyle, don't use braces around single statements.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 9fab30af0e75..fb2ccb536324 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -244,9 +244,8 @@ void default_restore_msi_irqs(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
 
-	list_for_each_entry(entry, &dev->msi_list, list) {
+	list_for_each_entry(entry, &dev->msi_list, list)
 		default_restore_msi_irq(dev, entry->irq);
-	}
 }
 
 void __read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
@@ -451,9 +450,8 @@ static void __pci_restore_msix_state(struct pci_dev *dev)
 				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
 
 	arch_restore_msi_irqs(dev);
-	list_for_each_entry(entry, &dev->msi_list, list) {
+	list_for_each_entry(entry, &dev->msi_list, list)
 		msix_mask_irq(entry, entry->masked);
-	}
 
 	msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 }
@@ -497,9 +495,8 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
 	int count = 0;
 
 	/* Determine how many msi entries we have */
-	list_for_each_entry(entry, &pdev->msi_list, list) {
+	list_for_each_entry(entry, &pdev->msi_list, list)
 		++num_msi;
-	}
 	if (!num_msi)
 		return 0;
 
-- 
1.7.10.4

