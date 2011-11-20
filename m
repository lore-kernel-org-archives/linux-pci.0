Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 20 Nov 2011 15:29:46 -0600
From: David Fries <david@fries.net>
To: linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org
Subject: [PATH] pci_has_legacy_pm_support add driver and device to WARN
Message-ID: <20111120212945.GA1781@spacedout.fries.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Fries <David@Fries.net>

Include the driver name and device in warning when a pci driver
supports both legacy pm and new framework as just the stack trace
gives no way to identify the driver.

Signed-off-by: David Fries <David@Fries.net>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/pci-driver.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 12d1e81..3623d65 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -604,7 +604,8 @@ static bool pci_has_legacy_pm_support(struct pci_dev *pci_dev)
 	 * supported as well.  Drivers are supposed to support either the
 	 * former, or the latter, but not both at the same time.
 	 */
-	WARN_ON(ret && drv->driver.pm);
+	WARN(ret && drv->driver.pm, "driver %s device %04x:%04x\n",
+		drv->name, pci_dev->vendor, pci_dev->device);
 
 	return ret;
 }
-- 
1.7.7.1

