Return-Path: <SRS0=SWM8=ST=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F44CC282DA
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 18:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511FF217F4
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 18:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbfDQS2P (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:28:15 -0400
Received: from foss.arm.com ([217.140.101.70]:49716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbfDQS2P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Apr 2019 14:28:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5491C15AB;
        Wed, 17 Apr 2019 11:28:15 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9D79D3F59C;
        Wed, 17 Apr 2019 11:28:12 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     will.deacon@arm.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        okaya@kernel.org, zhongmiao@hisilicon.com, eric.auger@redhat.com,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 2/9] PCI: Add a stub for pci_ats_disabled()
Date:   Wed, 17 Apr 2019 19:24:41 +0100
Message-Id: <20190417182448.12382-3-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417182448.12382-1-jean-philippe.brucker@arm.com>
References: <20190417182448.12382-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently pci_ats_disabled() is only defined when CONFIG_PCI is enabled.
Since we're about to use the function in the Arm SMMUv3 driver, which
could be built with CONFIG_PCI disabled, add a definition of
pci_ats_disabled() for !CONFIG_PCI.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 include/linux/pci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 169c6a18d0b0..61d7cd888bad 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1713,6 +1713,7 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
 static inline const struct pci_device_id *pci_match_id(const struct pci_device_id *ids,
 							 struct pci_dev *dev)
 { return NULL; }
+static inline bool pci_ats_disabled(void) { return true; }
 #endif /* CONFIG_PCI */
 
 #ifdef CONFIG_PCI_ATS
-- 
2.21.0

