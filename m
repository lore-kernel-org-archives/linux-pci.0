Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55376 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758022AbdCUX4C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2017 19:56:02 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v2LNroYi112046
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2017 19:55:51 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
        by mx0a-001b2d01.pphosted.com with ESMTP id 29b9vqajwa-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2017 19:55:50 -0400
Received: from localhost
        by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
        Wed, 22 Mar 2017 09:55:48 +1000
Date: Wed, 22 Mar 2017 10:54:49 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: bodong@mellanox.com
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, saeedm@mellanox.com,
        Eli Cohen <eli@mellanox.com>
Subject: Re: [V1,1/1] pci/sriov: Add an option to probe VFs or not before
 enabling SR-IOV
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1490125247-83685-1-git-send-email-bodong@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490125247-83685-1-git-send-email-bodong@mellanox.com>
Message-Id: <20170321235449.GC3972@gwshan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 21, 2017 at 09:40:47PM +0200, bodong@mellanox.com wrote:
>From: Bodong Wang <bodong@mellanox.com>
>
>Sometimes it is not desirable to probe the virtual functions after
>SRIOV is enabled. This can save host side resource usage by VF
>instances which would be eventually probed to VMs.
>
>Added a new PCI sysfs interface "sriov_probe_vfs" to control that
>from PF, all current callers still retain the same functionality.
>To modify it, echo 0/n/N (disable probe) or 1/y/Y (enable probe) to
>
>/sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_probe_vfs
>
>Note that, the choice must be made before enabling VFs. The change
>will not take effect if VFs are already enabled. Simply, one can set
>sriov_numvfs to 0, choose whether to probe or not, and then resume
>sriov_numvfs.
>
>Signed-off-by: Bodong Wang <bodong@mellanox.com>
>Signed-off-by: Eli Cohen <eli@mellanox.com>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

The subject would be [PATCH v2 xxx]. Some minor comments as below.

