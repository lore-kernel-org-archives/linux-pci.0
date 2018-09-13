Return-Path: <SRS0=+cVB=L3=linux.ibm.com=sebott@kernel.org>
Return-Path: <SRS0=+cVB=L3=linux.ibm.com=sebott@kernel.org>
From: Sebastian Ott <sebott@linux.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org,
        Oliver OHalloran <oliveroh@au1.ibm.com>
Subject: [PATCH 1/2] pci: provide add_vfs/del_vfs callbacks
Date: Thu, 13 Sep 2018 14:41:23 +0200
In-Reply-To: <20180913124124.14632-1-sebott@linux.ibm.com>
References: <20180912130205.GG118330@bhelgaas-glaptop.roam.corp.google.com>
 <20180913124124.14632-1-sebott@linux.ibm.com>
Message-Id: <20180913124124.14632-2-sebott@linux.ibm.com>
List-ID: <linux-pci.vger.kernel.org>

Provide callbacks that can be used by PCI host bridge implementations
to override the behavior of the generic vf detection and device
creation code.

Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
---
 drivers/pci/iov.c   | 51 +++++++++++++++++++++++++++++++++++++++------------
 include/linux/pci.h |  2 ++
 2 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 0f04ae648cf1..b2ddfe30c5d8 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -251,6 +251,41 @@ int __weak pcibios_sriov_disable(struct pci_dev *pdev)
 	return 0;
 }
 
+static int pcibios_sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
+{
+	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
+	unsigned int i;
+	int rc;
+
+	if (bridge->add_vfs)
+		return bridge->add_vfs(dev, num_vfs);
+
+	for (i = 0; i < num_vfs; i++) {
+		rc = pci_iov_add_virtfn(dev, i);
+		if (rc)
+			goto failed;
+	}
+	return 0;
+failed:
+	while (i--)
+		pci_iov_remove_virtfn(dev, i);
+
+	return rc;
+}
+
+static void pcibios_sriov_del_vfs(struct pci_dev *dev)
+{
+	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
+	struct pci_sriov *iov = dev->sriov;
+	int i;
+
+	if (bridge->del_vfs)
+		return bridge->del_vfs(dev);
+
+	for (i = 0; i < iov->num_VFs; i++)
+		pci_iov_remove_virtfn(dev, i);
+}
+
 static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 {
 	int rc;
@@ -336,21 +371,15 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	msleep(100);
 	pci_cfg_access_unlock(dev);
 
-	for (i = 0; i < initial; i++) {
-		rc = pci_iov_add_virtfn(dev, i);
-		if (rc)
-			goto failed;
-	}
+	rc = pcibios_sriov_add_vfs(dev, initial);
+	if (rc)
+		goto err_pcibios;
 
 	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
 	iov->num_VFs = nr_virtfn;
 
 	return 0;
 
-failed:
-	while (i--)
-		pci_iov_remove_virtfn(dev, i);
-
 err_pcibios:
 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
 	pci_cfg_access_lock(dev);
@@ -369,14 +398,12 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 
 static void sriov_disable(struct pci_dev *dev)
 {
-	int i;
 	struct pci_sriov *iov = dev->sriov;
 
 	if (!iov->num_VFs)
 		return;
 
-	for (i = 0; i < iov->num_VFs; i++)
-		pci_iov_remove_virtfn(dev, i);
+	pcibios_sriov_del_vfs(dev);
 
 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
 	pci_cfg_access_lock(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 680b6bcd0b97..bf99ae98ecb5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -475,6 +475,8 @@ struct pci_host_bridge {
 	int (*free_irq)(struct pci_dev *);
 	void (*add_bus)(struct pci_bus *);
 	void (*remove_bus)(struct pci_bus *);
+	int (*add_vfs)(struct pci_dev *dev, u16 num_vfs);
+	void (*del_vfs)(struct pci_dev *dev);
 	void		*release_data;
 	struct msi_controller *msi;
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
-- 
2.13.4
