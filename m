Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [193.47.165.129] ([193.47.165.129]:38861 "EHLO mellanox.co.il"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751052AbcFIMNw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 9 Jun 2016 08:13:52 -0400
From: Ilya Lesokhin <ilyal@mellanox.com>
To: kvm@vger.kernel.org, linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	noaos@mellanox.com, haggaie@mellanox.com, ogerlitz@mellanox.com,
	liranl@mellanox.com, ilyal@mellanox.com
Subject: [PATCH 4/4] VFIO: Add support for SR-IOV extended capablity
Date: Thu,  9 Jun 2016 15:09:32 +0300
Message-Id: <1465474173-53960-5-git-send-email-ilyal@mellanox.com>
In-Reply-To: <1465474173-53960-1-git-send-email-ilyal@mellanox.com>
References: <1465474173-53960-1-git-send-email-ilyal@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add support for PCIE SR-IOV extended capablity with following features:
1. The ability to probe SR-IOV BAR sizes.
2. The ability to enable and disable SR-IOV.

Since pci_enable_sriov and pci_disable_sriov are not thread-safe
a new mutex was added to vfio_pci_device to protect those function.

Signed-off-by: Ilya Lesokhin <ilyal@mellanox.com>
Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Signed-off-by: Haggai Eran <haggaie@mellanox.com>
---
 drivers/vfio/pci/vfio_pci.c         |   1 +
 drivers/vfio/pci/vfio_pci_config.c  | 208 +++++++++++++++++++++++++++++++++---
 drivers/vfio/pci/vfio_pci_private.h |   1 +
 3 files changed, 193 insertions(+), 17 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 72d048e..4fb2a93 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1151,6 +1151,7 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	vdev->pdev = pdev;
 	vdev->irq_type = VFIO_PCI_NUM_IRQS;
 	mutex_init(&vdev->igate);
+	mutex_init(&vdev->sriov_mutex);
 	spin_lock_init(&vdev->irqlock);
 
 	ret = vfio_add_group_dev(&pdev->dev, &vfio_pci_ops, vdev);
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 688691d..cea1503 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -448,6 +448,35 @@ static __le32 vfio_generate_bar_flags(struct pci_dev *pdev, int bar)
 	return cpu_to_le32(val);
 }
 
