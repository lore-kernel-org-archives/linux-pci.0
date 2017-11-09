Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:32828 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbdKIUr1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Nov 2017 15:47:27 -0500
From: Pawandeep Oza <poza@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH 4/4] PCI/AER: Dont do recovery when DPC is enabled
Date: Fri, 10 Nov 2017 02:16:39 +0530
Message-Id: <1510260399-14886-5-git-send-email-poza@codeaurora.org>
In-Reply-To: <1510260399-14886-1-git-send-email-poza@codeaurora.org>
References: <1510260399-14886-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Oza Pawandeep <poza@codeaurora.org>

PCI Express Base Specification, Rev. 4.0 Version 0.9
6.2.10: Downstream Port Containment (DPC)

DPC is an optional normative feature of a Downstream Port. DPC halts PCI
Express traffic below a Downstream Port after an unmasked uncorrectable
error is detected at or below the Port, avoiding the potential spread of
any data corruption, and permitting error recovery if supported by
software

Triggering DPC disables its Link by directing the LTSSM to the Disabled
state. Once the LTSSM reaches the Disabled state, it remains in that
state until the DPC Trigger Status bit is Cleared

So when DPC service is active and registered to port driver, AER should
not attempt to recover, since DPC will be removing downstream devices.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 7448052..8d48d5c 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -495,6 +495,18 @@ static void do_recovery(struct pci_dev *dev, int severity)
 	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
 	enum pci_channel_state state;
 
+	/*
+	 * If DPC is enabled, there is no need to attempt recovery.
+	 * Since DPC disables its Link by directing the LTSSM to
+	 * the Disabled state.
+	 * DPC driver will take care of the recovery, there is no need
+	 * for AER driver to race.
+	 */
+	if (pcie_port_query_service(dev, PCIE_PORT_SERVICE_DPC)) {
+		dev_info(&dev->dev, "AER: Device recovery to be done by DPC\n");
+		return;
+	}
+
 	if (severity == AER_FATAL)
 		state = pci_channel_io_frozen;
 	else
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
