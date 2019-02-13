Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4067C282CE
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 17:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D3F2086C
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 17:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404484AbfBMRzJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:55:09 -0500
Received: from ale.deltatee.com ([207.54.116.67]:54660 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393507AbfBMRzI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Feb 2019 12:55:08 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gtykN-0001z9-9W; Wed, 13 Feb 2019 10:55:06 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gtykL-0001y6-7z; Wed, 13 Feb 2019 10:54:57 -0700
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
Date:   Wed, 13 Feb 2019 10:54:45 -0700
Message-Id: <20190213175454.7506-4-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20190213175454.7506-1-logang@deltatee.com>
References: <20190213175454.7506-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, jdmason@kudzu.us, bhelgaas@google.com, joro@8bytes.org, dave.jiang@intel.com, allenbh@gmail.com, fancer.lancer@gmail.com, epilmore@gigaio.com, logang@deltatee.com, dwmw2@infradead.org, jacob.jun.pan@linux.intel.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 03/12] iommu/vt-d: Add helper to set an IRTE to verify only the bus number
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The current code uses set_irte_sid() with SVT_VERIFY_BUS and PCI_DEVID
to set the SID value. However, this is very confusing because, with
SVT_VERIFY_BUS, the SID value is not a PCI devfn address, but the start
and end bus numbers to match against.

According to the Intel Virtualization Technology for Directed I/O
Architecture Specification, Rev. 3.0, page 9-36:

  The most significant 8-bits of the SID field contains the Startbus#,
  and the least significant 8-bits of the SID field contains the Endbus#.
  Interrupt requests that reference this IRTE must have a requester-id
  whose bus# (most significant 8-bits of requester-id) has a value equal
  to or within the Startbus# to Endbus# range.

So to make this more clear, introduce a new set_irte_verify_bus() that
explicitly takes a start bus and end bus so that we can stop abusing
the PCI_DEVID macro.

This helper function will be called a second time in an subsequent patch.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel_irq_remapping.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 24d45b07f425..5a55bef8e379 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -294,6 +294,18 @@ static void set_irte_sid(struct irte *irte, unsigned int svt,
 	irte->sid = sid;
 }
 
+/*
+ * Set an IRTE to match only the bus number. Interrupt requests that reference
+ * this IRTE must have a requester-id whose bus number is between or equal
+ * to the start_bus and end_bus arguments.
+ */
+static void set_irte_verify_bus(struct irte *irte, unsigned int start_bus,
+				unsigned int end_bus)
+{
+	set_irte_sid(irte, SVT_VERIFY_BUS, SQ_ALL_16,
+		     (start_bus << 8) | end_bus);
+}
+
 static int set_ioapic_sid(struct irte *irte, int apic)
 {
 	int i;
@@ -391,9 +403,8 @@ static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
 	 * original device.
 	 */
 	if (PCI_BUS_NUM(data.alias) != data.pdev->bus->number)
-		set_irte_sid(irte, SVT_VERIFY_BUS, SQ_ALL_16,
-			     PCI_DEVID(PCI_BUS_NUM(data.alias),
-				       dev->bus->number));
+		set_irte_verify_bus(irte, PCI_BUS_NUM(data.alias),
+				    dev->bus->number);
 	else if (data.pdev->bus->number != dev->bus->number)
 		set_irte_sid(irte, SVT_VERIFY_SID_SQ, SQ_ALL_16, data.alias);
 	else
-- 
2.19.0

