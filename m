Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D7CC433F4
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 14:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1A821557
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 14:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1A821557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388909AbeIUUKm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:10:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:24582 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728365AbeIUUKm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Sep 2018 16:10:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 07:21:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,285,1534834800"; 
   d="scan'208";a="82260153"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.44])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Sep 2018 07:21:03 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Keith Busch <keith.busch@intel.com>
Subject: [PATCH] PCI: Fix compile error with DPC disabled
Date:   Fri, 21 Sep 2018 08:22:10 -0600
Message-Id: <20180921142210.1191-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The alternate functions when CONFIG_PCIE_DPC is not defined need to be
static inline.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pci.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a244bd0c5ca7..eb3125decffe 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -402,8 +402,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
 void pci_save_dpc_state(struct pci_dev *dev);
 void pci_restore_dpc_state(struct pci_dev *dev);
 #else
-void pci_save_dpc_state(struct pci_dev *dev) {}
-void pci_restore_dpc_state(struct pci_dev *dev) {}
+static inline void pci_save_dpc_state(struct pci_dev *dev) {}
+static inline void pci_restore_dpc_state(struct pci_dev *dev) {}
 #endif
 
 #ifdef CONFIG_PCI_ATS
-- 
2.14.4

