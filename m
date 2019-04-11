Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628CFC282CE
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 12:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317812077C
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 12:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfDKMlg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:41:36 -0400
Received: from foss.arm.com ([217.140.101.70]:42000 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbfDKMlg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Apr 2019 08:41:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D07E015AD;
        Thu, 11 Apr 2019 05:41:35 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 52F503F557;
        Thu, 11 Apr 2019 05:41:34 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     bhelgaas@google.com
Cc:     Robin.Murphy@arm.com, robh+dt@kernel.org, Mark.Rutland@arm.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Grant.Likely@arm.com
Subject: [PATCH v3 2/2] PCI: OF: Support external-facing property
Date:   Thu, 11 Apr 2019 13:40:27 +0100
Message-Id: <20190411124027.9490-3-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411124027.9490-1-jean-philippe.brucker@arm.com>
References: <20190411124027.9490-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Set the "untrusted" attribute to any PCIe port that has an
"external-facing" device tree property. Any device downstream of this
port will inherit the attribute and have only the strictest IOMMU
protection.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
v2->v3:
* Use of_property_read_bool().
* Firmware can in theory set the property on the host bridge node.
  Handle this case.
* Don't pass a NULL node to the of driver. Although it is handled
  gracefully at the moment, it isn't documented and we might as well
  proof this too.
---
 drivers/pci/of.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3d32da15c215..67376cf45880 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -31,10 +31,16 @@ void pci_release_of_node(struct pci_dev *dev)
 
 void pci_set_bus_of_node(struct pci_bus *bus)
 {
-	if (bus->self == NULL)
-		bus->dev.of_node = pcibios_get_phb_of_node(bus);
-	else
-		bus->dev.of_node = of_node_get(bus->self->dev.of_node);
+	struct device_node *node;
+
+	if (bus->self == NULL) {
+		node = pcibios_get_phb_of_node(bus);
+	} else {
+		node = of_node_get(bus->self->dev.of_node);
+		if (node && of_property_read_bool(node, "external-facing"))
+			bus->self->untrusted = true;
+	}
+	bus->dev.of_node = node;
 }
 
 void pci_release_bus_of_node(struct pci_bus *bus)
-- 
2.21.0

