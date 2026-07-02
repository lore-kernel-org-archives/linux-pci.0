Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3B9492185;
	Thu,  2 Jul 2026 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996167; cv=none; b=tN8VvG+LFDC6v2KF3x0hy2qLFErYz0jRj7IC2DBouiOgflUx6YKbYnpTmay+1LIvye9rUgY2IU8Omvzipu68Ojvo8TZKhOgUAwiefFrej6CLf+Rr33UkN48ksoIT7jCmG76qqo+yb1+/pmsgfjIk+6t59YeDQe4BbM6PHCkg/jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996167; c=relaxed/simple;
	bh=I0tb0R1szvxO8AzQLL4DCRCa5lnEUwnVj37MyHVCTlE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bkVXv1uCj1qrBzBDj9G7IlVA5ddZ2TPQxPQz54j2A+JpL1whcs/vuq3wOBja1qGPc+5hxqQLpOLJyCX/+2KjSOErCMMrBvkFc1K5+g4/GwCbH3Z2HSvalSZunmY7eP/508bwHG4T1xByH6mtw30b9BIpjCoSpa2s06naNldUgPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=lUX/yiGD; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="lUX/yiGD"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4s9bPd8UWolmO+qVrNxyLsKj/dlCghdYH5dDTP5Tb5Y=;
	b=lUX/yiGDAZDxWAYDRnKOPUVPCWaiJIzOwsjI1FKuOGPC7EpdGp+E16vysVeW7xcIANBSLM7lu
	xk4AFBtMuVANOuf7KMxSdTupNZZug1/Whoj1n3YYc1VdfmG3eYodw2kwVHwxYSmWkFFTCAOnj/U
	YXXm8z6N5YJTz6rqNbsBvmw=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4grbs50FrNz1K97H;
	Thu,  2 Jul 2026 20:33:29 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 3499740565;
	Thu,  2 Jul 2026 20:42:38 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Jul 2026 20:42:37 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v19 14/18] vfio/pci: Implement VFIO_DEVICE_FEATURE_TPH and valid TPH config write support
Date: Thu, 2 Jul 2026 20:42:20 +0800
Message-ID: <20260702124224.57168-15-fengchengwen@huawei.com>
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

Implement vfio_pci_core_feature_tph() to handle VFIO_DEVICE_FEATURE_TPH:
- SET permits TPH feature usage for the device;
- GET reports available TPH capabilities according to tph_policy and
  root-port DSM support.

Previously VFIO dropped all writes to the TPH capability register.
Now implement vfio_tph_config_write() to support legitimate TPH_CTRL
modification after TPH feature is permitted.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_config.c | 54 ++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c   | 36 ++++++++++++++++++++
 include/linux/vfio_pci_core.h      |  1 +
 3 files changed, 91 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 06d7b2fbf866..388dd6fed16b 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1150,6 +1150,60 @@ static int vfio_tph_config_write(struct vfio_pci_core_device *vdev, int pos,
 				 int count, struct perm_bits *perm,
 				 int offset, __le32 val)
 {
+	u16 start = vfio_find_cap_start(vdev, pos);
+	struct pci_dev *pdev = vdev->pdev;
+	u32 org_ctrl, new_ctrl, cap;
+	u8 mode, req, org_req;
+	__le32 org_val = 0;
+	bool extended;
+	int ret;
+
+	if (!vdev->tph_permit)
+		return count;
+
+	down_write(&vdev->memory_lock);
+
+	org_ctrl = le32_to_cpu(*(__le32 *)&vdev->vconfig[start + PCI_TPH_CTRL]);
+	vfio_default_config_read(vdev, pos, count, perm, offset, &org_val);
+
+	ret = vfio_default_config_write(vdev, pos, count, perm, offset, val);
+	if (ret != count)
+		goto out;
+
+	new_ctrl = le32_to_cpu(*(__le32 *)&vdev->vconfig[start + PCI_TPH_CTRL]);
+	if (new_ctrl == org_ctrl)
+		goto out; /* Only care about changes in TPH_CTRL. */
+
+	cap = le32_to_cpu(*(__le32 *)&vdev->vconfig[start + PCI_TPH_CAP]);
+	mode = FIELD_GET(PCI_TPH_CTRL_MODE_SEL_MASK, new_ctrl);
+	req = FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, new_ctrl);
+	if (mode > PCI_TPH_ST_DS_MODE || !(cap & (1u << mode)) || req == 0x2 ||
+		(req == PCI_TPH_REQ_EXT_TPH && !(cap & PCI_TPH_CAP_EXT_TPH)))
+		goto restore; /* Drop invalid or unsupported write value */
+
+	org_req = FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, org_ctrl);
+	if (req == org_req)
+		goto out; /* Only care about requester enable */
+
+	ret = vfio_pci_set_power_state(vdev, PCI_D0);
+	if (ret)
+		goto restore; /* Drop this write */
+
+	if (req == PCI_TPH_REQ_TPH_ONLY || req == PCI_TPH_REQ_EXT_TPH) {
+		extended = !!(req == PCI_TPH_REQ_EXT_TPH);
+		ret = pcie_enable_tph_explicit(pdev, mode, extended);
+		if (ret)
+			goto restore;
+	} else if (req == PCI_TPH_REQ_DISABLE) {
+		pcie_disable_tph(vdev->pdev);
+	}
+
+	goto out;
+
+restore:
+	vfio_default_config_write(vdev, pos, count, perm, offset, org_val);
+out:
+	up_write(&vdev->memory_lock);
 	return count;
 }
 
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3f11a9624b9c..14944d3ea86e 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -30,6 +30,7 @@
 #include <linux/sched/mm.h>
 #include <linux/iommufd.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/pci-tph.h>
 #include <linux/seq_file.h>
 #if IS_ENABLED(CONFIG_EEH)
 #include <asm/eeh.h>
