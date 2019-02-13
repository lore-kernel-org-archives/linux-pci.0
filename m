Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DD5C282CA
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 17:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7513222D8
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 17:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393497AbfBMRzH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:55:07 -0500
Received: from ale.deltatee.com ([207.54.116.67]:54602 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393491AbfBMRzG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Feb 2019 12:55:06 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gtykN-0001zA-9W; Wed, 13 Feb 2019 10:55:04 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gtykL-0001y9-BE; Wed, 13 Feb 2019 10:54:57 -0700
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
        David Woodhouse <dwmw2@infradead.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Date:   Wed, 13 Feb 2019 10:54:46 -0700
Message-Id: <20190213175454.7506-5-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20190213175454.7506-1-logang@deltatee.com>
References: <20190213175454.7506-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, jdmason@kudzu.us, bhelgaas@google.com, joro@8bytes.org, dave.jiang@intel.com, allenbh@gmail.com, fancer.lancer@gmail.com, epilmore@gigaio.com, logang@deltatee.com, dwmw2@infradead.org, jacob.jun.pan@linux.intel.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 04/12] iommu/vt-d: Allow interrupts from the entire bus for aliased devices
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
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel_irq_remapping.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 5a55bef8e379..2d74641b7f7b 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -368,6 +368,8 @@ static int set_hpet_sid(struct irte *irte, u8 id)
 struct set_msi_sid_data {
 	struct pci_dev *pdev;
 	u16 alias;
+	int count;
+	int busmatch_count;
 };
 
 static int set_msi_sid_cb(struct pci_dev *pdev, u16 alias, void *opaque)
@@ -376,6 +378,10 @@ static int set_msi_sid_cb(struct pci_dev *pdev, u16 alias, void *opaque)
 
 	data->pdev = pdev;
 	data->alias = alias;
+	data->count++;
+
+	if (PCI_BUS_NUM(alias) == pdev->bus->number)
+		data->busmatch_count++;
 
 	return 0;
 }
@@ -387,6 +393,8 @@ static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
 	if (!irte || !dev)
 		return -1;
 
+	data.count = 0;
+	data.busmatch_count = 0;
 	pci_for_each_dma_alias(dev, set_msi_sid_cb, &data);
 
 	/*
@@ -395,6 +403,11 @@ static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
 	 * device is the case of a PCIe-to-PCI bridge, where the alias is for
 	 * the subordinate bus.  In this case we can only verify the bus.
 	 *
+	 * If there are multiple aliases, all with the same bus number,
+	 * then all we can do is verify the bus. This is typical in NTB
+	 * hardware which use proxy IDs where the device will generate traffic
+	 * from multiple devfn numbers on the same bus.
+	 *
 	 * If the alias device is on a different bus than our source device
 	 * then we have a topology based alias, use it.
 	 *
@@ -405,6 +418,8 @@ static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
 	if (PCI_BUS_NUM(data.alias) != data.pdev->bus->number)
 		set_irte_verify_bus(irte, PCI_BUS_NUM(data.alias),
 				    dev->bus->number);
+	else if (data.count >= 2 && data.busmatch_count == data.count)
+		set_irte_verify_bus(irte, dev->bus->number, dev->bus->number);
 	else if (data.pdev->bus->number != dev->bus->number)
 		set_irte_sid(irte, SVT_VERIFY_SID_SQ, SQ_ALL_16, data.alias);
 	else
-- 
2.19.0

