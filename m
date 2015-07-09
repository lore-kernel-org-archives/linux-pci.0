Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Grant Likely <grant.likely@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Stuart Yoder <stuart.yoder@freescale.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Borislav Petkov <bp@alien8.de>,
	Ralf Baechle <ralf@linux-mips.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@linux-mips.org
Subject: [RFC Patch V1 02/12] MIPS, PCI: Use for_pci_msi_entry() to access MSI device list
Date: Thu,  9 Jul 2015 16:00:37 +0800
Message-Id: <1436428847-8886-3-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use accessor for_pci_msi_entry() to access MSI device list, so we could
easily move msi_list from struct pci_dev into struct device later.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/mips/pci/msi-octeon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/pci/msi-octeon.c b/arch/mips/pci/msi-octeon.c
index cffaaf4aae3c..2a5bb849b10e 100644
--- a/arch/mips/pci/msi-octeon.c
+++ b/arch/mips/pci/msi-octeon.c
@@ -200,7 +200,7 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	if (type == PCI_CAP_ID_MSI && nvec > 1)
 		return 1;
 
-	list_for_each_entry(entry, &dev->msi_list, list) {
+	for_each_pci_msi_entry(entry, dev) {
 		ret = arch_setup_msi_irq(dev, entry);
 		if (ret < 0)
 			return ret;
-- 
1.7.10.4

