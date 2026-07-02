Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C2E4963C5;
	Thu,  2 Jul 2026 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996177; cv=none; b=nahsJy0VnpJUHGZtoQfmGbwUXMUmO7pDdaZ/+vSxVTOzTWl9d9qZrmdlzs7MktcTVzDsmEP9CTAtEElik6+Sx97EPil6IW5SNTay/DYlCRBN8+HP+LIWq9TlK+cJhSBfl6HB3KmH8ab6XLtbmK9niozWWxhRTQ72/OvcorwPlhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996177; c=relaxed/simple;
	bh=hxxZFNzWSSG/FLu+iz3gMw+InxpGNyunbJ+mnPzF+Bg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Teark+ZyAqKv/W+E5gcFOloSL5L53iJbDt/4Hqrsm+FLwChkegObwfSBB8wipbGMH6CEl6CTdWikuOBPhmPEvKnzGf1bZZWSDbW+JTP+fWctWT8JtOJvjzMHYv31ccNBwpe9NWblBiPTwfYp08H8pAZaZTGUiqVJnYTjTGf0ufU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=UPLhWJP1; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="UPLhWJP1"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9gb2Za71lzW5Xm3J8Rsqmoz40LyNXU7HrNc9My3KBxY=;
	b=UPLhWJP1sQi8RW2iw9y+vFr+pFwOVU6vLNby2mF1PIpdBI9trigXboOf7GAbuVuzqFNv5X2Co
	lG40t6GkICxWKNbXUYaNaK9j5DrD8Iv7AomrnI8Jryx4fVG1stD45BjwTJ53M533al6KnGCD6TC
	2vSuFUp0WWyp/Pz1HOIb2a0=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4grbsQ2Rhtz1T4Fd;
	Thu,  2 Jul 2026 20:33:46 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id B108040537;
	Thu,  2 Jul 2026 20:42:38 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Jul 2026 20:42:38 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v19 15/18] vfio/pci: Implement TPH_RESOLVE feature for DMABUF and CPU source resolving
Date: Thu, 2 Jul 2026 20:42:21 +0800
Message-ID: <20260702124224.57168-16-fengchengwen@huawei.com>
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

Add vfio_pci_core_feature_tph_resolve() to implement the
VFIO_DEVICE_FEATURE_TPH_RESOLVE GET-only uAPI.

Resolve PH/ST values from two supported sources:
- DMABUF fd: retrieve stored TPH metadata via dmabuf helper
- CPU ID: fetch ST tag from platform via PCIe TPH core helper

Gate supported source types dynamically according to the tph_policy level:
No-ST/IV modes only permit DMABUF resolution, while DS+ modes additionally
allow CPU volatile/persistent sources.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 75 ++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 14944d3ea86e..ed6bbffa8b26 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1641,6 +1641,78 @@ static int vfio_pci_core_feature_tph(struct vfio_pci_core_device *vdev,
 	return copy_to_user(arg, &tph, sizeof(tph)) ? -EFAULT : 0;
 }
 
+static int vfio_pci_core_feature_tph_resolve(struct vfio_pci_core_device *vdev,
+			u32 flags,
+			struct vfio_device_feature_tph_resolve __user *arg,
+			size_t argsz)
+{
+	const u32 permit_src_mask[] = {
+		[VFIO_PCI_TPH_POLICY_NO_ST] = VFIO_DEVICE_TPH_SRC_DMABUF,
+		[VFIO_PCI_TPH_POLICY_IV_ST] = VFIO_DEVICE_TPH_SRC_DMABUF,
+		[VFIO_PCI_TPH_POLICY_DS_ST ... VFIO_PCI_TPH_POLICY_LITERAL] =
+					VFIO_DEVICE_TPH_SRC_DMABUF |
+					VFIO_DEVICE_TPH_SRC_CPU_VOLATILE |
+					VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT,
+	};
+	u32 permit_flags = permit_src_mask[vdev->tph_policy] |
+			   VFIO_DEVICE_TPH_EXTENDED;
+	struct vfio_device_feature_tph_resolve resolve = {0};
+	enum tph_mem_type mtype;
+	bool extended;
+	u32 src_bits;
+	u16 tag = 0;
+	u8 ph = 0;
+	int ret;
+
+	if (!vdev->tph_permit)
+		return -EOPNOTSUPP;
+
+	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
+				 sizeof(resolve));
+	if (ret <= 0)
+		return ret;
+
+	if (copy_from_user(&resolve, arg, sizeof(resolve)))
+		return -EFAULT;
+
+	src_bits = resolve.flags & VFIO_DEVICE_TPH_SRC_MASK;
+	if (!(resolve.flags & permit_flags) || !is_power_of_2(src_bits))
+		return -EINVAL;
+	extended = !!(resolve.flags & VFIO_DEVICE_TPH_EXTENDED);
+	if (extended && !pcie_tph_supported(vdev->pdev, true))
+		return -EINVAL;
+
+	resolve.valid = 0;
+	resolve.ph = 0;
+	resolve.st = 0;
+
+	if (src_bits & VFIO_DEVICE_TPH_SRC_DMABUF) {
+		ret = vfio_pci_dma_buf_get_tph_by_fd(resolve.src, extended,
+						     &tag, &ph);
+		if (ret)
+			return ret;
+		resolve.ph = ph;
+		resolve.valid = VFIO_DEVICE_TPH_VALID_PH;
+		if (vdev->tph_policy >= VFIO_PCI_TPH_POLICY_DS_ST) {
+			resolve.st = tag;
+			resolve.valid |= VFIO_DEVICE_TPH_VALID_ST;
+		}
+		goto out;
+	}
+
+	mtype = (src_bits & VFIO_DEVICE_TPH_SRC_CPU_VOLATILE) ?
+			TPH_MEM_TYPE_VM : TPH_MEM_TYPE_PM;
+	ret = pcie_tph_get_cpu_st_explicit(vdev->pdev, mtype, extended,
+					   resolve.src, &tag);
+	if (ret)
+		return ret;
+	resolve.valid = VFIO_DEVICE_TPH_VALID_ST;
+	resolve.st = tag;
+
+out:
+	return copy_to_user(arg, &resolve, sizeof(resolve)) ? -EFAULT : 0;
+}
+
 int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 				void __user *arg, size_t argsz)
 {
@@ -1661,6 +1733,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
 	case VFIO_DEVICE_FEATURE_TPH:
 		return vfio_pci_core_feature_tph(vdev, flags, arg, argsz);
+	case VFIO_DEVICE_FEATURE_TPH_RESOLVE:
+		return vfio_pci_core_feature_tph_resolve(vdev, flags,
+							 arg, argsz);
 	default:
 		return -ENOTTY;
 	}
-- 
2.17.1

