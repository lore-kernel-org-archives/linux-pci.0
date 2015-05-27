Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xspv0103.northgrum.com ([134.223.120.78]:57239 "EHLO
	xspv0103.northgrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbbE0VKD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2015 17:10:03 -0400
From: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>
Subject: [PATCH v0 01/13] PCI: Set bus's device name later
Date: Wed, 27 May 2015 20:58:43 +0000
Message-ID: <da3bdc7bcbff43f5a90172043866848d@XCGVAG27.northgrum.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI bus's device name is based upon its bus number. An upcoming
patch will allow the user to explicitly set a bus's number and
subordinate; thus its name will no longer be accurate. The solution is
to move when a bus's name is set to be a bit later within
pci_alloc_child_bus().

Furthermore, the name is currently based upon busnr. It is more accurate
to use child->number, even though at this time both values are the same.

Signed-off-by: Jason Tang <jason.tang2@ngc.com>
---
 drivers/pci/probe.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8d2f400..873030b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -684,7 +684,6 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 	 * now as the parent is not properly set up yet.
 	 */
 	child->dev.class = &pcibus_class;
-	dev_set_name(&child->dev, "%04x:%02x", pci_domain_nr(child), busnr);
 
 	/*
 	 * Set up the primary, secondary and subordinate
@@ -695,6 +694,8 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 	child->busn_res.end = 0xff;
 
 	if (!bridge) {
+		dev_set_name(&child->dev, "%04x:%02x", pci_domain_nr(child),
+			     child->number);
 		child->dev.parent = parent->bridge;
 		goto add_dev;
 	}
@@ -702,6 +703,10 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 	child->self = bridge;
 	child->bridge = get_device(&bridge->dev);
 	child->dev.parent = child->bridge;
+
+	dev_set_name(&child->dev, "%04x:%02x", pci_domain_nr(child),
+		     child->number);
+
 	pci_set_bus_of_node(child);
 	pci_set_bus_speed(child);
 
-- 
1.7.9.5

