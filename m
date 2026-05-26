Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A9D39C63E;
	Tue, 26 May 2026 04:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779768532; cv=none; b=m/0bA2A1EXqlz1okTScWLjNfENwwdhEcNAgA4ZtbqP5PWX9Htbdjh0ar/EuOGZwylrhqxDBuDz6jmAKWDi0snuoRpHGWQ8N5JqFLpopuCIlDc0bB+J1ag478rshfG4yw3958I4DTOQx2ZgWKy8XIMLgOw4Jq2vyuWOaMT7ENKLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779768532; c=relaxed/simple;
	bh=jyniR0+n1yAYmThjBfqScCnL4j5g/Akpci/gK3Py25M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQAXu80wYe38XA5sQ6NQnsYq9x4+qHpuAbYrBJ3e+2vmzkNL8BHgO5Jc23viRKPyJ9Ik/FezTQIPwcBFZhQI2vWWTDK2vvpBdhtvtB4ouDohGXuN32vEosrHcfn/OHQ+E+3/l8OQpYhcbqLSoNCzYCHNKDTC8kY/SPWFg8kwaK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=w0UywIN7; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="w0UywIN7"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9E/eZbeEQB5n4H93f0rwo4fBRQuqkvMQfh8sx4j7RGY=;
	b=w0UywIN7OdomBwidI/B1jEtU6m10JPgTRzRkiuGlw9p7N8Nnq+R2ROTMJldVr2/MOIuMT/IId
	bUTKIXD/Ue5dba2JP7zoJJKoQPc+3t0xqSWuA4NDF8oxwr9EirQo6i9aTwTHAOOHJJEvjsbJqnz
	iJQgFbiuE0LuDMqMMA6R+QM=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gPfDm54LWzLlSS;
	Tue, 26 May 2026 12:00:56 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 3D7F440561;
	Tue, 26 May 2026 12:08:41 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 May 2026 12:08:40 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v12 6/6] vfio/pci: Add PCIe TPH control register virtualization
Date: Tue, 26 May 2026 12:08:30 +0800
Message-ID: <20260526040830.52854-7-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260526040830.52854-1-fengchengwen@huawei.com>
References: <20260526040830.52854-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Implement virtualized handling for PCIe TPH capability control register
writes. Validate and mediate user write requests to accept only valid TPH
mode configurations. Synchronize shadow steering tag table to hardware when
TPH gets enabled successfully.

Automatically disable TPH feature during device ownership handover and
userspace file descriptor closing, ensuring hardware state consistency
after device release.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_config.c | 38 ++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c   |  8 ++++++-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index a10ed733f0e3..188845f81626 100644
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
@@ -313,6 +317,39 @@ static int vfio_virt_config_read(struct vfio_pci_core_device *vdev, int pos,
 	return count;
 }
 
+static int vfio_pci_tph_config_write(struct vfio_pci_core_device *vdev, int pos,
+				     int count, struct perm_bits *perm,
+				     int offset, __le32 val)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	u32 data = le32_to_cpu(val);
+	u8 mode, req_en;
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
+	req_en = FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, data);
+	if (req_en) {
+		ret = pcie_enable_tph(pdev, mode);
+		if (ret == 0 && vdev->tph_st_shadow) {
+			for (i = 0; i < vdev->tph_st_entries; i++)
+				pcie_tph_set_st_entry(pdev, i,
+						      vdev->tph_st_shadow[i]);
+		}
+	} else {
+		pcie_disable_tph(vdev->pdev);
+	}
+
+	return count;
+}
+
 static struct perm_bits direct_ro_perms = {
 	.readfn = vfio_direct_config_read,
 };
@@ -1121,6 +1158,7 @@ int __init vfio_pci_init_perm_bits(void)
 	ret |= init_pci_ext_cap_err_perm(&ecap_perms[PCI_EXT_CAP_ID_ERR]);
 	ret |= init_pci_ext_cap_pwr_perm(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
 	ecap_perms[PCI_EXT_CAP_ID_VNDR].writefn = vfio_raw_config_write;
+	ecap_perms[PCI_EXT_CAP_ID_TPH].writefn = vfio_pci_tph_config_write;
 	ecap_perms[PCI_EXT_CAP_ID_DVSEC].writefn = vfio_raw_config_write;
 
 	if (ret)
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 6fc7496cb8dd..1a9de22202de 100644
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

