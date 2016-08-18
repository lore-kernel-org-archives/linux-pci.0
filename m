Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:59493 "EHLO
	mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753534AbcHRH3j (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2016 03:29:39 -0400
From: Ilya Lesokhin <ilyal@mellanox.com>
To: kvm@vger.kernel.org, linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	noaos@mellanox.com, haggaie@mellanox.com, ogerlitz@mellanox.com,
	liranl@mellanox.com, ilyal@mellanox.com
Subject: [PATCH V3 3/3] vfio/pci: Add support for SR-IOV extended capablity
Date: Thu, 18 Aug 2016 10:29:17 +0300
Message-Id: <1471505357-78110-4-git-send-email-ilyal@mellanox.com>
In-Reply-To: <1471505357-78110-1-git-send-email-ilyal@mellanox.com>
References: <1471505357-78110-1-git-send-email-ilyal@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add support for PCIE SR-IOV extended capability.
The capability gives the VFIO user the following abilities:
1. Detect that the device has an SR-IOV capability
2. Change sriov_numvfs and read the corresponding changes in
sriov_vf_offset and sriov_vf_stride
3. Probe vf bar sizes

Enabling and disable sriov is still done through the sysfs interface

Signed-off-by: Ilya Lesokhin <ilyal@mellanox.com>
Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Signed-off-by: Haggai Eran <haggaie@mellanox.com>
---
 drivers/vfio/pci/vfio_pci.c         |  23 +++++-
 drivers/vfio/pci/vfio_pci_config.c  | 151 ++++++++++++++++++++++++++++++++----
 drivers/vfio/pci/vfio_pci_private.h |   2 +
 3 files changed, 157 insertions(+), 19 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 6a203a7..807caf2c 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1229,6 +1229,7 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	vdev->irq_type = VFIO_PCI_NUM_IRQS;
 	mutex_init(&vdev->igate);
 	spin_lock_init(&vdev->irqlock);
+	mutex_init(&vdev->sriov_mutex);
 
 	ret = vfio_add_group_dev(&pdev->dev, &vfio_pci_ops, vdev);
 	if (ret) {
@@ -1317,14 +1318,32 @@ static const struct pci_error_handlers vfio_err_handlers = {
 
 static int vfio_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
 {
+	struct vfio_pci_device *vdev;
+	struct vfio_device *device;
+	int ret = 0;
+
+	device = vfio_device_get_from_dev(&pdev->dev);
+	if (!device)
+		return -EINVAL;
+
+	vdev = vfio_device_data(device);
+	if (!vdev) {
+		vfio_device_put(device);
+		return -EINVAL;
+	}
+
+	mutex_lock(&vdev->sriov_mutex);
 	if (!num_vfs) {
 		pci_disable_sriov(pdev);
-		return 0;
+		goto out;
 	}
 
-	return pci_enable_sriov_with_override(pdev,
+	ret =  pci_enable_sriov_with_override(pdev,
 					      num_vfs,
 					     "vfio-pci");
+out:
+	mutex_unlock(&vdev->sriov_mutex);
+	return ret;
 }
 
 static struct pci_driver vfio_pci_driver = {
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 688691d..6c813d3 100644
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
@@ -901,6 +930,106 @@ static int __init init_pci_ext_cap_pwr_perm(struct perm_bits *perm)
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
+	p_setw(perm, PCI_SRIOV_CTRL, NO_VIRT,
+	       PCI_SRIOV_CTRL_MSE);
+
+	p_setw(perm, PCI_SRIOV_NUM_VF, (u16)NO_VIRT, (u16)ALL_WRITE);
+	p_setw(perm, PCI_SRIOV_SUP_PGSIZE, (u16)ALL_VIRT, NO_WRITE);
+
+	/* We cannot let user space application change the page size
+	 * so we mark it as read only and trust the user application
+	 * (e.g. qemu) to virtualize this correctly for the guest
+	 */
+	p_setw(perm, PCI_SRIOV_SYS_PGSIZE, (u16)ALL_VIRT, NO_WRITE);
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
+				      int offset, __le32 *val)
+{
+	int cap_start = vfio_find_cap_start(vdev, pos);
+
+	vfio_sriov_bar_fixup(vdev, cap_start);
+	return vfio_default_config_read(vdev, pos, count, perm, offset, val);
+}
+
+static int vfio_sriov_cap_config_write(struct vfio_pci_device *vdev, int pos,
+				       int count, struct perm_bits *perm,
+				       int offset, __le32 val)
+{
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
+		mutex_lock(&vdev->sriov_mutex);
+		if (pci_num_vf(vdev->pdev) ||
+		    val > pci_sriov_get_totalvfs(vdev->pdev)) {
+			mutex_unlock(&vdev->sriov_mutex);
+			return count;
+		}
+
+		pci_iov_set_numvfs(vdev->pdev, val);
+		mutex_unlock(&vdev->sriov_mutex);
+		break;
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
@@ -916,6 +1045,7 @@ void vfio_pci_uninit_perm_bits(void)
 
 	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_ERR]);
 	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
+	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_SRIOV]);
 }
 
 int __init vfio_pci_init_perm_bits(void)
@@ -938,29 +1068,16 @@ int __init vfio_pci_init_perm_bits(void)
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
index 2128de8..02732eb 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -96,6 +96,8 @@ struct vfio_pci_device {
 	struct eventfd_ctx	*err_trigger;
 	struct eventfd_ctx	*req_trigger;
 	struct list_head	dummy_resources_list;
+	struct mutex		sriov_mutex;
+
 };
 
 #define is_intx(vdev) (vdev->irq_type == VFIO_PCI_INTX_IRQ_INDEX)
-- 
1.8.3.1

