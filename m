Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:46348
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1031752AbdEXUkY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 May 2017 16:40:24 -0400
From: Haiyang Zhang <haiyangz@exchange.microsoft.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com,
        driverdev-devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pci-hyperv: Use only 16 bit integer for PCI domain
Date: Wed, 24 May 2017 13:39:15 -0700
Message-Id: <1495658355-13103-1-git-send-email-haiyangz@exchange.microsoft.com>
Reply-To: haiyangz@microsoft.com
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Haiyang Zhang <haiyangz@microsoft.com>

This patch uses the lower 16 bits of the serial number as PCI
domain, otherwise some drivers may not be able to handle it.

Besides Nvidia drivers, we also found X.org, and DPDK handle
only 16 bit PCI domain.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 8493638..51a815d 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1335,9 +1335,11 @@ static void put_pcichild(struct hv_pci_dev *hpdev,
 	 * can have shorter names than based on the bus instance UUID.
 	 * Only the first device serial number is used for domain, so the
 	 * domain number will not change after the first device is added.
+	 * The lower 16 bits of the serial number is used, otherwise some
+	 * drivers may not be able to handle it.
 	 */
 	if (list_empty(&hbus->children))
-		hbus->sysdata.domain = desc->ser;
+		hbus->sysdata.domain = desc->ser & 0xFFFF;
 	list_add_tail(&hpdev->list_entry, &hbus->children);
 	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
 	return hpdev;
-- 
1.7.1
