Return-Path: <SRS0=OVvK=DO=linux.vnet.ibm.com=bryantly@kernel.org>
Return-Path: <SRS0=OVvK=DO=linux.vnet.ibm.com=bryantly@kernel.org>
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
        alex.williamson@redhat.com, helgaas@kernel.org, aik@ozlabs.ru,
        ruscur@russell.cc, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
        saeedm@mellanox.com, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Subject: [PATCH v2 2/7] powerpc/kernel: Add uevents in EEH error/resume
Date: Mon, 18 Dec 2017 16:38:03 -0600
In-Reply-To: <20171218223808.83928-1-bryantly@linux.vnet.ibm.com>
References: <20171218223808.83928-1-bryantly@linux.vnet.ibm.com>
Message-Id: <20171218223808.83928-3-bryantly@linux.vnet.ibm.com>
List-ID: <linux-pci.vger.kernel.org>

Devices can go offline when EEH is reported. This patch adds
a change to the kernel object and lets udev know of error.
When device resumes a change is also set reporting device as
online. Therefore, EEH events are better propagated to user
space for devices in powerpc arch.

Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 3c0fa99c5533..9d4e8177c2e0 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -204,6 +204,7 @@ static void *eeh_report_error(void *data, void *userdata)
 	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
 	enum pci_ers_result rc, *res = userdata;
 	struct pci_driver *driver;
+	char *envp[] = {"EVENT=EEH_ERROR", "ONLINE=0", NULL};
 
 	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
 		return NULL;
@@ -228,6 +229,7 @@ static void *eeh_report_error(void *data, void *userdata)
 
 	edev->in_error = true;
 	eeh_pcid_put(dev);
+	kobject_uevent_env(&dev->dev.kobj, KOBJ_CHANGE, envp);
 	return NULL;
 }
 
@@ -358,6 +360,7 @@ static void *eeh_report_resume(void *data, void *userdata)
 	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
 	bool was_in_error;
 	struct pci_driver *driver;
+	char *envp[] = {"EVENT=EEH_RESUME", "ONLINE=1", NULL};
 
 	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
 		return NULL;
@@ -381,6 +384,7 @@ static void *eeh_report_resume(void *data, void *userdata)
 	driver->err_handler->resume(dev);
 
 	eeh_pcid_put(dev);
+	kobject_uevent_env(&dev->dev.kobj, KOBJ_CHANGE, envp);
 	return NULL;
 }
 
@@ -397,6 +401,7 @@ static void *eeh_report_failure(void *data, void *userdata)
 	struct eeh_dev *edev = (struct eeh_dev *)data;
 	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
 	struct pci_driver *driver;
+	char * envp[] = {"EVENT=EEH_PERMANENT_FAILURE", "ONLINE=0", NULL};
 
 	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
 		return NULL;
@@ -415,6 +420,7 @@ static void *eeh_report_failure(void *data, void *userdata)
 
 	driver->err_handler->error_detected(dev, pci_channel_io_perm_failure);
 
+	kobject_uevent_env(&dev->dev.kobj, KOBJ_CHANGE, envp);
 	eeh_pcid_put(dev);
 	return NULL;
 }
-- 
2.14.3 (Apple Git-98)
