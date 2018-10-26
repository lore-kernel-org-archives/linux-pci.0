Return-Path: <SRS0=XYt1=NG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AB4ECDE44
	for <linux-pci@archiver.kernel.org>; Fri, 26 Oct 2018 20:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5763B207DD
	for <linux-pci@archiver.kernel.org>; Fri, 26 Oct 2018 20:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5763B207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbeJ0FE7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:04:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:16267 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbeJ0FE7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 27 Oct 2018 01:04:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Oct 2018 13:26:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,429,1534834800"; 
   d="scan'208";a="102998736"
Received: from unknown (HELO localhost.localdomain.localdomain) ([10.232.117.194])
  by orsmga001.jf.intel.com with ESMTP; 26 Oct 2018 13:26:32 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 1/3] PCI/AER: Option to leave System Error Interrupts as-is
Date:   Fri, 26 Oct 2018 14:19:04 -0600
Message-Id: <1540585146-31876-1-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a bit in pci_host_bridge to indicate to leave the System Error
Interrupts as configured by the pre-boot environment. Propagate this to
the AER driver which disables System Error Interrupts.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/pcie/aer.c | 7 +++++--
 include/linux/pci.h    | 3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 83180ed..6a4af63 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1360,6 +1360,7 @@ static void set_downstream_devices_error_reporting(struct pci_dev *dev,
 static void aer_enable_rootport(struct aer_rpc *rpc)
 {
 	struct pci_dev *pdev = rpc->rpd;
+	struct pci_host_bridge *host;
 	int aer_pos;
 	u16 reg16;
 	u32 reg32;
@@ -1369,8 +1370,10 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
 	pcie_capability_write_word(pdev, PCI_EXP_DEVSTA, reg16);
 
 	/* Disable system error generation in response to error messages */
-	pcie_capability_clear_word(pdev, PCI_EXP_RTCTL,
-				   SYSTEM_ERROR_INTR_ON_MESG_MASK);
+	host = pci_find_host_bridge(pdev->bus);
+	if (!host->no_disable_sys_err)
+		pcie_capability_clear_word(pdev, PCI_EXP_RTCTL,
+					   SYSTEM_ERROR_INTR_ON_MESG_MASK);
 
 	aer_pos = pdev->aer_cap;
 	/* Clear error status */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6925828..6fcfab4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -484,6 +484,9 @@ struct pci_host_bridge {
 	unsigned int	native_shpc_hotplug:1;	/* OS may use SHPC hotplug */
 	unsigned int	native_pme:1;		/* OS may use PCIe PME */
 	unsigned int	native_ltr:1;		/* OS may use PCIe LTR */
+	unsigned int	no_disable_sys_err:1;	/* Don't disable system
+						   error interrupts */
+
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
 			const struct resource *res,
-- 
1.8.3.1

