Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7CBECE566
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 16:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417DB2147D
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 16:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 417DB2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731785AbeITWKt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:10:49 -0400
Received: from mga07.intel.com ([134.134.136.100]:21062 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730915AbeITWKt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 18:10:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 09:26:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,281,1534834800"; 
   d="scan'208";a="258918206"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.44])
  by orsmga005.jf.intel.com with ESMTP; 20 Sep 2018 09:26:32 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv4 10/12] PCI: ERR: Report current recovery status for udev
Date:   Thu, 20 Sep 2018 10:27:15 -0600
Message-Id: <20180920162717.31066-11-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180920162717.31066-1-keith.busch@intel.com>
References: <20180920162717.31066-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A device still participates in error recovery even if it doesn't have
the error callbacks. This patch provides the status for user event
watchers.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/err.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 362a717c831a..31e8a4314384 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -70,9 +70,8 @@ static int report_error_detected(struct pci_dev *dev,
 	} else {
 		err_handler = dev->driver->err_handler;
 		vote = err_handler->error_detected(dev, state);
-		pci_uevent_ers(dev, PCI_ERS_RESULT_NONE);
 	}
-
+	pci_uevent_ers(dev, vote);
 	*result = merge_result(*result, vote);
 	device_unlock(&dev->dev);
 	return 0;
@@ -140,8 +139,8 @@ static int report_resume(struct pci_dev *dev, void *data)
 
 	err_handler = dev->driver->err_handler;
 	err_handler->resume(dev);
-	pci_uevent_ers(dev, PCI_ERS_RESULT_RECOVERED);
 out:
+	pci_uevent_ers(dev, PCI_ERS_RESULT_RECOVERED);
 	device_unlock(&dev->dev);
 	return 0;
 }
-- 
2.14.4

