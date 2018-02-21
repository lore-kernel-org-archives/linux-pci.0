Return-Path: <linux-kernel-owner@vger.kernel.org>
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
Subject: [PATCH v8 3/7] PCI/ERR: add mutex to synchronize recovery
Date: Wed, 21 Feb 2018 15:56:40 +0530
Message-Id: <1519208804-24512-4-git-send-email-poza@codeaurora.org>
In-Reply-To: <1519208804-24512-1-git-send-email-poza@codeaurora.org>
References: <1519208804-24512-1-git-send-email-poza@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch protects pci_do_recovery with mutex.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/pcie-err.c b/drivers/pci/pcie/pcie-err.c
index a532fe0..8318c84 100644
--- a/drivers/pci/pcie/pcie-err.c
+++ b/drivers/pci/pcie/pcie-err.c
@@ -20,6 +20,8 @@
 #include <linux/pcieport_if.h>
 #include "portdrv.h"
 
+static DEFINE_MUTEX(pci_err_recovery_lock);
+
 struct aer_broadcast_data {
 	enum pci_channel_state state;
 	enum pci_ers_result result;
@@ -283,6 +285,8 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
 	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
 	enum pci_channel_state state;
 
+	mutex_lock(&pci_err_recovery_lock);
+
 	if (severity == AER_FATAL)
 		state = pci_channel_io_frozen;
 	else
@@ -326,9 +330,11 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
 				report_resume);
 
 	dev_info(&dev->dev, "Device recovery successful\n");
+	mutex_unlock(&pci_err_recovery_lock);
 	return;
 
 failed:
 	/* TODO: Should kernel panic here? */
 	dev_info(&dev->dev, "Device recovery failed\n");
+	mutex_unlock(&pci_err_recovery_lock);
 }
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
