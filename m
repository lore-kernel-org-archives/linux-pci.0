Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9552857EA;
	Wed, 27 May 2026 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875253; cv=none; b=OL7wzz6RReoE7WNNLKxfsdgrukDOtpgij+Ys4YkzdSbQ3bQUnEbM/Jta7Dc/EyIlSQns0XPbvMMa7y8PdAy4jNKeueCzdXOALSiXc/hCSaoMu0yPvtUz8/rbvkJB0ItkxN/plHIQd1Rek5YGREqfYnh4d7cpEaazT8rCKSv/Z/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875253; c=relaxed/simple;
	bh=voaLTE83pIZ7Ggrzhs+y/k6Wf85BGlrOoielvgkdBgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MM6kR2c0CSmbyc89Iik7n74owg/6Gccc/JGsKUOOFhkIGgJPEqB72uYRn5TYhr1HRWSdVBCyItGKJ+SWsIyW7DvgezOTlUsSJmQOEOhWhhRvPtXOwjKRnJFxVzvVL9OswBUbfrpBZID/CMpg/IJ7c0BmAPypmTD8NoNNXmaRUZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=X/ZsqnEv; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="X/ZsqnEv"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VWOZRl0MMXYg8PYmuPu5Eno3/BO2lnqFO2pUGPPACRc=;
	b=X/ZsqnEvcTTi5CH25FoZ13/tVH0iyzp6PqD9ZaGdS2UO+bwenIZaFyFhzUf0MVDkiTkNLWssL
	um8etJWfT1vOzSmf/WCpvPStCaQ6xUcbrSPS++6MgqO1/DeFKlFrHrAfBL0WeC6ZMc2/m/lhKHn
	79ezvh6uT88VvORUMwZN8TQ=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gQPhw3tJPz12LCc;
	Wed, 27 May 2026 17:39:28 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 422E940538;
	Wed, 27 May 2026 17:47:28 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 May 2026 17:47:27 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v13 8/8] vfio/pci: Virtualize PCIe TPH capability registers
Date: Wed, 27 May 2026 17:47:19 +0800
Message-ID: <20260527094719.43886-9-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260527094719.43886-1-fengchengwen@huawei.com>
References: <20260527094719.43886-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Implement read/write virtualization for PCIe TPH Extended Capability:
1. Read path: Mask out extended requester bit if hardware does not support
   extended ST, to hide unavailable capability from userspace.
2. Write path: Validate TPH mode and requester configuration, mediate TPH
   enable/disable requests. Sync shadow ST table to hardware after
   successful TPH enabling.

Automatically disable TPH feature during device ownership handover and
userspace file descriptor closing, ensuring hardware state consistency
after device release.

Gate the enable/disable TPH feature by enable_unsafe_tph module parameter.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_config.c | 68 ++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c   |  8 +++-
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index a10ed733f0e3..518a6afa7ada 100644
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
@@ -313,6 +317,68 @@ static int vfio_virt_config_read(struct vfio_pci_core_device *vdev, int pos,
 	return count;
 }
 
+static int vfio_pci_tph_config_read(struct vfio_pci_core_device *vdev, int pos,
+				    int count, struct perm_bits *perm,
+				    int offset, __le32 *val)
+{
+	const int target_byte = PCI_TPH_CAP + 1;
+	struct pci_dev *pdev = vdev->pdev;
+	const u8 ext_bit = BIT(0);
+	int byte_off;
+	u8 *data;
+	int ret;
+
+	if (pdev->tph_ext_requester || offset > target_byte ||
+		offset + count < target_byte)
+		return vfio_direct_config_read(vdev, pos, count, perm,
+					       offset, val);
+
+	ret = vfio_direct_config_read(vdev, pos, count, perm, offset, val);
+
+	/* Mask out TPH requester capability */
+	byte_off = target_byte - offset;
+	data = (u8 *)val;
+	data[byte_off] &= ~ext_bit;
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
@@ -1121,6 +1187,8 @@ int __init vfio_pci_init_perm_bits(void)
 	ret |= init_pci_ext_cap_err_perm(&ecap_perms[PCI_EXT_CAP_ID_ERR]);
 	ret |= init_pci_ext_cap_pwr_perm(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
 	ecap_perms[PCI_EXT_CAP_ID_VNDR].writefn = vfio_raw_config_write;
+	ecap_perms[PCI_EXT_CAP_ID_TPH].readfn = vfio_pci_tph_config_read;
+	ecap_perms[PCI_EXT_CAP_ID_TPH].writefn = vfio_pci_tph_config_write;
 	ecap_perms[PCI_EXT_CAP_ID_DVSEC].writefn = vfio_raw_config_write;
 
 	if (ret)
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 01c8396b9ffe..47d20f17ff65 100644
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
@@ -543,6 +543,9 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 			return ret;
 	}
 
+	/* Clear TPH status when taking over ownership */
+	pcie_disable_tph(pdev);
+
 	/* Don't allow our initial saved state to include busmaster */
 	pci_clear_master(pdev);
 
@@ -656,6 +659,9 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	 */
 	vfio_pci_set_power_state(vdev, PCI_D0);
 
+	/* Clear TPH status when releasing ownership */
+	pcie_disable_tph(pdev);
+
 	/* Stop the device from further DMA */
 	pci_clear_master(pdev);
 
-- 
2.17.1

