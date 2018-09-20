Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7AFECE566
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 16:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A3521529
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 16:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A3521529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbeITWKp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:10:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:21046 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730149AbeITWKo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 18:10:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 09:26:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,281,1534834800"; 
   d="scan'208";a="258918174"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.44])
  by orsmga005.jf.intel.com with ESMTP; 20 Sep 2018 09:26:27 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv4 04/12] PCI: AER: Take reference on error devices
Date:   Thu, 20 Sep 2018 10:27:09 -0600
Message-Id: <20180920162717.31066-5-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180920162717.31066-1-keith.busch@intel.com>
References: <20180920162717.31066-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Error handling may be running in parallel with a hot removal. This patch
reference counts the devices AER handling tracks so the device can not
be freed while AER wants to reference it.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/aer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 637d638f73da..ffbbd759683c 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -866,7 +866,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
 {
 	if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
-		e_info->dev[e_info->error_dev_num] = dev;
+		e_info->dev[e_info->error_dev_num] = pci_dev_get(dev);
 		e_info->error_dev_num++;
 		return 0;
 	}
@@ -1013,6 +1013,7 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 		pcie_do_nonfatal_recovery(dev);
 	else if (info->severity == AER_FATAL)
 		pcie_do_fatal_recovery(dev, PCIE_PORT_SERVICE_AER);
+	pci_dev_put(dev);
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
-- 
2.14.4

