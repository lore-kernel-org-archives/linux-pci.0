Return-Path: <SRS0=4BPp=EA=linux.vnet.ibm.com=bryantly@kernel.org>
Return-Path: <SRS0=4BPp=EA=linux.vnet.ibm.com=bryantly@kernel.org>
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
        alex.williamson@redhat.com, helgaas@kernel.org, aik@ozlabs.ru,
        ruscur@russell.cc, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
        saeedm@mellanox.com, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Subject: [PATCH v4 2/7] linux/pci: Add uevents in AER and EEH error/resume
Date: Fri,  5 Jan 2018 10:45:47 -0600
In-Reply-To: <20180105164552.36371-1-bryantly@linux.vnet.ibm.com>
References: <20180105164552.36371-1-bryantly@linux.vnet.ibm.com>
Message-Id: <20180105164552.36371-3-bryantly@linux.vnet.ibm.com>
List-ID: <linux-pci.vger.kernel.org>

Devices can go offline when erors reported. This
patch adds a change to the kernel object and lets udev
know of error. When device resumes, a change is also set
reporting device as online. Therefore, EEH and AER events
are better propagated to user space for PCI devices in
all arches.

Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/powerpc/kernel/eeh_driver.c   |  6 ++++++
 drivers/pci/pcie/aer/aerdrv_core.c |  3 +++
 include/linux/pci.h                | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 3c0fa99c5533..beea2182d754 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -228,6 +228,7 @@ static void *eeh_report_error(void *data, void *userdata)
 
 	edev->in_error = true;
 	eeh_pcid_put(dev);
+	pci_uevent_ers(dev, PCI_ERS_RESULT_NONE);
 	return NULL;
 }
 
@@ -381,6 +382,10 @@ static void *eeh_report_resume(void *data, void *userdata)
 	driver->err_handler->resume(dev);
 
 	eeh_pcid_put(dev);
+	pci_uevent_ers(dev, PCI_ERS_RESULT_RECOVERED);
+#ifdef CONFIG_PCI_IOV
+	eeh_ops->notify_resume(eeh_dev_to_pdn(edev));
+#endif
 	return NULL;
 }
 
@@ -416,6 +421,7 @@ static void *eeh_report_failure(void *data, void *userdata)
 	driver->err_handler->error_detected(dev, pci_channel_io_perm_failure);
 
 	eeh_pcid_put(dev);
+	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
 	return NULL;
 }
 
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 744805232155..8d7448063fd1 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -278,6 +278,7 @@ static int report_error_detected(struct pci_dev *dev, void *data)
 	} else {
 		err_handler = dev->driver->err_handler;
 		vote = err_handler->error_detected(dev, result_data->state);
+		pci_uevent_ers(dev, PCI_ERS_RESULT_NONE);
 	}
 
 	result_data->result = merge_result(result_data->result, vote);
@@ -341,6 +342,7 @@ static int report_resume(struct pci_dev *dev, void *data)
 
 	err_handler = dev->driver->err_handler;
 	err_handler->resume(dev);
+	pci_uevent_ers(dev, PCI_ERS_RESULT_RECOVERED);
 out:
 	device_unlock(&dev->dev);
 	return 0;
@@ -541,6 +543,7 @@ static void do_recovery(struct pci_dev *dev, int severity)
 	return;
 
 failed:
+	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
 	/* TODO: Should kernel panic here? */
 	dev_info(&dev->dev, "AER: Device recovery failed\n");
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e3e94467687a..405630441b74 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2277,6 +2277,42 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
 	return false;
 }
 
+/**
+ * pci_uevent_ers - emit a uevent during recovery path of pci device
+ * @pdev: pci device to check
+ * @err_type: type of error event
+ *
+ */
+static inline void pci_uevent_ers(struct pci_dev *pdev,
+				  enum  pci_ers_result err_type)
+{
+	int idx = 0;
+	char *envp[3];
+
+	switch (err_type) {
+	case PCI_ERS_RESULT_NONE:
+	case PCI_ERS_RESULT_CAN_RECOVER:
+		envp[idx++] = "ERROR_EVENT=BEGIN_RECOVERY";
+		envp[idx++] = "DEVICE_ONLINE=0";
+		break;
+	case PCI_ERS_RESULT_RECOVERED:
+		envp[idx++] = "ERROR_EVENT=SUCCESSFUL_RECOVERY";
+		envp[idx++] = "DEVICE_ONLINE=1";
+		break;
+	case PCI_ERS_RESULT_DISCONNECT:
+		envp[idx++] = "ERROR_EVENT=FAILED_RECOVERY";
+		envp[idx++] = "DEVICE_ONLINE=0";
+		break;
+	default:
+		break;
+	}
+
+	if (idx > 0) {
+		envp[idx++] = NULL;
+		kobject_uevent_env(&pdev->dev.kobj, KOBJ_CHANGE, envp);
+	}
+}
+
 /* provide the legacy pci_dma_* API */
 #include <linux/pci-dma-compat.h>
 
-- 
2.14.3 (Apple Git-98)
