Return-Path: <SRS0=3ogL=DJ=linux.vnet.ibm.com=bryantly@kernel.org>
Return-Path: <SRS0=3ogL=DJ=linux.vnet.ibm.com=bryantly@kernel.org>
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
        alex.williamson@redhat.com, helgaas@kernel.org, aik@ozlabs.ru,
        ruscur@russell.cc, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
        saeedm@mellanox.com, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Subject: [PATCH v1 5/7] powerpc/kernel: Add EEH notify resume sysfs
Date: Wed, 13 Dec 2017 09:32:40 -0600
In-Reply-To: <20171213153242.98015-1-bryantly@linux.vnet.ibm.com>
References: <20171213153242.98015-1-bryantly@linux.vnet.ibm.com>
Message-Id: <20171213153242.98015-6-bryantly@linux.vnet.ibm.com>
List-ID: <linux-pci.vger.kernel.org>

Introduce a method for notify resume to be
called from sysfs. In this patch one can
now call notify resume from sysfs when
is supported by platform.

Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_sysfs.c | 46 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_sysfs.c b/arch/powerpc/kernel/eeh_sysfs.c
index 797549289798..344e7607f2e0 100644
--- a/arch/powerpc/kernel/eeh_sysfs.c
+++ b/arch/powerpc/kernel/eeh_sysfs.c
@@ -90,6 +90,38 @@ static ssize_t eeh_pe_state_store(struct device *dev,
 
 static DEVICE_ATTR_RW(eeh_pe_state);
 
+#ifdef CONFIG_PCI_IOV
+static ssize_t eeh_notify_resume_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
+	struct pci_dn *pdn = pci_get_pdn(pdev);
+
+	if (!edev || !edev->pe)
+		return -ENODEV;
+
+	pdn = pci_get_pdn(pdev);
+	return sprintf(buf, "%d\n", pdn->last_allow_rc);
+}
+
+static ssize_t eeh_notify_resume_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
+
+	if (!edev || !edev->pe)
+		return -ENODEV;
+
+	if (eeh_ops->notify_resume(pci_get_pdn(pdev)))
+		return -EIO;
+	return count;
+}
+static DEVICE_ATTR_RW(eeh_notify_resume);
+#endif
+
 void eeh_sysfs_add_device(struct pci_dev *pdev)
 {
 	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
@@ -104,7 +136,13 @@ void eeh_sysfs_add_device(struct pci_dev *pdev)
 	rc += device_create_file(&pdev->dev, &dev_attr_eeh_mode);
 	rc += device_create_file(&pdev->dev, &dev_attr_eeh_pe_config_addr);
 	rc += device_create_file(&pdev->dev, &dev_attr_eeh_pe_state);
-
+#ifdef CONFIG_PCI_IOV
+	if (of_get_property(pci_device_to_OF_node
+			    ((pdev->is_physfn ? pdev : pdev->physfn)),
+			    "ibm,is-open-sriov-pf", NULL))
+		rc += device_create_file(&pdev->dev,
+					 &dev_attr_eeh_notify_resume);
+#endif
 	if (rc)
 		pr_warn("EEH: Unable to create sysfs entries\n");
 	else if (edev)
@@ -128,6 +166,12 @@ void eeh_sysfs_remove_device(struct pci_dev *pdev)
 	device_remove_file(&pdev->dev, &dev_attr_eeh_mode);
 	device_remove_file(&pdev->dev, &dev_attr_eeh_pe_config_addr);
 	device_remove_file(&pdev->dev, &dev_attr_eeh_pe_state);
+#ifdef CONFIG_PCI_IOV
+	if (of_get_property(pci_device_to_OF_node
+			    ((pdev->is_physfn ? pdev : pdev->physfn)),
+			    "ibm,is-open-sriov-pf", NULL))
+		device_remove_file(&pdev->dev, &dev_attr_eeh_notify_resume);
+#endif
 
 	if (edev)
 		edev->mode &= ~EEH_DEV_SYSFS;
-- 
2.14.3 (Apple Git-98)