+static void vfio_sriov_bar_fixup(struct vfio_pci_device *vdev,
+				 int sriov_cap_start)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	int i;
+	__le32 *bar;
+	u64 mask;
+
+	bar = (__le32 *)&vdev->vconfig[sriov_cap_start + PCI_SRIOV_BAR];
+
+	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++, bar++) {
+		if (!pci_resource_start(pdev, i)) {
+			*bar = 0; /* Unmapped by host = unimplemented to user */
+			continue;
+		}
+
+		mask = ~(pci_iov_resource_size(pdev, i) - 1);
+
+		*bar &= cpu_to_le32((u32)mask);
+		*bar |= vfio_generate_bar_flags(pdev, i);
+
+		if (*bar & cpu_to_le32(PCI_BASE_ADDRESS_MEM_TYPE_64)) {
+			bar++;
+			*bar &= cpu_to_le32((u32)(mask >> 32));
+			i++;
+		}
+	}
+}
+
 /*
  * Pretend we're hardware and tweak the values of the *virtual* PCI BARs
  * to reflect the hardware capabilities.  This implements BAR sizing.
@@ -901,6 +930,163 @@ static int __init init_pci_ext_cap_pwr_perm(struct perm_bits *perm)
 	return 0;
 }
 
+static int __init init_pci_ext_cap_sriov_perm(struct perm_bits *perm)
+{
+	int i;
+
+	if (alloc_perm_bits(perm, pci_ext_cap_length[PCI_EXT_CAP_ID_SRIOV]))
+		return -ENOMEM;
+
+	/*
+	 * Virtualize the first dword of all express capabilities
+	 * because it includes the next pointer.  This lets us later
+	 * remove capabilities from the chain if we need to.
+	 */
+	p_setd(perm, 0, ALL_VIRT, NO_WRITE);
+
+	/* VF Enable - Virtualized and writable
+	 * Memory Space Enable - Non-virtualized and writable
+	 */
+	p_setw(perm, PCI_SRIOV_CTRL, PCI_SRIOV_CTRL_VFE,
+	       PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
+
+	p_setw(perm, PCI_SRIOV_NUM_VF, (u16)ALL_VIRT, (u16)ALL_WRITE);
+	p_setw(perm, PCI_SRIOV_SUP_PGSIZE, (u16)ALL_VIRT, 0);
+
+	/* We cannot let user space application change the page size
+	 * so we mark it as read only and trust the user application
+	 * (e.g. qemu) to virtualize this correctly for the guest
+	 */
+	p_setw(perm, PCI_SRIOV_SYS_PGSIZE, (u16)ALL_VIRT, 0);
+
+	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
+		p_setd(perm, PCI_SRIOV_BAR + 4 * i, ALL_VIRT, ALL_WRITE);
+
+	return 0;
+}
+
+static int vfio_find_cap_start(struct vfio_pci_device *vdev, int pos)
+{
+	u8 cap;
+	int base = (pos >= PCI_CFG_SPACE_SIZE) ? PCI_CFG_SPACE_SIZE :
+						 PCI_STD_HEADER_SIZEOF;
+	cap = vdev->pci_config_map[pos];
+
+	if (cap == PCI_CAP_ID_BASIC)
+		return 0;
+
+	/* XXX Can we have to abutting capabilities of the same type? */
+	while (pos - 1 >= base && vdev->pci_config_map[pos - 1] == cap)
+		pos--;
+
+	return pos;
+}
+
+static int vfio_sriov_cap_config_read(struct vfio_pci_device *vdev, int pos,
+				      int count, struct perm_bits *perm,
+				       int offset, __le32 *val)
+{
+	int cap_start = vfio_find_cap_start(vdev, pos);
+
+	vfio_sriov_bar_fixup(vdev, cap_start);
+	return vfio_default_config_read(vdev, pos, count, perm, offset, val);
+}
+
+struct disable_sriov_data {
+	struct work_struct work;
+	struct vfio_pci_device *vdev;
+};
+
+static void vfio_disable_sriov_work(struct work_struct *work)
+{
+	struct disable_sriov_data *data =
+		container_of(work, struct disable_sriov_data, work);
+
+	mutex_lock(&data->vdev->sriov_mutex);
+	pci_disable_sriov(data->vdev->pdev);
+	mutex_unlock(&data->vdev->sriov_mutex);
+}
+
+/* pci_disable_sriov may block waiting for all the VF drivers to unload.
+ * As a result, If a process was allowed to call pci_disable_sriov()
+ * directly it could become unkillable by calling pci_disable_sriov()
+ * while holding a reference to one of the VFs.
+ * To address this issue we to the call to pci_disable_sriov
+ * on a kernel thread the can't hold references on the VFs.
+ */
+static inline int vfio_disable_sriov(struct vfio_pci_device *vdev)
+{
+	struct disable_sriov_data *data = kmalloc(sizeof(*data), GFP_USER);
+
+	if (!data)
+		return -ENOMEM;
+
+	INIT_WORK(&data->work, vfio_disable_sriov_work);
+	data->vdev = vdev;
+
+	schedule_work(&data->work);
+	return 0;
+}
+
+static int vfio_sriov_cap_config_write(struct vfio_pci_device *vdev, int pos,
+				       int count, struct perm_bits *perm,
+				       int offset, __le32 val)
+{
+	int ret;
+	int cap_start = vfio_find_cap_start(vdev, pos);
+	u16 sriov_ctrl = *(u16 *)(vdev->vconfig + cap_start + PCI_SRIOV_CTRL);
+	bool cur_vf_enabled = sriov_ctrl & PCI_SRIOV_CTRL_VFE;
+	bool vf_enabled;
+
+	switch (offset) {
+	case  PCI_SRIOV_NUM_VF:
+	/* Per SR-IOV spec sec 3.3.10 and 3.3.11, First VF Offset
+	 * and VF Stride may change when NumVFs changes.
+	 *
+	 * Therefore we should pass valid writes to the hardware.
+	 *
+	 * Per SR-IOV spec sec 3.3.7
+	 * The results are undefined if NumVFs is set to a value greater
+	 * than TotalVFs.
+	 * NumVFs may only be written while VF Enable is Clear.
+	 * If NumVFs is written when VF Enable is Set, the results
+	 * are undefined.
+
+	 * Avoid passing such writes to the Hardware just in case.
+	 */
+		if (cur_vf_enabled ||
+		    val > pci_sriov_get_totalvfs(vdev->pdev))
+			return count;
+
+		pci_iov_set_numvfs(vdev->pdev, val);
+		break;
+
+	case PCI_SRIOV_CTRL:
+		vf_enabled = val & PCI_SRIOV_CTRL_VFE;
+		ret = 0;
+
+		if (!cur_vf_enabled && vf_enabled) {
+			u16 num_vfs = *(u16 *)(vdev->vconfig +
+					cap_start +
+					PCI_SRIOV_NUM_VF);
+			mutex_lock(&vdev->sriov_mutex);
+			ret = pci_enable_sriov(vdev->pdev, num_vfs);
+			mutex_unlock(&vdev->sriov_mutex);
+		} else if (cur_vf_enabled && !vf_enabled) {
+			ret = vfio_disable_sriov(vdev);
+		}
+		if (ret)
+			return ret;
+		break;
+
+	default:
+		break;
+	}
+
+	return vfio_default_config_write(vdev, pos, count, perm,
+					 offset, val);
+}
+
 /*
  * Initialize the shared permission tables
  */
