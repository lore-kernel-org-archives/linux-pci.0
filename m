Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Haiyang Zhang <haiyangz@exchange.microsoft.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com,
        driverdev-devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pci-hyperv: Use only 16 bit integer for PCI domain
Date: Thu, 20 Apr 2017 09:35:23 -0700
Message-Id: <1492706123-22913-1-git-send-email-haiyangz@exchange.microsoft.com>
Reply-To: haiyangz@microsoft.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Haiyang Zhang <haiyangz@microsoft.com>

This patch uses the lower 16 bits of the serial number as PCI
domain, otherwise some drivers may not be able to handle it.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index e73880c..b18dff3 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1334,9 +1334,11 @@ static void put_pcichild(struct hv_pci_dev *hpdev,
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
