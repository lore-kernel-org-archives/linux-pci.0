Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18A8C433F4
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 16:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEAD21522
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 16:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AEAD21522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbeITWKn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:10:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:21034 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbeITWKn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 18:10:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 09:26:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,281,1534834800"; 
   d="scan'208";a="258918165"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.44])
  by orsmga005.jf.intel.com with ESMTP; 20 Sep 2018 09:26:26 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv4 02/12] PCI: portdrv: Restore pci state on slot reset
Date:   Thu, 20 Sep 2018 10:27:07 -0600
Message-Id: <20180920162717.31066-3-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180920162717.31066-1-keith.busch@intel.com>
References: <20180920162717.31066-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The port's config space may be cleared after a link reset, which wipes
out the bridge's bus and memory windows. We need to restore the config
space that was saved during probe in order to successfully access
downstream devices.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/portdrv_pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 23a5a0c2c3fe..17256733fa43 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -146,6 +146,13 @@ static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
 	return PCI_ERS_RESULT_CAN_RECOVER;
 }
 
+static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
+{
+	pci_restore_state(dev);
+	pci_save_state(dev);
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
 static pci_ers_result_t pcie_portdrv_mmio_enabled(struct pci_dev *dev)
 {
 	return PCI_ERS_RESULT_RECOVERED;
@@ -185,6 +192,7 @@ static const struct pci_device_id port_pci_ids[] = { {
 
 static const struct pci_error_handlers pcie_portdrv_err_handler = {
 	.error_detected = pcie_portdrv_error_detected,
+	.slot_reset = pcie_portdrv_slot_reset,
 	.mmio_enabled = pcie_portdrv_mmio_enabled,
 	.resume = pcie_portdrv_err_resume,
 };
-- 
2.14.4