@@ -916,6 +1102,7 @@ void vfio_pci_uninit_perm_bits(void)
 
 	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_ERR]);
 	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
+	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_SRIOV]);
 }
 
 int __init vfio_pci_init_perm_bits(void)
@@ -938,29 +1125,16 @@ int __init vfio_pci_init_perm_bits(void)
 	ret |= init_pci_ext_cap_pwr_perm(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
 	ecap_perms[PCI_EXT_CAP_ID_VNDR].writefn = vfio_raw_config_write;
 
+	ret |= init_pci_ext_cap_sriov_perm(&ecap_perms[PCI_EXT_CAP_ID_SRIOV]);
+	ecap_perms[PCI_EXT_CAP_ID_SRIOV].readfn = vfio_sriov_cap_config_read;
+	ecap_perms[PCI_EXT_CAP_ID_SRIOV].writefn = vfio_sriov_cap_config_write;
+
 	if (ret)
 		vfio_pci_uninit_perm_bits();
 
 	return ret;
 }
 
-static int vfio_find_cap_start(struct vfio_pci_device *vdev, int pos)
-{
-	u8 cap;
-	int base = (pos >= PCI_CFG_SPACE_SIZE) ? PCI_CFG_SPACE_SIZE :
-						 PCI_STD_HEADER_SIZEOF;
-	cap = vdev->pci_config_map[pos];
-
-	if (cap == PCI_CAP_ID_BASIC)
-		return 0;
-
-	/* XXX Can we have to abutting capabilities of the same type? */
-	while (pos - 1 >= base && vdev->pci_config_map[pos - 1] == cap)
-		pos--;
-
-	return pos;
-}
-
 static int vfio_msi_config_read(struct vfio_pci_device *vdev, int pos,
 				int count, struct perm_bits *perm,
 				int offset, __le32 *val)
diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index 016c14a..3be9a61 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -88,6 +88,7 @@ struct vfio_pci_device {
 	int			refcnt;
 	struct eventfd_ctx	*err_trigger;
 	struct eventfd_ctx	*req_trigger;
+	struct mutex		sriov_mutex;
 };
 
 #define is_intx(vdev) (vdev->irq_type == VFIO_PCI_INTX_IRQ_INDEX)
-- 
1.8.3.1

