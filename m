Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:38152 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755704Ab2BXHr1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2012 02:47:27 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 05/11] PCI: Use class for quirk for host bridge mmio_always_on
Date: Thu, 23 Feb 2012 23:46:53 -0800
Message-Id: <1330069619-14446-6-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330069619-14446-1-git-send-email-yinghai@kernel.org>
References: <1330069619-14446-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/quirks.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 2b4b1ea..007abec 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -102,10 +102,10 @@ DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, quirk_resource_alignment);
  */
 static void __devinit quirk_mmio_always_on(struct pci_dev *dev)
 {
-	if ((dev->class >> 8) == PCI_CLASS_BRIDGE_HOST)
-		dev->mmio_always_on = 1;
+	dev->mmio_always_on = 1;
 }
-DECLARE_PCI_FIXUP_EARLY(PCI_ANY_ID, PCI_ANY_ID, quirk_mmio_always_on);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_ANY_ID, PCI_ANY_ID,
+				PCI_CLASS_BRIDGE_HOST, 8, quirk_mmio_always_on);
 
 /* The Mellanox Tavor device gives false positive parity errors
  * Mark this device with a broken_parity_status, to allow
-- 
1.7.7

