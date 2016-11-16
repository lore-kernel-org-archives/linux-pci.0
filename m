Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753891AbcKPWNf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Nov 2016 17:13:35 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 90579203E1
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2016 22:13:34 +0000 (UTC)
Received: from localhost (unknown [69.71.4.155])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 840E9203C4
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2016 22:13:33 +0000 (UTC)
Subject: [PATCH 4/4] PCI: Expand "VPD access disabled" quirk message
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Date: Wed, 16 Nov 2016 16:13:32 -0600
Message-ID: <20161116221332.15842.39092.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161116221122.15842.77692.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161116221122.15842.77692.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It's not very enlightening to see

  pci 0000:07:00.0: [Firmware Bug]: VPD access disabled

in the dmesg log because there's no clue about what the firmware bug is.
Expand the message to explain why we're disabling VPD.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/quirks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index c232729..7329796 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2156,7 +2156,7 @@ static void quirk_blacklist_vpd(struct pci_dev *dev)
 {
 	if (dev->vpd) {
 		dev->vpd->len = 0;
-		dev_warn(&dev->dev, FW_BUG "VPD access disabled\n");
+		dev_warn(&dev->dev, FW_BUG "disabling VPD access (can't determine size of non-standard VPD format)\n");
 	}
 }
 

