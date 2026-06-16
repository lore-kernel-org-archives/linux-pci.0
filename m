Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BE542EED1;
	Tue, 16 Jun 2026 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781606799; cv=none; b=dXOPjgYfO+IWpoXrDJwI+WzN+loOP3MFIB7dASVSrEqxe9zILNjyfnJdKlLOjrguFZ/Z/+KDdFSNACkfqfNttIR4SXUv8vf9uOsmCGDcaCR1tBkgplrBajOzrVrZp0uoA03hu2T4ANbZ5yU/NnT+lM+Wd9tb4fnvO+EbFNK8IMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781606799; c=relaxed/simple;
	bh=MLEo3xsDD0Knwbo5JwEyeyHdhTLgFZMl4IcGmR6+yTo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2AQzTUgotnsefOVr1xHdWdhwk87mCXbPwL+lCIZx+52QQL8FRPuvN4lPQcT5T5jbbD0l1ivH22HtgQz/4PlBUdvkpXVKHJDcrIGkFZS6+Fmnxg4sVbgNMOH6GYimBFB0nqkPpMKMDLIiSdeE1QPFul/CXAI2DmDgetRe4L7bUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=mr6jtKMh; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="mr6jtKMh"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wW+xK9mqFWHDSHiALmkMGwsXlvoPOU0Pu9C+fHVfdGU=;
	b=mr6jtKMh2HdkHOBwLcwzynJLeAVsLiplYNswzFAaPswx4gsFpkR5yzTNj4PWgInYWecAqTXfa
	gnwHABVFc7ReLgpo+jjQZTst9A0U1mou86wjcRpP0/enk+bIBeXDVTOvQ9GRJxfsvoUqFJVAipw
	ERPC6EkuT+3opkJ67l5wCmc=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gfk3w49ZBz1K98T;
	Tue, 16 Jun 2026 18:38:36 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 3736440562;
	Tue, 16 Jun 2026 18:46:33 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Jun 2026 18:46:32 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v17 12/12] vfio/pci: Virtualize PCIe TPH capability registers
Date: Tue, 16 Jun 2026 18:46:21 +0800
Message-ID: <20260616104621.41915-13-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260616104621.41915-1-fengchengwen@huawei.com>
References: <20260616104621.41915-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Virtualize TPH extended capability config space registers:
- Original TPH capability was fully read-only; now split permission:
  TPH_CAP header remains read-only, TPH_CTRL register supports write to
  toggle TPH requester enable mode.
- Block direct ST-table programming via config space write access: all ST
  entry configuration is restricted to VFIO_DEVICE_FEATURE_TPH_ST_CONFIG
  feature exclusively after userspace SET TPH_ENABLE opt-in.
- Backup original virtual config value and revert vconfig if hardware TPH
  enable operation fails or invalid requester mode is configured.
- After TPH requester gets enabled via CTRL write, sync cached shadow ST
  table down to physical hardware with memory_lock protection and PCI D0
  power check.

