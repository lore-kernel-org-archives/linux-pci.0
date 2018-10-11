Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E160EC67806
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 18:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84022085B
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 18:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84022085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbeJLCFl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 22:05:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:50095 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728581AbeJLCFl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 22:05:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 11:37:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,369,1534834800"; 
   d="scan'208";a="80468700"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga007.jf.intel.com with ESMTP; 11 Oct 2018 11:37:15 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 2/4] PCI/AER: Abstract AER interrupt handling
Date:   Thu, 11 Oct 2018 12:34:11 -0600
Message-Id: <20181011183413.13183-3-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181011183413.13183-1-keith.busch@intel.com>
References: <20181011183413.13183-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The aer_inject module was directly calling aer_irq().  This required the
AER driver export its private IRQ handler for no other reason than to
support error injection.  A driver should not have to expose its private
interfaces, so use the IRQ subsystem to route injection to the AER driver,
and make aer_irq() a private interface.

This provides additional benefits:

First, directly calling the IRQ handler bypassed the IRQ subsytem so the
injection wasn't really synthesizing what happens if a shared AER interrupt
occurs.

The error injection had to provide the callback data directly, which may be
racing with a removal that is freeing that structure.  The IRQ subsystem
can handle that race.

Finally, using the IRQ subsystem automatically reacts to threaded IRQs,
keeping the error injection abstracted from that implementation detail.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/aer.c        | 3 +--
 drivers/pci/pcie/aer_inject.c | 5 ++++-
 drivers/pci/pcie/portdrv.h    | 4 ----
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 90b53abf621d..a90a9194ac4a 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1229,7 +1229,7 @@ static irqreturn_t aer_isr(int irq, void *context)
  *
  * Invoked when Root Port detects AER messages.
  */
-irqreturn_t aer_irq(int irq, void *context)
+static irqreturn_t aer_irq(int irq, void *context)
 {
 	struct pcie_device *pdev = (struct pcie_device *)context;
 	struct aer_rpc *rpc = get_service_data(pdev);
@@ -1249,7 +1249,6 @@ irqreturn_t aer_irq(int irq, void *context)
 
 	return IRQ_WAKE_THREAD;
 }
-EXPORT_SYMBOL_GPL(aer_irq);
 
 static int set_device_error_reporting(struct pci_dev *dev, void *data)
 {
diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index f40ed5867c89..726987f8d53c 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -14,6 +14,7 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/miscdevice.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
@@ -457,7 +458,9 @@ static int aer_inject(struct aer_error_inj *einj)
 		dev_info(&edev->device,
 			 "aer_inject: Injecting errors %08x/%08x into device %s\n",
 			 einj->cor_status, einj->uncor_status, pci_name(dev));
-		aer_irq(-1, edev);
+		local_irq_disable();
+		generic_handle_irq(edev->irq);
+		local_irq_enable();
 	} else {
 		pci_err(rpdev, "aer_inject: AER device not found\n");
 		ret = -ENODEV;
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index abfdc2ae7979..e495f04394d0 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -151,10 +151,6 @@ static inline int pcie_aer_get_firmware_first(struct pci_dev *pci_dev)
 }
 #endif
 
-#ifdef CONFIG_PCIEAER
-irqreturn_t aer_irq(int irq, void *context);
-#endif
-
 struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
 							u32 service);
 struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
-- 
2.14.4

