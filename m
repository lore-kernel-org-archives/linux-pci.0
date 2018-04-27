Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27474 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932589AbeD0Ko0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Apr 2018 06:44:26 -0400
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Add ACS quirk for Intel 300 series chipset
Date: Fri, 27 Apr 2018 13:44:23 +0300
Message-Id: <20180427104423.2203-1-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Intel 300 series chipset still has the same ACS issue than the previous
generations so extend the ACS quirk to cover it as well.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 2990ad1e7c99..7a0f41176369 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4230,6 +4230,11 @@ static int pci_quirk_qcom_rp_acs(struct pci_dev *dev, u16 acs_flags)
  * 0xa290-0xa29f PCI Express Root port #{0-16}
  * 0xa2e7-0xa2ee PCI Express Root port #{17-24}
  *
+ * The 300 series chipset suffers from the same bug so include those root
+ * ports here as well.
+ *
+ * 0xa32c-0xa343 PCI Express Root port #{0-24}
+ *
  * [1] http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-datasheet-vol-2.html
  * [2] http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-datasheet-vol-1.html
  * [3] http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-spec-update.html
@@ -4244,6 +4249,7 @@ static bool pci_quirk_intel_spt_pch_acs_match(struct pci_dev *dev)
 	switch (dev->device) {
 	case 0xa110 ... 0xa11f: case 0xa167 ... 0xa16a: /* Sunrise Point */
 	case 0xa290 ... 0xa29f: case 0xa2e7 ... 0xa2ee: /* Union Point */
+	case 0xa32c ... 0xa343:				/* 300 series */
 		return true;
 	}
 
-- 
2.17.0
