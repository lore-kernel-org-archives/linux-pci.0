Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B795F481226;
	Thu,  2 Jul 2026 12:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996161; cv=none; b=h8n25epNXLHvd/ti5BH9ndX0j8E2AkICepROy0rbbmkUXagsCDqkJVPFWyr6TaEtEsOCPIS4QlZMR0saPQOpcjaftTVmbL5OJ08m6bbeUwKk7SnXFpVpeTfwRf9Ma1HmnGu/+Y8GXqkIt6LgUHJWLQZgN38cOJdKIp0PZ8iKvGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996161; c=relaxed/simple;
	bh=EENKoPi8yz+eCG721V6CRCSE21hc9RT4rglO3bGyQkE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KqqKEbnLjwNBtGi1o8sRnM7aIkWMuQH0ZLx9knHKYZ8QHBkAi6SOiBhUx4QBqLQ6TyFtE78ASzauH7hBVstl6Z0Lw4rx6W70jfooFhU7n1tz2IlM6nbNxiV27X1T9u71EEDpkAmqpHtlfOf1dDnds2ZbKDr0ViHn8mxBUOdhN6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ZUyZGQ/q; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ZUyZGQ/q"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=elVR9ETs1+YnNzTTueUXWeDZ/DDlPbqfsBPXA84S1nY=;
	b=ZUyZGQ/qFjYI74ZNBaZfznMblUU/Xi0JcmoaIPLj7SwHpfxmEXCXNh2iYOuyF2e80pZ6ktlOl
	XaMWB6gOfB6mcPcoqukzpMO2gfvDwMpukGJu4cXWhrSs+qmFnG9Ru+VT0KC8XiyRNuU0UCYYLXv
	3oMecHdRFrcMBj1IGnhXqUM=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4grbs20PBmzmVVm;
	Thu,  2 Jul 2026 20:33:26 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D03040574;
	Thu,  2 Jul 2026 20:42:36 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Jul 2026 20:42:35 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v19 11/18] vfio/pci: Virtualize PCIe TPH capability registers
Date: Thu, 2 Jul 2026 20:42:17 +0800
Message-ID: <20260702124224.57168-12-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260702124224.57168-1-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Implement virtualization and policy masking for PCIe TPH extended
capability:
- Split TPH config space permissions: keep header read-only, mark
  TPH_CTRL and ST-table entries virtually writable.
- Adjust virtual TPH capability bits according to hardware capability
  and tph_policy, hiding unsupported modes.
- Silently discard all write operations.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_config.c | 72 ++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 5c6ab172df6c..06d7b2fbf866 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1086,6 +1086,73 @@ static int __init init_pci_ext_cap_pwr_perm(struct perm_bits *perm)
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
+	p_setd(perm, PCI_TPH_CTRL, ALL_VIRT,
+	       PCI_TPH_CTRL_MODE_SEL_MASK | PCI_TPH_CTRL_REQ_EN_MASK);
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
+static void vfio_tph_capability_adjust(struct vfio_pci_core_device *vdev,
+				       int pos)
+{
+	__le32 *vptr = (__le32 *)&vdev->vconfig[pos + PCI_TPH_CAP];
+	struct pci_dev *pdev = vdev->pdev;
+	u32 val = le32_to_cpu(*vptr);
+	bool need_adjust = false;
+
+	if (!pcie_tph_supported(pdev, true)) {
+		/* Remove extend TPH if root-port don't support */
+		val &= ~PCI_TPH_CAP_EXT_TPH;
+		need_adjust = true;
+	}
+
+	if (vdev->tph_policy == VFIO_PCI_TPH_POLICY_NO_ST) {
+		/* Report only No-ST mode supported */
+		val &= ~(PCI_TPH_CAP_ST_IV | PCI_TPH_CAP_ST_DS |
+			 PCI_TPH_CAP_LOC_MASK | PCI_TPH_CAP_ST_MASK);
+		need_adjust = true;
+	} else if (vdev->tph_policy == VFIO_PCI_TPH_POLICY_IV_ST) {
+		/* Report only No-ST and IV modes supported */
+		val &= ~PCI_TPH_CAP_ST_DS;
+		/* Remove ST location and size if dev don't support IV mode */
+		if (!(val & PCI_TPH_CAP_ST_IV))
+			val &= ~(PCI_TPH_CAP_LOC_MASK | PCI_TPH_CAP_ST_MASK);
+		need_adjust = true;
+	}
+
+	if (need_adjust)
+		*vptr = cpu_to_le32(val);
+}
+
+static int vfio_find_cap_start(struct vfio_pci_core_device *vdev, int pos);
+static int vfio_tph_config_write(struct vfio_pci_core_device *vdev, int pos,
+				 int count, struct perm_bits *perm,
+				 int offset, __le32 val)
+{
+	return count;
+}
+
 /*
  * Initialize the shared permission tables
  */
@@ -1101,6 +1168,7 @@ void vfio_pci_uninit_perm_bits(void)
 
 	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_ERR]);
 	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
+	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_TPH]);
 }
 
 int __init vfio_pci_init_perm_bits(void)
@@ -1121,6 +1189,8 @@ int __init vfio_pci_init_perm_bits(void)
 	/* Extended capabilities */
 	ret |= init_pci_ext_cap_err_perm(&ecap_perms[PCI_EXT_CAP_ID_ERR]);
 	ret |= init_pci_ext_cap_pwr_perm(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
+	ret |= init_pci_ext_cap_tph_perm(&ecap_perms[PCI_EXT_CAP_ID_TPH]);
+	ecap_perms[PCI_EXT_CAP_ID_TPH].writefn = vfio_tph_config_write;
 	ecap_perms[PCI_EXT_CAP_ID_VNDR].writefn = vfio_raw_config_write;
 	ecap_perms[PCI_EXT_CAP_ID_DVSEC].writefn = vfio_raw_config_write;
 
@@ -1704,6 +1774,8 @@ static int vfio_ecap_init(struct vfio_pci_core_device *vdev)
 		ret = vfio_fill_vconfig_bytes(vdev, epos, len);
 		if (ret)
 			return ret;
+		if (ecap == PCI_EXT_CAP_ID_TPH && !hidden)
+			vfio_tph_capability_adjust(vdev, epos);
 
 		/*
 		 * If we're just using this capability to anchor the list,
-- 
2.17.1

