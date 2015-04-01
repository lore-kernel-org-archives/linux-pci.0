Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:36080 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081AbbDACip (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 31 Mar 2015 22:38:45 -0400
Date: Tue, 31 Mar 2015 19:38:38 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH] quirks: fix typo in kernel message
Message-ID: <20150401023838.GA25795@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fix a typo in one of the kernel messages.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 drivers/pci/quirks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 85f247e..4c0260c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3182,7 +3182,7 @@ static void quirk_apple_wait_for_thunderbolt(struct pci_dev *dev)
 			|| nhi->subsystem_vendor != 0x2222
 			|| nhi->subsystem_device != 0x1111)
 		goto out;
-	dev_info(&dev->dev, "quirk: wating for thunderbolt to reestablish pci tunnels...\n");
+	dev_info(&dev->dev, "quirk: waiting for thunderbolt to reestablish pci tunnels...\n");
 	device_pm_wait_for_dev(&dev->dev, &nhi->dev);
 out:
 	pci_dev_put(nhi);
