Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f202.google.com ([74.125.82.202]:65276 "EHLO
	mail-we0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932527Ab2HPX0m (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Aug 2012 19:26:42 -0400
Received: by mail-we0-f202.google.com with SMTP id r1so155204wey.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Aug 2012 16:26:41 -0700 (PDT)
Subject: [PATCH 5/6] sgi-agp: Use list_for_each_entry() for bus->devices
	traversal
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Airlie <airlied@linux.ie>
Date: Thu, 16 Aug 2012 17:26:41 -0600
Message-ID: <20120816232641.3662.52757.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120816232620.3662.90438.stgit@bhelgaas.mtv.corp.google.com>
References: <20120816232620.3662.90438.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace list_for_each() + pci_dev_b() with the simpler
list_for_each_entry().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: David Airlie <airlied@linux.ie>
---
 drivers/char/agp/sgi-agp.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/char/agp/sgi-agp.c b/drivers/char/agp/sgi-agp.c
index 1920003..3a5af2f 100644
--- a/drivers/char/agp/sgi-agp.c
+++ b/drivers/char/agp/sgi-agp.c
@@ -289,12 +289,11 @@ static int __devinit agp_sgi_init(void)
 
 	j = 0;
 	list_for_each_entry(info, &tioca_list, ca_list) {
-		struct list_head *tmp;
 		if (list_empty(info->ca_devices))
 			continue;
-		list_for_each(tmp, info->ca_devices) {
+		list_for_each_entry(pdev, info->ca_devices, bus_list) {
 			u8 cap_ptr;
-			pdev = pci_dev_b(tmp);
+
 			if (pdev->class != (PCI_CLASS_DISPLAY_VGA << 8))
 				continue;
 			cap_ptr = pci_find_capability(pdev, PCI_CAP_ID_AGP);

