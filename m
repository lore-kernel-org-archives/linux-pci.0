Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:57702 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbaJNGtB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Oct 2014 02:49:01 -0400
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 14 Oct 2014 16:48:58 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id D486A2BB0047
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2014 17:48:55 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id s9E6ONf962521486
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2014 17:24:23 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s9E6mt1P011015
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2014 17:48:55 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH 3/3] PCI: use u16 instead of int for pci express extended capabilities pos and cap
Date: Tue, 14 Oct 2014 14:47:32 +0800
Message-Id: <1413269253-8990-4-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1413269253-8990-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1413269253-8990-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For pci express devices, it could have extended capabilities. The position of
extened capabilities is 12bit and the cap is 16bit.

This patch does a clean up for pci express extended capabilities by replacing
type int with u16.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/iov.c   |    2 +-
 drivers/pci/pci.c   |   12 ++++++------
 drivers/pci/probe.c |    2 +-
 include/linux/pci.h |    6 +++---
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index cb6f247..fffab81 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -453,7 +453,7 @@ static void sriov_restore_state(struct pci_dev *dev)
  */
 int pci_iov_init(struct pci_dev *dev)
 {
-	int pos;
+	u16 pos;
 
 	if (!pci_is_pcie(dev))
 		return -ENODEV;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 47d8d0c..023af40 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -266,11 +266,11 @@ EXPORT_SYMBOL(pci_bus_find_capability);
  * not support it.  Some capabilities can occur several times, e.g., the
  * vendor-specific capability, and this provides a way to find them all.
  */
-int pci_find_next_ext_capability(struct pci_dev *dev, int start, int cap)
+u16 pci_find_next_ext_capability(struct pci_dev *dev, int start, u16 cap)
 {
 	u32 header;
 	int ttl;
-	int pos = PCI_CFG_SPACE_SIZE;
+	u16 pos = PCI_CFG_SPACE_SIZE;
 
 	/* minimum 8 bytes per capability */
 	ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
@@ -321,7 +321,7 @@ EXPORT_SYMBOL_GPL(pci_find_next_ext_capability);
  *  %PCI_EXT_CAP_ID_DSN		Device Serial Number
  *  %PCI_EXT_CAP_ID_PWR		Power Budgeting
  */
-int pci_find_ext_capability(struct pci_dev *dev, int cap)
+u16 pci_find_ext_capability(struct pci_dev *dev, u16 cap)
 {
 	return pci_find_next_ext_capability(dev, 0, cap);
 }
@@ -2119,7 +2119,7 @@ static void pci_add_saved_cap(struct pci_dev *pci_dev,
 static int _pci_add_cap_save_buffer(struct pci_dev *dev, u16 cap,
 				    bool extended, unsigned int size)
 {
-	int pos;
+	u16 pos;
 	struct pci_cap_saved_state *save_state;
 
 	if (extended)
@@ -2233,7 +2233,7 @@ void pci_request_acs(void)
  */
 static int pci_std_enable_acs(struct pci_dev *dev)
 {
-	int pos;
+	u16 pos;
 	u16 cap;
 	u16 ctrl;
 
@@ -2278,7 +2278,7 @@ void pci_enable_acs(struct pci_dev *dev)
 
 static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 {
-	int pos;
+	u16 pos;
 	u16 cap, ctrl;
 
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ACS);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9b316bf..86147ba 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1425,7 +1425,7 @@ EXPORT_SYMBOL(pci_scan_single_device);
 
 static unsigned next_fn(struct pci_bus *bus, struct pci_dev *dev, unsigned fn)
 {
-	int pos;
+	u16 pos;
 	u16 cap = 0;
 	unsigned next_fn;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 399a18a..b9a4f40 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -820,8 +820,8 @@ enum pci_lost_interrupt_reason {
 enum pci_lost_interrupt_reason pci_lost_interrupt(struct pci_dev *dev);
 u8 pci_find_capability(struct pci_dev *dev, u8 cap);
 u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, u8 cap);
-int pci_find_ext_capability(struct pci_dev *dev, int cap);
-int pci_find_next_ext_capability(struct pci_dev *dev, int pos, int cap);
+u16 pci_find_ext_capability(struct pci_dev *dev, u16 cap);
+u16 pci_find_next_ext_capability(struct pci_dev *dev, int pos, u16 cap);
 u8 pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
 u8 pci_find_next_ht_capability(struct pci_dev *dev, u8 pos, int ht_cap);
 struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
@@ -1365,7 +1365,7 @@ static inline u8 pci_find_capability(struct pci_dev *dev, u8 cap)
 static inline u8 pci_find_next_capability(struct pci_dev *dev, u8 post,
 					   u8 cap)
 { return 0; }
-static inline int pci_find_ext_capability(struct pci_dev *dev, int cap)
+static inline u16 pci_find_ext_capability(struct pci_dev *dev, u16 cap)
 { return 0; }
 
 /* Power management related routines */
-- 
1.7.9.5

