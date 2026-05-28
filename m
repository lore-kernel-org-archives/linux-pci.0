Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE5A3F0743;
	Thu, 28 May 2026 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779972424; cv=none; b=sLQjBhxwxAawgsuig2nyurwhQsminFnnRNs0igCOOStAlgeVg3u67/JuMThZO8WTar/GvbbWaaLshYdP0WIIXkxcafBfF6+FkwsgpccC5E21073tPPv4QiMMUtOBepFEb4Nsas3j/PFXbRV28imN5d6ViaZIwRz0x8tFAd9QTvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779972424; c=relaxed/simple;
	bh=xko47/rh7GiUYTr7JrKm/m526whga2UGg7CSULC8GMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WklM469xb6DLqQJuPDy2Bnq5/kAzscGZGw4keg/4Hg9Iej+6bE5bFN0/v7yrNOY1TFCrG3xofBDohKnkkRa+LN0R/33PQIS/ET2JPk+Z/lpAU/15YS1jYPe8NDir5vdsYm/FNKWYxZ1FQbx1UQ6UFut0/dKs2+rXpp4SjtAIEz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=GoCObkPM; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="GoCObkPM"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=G62qncsWltq0L1zx5h1ziXQmHFrLrivFNwnOLOsOYVQ=;
	b=GoCObkPM+sbTXq44b9FxGHya7gzUKh6safSCTUtzEO6dJ6T+CJIAnx903EQ93alloIpMgV377
	6XJ/KdZC9fv/S5ShH9GDJlcbDG94PDcS02CD3p1gjTrHhzKqEbmq1W42rAmnNtaJxepNOAYbngR
	cWZiOl7qqZ56o99VQhNWO6s=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gR5db3wJjz12LJK;
	Thu, 28 May 2026 20:38:59 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 9924A40569;
	Thu, 28 May 2026 20:46:58 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 May 2026 20:46:58 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<zhipingz@meta.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v14 8/8] vfio/pci: Virtualize PCIe TPH capability registers
Date: Thu, 28 May 2026 20:46:49 +0800
Message-ID: <20260528124649.14732-9-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260528124649.14732-1-fengchengwen@huawei.com>
References: <20260528124649.14732-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Implement read/write virtualization for PCIe TPH Extended Capability:
1. Read path: Mask out extended requester bit if hardware does not support
   extended ST, to hide unavailable capability from userspace.
2. Write path: Validate TPH mode and requester configuration, mediate TPH
   enable/disable requests. Sync shadow ST table to hardware after
   successful TPH enabling.

Clear shadow table and reset TPH status on user session transition, to
prevent cross-session state leakage.

Gate the enable/disable TPH feature by enable_unsafe_tph module parameter.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_config.c | 78 ++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c   |  8 ++-
 2 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index a10ed733f0e3..bed3794e6033 100644
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
@@ -313,6 +317,78 @@ static int vfio_virt_config_read(struct vfio_pci_core_device *vdev, int pos,
 	return count;
 }
 
+static int vfio_pci_tph_config_read(struct vfio_pci_core_device *vdev, int pos,
+				    int count, struct perm_bits *perm,
+				    int offset, __le32 *val)
+{
+	const int target_byte = PCI_TPH_CAP + 1;
+	struct pci_dev *pdev = vdev->pdev;
+	const u8 ext_bit = BIT(0);
+	u8 *data = (u8 *)val;
+	int byte_off;
+	int ret;
+
+	if (pdev->tph_ext_requester || offset > target_byte ||
+		offset + count <= target_byte)
+		return vfio_direct_config_read(vdev, pos, count, perm,
+					       offset, val);
+
+	ret = vfio_direct_config_read(vdev, pos, count, perm, offset, val);
+
+	/* Mask out TPH requester capability */
+	byte_off = target_byte - offset;
+	/* Defensive check: prevent out-of-bounds access */
+	if (byte_off < count)
+		data[byte_off] &= ~ext_bit;
+
+	return ret;
+}
+
+static int vfio_pci_tph_config_write(struct vfio_pci_core_device *vdev, int pos,
+				     int count, struct perm_bits *perm,
+				     int offset, __le32 val)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	u32 data = le32_to_cpu(val);
+	enum tph_req_policy policy;
+	u8 mode, req;
+	int i, ret;
+
+	if (!enable_unsafe_tph)
+		return count;
+
+	/*
+	 * TPH_CTRL (offset 4) register layout:
+	 *   Byte 0 (offset 4): Bits [2:0] - ST Mode selection
+	 *   Byte 1 (offset 5): Bits [1:0] - TPH Requester enable
+	 *
+	 * Only intercept writes with count >= 2 which cover both control
+	 * fields. Single-byte partial writes do not affect combined
+	 * configuration.
+	 */
+	if (offset != PCI_TPH_CTRL || count < 2)
+		return count;
+
+	guard(mutex)(&vdev->tph_lock);
+
+	mode = FIELD_GET(PCI_TPH_CTRL_MODE_SEL_MASK, data);
+	req = FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, data);
+	if (req == PCI_TPH_REQ_TPH_ONLY || req == PCI_TPH_REQ_EXT_TPH) {
+		policy = (req == PCI_TPH_REQ_TPH_ONLY) ?
+			 TPH_REQ_STANDARD : TPH_REQ_EXTENDED;
+		ret = pcie_enable_tph(pdev, mode, policy);
+		if (ret == 0 && vdev->tph_st_shadow) {
+			for (i = 0; i < vdev->tph_st_entries; i++)
+				pcie_tph_set_st_entry(pdev, i,
+						      vdev->tph_st_shadow[i]);
+		}
+	} else if (req == PCI_TPH_REQ_DISABLE) {
+		pcie_disable_tph(vdev->pdev);
+	}
+
+	return count;
+}
+
 static struct perm_bits direct_ro_perms = {
 	.readfn = vfio_direct_config_read,
 };
@@ -1121,6 +1197,8 @@ int __init vfio_pci_init_perm_bits(void)
 	ret |= init_pci_ext_cap_err_perm(&ecap_perms[PCI_EXT_CAP_ID_ERR]);
 	ret |= init_pci_ext_cap_pwr_perm(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
 	ecap_perms[PCI_EXT_CAP_ID_VNDR].writefn = vfio_raw_config_write;
+	ecap_perms[PCI_EXT_CAP_ID_TPH].readfn = vfio_pci_tph_config_read;
+	ecap_perms[PCI_EXT_CAP_ID_TPH].writefn = vfio_pci_tph_config_write;
 	ecap_perms[PCI_EXT_CAP_ID_DVSEC].writefn = vfio_raw_config_write;
 
 	if (ret)
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 851e4d0828f2..2a5cb945275e 100644
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
@@ -1595,6 +1595,9 @@ static int vfio_pci_tph_init(struct vfio_pci_core_device *vdev)
 
 	mutex_init(&vdev->tph_lock);
 
+	/* Reset TPH status on new user session */
+	pcie_disable_tph(vdev->pdev);
+
 	return 0;
 }
 
@@ -1605,6 +1608,9 @@ static void vfio_pci_tph_deinit(struct vfio_pci_core_device *vdev)
 	vdev->tph_st_entries = 0;
 
 	mutex_destroy(&vdev->tph_lock);
+
+	/* Reset TPH status on session exit */
+	pcie_disable_tph(vdev->pdev);
 }
 
 static int vfio_pci_core_feature_tph_st_config(
-- 
2.17.1

