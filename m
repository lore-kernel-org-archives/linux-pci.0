Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC600480DDB;
	Thu,  2 Jul 2026 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996167; cv=none; b=IOCust1XpZe0bzHYaWN3G2XXe6ekPWh5tQTuMV7iVFZfqScwkPtGDAUBdpqDpfZ4CWSMPRBfyw1a15T8/R4qGzgfx4PbFZU8a/PKGYYvZbP9xc35i8cZ0cgWZuNbpJVpg2GL8EhJxwMWfs74ACYFLbl1uq68CmgJM5kNkFC6F78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996167; c=relaxed/simple;
	bh=V1Dl3jp+BWfV5YKD+YKqo79xBjYmfdIZkM66nmoDCxU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o8YJiT8G0NivL55+MMTyce7okcO2DG+/xTwwf7ajdGolznTvwRLqXHROTKGO8W75d1yUehbjIter4mfXOHe/aalIoEycmSes4OBC0jshf+UK3z96h9UWHCpcNDHbMs4qh3mIFLv5bFCHtE1hCtcAiImX2EpOE1perKEZOUZFDU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=eW/rdHQz; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="eW/rdHQz"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=usZPSix5d/S3KZeVR9QZJk/hqQ3Vo83PRDsnGk/MKtE=;
	b=eW/rdHQztw2p9mucsH9F5eCakNdxtPizHl/OyUzeQ+v9perhCfI54+johE8dHoqpWTU2/jvZR
	wVyZMwpV5rDvA4eaWPA+GiU1MyFjCa0ZEhA9DT+pM9zB880ia7rBxjHx7076xrdsx+jeW8oawoZ
	KlpP9s9fdeGrbmUSiTb+Jvo=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4grbs41ZGtz1cyQT;
	Thu,  2 Jul 2026 20:33:28 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 2CFD94055B;
	Thu,  2 Jul 2026 20:42:37 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Jul 2026 20:42:36 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v19 12/18] vfio/pci: Add dmabuf TPH metadata storage and fd query helper
Date: Thu, 2 Jul 2026 20:42:18 +0800
Message-ID: <20260702124224.57168-13-fengchengwen@huawei.com>
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

Add TPH metadata fields to struct vfio_pci_dma_buf to store PH,
basic/extended ST and their validity flags.

Implement vfio_pci_dma_buf_get_pci_tph() to fetch TPH tag and PH from
dmabuf, distinguish basic and extended ST namespace.

Add vfio_pci_dma_buf_get_tph_by_fd() to resolve TPH data via dmabuf fd,
validate dmabuf owner ops. Provide stub implementation if
CONFIG_VFIO_PCI_DMABUF is unset.

Lay dmabuf foundation for the upcoming TPH_RESOLVE feature.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_dmabuf.c | 49 +++++++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h   |  6 ++++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index c16f460c01d6..d9c5e434e586 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -19,7 +19,14 @@ struct vfio_pci_dma_buf {
 	u32 nr_ranges;
 	struct kref kref;
 	struct completion comp;
-	u8 revoked : 1;
+
+	/* Protected by dmabuf->resv. */
+	u8 revoked:1;
+	u8 tph_ph:2;
+	u8 tph_st_valid:1;
+	u8 tph_xst_valid:1;
+	u8 tph_st;
+	u16 tph_xst;
 };
 
 static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
@@ -81,6 +88,26 @@ static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachment,
 	kref_put(&priv->kref, vfio_pci_dma_buf_done);
 }
 
+static int vfio_pci_dma_buf_get_pci_tph(struct dma_buf *dmabuf, bool extended,
+					u16 *tag, u8 *ph)
+{
+	struct vfio_pci_dma_buf *priv = dmabuf->priv;
+
+	dma_resv_assert_held(priv->dmabuf->resv);
+
+	if (extended) {
+		if (!priv->tph_xst_valid)
+			return -EOPNOTSUPP;
+		*tag = priv->tph_xst;
+	} else {
+		if (!priv->tph_st_valid)
+			return -EOPNOTSUPP;
+		*tag = priv->tph_st;
+	}
+	*ph = priv->tph_ph;
+	return 0;
+}
+
 static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
 {
 	struct vfio_pci_dma_buf *priv = dmabuf->priv;
@@ -106,6 +133,26 @@ static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
 	.release = vfio_pci_dma_buf_release,
 };
 
+int vfio_pci_dma_buf_get_tph_by_fd(int fd, bool extended, u16 *tag, u8 *ph)
+{
+	struct dma_buf *dmabuf;
+	int ret = 0;
+
+	dmabuf = dma_buf_get(fd);
+	if (IS_ERR(dmabuf))
+		return PTR_ERR(dmabuf);
+
+	if (dmabuf->ops != &vfio_pci_dmabuf_ops) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = vfio_pci_dma_buf_get_pci_tph(dmabuf, extended, tag, ph);
+out:
+	dma_buf_put(dmabuf);
+	return ret;
+}
+
 /*
  * This is a temporary "private interconnect" between VFIO DMABUF and iommufd.
  * It allows the two co-operating drivers to exchange the physical address of
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index c997cc9bf330..d7bc52f488c6 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -122,12 +122,18 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
 }
 
 #ifdef CONFIG_VFIO_PCI_DMABUF
+int vfio_pci_dma_buf_get_tph_by_fd(int fd, bool extended, u16 *tag, u8 *ph);
 int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 				  struct vfio_device_feature_dma_buf __user *arg,
 				  size_t argsz);
 void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev);
 void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked);
 #else
+static inline int vfio_pci_dma_buf_get_tph_by_fd(int fd, bool extended,
+						 u16 *tag, u8 *ph)
+{
+	return -EOPNOTSUPP;
+}
 static inline int
 vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 			      struct vfio_device_feature_dma_buf __user *arg,
-- 
2.17.1