Add vconfig masking to hide EXT_TPH capability bit if underlying hardware
does not support extended TPH via new vfio_tph_mask_ext_tph_bit helper.
Reset hardware TPH state on device open/close to eliminate cross-session
TPH configuration leakage between different VM lifecycles.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_config.c | 117 +++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c   |   4 +
 2 files changed, 121 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 251d3ec7fdd4..1fcb53803b64 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1086,6 +1086,118 @@ static int __init init_pci_ext_cap_pwr_perm(struct perm_bits *perm)
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
+	p_setd(perm, 0, ALL_VIRT, NO_WRITE);
+	p_setd(perm, PCI_TPH_CAP, ALL_VIRT, NO_WRITE);
+
+	p_setd(perm, PCI_TPH_CTRL, ALL_VIRT, ALL_WRITE);
+
+	/* Per PCI specification: There is an upper limit of 64 entries
+	 * when the ST table is located in the TPH Requester Extended
+	 * Capability structure.
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
+static void vfio_tph_mask_ext_tph_bit(struct vfio_pci_core_device *vdev,
+				      int pos)
+{
+	__le32 *vptr = (__le32 *)&vdev->vconfig[pos + PCI_TPH_CAP];
+	struct pci_dev *pdev = vdev->pdev;
+	u32 val;
+
+	if (!pcie_tph_supported(pdev, true)) {
+		val = le32_to_cpu(*vptr);
+		val &= ~PCI_TPH_CAP_EXT_TPH;
+		*vptr = cpu_to_le32(val);
+	}
+}
+
+static int vfio_find_cap_start(struct vfio_pci_core_device *vdev, int pos);
+static int vfio_tph_config_write(struct vfio_pci_core_device *vdev, int pos,
+				 int count, struct perm_bits *perm,
+				 int offset, __le32 val)
+{
+	int req_en_byte = PCI_TPH_CTRL + 1;
+	struct pci_dev *pdev = vdev->pdev;
+	__le32 org_val = 0;
+	bool extended;
+	u8 mode, req;
+	int i, ret;
+	u16 start;
+	u32 data;
+
+	if (!vdev->tph_permit)
+		return count;
+
+	down_write(&vdev->memory_lock);
+
+	/* Back up the original values in order rollback when fail */
+	if (offset <= req_en_byte && offset + count > req_en_byte)
+		vfio_default_config_read(vdev, pos, count, perm, offset,
+					 &org_val);
+
+	ret = vfio_default_config_write(vdev, pos, count, perm, offset, val);
+	if (ret != count) {
+		up_write(&vdev->memory_lock);
+		return ret;
+	}
+
+	/* Skip if write range does not cover Requester Enable byte */
+	if (offset > req_en_byte || offset + count <= req_en_byte) {
+		up_write(&vdev->memory_lock);
+		return count;
+	}
+
+	ret = vfio_pci_set_power_state(vdev, PCI_D0);
+	if (ret) {
+		vfio_default_config_write(vdev, pos, count, perm, offset,
+					  org_val);
+		up_write(&vdev->memory_lock);
+		return count;
+	}
+
+	start = vfio_find_cap_start(vdev, pos);
+	data = le32_to_cpu(*(__le32 *)&vdev->vconfig[start + PCI_TPH_CTRL]);
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
+		if (ret)
+			vfio_default_config_write(vdev, pos, count, perm,
+						  offset, org_val);
+	} else if (req == PCI_TPH_REQ_DISABLE) {
+		pcie_disable_tph(vdev->pdev);
+	} else {
+		vfio_default_config_write(vdev, pos, count, perm, offset,
+					  org_val);
+	}
+
+	up_write(&vdev->memory_lock);
+
+	return count;
+}
+
 /*
  * Initialize the shared permission tables
  */
@@ -1101,6 +1213,7 @@ void vfio_pci_uninit_perm_bits(void)
 
 	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_ERR]);
 	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
+	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_TPH]);
 }
 
 int __init vfio_pci_init_perm_bits(void)
@@ -1121,6 +1234,8 @@ int __init vfio_pci_init_perm_bits(void)
 	/* Extended capabilities */
 	ret |= init_pci_ext_cap_err_perm(&ecap_perms[PCI_EXT_CAP_ID_ERR]);
 	ret |= init_pci_ext_cap_pwr_perm(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
+	ret |= init_pci_ext_cap_tph_perm(&ecap_perms[PCI_EXT_CAP_ID_TPH]);
+	ecap_perms[PCI_EXT_CAP_ID_TPH].writefn = vfio_tph_config_write;
 	ecap_perms[PCI_EXT_CAP_ID_VNDR].writefn = vfio_raw_config_write;
 	ecap_perms[PCI_EXT_CAP_ID_DVSEC].writefn = vfio_raw_config_write;
 
@@ -1704,6 +1819,8 @@ static int vfio_ecap_init(struct vfio_pci_core_device *vdev)
 		ret = vfio_fill_vconfig_bytes(vdev, epos, len);
 		if (ret)
 			return ret;
+		if (ecap == PCI_EXT_CAP_ID_TPH && !hidden)
+			vfio_tph_mask_ext_tph_bit(vdev, epos);
 
 		/*
 		 * If we're just using this capability to anchor the list,
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 0f602faeaef3..0bf49e36e64b 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -601,6 +601,8 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 
 	vdev->reset_works = !ret;
 
+	/* Reset TPH status on new user session */
+	pcie_disable_tph(vdev->pdev);
 	ret = vfio_pci_tph_init(vdev);
 	if (ret)
 		goto out_disable_device;
@@ -731,6 +733,8 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	kfree(vdev->region);
 	vdev->region = NULL; /* don't krealloc a freed pointer */
 
+	/* Reset TPH status on session exit */
+	pcie_disable_tph(vdev->pdev);
 	vfio_pci_tph_deinit(vdev);
 	vfio_config_free(vdev);
 
-- 
2.17.1

