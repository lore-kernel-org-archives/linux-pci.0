Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755119AbcKUVqV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Nov 2016 16:46:21 -0500
Subject: [PATCH v2 9/9] PCI: Expand "VPD access disabled" quirk message
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Date: Mon, 21 Nov 2016 15:46:17 -0600
Message-ID: <20161121214617.21036.65418.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161121214006.21036.11599.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161121214006.21036.11599.stgit@bhelgaas-glaptop.roam.corp.google.com>
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
 

