Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2F8C67807
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 18:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB8D204FD
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 18:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB8D204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbeJLCFk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 22:05:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:50095 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728581AbeJLCFk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 22:05:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 11:37:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,369,1534834800"; 
   d="scan'208";a="80468695"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga007.jf.intel.com with ESMTP; 11 Oct 2018 11:37:15 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 1/4] PCI/AER: Reuse existing pcie_port_find_device() interface
Date:   Thu, 11 Oct 2018 12:34:10 -0600
Message-Id: <20181011183413.13183-2-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181011183413.13183-1-keith.busch@intel.com>
References: <20181011183413.13183-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The port services driver already provides a method to find the pcie_device
for a service.  Export that function, use it from the aer_inject module,
and remove the duplicate functionality.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/aer_inject.c   | 25 ++++---------------------
 drivers/pci/pcie/portdrv_core.c |  1 +
 2 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 0eb24346cad3..f40ed5867c89 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -303,32 +303,13 @@ static int pci_bus_set_aer_ops(struct pci_bus *bus)
 	return 0;
 }
 
-static int find_aer_device_iter(struct device *device, void *data)
-{
-	struct pcie_device **result = data;
-	struct pcie_device *pcie_dev;
-
-	if (device->bus == &pcie_port_bus_type) {
-		pcie_dev = to_pcie_device(device);
-		if (pcie_dev->service & PCIE_PORT_SERVICE_AER) {
-			*result = pcie_dev;
-			return 1;
-		}
-	}
-	return 0;
-}
-
-static int find_aer_device(struct pci_dev *dev, struct pcie_device **result)
-{
-	return device_for_each_child(&dev->dev, result, find_aer_device_iter);
-}
-
 static int aer_inject(struct aer_error_inj *einj)
 {
 	struct aer_error *err, *rperr;
 	struct aer_error *err_alloc = NULL, *rperr_alloc = NULL;
 	struct pci_dev *dev, *rpdev;
 	struct pcie_device *edev;
+	struct device *device;
 	unsigned long flags;
 	unsigned int devfn = PCI_DEVFN(einj->dev, einj->fn);
 	int pos_cap_err, rp_pos_cap_err;
@@ -464,7 +445,9 @@ static int aer_inject(struct aer_error_inj *einj)
 	if (ret)
 		goto out_put;
 
-	if (find_aer_device(rpdev, &edev)) {
+	device = pcie_port_find_device(rpdev, PCIE_PORT_SERVICE_AER);
+	if (device) {
+		edev = to_pcie_device(device);
 		if (!get_service_data(edev)) {
 			dev_warn(&edev->device,
 				 "aer_inject: AER service is not initialized\n");
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 6542c48c7f59..f458ac9cb70c 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -486,6 +486,7 @@ struct device *pcie_port_find_device(struct pci_dev *dev,
 	device = pdrvs.dev;
 	return device;
 }
+EXPORT_SYMBOL_GPL(pcie_port_find_device);
 
 /**
  * pcie_port_device_remove - unregister PCI Express port service devices
-- 
2.14.4

