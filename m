Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:57906 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925AbcFFOZr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 6 Jun 2016 10:25:47 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] PCI / PM: check all fields in pci_set_platform_pm()
Date: Mon,  6 Jun 2016 17:25:33 +0300
Message-Id: <1465223133-73532-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When assign new PCI platform PM operations check for all mandatory fields to
prevent NULL pointer dereference.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c8b4dbd..badbddc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -530,8 +530,8 @@ static const struct pci_platform_pm_ops *pci_platform_pm;
 
 int pci_set_platform_pm(const struct pci_platform_pm_ops *ops)
 {
-	if (!ops->is_manageable || !ops->set_state || !ops->choose_state
-	    || !ops->sleep_wake)
+	if (!ops->is_manageable || !ops->set_state || !ops->choose_state ||
+	    !ops->sleep_wake || !ops->run_wake || !ops->need_resume)
 		return -EINVAL;
 	pci_platform_pm = ops;
 	return 0;
-- 
2.8.1

