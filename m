Return-Path: <SRS0=+1WX=V6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBD3C32753
	for <linux-pci@archiver.kernel.org>; Fri,  2 Aug 2019 00:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728342084C
	for <linux-pci@archiver.kernel.org>; Fri,  2 Aug 2019 00:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfHBAIq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 1 Aug 2019 20:08:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:59857 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727604AbfHBAIq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Aug 2019 20:08:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 17:08:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,336,1559545200"; 
   d="scan'208";a="177993973"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga006.jf.intel.com with ESMTP; 01 Aug 2019 17:08:44 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v5 7/7] PCI: Skip Enhanced Allocation (EA) initialization for VF device
Date:   Thu,  1 Aug 2019 17:06:04 -0700
Message-Id: <0418e168c33b9373af104ffda623f266d45e6f9f.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

As per PCIe r4.0, sec 9.3.6, VF must not implement Enhanced Allocation
Capability. So skip pci_ea_init() for virtual devices.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 29ed5ec1ac27..4b2844c3606c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3020,6 +3020,13 @@ void pci_ea_init(struct pci_dev *dev)
 	int offset;
 	int i;
 
+	/*
+	 * Per PCIe r4.0, sec 9.3.6, VF must not implement Enhanced
+	 * Allocation Capability.
+	 */
+	if (dev->is_virtfn)
+		return;
+
 	/* find PCI EA capability in list */
 	ea = pci_find_capability(dev, PCI_CAP_ID_EA);
 	if (!ea)
-- 
2.21.0

