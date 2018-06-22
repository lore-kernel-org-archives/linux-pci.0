Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:39596 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751325AbeFVJ6U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2018 05:58:20 -0400
From: Oza Pawandeep <poza@codeaurora.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Cc: Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH v2 2/6] PCI/AER: Clear uncorrectable fatal error status bits
Date: Fri, 22 Jun 2018 05:58:10 -0400
Message-Id: <1529661494-20936-3-git-send-email-poza@codeaurora.org>
In-Reply-To: <1529661494-20936-1-git-send-email-poza@codeaurora.org>
References: <1529661494-20936-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

During ERR_FATAL handling, AER calls pci_cleanup_aer_uncorrect_error_status
which should handle pci_channel_io_frozen case in order to determine if it
has to clear fatal bits.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d6cb1f0..e9c115d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -369,7 +369,12 @@ int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
 	/* Clean AER Root Error Status */
 	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
 	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &mask);
-	status &= ~mask; /* Clear corresponding nonfatal bits */
+
+	if (dev->error_state == pci_channel_io_normal)
+		status &= ~mask; /* Clear corresponding nonfatal bits */
+	else
+		status &= mask; /* Clear corresponding fatal bits */
+
 	if (status)
 		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
 
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index f7ce0cb..00d2875 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -288,6 +288,7 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
 	struct pci_dev *pdev, *temp;
 	pci_ers_result_t result;
 
+	dev->error_state = pci_channel_io_frozen;
 	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
 		udev = dev;
 	else
@@ -323,6 +324,7 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
 		if (pcie_wait_for_link(udev, true))
 			pci_rescan_bus(udev->bus);
 		pci_info(dev, "Device recovery from fatal error successful\n");
+		dev->error_state = pci_channel_io_normal;
 	} else {
 		pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
 		pci_info(dev, "Device recovery from fatal error failed\n");
-- 
2.7.4
