Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:44168 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165AbaBZTiF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Feb 2014 14:38:05 -0500
Received: by mail-ie0-f179.google.com with SMTP id to1so1119236ieb.38
        for <linux-pci@vger.kernel.org>; Wed, 26 Feb 2014 11:38:05 -0800 (PST)
Subject: [PATCH 9/9] PCI: Don't enable decoding if BAR hasn't been assigned
 an address
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org
Date: Wed, 26 Feb 2014 12:38:03 -0700
Message-ID: <20140226193803.10125.95129.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140226192614.10125.68711.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140226192614.10125.68711.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Don't enable memory or I/O decoding if we haven't assigned or claimed the
BAR's resource.

If we enable decoding for a BAR that hasn't been assigned an address, we'll
likely cause bus conflicts.  This declines to enable decoding for resources
with IORESOURCE_UNSET.

Note that drivers can use pci_enable_device_io() or pci_enable_device_mem()
if they only care about specific types of BARs.  In that case, we don't
bother checking whether the corresponding resources are assigned or
claimed.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/setup-res.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 6e443135ba24..7eed671d5586 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -343,9 +343,15 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
 				(!(r->flags & IORESOURCE_ROM_ENABLE)))
 			continue;
 
+		if (r->flags & IORESOURCE_UNSET) {
+			dev_err(&dev->dev, "can't enable device: BAR %d %pR not assigned\n",
+				i, r);
+			return -EINVAL;
+		}
+
 		if (!r->parent) {
-			dev_err(&dev->dev, "device not available "
-				"(can't reserve %pR)\n", r);
+			dev_err(&dev->dev, "can't enable device: BAR %d %pR not claimed\n",
+				i, r);
 			return -EINVAL;
 		}
 

