Return-Path: <SRS0=JYfi=M4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB90DC04EBF
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 00:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830712145D
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 00:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830712145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeJPInB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Oct 2018 04:43:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:26009 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbeJPIm7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Oct 2018 04:42:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 17:55:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,386,1534834800"; 
   d="scan'208";a="95512632"
Received: from unknown (HELO localhost.localdomain.localdomain) ([10.232.117.194])
  by fmsmga002.fm.intel.com with ESMTP; 15 Oct 2018 17:55:13 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 1/2] PCI/VMD: Detach resources after stopping root bus
Date:   Mon, 15 Oct 2018 18:48:07 -0600
Message-Id: <1539650888-3792-2-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1539650888-3792-1-git-send-email-jonathan.derrick@intel.com>
References: <1539650888-3792-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The VMD removal path calls pci_stop_root_bus, which tears down the pcie
tree, including detaching all of the attached drivers. During driver
detachment, devices may use pci_release_region to release resources.
This path relies on the resource being accessible in resource tree.

By detaching the child domain from the parent resource domain prior to
stopping the bus, we are preventing the list traversal from finding the
resource to be freed. If we instead detach the resource after stopping
the bus, we will have properly freed the resource and detaching is
simply accounting at that point.

Without this order, the resource is never freed and is orphaned on VMD
removal, leading to warning:
[  181.940162] Trying to free nonexistent resource <e5a10000-e5a13fff>

Fixes 2c2c5c5cd213aea38c850bb6edc9b7f77f29802f:
"x86/PCI: VMD: Attach VMD resources to parent domain's resource tree"
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index fd2dbd7..46ed80f 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -813,12 +813,12 @@ static void vmd_remove(struct pci_dev *dev)
 {
 	struct vmd_dev *vmd = pci_get_drvdata(dev);
 
-	vmd_detach_resources(vmd);
 	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
 	pci_stop_root_bus(vmd->bus);
 	pci_remove_root_bus(vmd->bus);
 	vmd_cleanup_srcu(vmd);
 	vmd_teardown_dma_ops(vmd);
+	vmd_detach_resources(vmd);
 	irq_domain_remove(vmd->irq_domain);
 }
 
-- 
1.8.3.1

