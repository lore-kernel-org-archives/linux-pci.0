Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1840C71132
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 14:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D8220892
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 14:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D8220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbeJOWaJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Oct 2018 18:30:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:9183 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbeJOWaJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Oct 2018 18:30:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 07:44:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,384,1534834800"; 
   d="scan'208";a="78896437"
Received: from unknown (HELO localhost.localdomain.localdomain) ([10.232.117.194])
  by fmsmga008.fm.intel.com with ESMTP; 15 Oct 2018 07:44:35 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH] PCI: Configure MPS on rescan
Date:   Mon, 15 Oct 2018 08:37:30 -0600
Message-Id: <1539614250-2749-2-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1539614250-2749-1-git-send-email-jonathan.derrick@intel.com>
References: <1539614250-2749-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

During pci_rescan_bus(), we may encounter new busses and devices which
don't have MPS set for compatibility. Using this path, newly discovered
busses and devices would then require their MPS to be configured after
driver attachment, which will often be too later for drivers which do
memory transactions on probe. This additionally ensures that any
pcie_bus_config kernel settings will be applied to the busses and devices
discovered through this path prior to driver attachment.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/probe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 201f9e5..c0406d9 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3149,10 +3149,13 @@ unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge)
  */
 unsigned int pci_rescan_bus(struct pci_bus *bus)
 {
+	struct pci_bus *child;
 	unsigned int max;
 
 	max = pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
 	pci_bus_add_devices(bus);
 
 	return max;
-- 
1.8.3.1

