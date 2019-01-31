Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9A0C169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 18:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787E1218AF
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 18:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfAaS5p (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:57:45 -0500
Received: from ale.deltatee.com ([207.54.116.67]:49980 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728492AbfAaS5X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Jan 2019 13:57:23 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gpHWS-0001ur-NL; Thu, 31 Jan 2019 11:57:21 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gpHWO-0004gl-S7; Thu, 31 Jan 2019 11:57:08 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        David Woodhouse <dwmw2@infradead.org>
Date:   Thu, 31 Jan 2019 11:56:48 -0700
Message-Id: <20190131185656.17972-2-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20190131185656.17972-1-logang@deltatee.com>
References: <20190131185656.17972-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, jdmason@kudzu.us, bhelgaas@google.com, joro@8bytes.org, dave.jiang@intel.com, allenbh@gmail.com, fancer.lancer@gmail.com, epilmore@gigaio.com, logang@deltatee.com, dwmw2@infradead.org
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 1/9] iommu/vt-d: Allow interrupts from the entire bus for aliased devices
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When a device has multiple aliases that all are from the same bus,
we program the IRTE to accept requests from any matching device on the
bus.

This is so NTB devices which can have requests from multiple bus-devfns
can pass MSI interrupts through across the bridge.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: David Woodhouse <dwmw2@infradead.org>
---
 drivers/iommu/intel_irq_remapping.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 24d45b07f425..8d3107a6b2b4 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -356,6 +356,8 @@ static int set_hpet_sid(struct irte *irte, u8 id)
 struct set_msi_sid_data {
 	struct pci_dev *pdev;
 	u16 alias;
+	int count;
+	int busmatch_count;
 };
 
 static int set_msi_sid_cb(struct pci_dev *pdev, u16 alias, void *opaque)
@@ -364,6 +366,10 @@ static int set_msi_sid_cb(struct pci_dev *pdev, u16 alias, void *opaque)
 
 	data->pdev = pdev;
 	data->alias = alias;
+	data->count++;
+
+	if (PCI_BUS_NUM(alias) == pdev->bus->number)
+		data->busmatch_count++;
 
 	return 0;
 }
@@ -375,6 +381,8 @@ static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
 	if (!irte || !dev)
 		return -1;
 
+	data.count = 0;
+	data.busmatch_count = 0;
 	pci_for_each_dma_alias(dev, set_msi_sid_cb, &data);
 
 	/*
@@ -394,6 +402,10 @@ static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
 		set_irte_sid(irte, SVT_VERIFY_BUS, SQ_ALL_16,
 			     PCI_DEVID(PCI_BUS_NUM(data.alias),
 				       dev->bus->number));
+	else if (data.count >= 2 && data.busmatch_count == data.count)
+		set_irte_sid(irte, SVT_VERIFY_BUS, SQ_ALL_16,
+			     PCI_DEVID(dev->bus->number,
+				       dev->bus->number));
 	else if (data.pdev->bus->number != dev->bus->number)
 		set_irte_sid(irte, SVT_VERIFY_SID_SQ, SQ_ALL_16, data.alias);
 	else
-- 
2.19.0

