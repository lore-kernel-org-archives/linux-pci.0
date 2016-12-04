Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:56007 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbcLDOf6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Dec 2016 09:35:58 -0500
Message-Id: <ba07572b4c4fad1f60593454693a58137f518896.1480859081.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 4 Dec 2016 15:35:55 +0100
Subject: [PATCH] x86/platform/intel-mid: Constify mid_pci_platform_pm
To: x86@kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This struct never needs to be modified.  The size of pci-mid.o ELF
sections changes thusly:

-.data          56
+.data           0
-.rodata        32
+.rodata        88

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---

Link to Andy's ack:
https://www.spinics.net/lists/linux-pci/msg54977.html

Link to Bjorn's ack:
https://www.spinics.net/lists/linux-pci/msg56476.html

 drivers/pci/pci-mid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-mid.c b/drivers/pci/pci-mid.c
index c7f3408..1c4af72 100644
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
2.10.2

