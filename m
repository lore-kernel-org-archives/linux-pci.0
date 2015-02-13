Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:52854 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbbBME4E (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Feb 2015 23:56:04 -0500
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Fri, 13 Feb 2015 14:56:01 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id DEFA72CE8055
	for <linux-pci@vger.kernel.org>; Fri, 13 Feb 2015 15:55:58 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t1D4toHB36700216
	for <linux-pci@vger.kernel.org>; Fri, 13 Feb 2015 15:55:58 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t1D4tPT9020929
	for <linux-pci@vger.kernel.org>; Fri, 13 Feb 2015 15:55:25 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	cascardo@linux.vnet.ibm.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 1/4] PCI: Rename struct pci_dev_reset_methods
Date: Fri, 13 Feb 2015 15:54:56 +1100
Message-Id: <1423803299-22356-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1423803299-22356-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1423803299-22356-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It'd better to have "struct pci_dev_reset_method" as its name.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/pci.h    | 2 +-
 drivers/pci/quirks.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4091f82..e67b22f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -306,7 +306,7 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 
 void pci_enable_acs(struct pci_dev *dev);
 
-struct pci_dev_reset_methods {
+struct pci_dev_reset_method {
 	u16 vendor;
 	u16 device;
 	int (*reset)(struct pci_dev *dev, int probe);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 85f247e..512bbbb 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3508,7 +3508,7 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, int probe)
 #define PCI_DEVICE_ID_INTEL_IVB_M_VGA      0x0156
 #define PCI_DEVICE_ID_INTEL_IVB_M2_VGA     0x0166
 
-static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
+static const struct pci_dev_reset_method pci_dev_reset_methods[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
 		 reset_intel_82599_sfp_virtfn },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M_VGA,
@@ -3529,7 +3529,7 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
  */
 int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 {
-	const struct pci_dev_reset_methods *i;
+	const struct pci_dev_reset_method *i;
 
 	for (i = pci_dev_reset_methods; i->reset; i++) {
 		if ((i->vendor == dev->vendor ||
-- 
1.8.3.2

