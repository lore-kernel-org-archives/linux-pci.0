Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B334C43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 16:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BFE223CB
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 16:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64BFE223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388452AbeKPDGz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:06:55 -0500
Received: from foss.arm.com ([217.140.101.70]:38070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbeKPDGy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 22:06:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6931080D;
        Thu, 15 Nov 2018 08:58:18 -0800 (PST)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0BBB13F718;
        Thu, 15 Nov 2018 08:58:14 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, joro@8bytes.org, mst@redhat.com
Cc:     frowand.list@gmail.com, jasowang@redhat.com, robh+dt@kernel.org,
        mark.rutland@arm.com, bhelgaas@google.com,
        kvmarm@lists.cs.columbia.edu, eric.auger@redhat.com,
        tnowicki@caviumnetworks.com, kevin.tian@intel.com,
        marc.zyngier@arm.com, robin.murphy@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, bharat.bhushan@nxp.com
Subject: [PATCH v4 4/7] PCI: OF: Initialize dev->fwnode appropriately
Date:   Thu, 15 Nov 2018 16:52:31 +0000
Message-Id: <20181115165234.43990-5-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115165234.43990-1-jean-philippe.brucker@arm.com>
References: <20181115165234.43990-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For PCI devices that have an OF node, set the fwnode as well. This way
drivers that rely on fwnode don't need the special case described by
commit f94277af03ea ("of/platform: Initialise dev->fwnode appropriately").

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/pci/of.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 4c4217d0c3f1..c272ecfcd038 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -21,12 +21,15 @@ void pci_set_of_node(struct pci_dev *dev)
 		return;
 	dev->dev.of_node = of_pci_find_child_device(dev->bus->dev.of_node,
 						    dev->devfn);
+	if (dev->dev.of_node)
+		dev->dev.fwnode = &dev->dev.of_node->fwnode;
 }
 
 void pci_release_of_node(struct pci_dev *dev)
 {
 	of_node_put(dev->dev.of_node);
 	dev->dev.of_node = NULL;
+	dev->dev.fwnode = NULL;
 }
 
 void pci_set_bus_of_node(struct pci_bus *bus)
@@ -35,12 +38,16 @@ void pci_set_bus_of_node(struct pci_bus *bus)
 		bus->dev.of_node = pcibios_get_phb_of_node(bus);
 	else
 		bus->dev.of_node = of_node_get(bus->self->dev.of_node);
+
+	if (bus->dev.of_node)
+		bus->dev.fwnode = &bus->dev.of_node->fwnode;
 }
 
 void pci_release_bus_of_node(struct pci_bus *bus)
 {
 	of_node_put(bus->dev.of_node);
 	bus->dev.of_node = NULL;
+	bus->dev.fwnode = NULL;
 }
 
 struct device_node * __weak pcibios_get_phb_of_node(struct pci_bus *bus)
-- 
2.19.1

