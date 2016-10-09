Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:42235 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750801AbcJILM7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Oct 2016 07:12:59 -0400
Message-Id: <c2b767a782f9a0e1780e5c201d245d1be5b7d78a.1476011255.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 9 Oct 2016 13:12:55 +0200
Subject: [PATCH] x86/platform/intel-mid: Constify mid_pci_platform_pm
To: linux-pci@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

-.data          56
+.data           0
-.rodata        32
+.rodata        88

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci-mid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-mid.c b/drivers/pci/pci-mid.c
index a8b52dc..566ded1 100644
--- a/drivers/pci/pci-mid.c
+++ b/drivers/pci/pci-mid.c
@@ -54,7 +54,7 @@ static bool mid_pci_need_resume(struct pci_dev *dev)
 	return false;
 }
 
-static struct pci_platform_pm_ops mid_pci_platform_pm = {
+static const struct pci_platform_pm_ops mid_pci_platform_pm = {
 	.is_manageable	= mid_pci_power_manageable,
 	.set_state	= mid_pci_set_power_state,
 	.get_state	= mid_pci_get_power_state,
-- 
2.9.3

