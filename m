Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6916D3E8324;
	Tue,  2 Jun 2026 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411259; cv=none; b=dtwidP6msyTRKWPPGs3qEjeLNbVh9HUFV+GhZsAPuO52W3OdJrFS72hGCnJdpJSpNAxLJvmvnH9M5e3LuUMVcIbUPj1h2zsz540prBfXDsOtkVM9OFlt8A58CjHku23KuAYzv9onnG1w8FIRLa9hYTkCpNrZWzNlFGTfJrakKJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411259; c=relaxed/simple;
	bh=8e8rTjY2sCpgocS1hgvqHRS9eJcHmKGHdyc3FaUWTOg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRO8WDnhRIjZKzOvjVVesNUGvL2W4pRBVR7/2U93fglTiBrCPHyxkMZa2LjjkAF/z0g7BjwezRnXW00sE6UNq7FIKD0zA27YMUwm99jj0tsS638AuEby8myYbSbdISaoHgp49oxHBrcSZUmz6GJRERqRDZE8Fc4ZX0MuusEjL14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=yyGd/wg1; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="yyGd/wg1"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=OhnJhMMBB0uI5/xzejauDqdYsC/OWRqbvve4UXw2OVw=;
	b=yyGd/wg1SJX04um5w/3pkFcFoOJBXLbSWRIXN3VcpXIvdrUjSmTIgrii3rC9wCe3Qvhl2LCQM
	uFvdQX3yRGYT7GdsTX8/P9sxP09sOHpuhV9f/Xu2tbxJodrq+JMRXFFg7PHeuOj7ynJGqOqF+t3
	CICiHU2Rmqz2IIt8BQp2S6g=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gVCwv5YRjzLlTC;
	Tue,  2 Jun 2026 22:33:03 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id D582740539;
	Tue,  2 Jun 2026 22:40:52 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Jun 2026 22:40:52 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<zhipingz@meta.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v15 10/10] vfio/pci: Virtualize PCIe TPH capability registers
Date: Tue, 2 Jun 2026 22:40:23 +0800
Message-ID: <20260602144023.25254-11-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260602144023.25254-1-fengchengwen@huawei.com>
References: <20260602144023.25254-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Implement TPH ext cap register virtualization:
1. Read: Mask EXT_TPH bit in vconfig if unsupported; mark CAP read-only
   virtual.
2. Write: Apply update to vconfig first then sync hardware via core TPH
   APIs. Sync shadow ST to HW after TPH enable with device power/memory
   check.

Disable stale TPH before save_state on open, disable active TPH before
restore on close to avoid cross-session leakage. Hide TPH cap entirely
unless enable_unsafe_tph is set.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_config.c | 106 +++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c   |  18 +++--
 2 files changed, 117 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index a10ed733f0e3..24614a4a5264 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -20,8 +20,10 @@
  * must be negotiated with the underlying OS.
  */
 
+#include <linux/bitfield.h>
 #include <linux/fs.h>
 #include <linux/pci.h>
+#include <linux/pci-tph.h>
 #include <linux/uaccess.h>
 #include <linux/vfio.h>
 #include <linux/slab.h>
@@ -35,6 +37,8 @@
 	((offset >= PCI_BASE_ADDRESS_0 && offset < PCI_BASE_ADDRESS_5 + 4) || \
 	 (offset >= PCI_ROM_ADDRESS && offset < PCI_ROM_ADDRESS + 4))
 
+extern bool enable_unsafe_tph;
+
 /*
  * Lengths of PCI Config Capabilities
  *   0: Removed from the user visible capability list
@@ -1085,6 +1089,100 @@ static int __init init_pci_ext_cap_pwr_perm(struct perm_bits *perm)
 	return 0;
 }
 
+/* Permissions for TPH extended capability */
+static int __init init_pci_ext_cap_tph_perm(struct perm_bits *perm)
+{
+	int i;
+
+	if (alloc_perm_bits(perm, pci_ext_cap_length[PCI_EXT_CAP_ID_TPH]))
+		return -ENOMEM;
+
+	p_setd(perm, PCI_TPH_CAP, ALL_VIRT, NO_WRITE);
+
+	p_setd(perm, PCI_TPH_CTRL, ALL_VIRT, ALL_WRITE);
+
+	/* According PCI specification: There is an upper limit of 64 entries
+	 * when the ST table is located in the TPH Requester Extended
+	 * Capability struction.
+	 * And the pci_ext_cap_length[PCI_EXT_CAP_ID_TPH] is 0xFF, so the
+	 * following operation is fine.
+	 */
+	for (i = 0; i < 64; i++)
+		p_setw(perm, PCI_TPH_BASE_SIZEOF + i * sizeof(u16),
+		       (u16)ALL_VIRT, (u16)ALL_WRITE);
+
+	return 0;
+}
+
+static void vfio_tph_vconfig_fill(struct vfio_pci_core_device *vdev, int pos)
+{
+	__le32 *vptr = (__le32 *)&vdev->vconfig[pos + PCI_TPH_CAP];
+	struct pci_dev *pdev = vdev->pdev;
+	u32 val;
+
+	if (!pdev->tph_ext_requester) {
+		val = le32_to_cpu(*vptr);
+		val &= ~PCI_TPH_CAP_EXT_TPH;
+		*vptr = cpu_to_le32(val);
+	}
+}
+
+static int vfio_tph_config_write(struct vfio_pci_core_device *vdev, int pos,
+				 int count, struct perm_bits *perm,
+				 int offset, __le32 val)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	bool extended;
+	u8 mode, req;
+	int i, ret;
+	u32 data;
+
+	if (!enable_unsafe_tph)
+		return count;
+
+	ret = vfio_default_config_write(vdev, pos, count, perm, offset, val);
+	if (ret != count)
+		return ret;
+
+	/*
+	 * TPH_CTRL (offset 8) register layout:
+	 *   Byte 0 (offset 8): Bits [2:0] - ST Mode selection
+	 *   Byte 1 (offset 9): Bits [1:0] - TPH Requester enable
+	 *
+	 * Only intercept writes with count >= 2 which cover both control
+	 * fields. Single-byte partial writes do not affect combined
+	 * configuration.
+	 */
+	if (offset != PCI_TPH_CTRL || count < 2)
+		return count;
+
+	ret = vfio_pci_set_power_state(vdev, PCI_D0);
+	if (ret)
+		return count;
+
+	mutex_lock(&vdev->tph_lock);
+
+	data = le32_to_cpu(val);
+	mode = FIELD_GET(PCI_TPH_CTRL_MODE_SEL_MASK, data);
+	req = FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, data);
+
+	if (req == PCI_TPH_REQ_TPH_ONLY || req == PCI_TPH_REQ_EXT_TPH) {
+		extended = !!(req == PCI_TPH_REQ_EXT_TPH);
+		ret = pcie_enable_tph_explicit(pdev, mode, extended);
+		if (!ret && vdev->tph_st_shadow) {
+			for (i = 0; i < vdev->tph_st_entries; i++)
+				pcie_tph_set_st_entry(pdev, i,
+						      vdev->tph_st_shadow[i]);
+		}
+	} else if (req == PCI_TPH_REQ_DISABLE) {
+		pcie_disable_tph(vdev->pdev);
+	}
+
+	mutex_unlock(&vdev->tph_lock);
+
+	return count;
+}
+
 /*
  * Initialize the shared permission tables
  */
