Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f202.google.com ([209.85.214.202]:34062 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297Ab2HQXf4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 19:35:56 -0400
Received: by mail-ob0-f202.google.com with SMTP id wc20so3010724obb.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Aug 2012 16:35:56 -0700 (PDT)
Subject: [PATCH v2 02/16] PCI: acpiphp: Use common
	pci_stop_and_remove_bus_device()
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pcmcia@lists.infradead.org, Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date: Fri, 17 Aug 2012 17:35:55 -0600
Message-ID: <20120817233555.10973.75372.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
References: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use pci_stop_and_remove_bus_device() like most other hotplug drivers
rather than stopping and removing separately.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index c25291c..b5d798e 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -920,8 +920,7 @@ static int disable_device(struct acpiphp_slot *slot)
 	 * here.
 	 */
 	while ((pdev = dev_in_slot(slot))) {
-		pci_stop_bus_device(pdev);
-		__pci_remove_bus_device(pdev);
+		pci_stop_and_remove_bus_device(pdev);
 		pci_dev_put(pdev);
 	}
 

