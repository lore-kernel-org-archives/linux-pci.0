Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4]:56738 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbbF3BQz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jun 2015 21:16:55 -0400
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 30 Jun 2015 06:46:53 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id 34B12E004C
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2015 06:50:31 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5U1GnWW60424378
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2015 06:46:49 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5U1GnEv011179
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2015 06:46:49 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V2 1/4] PCI: move PCI_FIND_CAP_TTL to pci.h and use it in quirks
Date: Tue, 30 Jun 2015 09:16:41 +0800
Message-Id: <1435627004-6029-2-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1435627004-6029-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1435627004-6029-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In some quirks, it tries to search a pci cap and use a ttl value to avoid
infinite loop. While the value is hard coded to 48, which is the same as
macro PCI_FIND_CAP_TTL.

This patch moves the definition of PCI_FIND_CAP_TTL to pci.h and replace
the hard coded value with it.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>

---
v1 -> v2:
   define PCI_FIND_CAP_TTL in drivers/pci/pci.h instead of include/linux/pci.h
---
 drivers/pci/pci.c    |    1 -
 drivers/pci/pci.h    |    2 ++
 drivers/pci/quirks.c |    8 ++++----
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index acc4b6e..24ebb1b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -140,7 +140,6 @@ void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar)
 EXPORT_SYMBOL_GPL(pci_ioremap_bar);
 #endif
 
-#define PCI_FIND_CAP_TTL	48
 
 static int __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
 				   u8 pos, int cap, int *ttl)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9bd762c2..1b0d20e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -4,6 +4,8 @@
 #define PCI_CFG_SPACE_SIZE	256
 #define PCI_CFG_SPACE_EXP_SIZE	4096
 
+#define PCI_FIND_CAP_TTL	48
+
 extern const unsigned char pcie_link_speed[];
 
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index c6dc1df..ad3b62c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2250,7 +2250,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x9601, quirk_amd_780_apc_msi);
  * return 1 if a HT MSI capability is found and enabled */
 static int msi_ht_cap_enabled(struct pci_dev *dev)
 {
-	int pos, ttl = 48;
+	int pos, ttl = PCI_FIND_CAP_TTL;
 
 	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
 	while (pos && ttl--) {
@@ -2309,7 +2309,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_CK804_PCIE,
 /* Force enable MSI mapping capability on HT bridges */
 static void ht_enable_msi_mapping(struct pci_dev *dev)
 {
-	int pos, ttl = 48;
+	int pos, ttl = PCI_FIND_CAP_TTL;
 
 	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
 	while (pos && ttl--) {
@@ -2388,7 +2388,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
 
 static int ht_check_msi_mapping(struct pci_dev *dev)
 {
-	int pos, ttl = 48;
+	int pos, ttl = PCI_FIND_CAP_TTL;
 	int found = 0;
 
 	/* check if there is HT MSI cap or enabled on this device */
@@ -2513,7 +2513,7 @@ out:
 
 static void ht_disable_msi_mapping(struct pci_dev *dev)
 {
-	int pos, ttl = 48;
+	int pos, ttl = PCI_FIND_CAP_TTL;
 
 	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
 	while (pos && ttl--) {
-- 
1.7.9.5

