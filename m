Return-Path: <SRS0=UCfD=CY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEF8C43461
	for <linux-pci@archiver.kernel.org>; Tue, 15 Sep 2020 23:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA7332193E
	for <linux-pci@archiver.kernel.org>; Tue, 15 Sep 2020 23:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgIOX1y (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 15 Sep 2020 19:27:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:50317 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727225AbgIOX1w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Sep 2020 19:27:52 -0400
IronPort-SDR: FAblg7oGQ+AJnrtvj1/AP6GZFWRYCNZRM/DqeoCGYquiVCdHGP60tihI4j/tmNACRgvgEWJfT0
 YO/EXmiF9wCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="244200209"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="244200209"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 16:27:51 -0700
IronPort-SDR: YQADHup6O6rIdY3Au4rbDBvjquOi5gXEiGEv70TOm3Hk+GGW0CzJ7zfiyj39vZM7OT/n3bF8d5
 mYLhwifju0XQ==
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="451619391"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 16:27:49 -0700
Subject: [PATCH v3 02/18] iommu/vt-d: Add DEV-MSI support
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org, megha.dey@intel.com, maz@kernel.org,
        bhelgaas@google.com, tglx@linutronix.de,
        alex.williamson@redhat.com, jacob.jun.pan@intel.com,
        ashok.raj@intel.com, jgg@mellanox.com, yi.l.liu@intel.com,
        baolu.lu@intel.com, kevin.tian@intel.com, sanjay.k.kumar@intel.com,
        tony.luck@intel.com, jing.lin@intel.com, dan.j.williams@intel.com,
        kwankhede@nvidia.com, eric.auger@redhat.com, parav@mellanox.com,
        jgg@mellanox.com, rafael@kernel.org, netanelg@mellanox.com,
        shahafs@mellanox.com, yan.y.zhao@linux.intel.com,
        pbonzini@redhat.com, samuel.ortiz@intel.com, mona.hossain@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pci@vger.kernel.org, kvm@vger.kernel.org
Date:   Tue, 15 Sep 2020 16:27:49 -0700
Message-ID: <160021246905.67751.1674517279122764758.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <160021207013.67751.8220471499908137671.stgit@djiang5-desk3.ch.intel.com>
References: <160021207013.67751.8220471499908137671.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Megha Dey <megha.dey@intel.com>

Add required support in the interrupt remapping driver for devices
which generate dev-msi interrupts and use the intel remapping
domain as the parent domain.

Signed-off-by: Megha Dey <megha.dey@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel/irq_remapping.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 0cfce1d3b7bb..75e388263b78 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1303,9 +1303,10 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
 	case X86_IRQ_ALLOC_TYPE_HPET:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
+	case X86_IRQ_ALLOC_TYPE_DEV_MSI:
 		if (info->type == X86_IRQ_ALLOC_TYPE_HPET)
 			set_hpet_sid(irte, info->devid);
-		else
+		else if (info->type != X86_IRQ_ALLOC_TYPE_DEV_MSI)
 			set_msi_sid(irte, msi_desc_to_pci_dev(info->desc));
 
 		msg->address_hi = MSI_ADDR_BASE_HI;
@@ -1358,7 +1359,8 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
 	if (!info || !iommu)
 		return -EINVAL;
 	if (nr_irqs > 1 && info->type != X86_IRQ_ALLOC_TYPE_PCI_MSI &&
-	    info->type != X86_IRQ_ALLOC_TYPE_PCI_MSIX)
+	    info->type != X86_IRQ_ALLOC_TYPE_PCI_MSIX &&
+	    info->type != X86_IRQ_ALLOC_TYPE_DEV_MSI)
 		return -EINVAL;
 
 	/*