@@ -1100,6 +1198,7 @@ void vfio_pci_uninit_perm_bits(void)
 
 	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_ERR]);
 	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
+	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_TPH]);
 }
 
 int __init vfio_pci_init_perm_bits(void)
@@ -1120,6 +1219,8 @@ int __init vfio_pci_init_perm_bits(void)
 	/* Extended capabilities */
 	ret |= init_pci_ext_cap_err_perm(&ecap_perms[PCI_EXT_CAP_ID_ERR]);
 	ret |= init_pci_ext_cap_pwr_perm(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
+	ret |= init_pci_ext_cap_tph_perm(&ecap_perms[PCI_EXT_CAP_ID_TPH]);
+	ecap_perms[PCI_EXT_CAP_ID_TPH].writefn = vfio_tph_config_write;
 	ecap_perms[PCI_EXT_CAP_ID_VNDR].writefn = vfio_raw_config_write;
 	ecap_perms[PCI_EXT_CAP_ID_DVSEC].writefn = vfio_raw_config_write;
 
@@ -1450,6 +1551,9 @@ static int vfio_ext_cap_len(struct vfio_pci_core_device *vdev, u16 ecap, u16 epo
 		byte &= PCI_DPA_CAP_SUBSTATE_MASK;
 		return PCI_DPA_BASE_SIZEOF + byte + 1;
 	case PCI_EXT_CAP_ID_TPH:
+		if (!enable_unsafe_tph || !pcie_tph_supported(pdev))
+			return 0;
+
 		ret = pci_read_config_dword(pdev, epos + PCI_TPH_CAP, &dword);
 		if (ret)
 			return pcibios_err_to_errno(ret);
@@ -1701,6 +1805,8 @@ static int vfio_ecap_init(struct vfio_pci_core_device *vdev)
 		ret = vfio_fill_vconfig_bytes(vdev, epos, len);
 		if (ret)
 			return ret;
+		if (ecap == PCI_EXT_CAP_ID_TPH && !hidden)
+			vfio_tph_vconfig_fill(vdev, epos);
 
 		/*
 		 * If we're just using this capability to anchor the list,
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 1c11549f71ec..bcce2b1ac266 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -42,7 +42,7 @@
 static bool nointxmask;
 static bool disable_vga;
 static bool disable_idle_d3;
-static bool enable_unsafe_tph;
+bool enable_unsafe_tph;
 
 static void vfio_pci_eventfd_rcu_free(struct rcu_head *rcu)
 {
@@ -596,6 +596,13 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 		goto out_disable_device;
 
 	vdev->reset_works = !ret;
+
+	/* Reset TPH status on new user session */
+	pcie_disable_tph(vdev->pdev);
+	ret = vfio_pci_tph_init(vdev);
+	if (ret)
+		goto out_disable_device;
+
 	pci_save_state(pdev);
 	vdev->pci_saved_state = pci_store_saved_state(pdev);
 	if (!vdev->pci_saved_state)
@@ -624,10 +631,6 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	if (ret)
 		goto out_free_zdev;
 
-	ret = vfio_pci_tph_init(vdev);
-	if (ret)
-		goto out_free_config;
-
 	msix_pos = pdev->msix_cap;
 	if (msix_pos) {
 		u16 flags;
@@ -652,13 +655,12 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 
 	return 0;
 
-out_free_config:
-	vfio_config_free(vdev);
 out_free_zdev:
 	vfio_pci_zdev_close_device(vdev);
 out_free_state:
 	kfree(vdev->pci_saved_state);
 	vdev->pci_saved_state = NULL;
+	vfio_pci_tph_deinit(vdev);
 out_disable_device:
 	pci_disable_device(pdev);
 out_power:
@@ -727,6 +729,8 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	kfree(vdev->region);
 	vdev->region = NULL; /* don't krealloc a freed pointer */
 
+	/* Reset TPH status on session exit */
+	pcie_disable_tph(vdev->pdev);
 	vfio_pci_tph_deinit(vdev);
 	vfio_config_free(vdev);
 
-- 
2.17.1

