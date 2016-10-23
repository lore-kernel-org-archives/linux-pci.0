Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34111 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756102AbcJWQcS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Oct 2016 12:32:18 -0400
Received: by mail-pf0-f180.google.com with SMTP id r16so84043424pfg.1
        for <linux-pci@vger.kernel.org>; Sun, 23 Oct 2016 09:32:18 -0700 (PDT)
Date: Sun, 23 Oct 2016 09:32:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: bhelgaas@google.com, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH] doc: add missing parameter for msi_setup
Message-ID: <20161023093234.41f2d1fb@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Stephen Hemminger <sthemmin@microsoft.com>

commit 92ca8d20dee2 ("genirq/msi: Switch to new irq spreading")
introduced new parameter to msi_init_setup and but did not update
docbook comments. Fixes 'make htmldocs' warning.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
---
 drivers/pci/msi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index bfdd074..ad70507 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -610,6 +610,7 @@ static int msi_verify_entries(struct pci_dev *dev)
  * msi_capability_init - configure device's MSI capability structure
  * @dev: pointer to the pci_dev data structure of MSI device function
  * @nvec: number of interrupts to allocate
+ * @affinity: flag to indicate cpu irq affinity mask should be set
  *
  * Setup the MSI capability structure of the device with the requested
  * number of interrupts.  A return value of zero indicates the successful
@@ -752,6 +753,7 @@ static void msix_program_entries(struct pci_dev *dev,
  * @dev: pointer to the pci_dev data structure of MSI-X device function
  * @entries: pointer to an array of struct msix_entry entries
  * @nvec: number of @entries
+ * @affinity: flag to indicate cpu irq affinity mask should be set
  *
  * Setup the MSI-X capability structure of device function with a
  * single MSI-X irq. A return of zero indicates the successful setup of
-- 
2.9.3

