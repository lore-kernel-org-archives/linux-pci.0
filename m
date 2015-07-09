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
	"David S. Miller" <davem@davemloft.net>,
	Eric Snowberg <eric.snowberg@oracle.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	sparclinux@vger.kernel.org
Subject: [RFC Patch V1 07/12] sparc, PCI: Use helper functions to access fields in struct msi_desc
Date: Thu,  9 Jul 2015 16:00:42 +0800
Message-Id: <1436428847-8886-8-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use helper functions to access fields in struct msi_desc, so we could
easily refine struct msi_desc later.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/sparc/kernel/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index c928bc64b4ba..048b406d9e02 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -918,7 +918,7 @@ int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
 void arch_teardown_msi_irq(unsigned int irq)
 {
 	struct msi_desc *entry = irq_get_msi_desc(irq);
-	struct pci_dev *pdev = entry->dev;
+	struct pci_dev *pdev = msi_desc_to_pci_dev(entry);
 	struct pci_pbm_info *pbm = pdev->dev.archdata.host_controller;
 
 	if (pbm->teardown_msi_irq)
-- 
1.7.10.4

