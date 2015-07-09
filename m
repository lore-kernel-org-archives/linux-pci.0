Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:30996 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751884AbbGIH7s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 9 Jul 2015 03:59:48 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Grant Likely <grant.likely@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Stuart Yoder <stuart.yoder@freescale.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Borislav Petkov <bp@alien8.de>,
	Sebastian Ott <sebott@linux.vnet.ibm.com>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org
Subject: [RFC Patch V1 04/12] s390/pci: Use for_pci_msi_entry() to access MSI device list
Date: Thu,  9 Jul 2015 16:00:39 +0800
Message-Id: <1436428847-8886-5-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use accessor for_pci_msi_entry() to access MSI device list, so we could
easily move msi_list from struct pci_dev into struct device later.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/s390/pci/pci.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 598f023cf8a6..34f162753403 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -414,7 +414,7 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 
 	/* Request MSI interrupts */
 	hwirq = 0;
-	list_for_each_entry(msi, &pdev->msi_list, list) {
+	for_each_pci_msi_entry(msi, pdev) {
 		rc = -EIO;
 		irq = irq_alloc_desc(0);	/* Alloc irq on node 0 */
 		if (irq < 0)
@@ -440,7 +440,7 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	return (msi_vecs == nvec) ? 0 : msi_vecs;
 
 out_msi:
-	list_for_each_entry(msi, &pdev->msi_list, list) {
+	for_each_pci_msi_entry(msi, pdev) {
 		if (hwirq-- == 0)
 			break;
 		irq_set_msi_desc(msi->irq, NULL);
@@ -470,7 +470,7 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
 		return;
 
 	/* Release MSI interrupts */
-	list_for_each_entry(msi, &pdev->msi_list, list) {
+	for_each_pci_msi_entry(msi, pdev) {
 		if (msi->msi_attrib.is_msix)
 			__pci_msix_desc_mask_irq(msi, 1);
 		else
-- 
1.7.10.4

