Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [193.47.165.129] ([193.47.165.129]:33992 "EHLO mellanox.co.il"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S933308AbcBDI3q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Feb 2016 03:29:46 -0500
From: Ilya Lesokhin <ilyal@mellanox.com>
To: kvm@vger.kernel.org, linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	noaos@mellanox.com, haggaie@mellanox.com, ogerlitz@mellanox.com,
	liranl@mellanox.com, ilyal@mellanox.com
Subject: [RFC V2 4/4] VFIO: Add support for SRIOV extended capablity
Date: Thu,  4 Feb 2016 10:28:57 +0200
Message-Id: <1454574537-123466-5-git-send-email-ilyal@mellanox.com>
In-Reply-To: <1454574537-123466-1-git-send-email-ilyal@mellanox.com>
References: <1454574537-123466-1-git-send-email-ilyal@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add support for PCIE SRIOV extended capablity with following features:
1. The ability to probe SRIOV BAR sizes.
2. The ability to enable and disable sriov.

Signed-off-by: Ilya Lesokhin <ilyal@mellanox.com>
Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Signed-off-by: Haggai Eran <haggaie@mellanox.com>
---
 drivers/vfio/pci/vfio_pci_config.c | 169 +++++++++++++++++++++++++++++++++----
 1 file changed, 152 insertions(+), 17 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index ff75ca3..04e364f 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -420,6 +420,35 @@ static __le32 vfio_generate_bar_flags(struct pci_dev *pdev, int bar)
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
@@ -782,6 +811,124 @@ static int __init init_pci_ext_cap_pwr_perm(struct perm_bits *perm)
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
+
+		if (!cur_vf_enabled && vf_enabled) {
+			u16 num_vfs = *(u16 *)(vdev->vconfig +
+					cap_start +
+					PCI_SRIOV_NUM_VF);
+			ret = pci_enable_sriov(vdev->pdev, num_vfs);
+			if (ret)
+				return count;
+		} else if (cur_vf_enabled && !vf_enabled) {
+			pci_disable_sriov(vdev->pdev);
+		}
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
@@ -796,6 +943,7 @@ void vfio_pci_uninit_perm_bits(void)
 
 	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_ERR]);
 	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
+	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_SRIOV]);
 }
 
 int __init vfio_pci_init_perm_bits(void)
@@ -818,29 +966,16 @@ int __init vfio_pci_init_perm_bits(void)
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
-- 
1.8.3.1

