Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:30996 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939AbbGIH7v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 9 Jul 2015 03:59:51 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Grant Likely <grant.likely@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Stuart Yoder <stuart.yoder@freescale.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Borislav Petkov <bp@alien8.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	xen-devel@lists.xenproject.org
Subject: [RFC Patch V1 05/12] x86, PCI: Use for_pci_msi_entry() to access MSI device list
Date: Thu,  9 Jul 2015 16:00:40 +0800
Message-Id: <1436428847-8886-6-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use accessor for_pci_msi_entry() to access MSI device list, so we could
easily move msi_list from struct pci_dev into struct device later.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/pci/xen.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index d22f4b5bbc04..ff31ab464213 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -179,7 +179,7 @@ static int xen_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	if (ret)
 		goto error;
 	i = 0;
-	list_for_each_entry(msidesc, &dev->msi_list, list) {
+	for_each_pci_msi_entry(msidesc, dev) {
 		irq = xen_bind_pirq_msi_to_irq(dev, msidesc, v[i],
 					       (type == PCI_CAP_ID_MSI) ? nvec : 1,
 					       (type == PCI_CAP_ID_MSIX) ?
@@ -230,7 +230,7 @@ static int xen_hvm_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	if (type == PCI_CAP_ID_MSI && nvec > 1)
 		return 1;
 
-	list_for_each_entry(msidesc, &dev->msi_list, list) {
+	for_each_pci_msi_entry(msidesc, dev) {
 		__pci_read_msi_msg(msidesc, &msg);
 		pirq = MSI_ADDR_EXT_DEST_ID(msg.address_hi) |
 			((msg.address_lo >> MSI_ADDR_DEST_ID_SHIFT) & 0xff);
@@ -274,7 +274,7 @@ static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	int ret = 0;
 	struct msi_desc *msidesc;
 
-	list_for_each_entry(msidesc, &dev->msi_list, list) {
+	for_each_pci_msi_entry(msidesc, dev) {
 		struct physdev_map_pirq map_irq;
 		domid_t domid;
 
@@ -386,7 +386,7 @@ static void xen_teardown_msi_irqs(struct pci_dev *dev)
 {
 	struct msi_desc *msidesc;
 
-	msidesc = list_entry(dev->msi_list.next, struct msi_desc, list);
+	msidesc = first_pci_msi_entry(dev);
 	if (msidesc->msi_attrib.is_msix)
 		xen_pci_frontend_disable_msix(dev);
 	else
-- 
1.7.10.4

