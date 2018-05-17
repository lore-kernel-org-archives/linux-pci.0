Return-Path: <SRS0=92Ow=IE=qualcomm.com=poza@kernel.org>
Return-Path: <SRS0=92Ow=IE=qualcomm.com=poza@kernel.org>
From: Oza Pawandeep <poza@codeaurora.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>,
	Keith Busch <keith.busch@intel.com>,
	Wei Zhang <wzhang@fb.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>
Cc: Oza Pawandeep <poza@codeaurora.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v17 8/9] PCI/AER: Pass service type to pcie_do_fatal_recovery()
Date: Thu, 17 May 2018 03:43:10 -0400
Message-Id: <1526542991-5291-9-git-send-email-poza@codeaurora.org>
In-Reply-To: <1526542991-5291-1-git-send-email-poza@codeaurora.org>
References: <1526542991-5291-1-git-send-email-poza@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

Pass the service type to pcie_do_fatal_recovery() instead of assuming AER.
We will make DPC also use pcie_do_fatal_recovery(), and it needs to do
things a little differently for AER and DPC.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
[bhelgaas: split to separate patch]
Signed-off-by: Bjorn Helgaas <helgaas@kernel.org>

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5e8857a..6af7595 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -354,7 +354,7 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 void pci_enable_acs(struct pci_dev *dev);
 
 /* PCI error reporting and recovery */
-void pcie_do_fatal_recovery(struct pci_dev *dev);
+void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service);
 void pcie_do_nonfatal_recovery(struct pci_dev *dev);
 
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index fdfc474..36e622d 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -254,7 +254,7 @@ static void handle_error_source(struct pcie_device *aerdev,
 	} else if (info->severity == AER_NONFATAL)
 		pcie_do_nonfatal_recovery(dev);
 	else if (info->severity == AER_FATAL)
-		pcie_do_fatal_recovery(dev);
+		pcie_do_fatal_recovery(dev, PCIE_PORT_SERVICE_AER);
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
@@ -321,7 +321,7 @@ static void aer_recover_work_func(struct work_struct *work)
 		if (entry.severity == AER_NONFATAL)
 			pcie_do_nonfatal_recovery(pdev);
 		else if (entry.severity == AER_FATAL)
-			pcie_do_fatal_recovery(pdev);
+			pcie_do_fatal_recovery(pdev, PCIE_PORT_SERVICE_AER);
 		pci_dev_put(pdev);
 	}
 }
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index a1668e9..8d68cd7 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -180,7 +180,7 @@ static pci_ers_result_t default_reset_link(struct pci_dev *dev)
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-static pci_ers_result_t reset_link(struct pci_dev *dev)
+static pci_ers_result_t reset_link(struct pci_dev *dev, u32 service)
 {
 	struct pci_dev *udev;
 	pci_ers_result_t status;
@@ -195,7 +195,7 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
 	}
 
 	/* Use the aer driver of the component firstly */
-	driver = pcie_port_find_service(udev, PCIE_PORT_SERVICE_AER);
+	driver = pcie_port_find_service(udev, service);
 
 	if (driver && driver->reset_link) {
 		status = driver->reset_link(udev);
@@ -281,7 +281,7 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
  * beneath this AER agent, followed by reset link e.g. secondary bus reset
  * followed by re-enumeration of devices.
  */
-void pcie_do_fatal_recovery(struct pci_dev *dev)
+void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
 {
 	struct pci_dev *udev;
 	struct pci_bus *parent;
@@ -307,9 +307,10 @@ void pcie_do_fatal_recovery(struct pci_dev *dev)
 		pci_dev_put(pdev);
 	}
 
-	result = reset_link(udev);
+	result = reset_link(udev, service);
 
-	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+	if ((service == PCIE_PORT_SERVICE_AER) &&
+	    (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)) {
 		/*
 		 * If the error is reported by a bridge, we think this error
 		 * is related to the downstream link of the bridge, so we
-- 
2.7.4
