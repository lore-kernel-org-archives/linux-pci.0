Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Oza Pawandeep <poza@codeaurora.org>
To: linux-pci@vger.kernel.org,
	okaya@codeaurora.org,
	timur@codeaurora.org
Subject: [PATCH v2 4/4] PCI/AER: Dont do recovery when DPC is enabled
Date: Wed, 15 Nov 2017 10:26:48 +0530
Message-Id: <1510721808-27164-5-git-send-email-poza@codeaurora.org>
In-Reply-To: <1510721808-27164-1-git-send-email-poza@codeaurora.org>
References: <1510721808-27164-1-git-send-email-poza@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Oza Pawandeep <poza@codeaurora.org>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dongdong Liu <liudongdong3@huawei.com>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

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
not attempt to recover, since DPC will be removing downstream devices,
and do the recovery.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 7448052..a9108ea 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -482,6 +482,27 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
 }
 
 /**
+ * pcie_port_query_uptream_service - query upstream service
+ * @dev: pointer to a pci_dev data structure of agent detecting an error
+ * @service: service to be queried
+ *
+ * Invoked to know the status of the service for pci device.
+ */
+static bool pcie_port_query_uptream_service(struct pci_dev *dev, u32 service)
+{
+	struct pci_dev *upstream_dev = dev;
+
+	do {
+		if (pcie_port_query_service(upstream_dev, service))
+			return true;
+		upstream_dev = pcie_port_upstream_bridge(upstream_dev);
+	} while (upstream_dev);
+
+	return false;
+}
+
+
+/**
  * do_recovery - handle nonfatal/fatal error recovery process
  * @dev: pointer to a pci_dev data structure of agent detecting an error
  * @severity: error severity type
@@ -495,6 +516,18 @@ static void do_recovery(struct pci_dev *dev, int severity)
 	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
 	enum pci_channel_state state;
 
+	/*
+	 * If DPC is enabled, there is no need to attempt recovery.
+	 * Since DPC disables its Link by directing the LTSSM to
+	 * the Disabled state.
+	 * DPC driver will take care of the recovery, there is no need
+	 * for AER driver to race.
+	 */
+	if (pcie_port_query_uptream_service(dev, PCIE_PORT_SERVICE_DPC)) {
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


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
