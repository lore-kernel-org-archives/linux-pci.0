Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2983 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732327AbeHCLrM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Aug 2018 07:47:12 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] PCI/ASPM: Convert to use sysfs_match_string() helper
Date: Fri,  3 Aug 2018 12:51:37 +0300
Message-Id: <20180803095137.52401-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The commit

  4cec16861a40 ("PCI/ASPM: Convert to use match_string() helper")

didn't take into consideration small but crucial detail about scope of
usage, i.e. sysfs interface provided to handle the ASPM policy. Due to
this in most of the cases input string comes with a new line symbol.

Use sysfs_match_string() helper to take into account above.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
Fixes: 4cec16861a40 ("PCI/ASPM: Convert to use match_string() helper")
---
 drivers/pci/pcie/aspm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 0e88b3ad065f..5326916715d2 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1127,7 +1127,7 @@ static int pcie_aspm_set_policy(const char *val,
 
 	if (aspm_disabled)
 		return -EPERM;
-	i = match_string(policy_str, ARRAY_SIZE(policy_str), val);
+	i = sysfs_match_string(policy_str, val);
 	if (i < 0)
 		return i;
 	if (i == aspm_policy)
-- 
2.18.0