>---
> Documentation/PCI/pci-iov-howto.txt | 10 ++++++++++
> drivers/pci/iov.c                   |  1 +
> drivers/pci/pci-driver.c            | 23 +++++++++++++++++++----
> drivers/pci/pci-sysfs.c             | 28 ++++++++++++++++++++++++++++
> drivers/pci/pci.h                   |  1 +
> 5 files changed, 59 insertions(+), 4 deletions(-)
>
>diff --git a/Documentation/PCI/pci-iov-howto.txt b/Documentation/PCI/pci-iov-howto.txt
>index 2d91ae2..902a528 100644
>--- a/Documentation/PCI/pci-iov-howto.txt
>+++ b/Documentation/PCI/pci-iov-howto.txt
>@@ -68,6 +68,16 @@ To disable SR-IOV capability:
> 	echo  0 > \
>         /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_numvfs
>
>+To enable probing VFs by a compatible driver on the host:
>+Before enabling SR-IOV capabilities, do:
>+	echo 1 > \
>+        /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_probe_vfs
>+
>+To disable probing VFs by a compatible driver on the host:
>+Before enabling SR-IOV capabilities, do:
>+	echo  0 > \
>+        /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_probe_vfs
>+
> 3.2 Usage example
>
> Following piece of code illustrates the usage of the SR-IOV API.
>diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>index 2479ae8..70691de 100644
>--- a/drivers/pci/iov.c
>+++ b/drivers/pci/iov.c
>@@ -450,6 +450,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
> 	iov->total_VFs = total;
> 	iov->pgsz = pgsz;
> 	iov->self = dev;
>+	iov->probe_vfs = true;
> 	pci_read_config_dword(dev, pos + PCI_SRIOV_CAP, &iov->cap);
> 	pci_read_config_byte(dev, pos + PCI_SRIOV_FUNC_LINK, &iov->link);
> 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END)
>diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>index afa7271..cc3a479 100644
>--- a/drivers/pci/pci-driver.c
>+++ b/drivers/pci/pci-driver.c
>@@ -394,6 +394,18 @@ void __weak pcibios_free_irq(struct pci_dev *dev)
> {
> }
>
>+#ifdef CONFIG_PCI_IOV
>+static inline bool pci_device_can_probe(struct pci_dev *pdev)
>+{
>+	return (!pdev->is_virtfn || pdev->physfn->sriov->probe_vfs);
>+}
>+#else
>+static inline bool pci_device_can_probe(struct pci_dev *pdev)
>+{
>+	return true;
>+}
>+#endif
>+
> static int pci_device_probe(struct device *dev)
> {
> 	int error;
>@@ -405,10 +417,13 @@ static int pci_device_probe(struct device *dev)
> 		return error;
>
> 	pci_dev_get(pci_dev);
>-	error = __pci_device_probe(drv, pci_dev);
>-	if (error) {
>-		pcibios_free_irq(pci_dev);
>-		pci_dev_put(pci_dev);
>+

It seems this blank line isn't needed.

>+	if (pci_device_can_probe(pci_dev)) {
>+		error = __pci_device_probe(drv, pci_dev);
>+		if (error) {
>+			pcibios_free_irq(pci_dev);
>+			pci_dev_put(pci_dev);
>+		}
> 	}
>
> 	return error;
>diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>index 25d010d..1d5b89d 100644
>--- a/drivers/pci/pci-sysfs.c
>+++ b/drivers/pci/pci-sysfs.c
>@@ -526,10 +526,37 @@ static ssize_t sriov_numvfs_store(struct device *dev,
> 	return count;
> }
>
>+static ssize_t sriov_probe_vfs_show(struct device *dev,
>+				    struct device_attribute *attr,
>+				    char *buf)
>+{
>+	struct pci_dev *pdev = to_pci_dev(dev);
>+
>+	return sprintf(buf, "%u\n", pdev->sriov->probe_vfs);
>+}
>+
>+static ssize_t sriov_probe_vfs_store(struct device *dev,
>+				     struct device_attribute *attr,
>+				     const char *buf, size_t count)
>+{
>+	struct pci_dev *pdev = to_pci_dev(dev);
>+	bool probe_vfs;
>+
>+	if (kstrtobool(buf, &probe_vfs) < 0)
>+		return -EINVAL;
>+
>+	pdev->sriov->probe_vfs = probe_vfs;
>+
>+	return count;
>+}
>+
> static struct device_attribute sriov_totalvfs_attr = __ATTR_RO(sriov_totalvfs);
> static struct device_attribute sriov_numvfs_attr =
> 		__ATTR(sriov_numvfs, (S_IRUGO|S_IWUSR|S_IWGRP),
> 		       sriov_numvfs_show, sriov_numvfs_store);
>+static struct device_attribute sriov_probe_vfs_attr =
>+		__ATTR(sriov_probe_vfs, (S_IRUGO|S_IWUSR|S_IWGRP),
>+		       sriov_probe_vfs_show, sriov_probe_vfs_store);
> #endif /* CONFIG_PCI_IOV */
>
> static ssize_t driver_override_store(struct device *dev,
>@@ -1549,6 +1576,7 @@ static umode_t pci_dev_hp_attrs_are_visible(struct kobject *kobj,
> static struct attribute *sriov_dev_attrs[] = {
> 	&sriov_totalvfs_attr.attr,
> 	&sriov_numvfs_attr.attr,
>+	&sriov_probe_vfs_attr.attr,
> 	NULL,
> };
>
>diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>index 8dd38e6..a62c6bf 100644
>--- a/drivers/pci/pci.h
>+++ b/drivers/pci/pci.h
>@@ -272,6 +272,7 @@ struct pci_sriov {
> 	struct pci_dev *self;	/* this PF */
> 	struct mutex lock;	/* lock for setting sriov_numvfs in sysfs */
> 	resource_size_t barsz[PCI_SRIOV_NUM_BARS];	/* VF BAR size */
>+	bool probe_vfs;		/* probe VFs or not */

It could be a bit clearer:      /* Load driver for VFs or not */

> };
>
> #ifdef CONFIG_PCI_ATS

Thanks,
Gavin
