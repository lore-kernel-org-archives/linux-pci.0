Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:35071 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933721AbeE2Ncv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 May 2018 09:32:51 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] PCI/ASPM: Convert to use match_string() helper
Date: Tue, 29 May 2018 16:32:47 +0300
Message-Id: <20180529133247.19728-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The new helper returns index of the matching string in an array.
We are going to use it here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/pcie/aspm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index c687c817b47d..0e88b3ad065f 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1127,11 +1127,9 @@ static int pcie_aspm_set_policy(const char *val,
 
 	if (aspm_disabled)
 		return -EPERM;
-	for (i = 0; i < ARRAY_SIZE(policy_str); i++)
-		if (!strncmp(val, policy_str[i], strlen(policy_str[i])))
-			break;
-	if (i >= ARRAY_SIZE(policy_str))
-		return -EINVAL;
+	i = match_string(policy_str, ARRAY_SIZE(policy_str), val);
+	if (i < 0)
+		return i;
 	if (i == aspm_policy)
 		return 0;
 
-- 
2.17.0
