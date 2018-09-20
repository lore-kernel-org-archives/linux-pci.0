Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7E9ECE566
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 16:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFC821522
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 16:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACFC821522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbeITWKo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:10:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:21046 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbeITWKo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 18:10:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 09:26:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,281,1534834800"; 
   d="scan'208";a="258918168"
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
Subject: [PATCHv4 03/12] PCI: DPC: Save and restore control state
Date:   Thu, 20 Sep 2018 10:27:08 -0600
Message-Id: <20180920162717.31066-4-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180920162717.31066-1-keith.busch@intel.com>
References: <20180920162717.31066-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch provides DPC save and restore capabilities. This is necessary
for the driver to observe DPC events in the event the configuration
space needs to be restored after a reset.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pci.c      |  2 ++
 drivers/pci/pci.h      |  8 +++++++
 drivers/pci/pcie/dpc.c | 61 +++++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c4801a83fcc5..bcb70b7c190c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1284,6 +1284,7 @@ int pci_save_state(struct pci_dev *dev)
 	if (i != 0)
 		return i;
 
+	pci_save_dpc_state(dev);
 	return pci_save_vc_state(dev);
 }
 EXPORT_SYMBOL(pci_save_state);
@@ -1389,6 +1390,7 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_ats_state(dev);
 	pci_restore_vc_state(dev);
 	pci_restore_rebar_state(dev);
+	pci_restore_dpc_state(dev);
 
 	pci_cleanup_aer_error_status_regs(dev);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6e0d1528d471..5a5c6099b253 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -346,6 +346,14 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
 #endif	/* CONFIG_PCIEAER */
 
+#ifdef CONFIG_PCIE_DPC
+void pci_save_dpc_state(struct pci_dev *dev);
+void pci_restore_dpc_state(struct pci_dev *dev);
+#else
+void pci_save_dpc_state(struct pci_dev *dev) {}
+void pci_restore_dpc_state(struct pci_dev *dev) {}
+#endif
+
 #ifdef CONFIG_PCI_ATS
 void pci_restore_ats_state(struct pci_dev *dev);
 #else
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index a1fd16bf1cab..ed815a28512e 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -44,6 +44,58 @@ static const char * const rp_pio_error_string[] = {
 	"Memory Request Completion Timeout",		 /* Bit Position 18 */
 };
 
+static struct dpc_dev *to_dpc_dev(struct pci_dev *dev)
+{
+	struct device *device;
+
+	device = pcie_port_find_device(dev, PCIE_PORT_SERVICE_DPC);
+	if (!device)
+		return NULL;
+	return get_service_data(to_pcie_device(device));
+}
+
+void pci_save_dpc_state(struct pci_dev *dev)
+{
+	struct dpc_dev *dpc;
+	struct pci_cap_saved_state *save_state;
+	u16 *cap;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	dpc = to_dpc_dev(dev);
+	if (!dpc)
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
+	if (!save_state)
+		return;
+
+	cap = (u16 *)&save_state->cap.data[0];
+	pci_read_config_word(dev, dpc->cap_pos + PCI_EXP_DPC_CTL, cap);
+}
+
+void pci_restore_dpc_state(struct pci_dev *dev)
+{
+	struct dpc_dev *dpc;
+	struct pci_cap_saved_state *save_state;
+	u16 *cap;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	dpc = to_dpc_dev(dev);
+	if (!dpc)
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
+	if (!save_state)
+		return;
+
+	cap = (u16 *)&save_state->cap.data[0];
+	pci_write_config_word(dev, dpc->cap_pos + PCI_EXP_DPC_CTL, *cap);
+}
+
 static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
 {
 	unsigned long timeout = jiffies + HZ;
@@ -67,18 +119,13 @@ static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
 static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 {
 	struct dpc_dev *dpc;
-	struct pcie_device *pciedev;
-	struct device *devdpc;
-
 	u16 cap;
 
 	/*
 	 * DPC disables the Link automatically in hardware, so it has
 	 * already been reset by the time we get here.
 	 */
-	devdpc = pcie_port_find_device(pdev, PCIE_PORT_SERVICE_DPC);
-	pciedev = to_pcie_device(devdpc);
-	dpc = get_service_data(pciedev);
+	dpc = to_dpc_dev(pdev);
 	cap = dpc->cap_pos;
 
 	/*
@@ -259,6 +306,8 @@ static int dpc_probe(struct pcie_device *dev)
 		FLAG(cap, PCI_EXP_DPC_CAP_POISONED_TLP),
 		FLAG(cap, PCI_EXP_DPC_CAP_SW_TRIGGER), dpc->rp_log_size,
 		FLAG(cap, PCI_EXP_DPC_CAP_DL_ACTIVE));
+
+	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_DPC, sizeof(u16));
 	return status;
 }
 
-- 
2.14.4

