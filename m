Return-Path: <SRS0=HN6g=PX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7AEC43387
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 12:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C66220651
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 12:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbfAOMZT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:25:19 -0500
Received: from foss.arm.com ([217.140.101.70]:49330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729432AbfAOMZS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Jan 2019 07:25:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F95F80D;
        Tue, 15 Jan 2019 04:25:18 -0800 (PST)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 21CB43F70D;
        Tue, 15 Jan 2019 04:25:14 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, joro@8bytes.org, mst@redhat.com
Cc:     jasowang@redhat.com, robh+dt@kernel.org, mark.rutland@arm.com,
        bhelgaas@google.com, frowand.list@gmail.com,
        kvmarm@lists.cs.columbia.edu, eric.auger@redhat.com,
        tnowicki@caviumnetworks.com, kevin.tian@intel.com,
        marc.zyngier@arm.com, robin.murphy@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, bharat.bhushan@nxp.com
Subject: [PATCH v7 3/7] of: Allow the iommu-map property to omit untranslated devices
Date:   Tue, 15 Jan 2019 12:19:55 +0000
Message-Id: <20190115121959.23763-4-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190115121959.23763-1-jean-philippe.brucker@arm.com>
References: <20190115121959.23763-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In PCI root complex nodes, the iommu-map property describes the IOMMU that
translates each endpoint. On some platforms, the IOMMU itself is presented
as a PCI endpoint (e.g. AMD IOMMU and virtio-iommu). This isn't supported
by the current OF driver, which expects all endpoints to have an IOMMU.
Allow the iommu-map property to have gaps.

Relaxing of_map_rid() also allows the msi-map property to have gaps, which
is invalid since MSIs always reach an MSI controller. In that case
pci_msi_setup_msi_irqs() will return an error when attempting to find the
device's MSI domain.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/of/base.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 5226e898476e..4d12b1cab55f 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2293,8 +2293,12 @@ int of_map_rid(struct device_node *np, u32 rid,
 		return 0;
 	}
 
-	pr_err("%pOF: Invalid %s translation - no match for rid 0x%x on %pOF\n",
-		np, map_name, rid, target && *target ? *target : NULL);
-	return -EFAULT;
+	pr_info("%pOF: no %s translation for rid 0x%x on %pOF\n", np, map_name,
+		rid, target && *target ? *target : NULL);
+
+	/* Bypasses translation */
+	if (id_out)
+		*id_out = rid;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(of_map_rid);
-- 
2.19.1

