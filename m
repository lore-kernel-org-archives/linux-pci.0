Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:13227 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932500AbeBVM72 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Feb 2018 07:59:28 -0500
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/4] pci: Re-use new dmi_get_bios_year() helper
Date: Thu, 22 Feb 2018 14:59:23 +0200
Message-Id: <20180222125923.57385-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20180222125923.57385-1-andriy.shevchenko@linux.intel.com>
References: <20180222125923.57385-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

...instead of open coding its functionality.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f6a4dd10d9b0..ae654e21439d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2258,8 +2258,6 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
  */
 bool pci_bridge_d3_possible(struct pci_dev *bridge)
 {
-	unsigned int year;
-
 	if (!pci_is_pcie(bridge))
 		return false;
 
@@ -2287,10 +2285,8 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 		 * It should be safe to put PCIe ports from 2015 or newer
 		 * to D3.
 		 */
-		if (dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) &&
-		    year >= 2015) {
+		if (dmi_get_bios_year() >= 2015)
 			return true;
-		}
 		break;
 	}
 
-- 
2.16.1
