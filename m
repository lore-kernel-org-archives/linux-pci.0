Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCCFECDE43
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 02:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E1221477
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 02:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWbZFACm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E1221477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbeJSKPn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 06:15:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbeJSKPn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Oct 2018 06:15:43 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.117.90.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFB5521476;
        Fri, 19 Oct 2018 02:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539915108;
        bh=vp9qC3YiLnSl3Q92dXbgn7jZasg7kOOVChQZcHo90dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SWbZFACmcMQVwZVRK+wadNUZHb9TNkt4/zquFiUpSynTXK2Lvo9ztCE0XVj8ggL4X
         ELgelJp3Sr0LcmSdLlZdRtuxRSLOaXx2OKKrsL8VUeYWcDt6aDxb2dGd0hL0lf+5Sf
         MAPGcbwOZ5vGdfKy2VOfQ8hzKQ6aXSnfg/xTWTgo=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v6 5/7] PCI: Expose reset type to users of pci_probe_reset_function()
Date:   Fri, 19 Oct 2018 02:11:25 +0000
Message-Id: <20181019021132.14743-5-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181019021132.14743-1-okaya@kernel.org>
References: <20181019021132.14743-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Looking to have more control between the users of the API vs. what the API
can do internally. The new reset_type tells the PCI core about the bounds
of the request.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/pci/pci.c   | 52 ++++++++++++++++++++++++++++++---------------
 drivers/pci/pci.h   |  2 +-
 drivers/pci/probe.c |  2 +-
 3 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7739f28988ae..a1a7dd6988be 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4745,6 +4745,7 @@ EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
 /**
  * pci_probe_reset_function - check whether the device can be safely reset
  * @dev: PCI device to reset
+ * @reset_type: reset type to apply
  *
  * Some devices allow an individual function to be reset without affecting
  * other functions in the same device.  The PCI device must be responsive
@@ -4753,28 +4754,45 @@ EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
  * Returns 0 if the device function can be reset or negative if the
  * device doesn't support resetting a single function.
  */
-int pci_probe_reset_function(struct pci_dev *dev)
+int pci_probe_reset_function(struct pci_dev *dev, u32 reset_type)
 {
-	int rc;
+	int rc = 0;
 
 	might_sleep();
 
-	rc = pci_dev_specific_reset(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
-	if (pcie_has_flr(dev))
-		return 0;
-	rc = pci_af_flr(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pci_pm_reset(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pci_dev_reset_slot_function(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
+	if (reset_type & PCI_RESET_DEV_SPECIFIC) {
+		rc = pci_dev_specific_reset(dev, 1);
+		if (rc != -ENOTTY)
+			return rc;
+	}
+
+	if (reset_type & PCI_RESET_FLR) {
+		if (pcie_has_flr(dev))
+			return 0;
+		rc = pci_af_flr(dev, 1);
+		if (rc != -ENOTTY)
+			return rc;
+	}
 
-	return pci_parent_bus_reset(dev, 1);
+	if (reset_type & PCI_RESET_PM) {
+		rc = pci_pm_reset(dev, 1);
+		if (rc != -ENOTTY)
+			return rc;
+	}
+
+	if (reset_type & PCI_RESET_SLOT) {
+		rc = pci_dev_reset_slot_function(dev, 1);
+		if (rc != -ENOTTY)
+			return rc;
+	}
+
+	if (reset_type & PCI_RESET_BUS) {
+		rc = pci_parent_bus_reset(dev, 1);
+		if (rc != -ENOTTY)
+			return rc;
+	}
+
+	return rc;
 }
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6e0d1528d471..0444bfa51b52 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -33,7 +33,7 @@ enum pci_mmap_api {
 int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
 		  enum pci_mmap_api mmap_api);
 
-int pci_probe_reset_function(struct pci_dev *dev);
+int pci_probe_reset_function(struct pci_dev *dev, u32 reset_type);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 
 /**
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 201f9e5ff55c..6c8f6af2d4aa 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2335,7 +2335,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 
 	pcie_report_downtraining(dev);
 
-	if (pci_probe_reset_function(dev) == 0)
+	if (pci_probe_reset_function(dev, PCI_RESET_ANY) == 0)
 		dev->reset_fn = 1;
 }
 
-- 
2.19.0

