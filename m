Return-Path: <SRS0=mL0v=MY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA49C6783C
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 15:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115C420865
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 15:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115C420865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbeJLWdq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:33:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52722 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbeJLWdq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Oct 2018 18:33:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E36715BF;
        Fri, 12 Oct 2018 08:00:55 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1E80B3F5BC;
        Fri, 12 Oct 2018 08:00:51 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        peter.maydell@linaro.org, joro@8bytes.org, mst@redhat.com,
        jasowang@redhat.com, robh+dt@kernel.org, mark.rutland@arm.com,
        eric.auger@redhat.com, tnowicki@caviumnetworks.com,
        kevin.tian@intel.com, marc.zyngier@arm.com, robin.murphy@arm.com,
        will.deacon@arm.com, lorenzo.pieralisi@arm.com
Subject: [PATCH v3 3/7] PCI: OF: Allow endpoints to bypass the iommu
Date:   Fri, 12 Oct 2018 15:59:13 +0100
Message-Id: <20181012145917.6840-4-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
References: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Using the iommu-map binding, endpoints in a given PCI domain can be
managed by different IOMMUs. Some virtual machines may allow a subset of
endpoints to bypass the IOMMU. In some case the IOMMU itself is presented
as a PCI endpoint (e.g. AMD IOMMU and virtio-iommu). Currently, when a
PCI root complex has an iommu-map property, the driver requires all
endpoints to be described by the property. Allow the iommu-map property to
have gaps.

Relaxing of_pci_map_rid also allows the msi-map property to have gaps,
which is invalid since MSIs always reach an MSI controller. Thankfully
Linux will error out later, when attempting to find an MSI domain for the
device.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/pci/of.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 1836b8ddf292..2f5015bdb256 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -451,9 +451,10 @@ int of_pci_map_rid(struct device_node *np, u32 rid,
 		return 0;
 	}
 
-	pr_err("%pOF: Invalid %s translation - no match for rid 0x%x on %pOF\n",
-		np, map_name, rid, target && *target ? *target : NULL);
-	return -EFAULT;
+	/* Bypasses translation */
+	if (id_out)
+		*id_out = rid;
+	return 0;
 }
 
 #if IS_ENABLED(CONFIG_OF_IRQ)
-- 
2.19.1

