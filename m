Return-Path: <SRS0=PAID=M6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB3FC5ACCC
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 12:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC4D2148D
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 12:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC4D2148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbeJRUbj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Oct 2018 16:31:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:60958 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbeJRUbi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Oct 2018 16:31:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2018 05:30:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,396,1534834800"; 
   d="scan'208";a="100519703"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.72])
  by orsmga001.jf.intel.com with ESMTP; 18 Oct 2018 05:30:44 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean Delvare <jdelvare@suse.de>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH] PCI / PM: Allow runtime PM without callback functions
Date:   Thu, 18 Oct 2018 15:30:38 +0300
Message-Id: <20181018123038.21386-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Allow PCI core to do runtime PM to devices without needing to use dummy
runtime PM callback functions if there is no need to do anything device
specific beyond PCI device power state management.

Implement this by letting core to change device power state during
runtime PM transitions even if no callback functions are defined.

Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
This is related to my i2c-i801.c fix thread back in June which I completely
forgot till now: https://lkml.org/lkml/2018/6/27/642
Discussion back then was that it should be handled in the PCI PM instead
of having dummy functions in the drivers. I wanted to respin with a
patch.
---
 drivers/pci/pci-driver.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index bef17c3fca67..6185b878ede1 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1239,7 +1239,7 @@ static int pci_pm_runtime_suspend(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 	pci_power_t prev = pci_dev->current_state;
-	int error;
+	int error = 0;
 
 	/*
 	 * If pci_dev->driver is not set (unbound), we leave the device in D0,
@@ -1251,11 +1251,9 @@ static int pci_pm_runtime_suspend(struct device *dev)
 		return 0;
 	}
 
-	if (!pm || !pm->runtime_suspend)
-		return -ENOSYS;
-
 	pci_dev->state_saved = false;
-	error = pm->runtime_suspend(dev);
+	if (pm && pm->runtime_suspend)
+		error = pm->runtime_suspend(dev);
 	if (error) {
 		/*
 		 * -EBUSY and -EAGAIN is used to request the runtime PM core
@@ -1292,7 +1290,7 @@ static int pci_pm_runtime_suspend(struct device *dev)
 
 static int pci_pm_runtime_resume(struct device *dev)
 {
-	int rc;
+	int rc = 0;
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 
@@ -1306,14 +1304,12 @@ static int pci_pm_runtime_resume(struct device *dev)
 	if (!pci_dev->driver)
 		return 0;
 
-	if (!pm || !pm->runtime_resume)
-		return -ENOSYS;
-
 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 	pci_enable_wake(pci_dev, PCI_D0, false);
 	pci_fixup_device(pci_fixup_resume, pci_dev);
 
-	rc = pm->runtime_resume(dev);
+	if (pm && pm->runtime_resume)
+		rc = pm->runtime_resume(dev);
 
 	pci_dev->runtime_d3cold = false;
 
-- 
2.19.1