@@ -610,6 +611,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 		goto out_disable_device;
 
 	vdev->reset_works = !ret;
+	vdev->tph_permit = false;
 	pci_save_state(pdev);
 	vdev->pci_saved_state = pci_store_saved_state(pdev);
 	if (!vdev->pci_saved_state)
@@ -1607,6 +1609,38 @@ static int vfio_pci_core_feature_token(struct vfio_pci_core_device *vdev,
 	return 0;
 }
 
+static int vfio_pci_core_feature_tph(struct vfio_pci_core_device *vdev,
+				     u32 flags,
+				     struct vfio_device_feature_tph __user *arg,
+				     size_t argsz)
+{
+	struct vfio_device_feature_tph tph = {0};
+	int ret;
+
+	if (!pcie_tph_supported(vdev->pdev, false))
+		return -EOPNOTSUPP;
+
+	ret = vfio_check_feature(flags, argsz,
+			VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_SET,
+			sizeof(tph));
+	if (ret <= 0)
+		return ret;
+
+	if (flags & VFIO_DEVICE_FEATURE_SET) {
+		vdev->tph_permit = 1;
+		return 0;
+	}
+
+	tph.flags = VFIO_DEVICE_TPH_CAP_DMABUF;
+	if (vdev->tph_policy != VFIO_PCI_TPH_POLICY_NO_ST &&
+		pcie_tph_dsm_supported(vdev->pdev))
+		tph.flags |= VFIO_DEVICE_TPH_CAP_CPU;
+	if (vdev->tph_policy == VFIO_PCI_TPH_POLICY_LITERAL)
+		tph.flags |= VFIO_DEVICE_TPH_CAP_LITERAL;
+
+	return copy_to_user(arg, &tph, sizeof(tph)) ? -EFAULT : 0;
+}
+
 int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 				void __user *arg, size_t argsz)
 {
@@ -1625,6 +1659,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
 	case VFIO_DEVICE_FEATURE_DMA_BUF:
 		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
+	case VFIO_DEVICE_FEATURE_TPH:
+		return vfio_pci_core_feature_tph(vdev, flags, arg, argsz);
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index a0641286dd90..9a6e82c5c00c 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -150,6 +150,7 @@ struct vfio_pci_core_device {
 	struct rw_semaphore	memory_lock;
 	struct list_head	dmabufs;
 	u8			tph_policy;
+	bool			tph_permit;
 };
 
 enum vfio_pci_io_width {
-- 
2.17.1

