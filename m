Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15630 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754899AbcFGRsi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 7 Jun 2016 13:48:38 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] PCI / PM: enforce type casting for pci_power_t
Date: Tue,  7 Jun 2016 20:48:33 +0300
Message-Id: <1465321713-146178-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When cast pci_power_t type of variables a static analizer tool complains on
that.

	include/linux/pci.h:119:37: warning: cast from restricted pci_power_t

Enforce type casting to make static analizer happy.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index b67e4df..8d74834 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -116,7 +116,7 @@ extern const char *pci_power_names[];
 
 static inline const char *pci_power_name(pci_power_t state)
 {
-	return pci_power_names[1 + (int) state];
+	return pci_power_names[1 + (__force int) state];
 }
 
 #define PCI_PM_D2_DELAY		200
-- 
2.8.1

