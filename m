Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33133 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751523AbbIJJdh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 10 Sep 2015 05:33:37 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>, lorenzo.pieralisi@arm.com
Subject: [PATCH] PCI: Fix pci_claim_bridge_resource() resource claiming
Date: Thu, 10 Sep 2015 10:33:48 +0100
Message-Id: <1441877628-28879-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 8505e729a2f6eb ("PCI: Add pci_claim_bridge_resource() to clip
window if necessary") introduced a new API to claim bridge resources.
pci_claim_bridge_resource() tries to claim a bridge resource, and if
the claiming fails the function tries to clip the resource to make
it fit within the parent resource window.
If the clipping succeeds the bridge aperture is set-up accordingly
and pci_claim_bridge_resource() tries to claim the resource again.

Commit c770cb4cb505 ("PCI: Mark invalid BARs as unassigned") added
code that sets the IORESOURCE_UNSET flag on claiming failure.

This means that the second resource claiming after window clipping will
always fail, since the resource flags contain IORESOURCE_UNSET,
previously set on failure by pci_claim_resource(), so the subsequent
pci_claim_resource() call ends up spitting a log message and return
failure with no chance whatsoever to succeed.

This patch clears the IORESOURCE_UNSET in the bridge resource flags
after clipping the bridge window successfully, so that the subsequent
pci_claim_resource() has a chance to succeed.

Fixes: c770cb4cb505 ("PCI: Mark invalid BARs as unassigned")
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: <stable@vger.kernel.org> # 4.1+
---
 drivers/pci/setup-bus.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 508cc56..6de55d0 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -733,6 +733,13 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
 		return -EINVAL;
 	}
 
+	/*
+	 * Clear the IORESOURCE_UNSET flag set by the previous
+	 * pci_claim_resource() failure so that the resource
+	 * claiming can actually be carried out
+	 */
+	bridge->resource[i].flags &= ~IORESOURCE_UNSET;
+
 	if (pci_claim_resource(bridge, i) == 0)
 		return 0;	/* claimed a smaller window */
 
-- 
2.2.1

